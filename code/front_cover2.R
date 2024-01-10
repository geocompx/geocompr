library(camcorder)
library(cartogram)
library(glue)
library(ggtext)
library(ggforce)
library(MoMAColors) # dev version available on github: https://github.com/BlakeRMills/MoMAColors
library(rnaturalearth)
library(scico)
library(sf)
library(showtext)
library(terra)
library(tidyterra)
library(tidyverse)
library(od)

# Set fonts
font_add_google("Raleway","ral")
showtext_auto()

# Set size
gg_record(
  dir = file.path(tempdir(),"recording"), 
  device = "png", 
  width = 15.6, # I chose the size of the 1st edition book, so the image created here may cover all of the first page 
  height = 23.4, 
  units = "cm", # may also be exported as svg
  dpi = 600 
)

# Cover is made of two different type of maps (1 "buffer" map and 1 "dorling" cartogram) that will be created one after another


#############################
# Creation of the first map #
#############################

# Let's start with the 1st map: buffer area around capitals in Africa

# Loading data
##############
# Vector files of world borders loaded from {rnaturalearth}
mp_with_countries<-ne_countries(scale = 50, type = "countries", returnclass = "sf")%>%
  st_transform(crs="+proj=robin")

# Populated places layer has been downloaded from Natural Earth:
# https://www.naturalearthdata.com/downloads/10m-cultural-vectors/
# For script reproducibility purposes, I uploaded a subset on my github:
cp<-read_sf('https://github.com/BjnNowak/geocomputation/raw/main/data/ne_10m_populated_places.gpkg')%>%
  # Select only administrative capitals
  filter(ADM0CAP==1)%>%
  # Reproject to Robinson
  st_transform(crs="+proj=robin")%>%
  # Intersection to keep only capitals in Africa or (West) Asia
  st_intersection(mp_with_countries%>%filter(continent%in%c('Africa')))

# Clean data
############
# Dissolve countries for world basemap
mp<-mp_with_countries%>%
  mutate(
    entity="world",
    ct=1
  )%>%
  group_by(entity)%>%
  summarize(sm=sum(ct))%>%
  ungroup()

# Prepare labels and extract coordinates (to place later with {ggtext}) of capitals
main_cp <- cp%>%
  arrange(-POP_MAX)%>%
  mutate(pop=round(POP_MAX/1000000,2))%>%
  mutate(label=glue::glue("<b>{NAME}</b><br>{pop} M"))%>%
  mutate(
    lon = sf::st_coordinates(.)[,1],
    lat = sf::st_coordinates(.)[,2]
  )

# Subset of capitals to be placed on final map
sel<-c(
  'Cairo','Algiers','Tripoli',
  'Baghdad','Khartoum','Addis Ababa',
  'Abidjan','Dakar','Bangui','Harare',
  'Brazzaville','Luanda','Nairobi',
  "N'Djamena"
)

# Function to create sucessive buffers around capitals
fun_buff<-function(cp,buff){
  # Create empty list
  buff_list <- list()
  # Fill list with 5 successive buffers
  for (i in 1:5){
    buff_list[[i]]<-cp%>%
      st_buffer(buff*i)%>%
      st_intersection(mp)
  }
  return(buff_list)
}

# Apply function to create list with buffers around points
buff_list<-fun_buff(cp=cp,buff=100000)



##############################
# Creation of the second map #
##############################


# The second map is a customized dorling cartogram showing the quantity and origin of energy production in Europe.
# I made it on a different continent to avoid overlapping.

# I've written an online tutorial detailing my method for creating 'customized' Dorling cartograms, displaying the value of sub-variables:
# https://r-graph-gallery.com/web-dorling-cartogram-with-R.html
# For this map, the sub-variables will represent the origin of the energy (fossil, renewable or nuclear)

# Load data
#############
# Data is from a TidyTuesday dataset (so already available online):
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-06-06/readme.md
owid_energy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-06/owid-energy.csv')

# Data cleaning
###############

# Compute the origin of the energy produced per country since 2010
clean<-owid_energy%>%
  filter(year>2010)%>%
  mutate(iso_code=case_when(
    country=="Kosovo"~'KOS',
    TRUE~iso_code
  ))%>%
  drop_na(iso_code)%>%
  group_by(country)%>%
  summarize(
    iso_code=iso_code[1],
    biofuel=mean(na.omit(biofuel_elec_per_capita)),
    coal=mean(na.omit(coal_elec_per_capita)),
    gas=mean(na.omit(gas_elec_per_capita)),
    hydro=mean(na.omit(hydro_elec_per_capita)),
    nuke=mean(na.omit(nuclear_elec_per_capita)),
    oil=mean(na.omit(oil_elec_per_capita)),
    solar=mean(na.omit(solar_elec_per_capita)),
    wind=mean(na.omit(wind_elec_per_capita)),
    total=biofuel+coal+gas+hydro+nuke+oil+solar+wind
  )%>%
  ungroup()

# Make cartogram
################

# Join data and map
# (we use here the basemap already downloaded for 1st map)
world<-mp_with_countries%>%
  left_join(clean,by=c("iso_a3"="iso_code"))%>%
  # Keeping only European countries
  filter(continent=="Europe")%>%
  drop_na(total)

# Making Dorling cartogram based on total quantity of energy produced
dorl<-cartogram_dorling(world, weight="total", k = 2.5, m_weight = 0, itermax = 1000)

# Compute area and radius for each circle of the cartogram
d2<-dorl%>%
  mutate(
    ar=st_area(dorl),
    rad=sqrt(ar/pi)
  )

# Extract centroids for each circle
centr <- dorl%>%
  st_centroid()%>%
  st_coordinates()

# Merge area and centroids 
# and compute proportional radius for different sources of energy 
d3 <- tibble(d2,X=centr[,1],Y=centr[,2])%>%
  mutate(rad=as.numeric(rad))%>%
  mutate(
    # Renewable
    ratio_renew = (biofuel+hydro+solar+wind)/total,
    # Fossil
    ratio_fossil = (oil+gas+coal)/total,
    # Nuclear
    ratio_nuke = nuke/total
  )%>%
  mutate(
    rad_renew=sqrt(rad*rad*ratio_renew),
    rad_fossil=sqrt(rad*rad*ratio_fossil),
    rad_nuke=sqrt(rad*rad*ratio_nuke)
  )

# Create custom function to draw circles based on centroid and radius
circleFun <- function(center=c(0,0), diameter=1, npoints=100, start=0, end=2){
  tt <- seq(start*pi, end*pi, length.out=npoints)
  df<-data.frame(
    x = center[1] + diameter / 2 * cos(tt), 
    y = center[2] + diameter / 2 * sin(tt)
  )
  df2<-bind_rows(
    df,
    tibble(x = center[1],y=center[2]),
  )
  return(df2)
}


# Sort by country code
dord<-d3%>%
  arrange(iso_a3)

# Limits of the three "slices" (renewable, fossil or nuclear) for each circle
c_renew <- c(0,2*1/3)
c_fossil <- c(2*1/3,2*2/3)
c_nuke <- c(2*2/3,2)

# Empty object to be filled with values later
renew<-tibble(iso=c(),x=c(),y=c())
nuke<-tibble(iso=c(),x=c(),y=c())
fossil<-tibble(iso=c(),x=c(),y=c())

# Apply function for each country and type of energy
for (i in 1:dim(dord)[1]){
  
  # compared to the version of the tutorial created for R Graph Gallery, 
  # the only difference here is that I need to add a point for the center 
  # (required coz we do not draw half circles here).
  t1 <- tibble(
    iso = dord$iso_a3[i],
    x = dord$X[i],
    y = dord$Y[i]
  )
  
  temp_renew <- 
    tibble(
      iso=dord$iso_a3[i],
      circleFun(
        c(dord$X[i],dord$Y[i]),diameter=dord$rad_renew[i]*2, start=c_renew[1], end=c_renew[2]
      )
    )%>%
    bind_rows(t1) # Add center point
  
  temp_nuke <- 
    tibble(
      iso=dord$iso_a3[i],
      circleFun(
        c(dord$X[i],dord$Y[i]),diameter=dord$rad_nuke[i]*2, start=c_nuke[1], end=c_nuke[2]
      )
    )%>%
    bind_rows(t1)
  
  temp_fossil <- 
    tibble(
      iso=dord$iso_a3[i],
      circleFun(
        c(dord$X[i],dord$Y[i]),diameter=dord$rad_fossil[i]*2, start=c_fossil[1], end=c_fossil[2]
      )
    )%>%
    bind_rows(t1)
  
  renew<-renew%>%
    bind_rows(temp_renew)
  nuke<-nuke%>%
    bind_rows(temp_nuke)
  fossil<-fossil%>%
    bind_rows(temp_fossil)
}

#####################
# Generate OD data  #
#####################

eu_flows_clean = read_csv("https://raw.githubusercontent.com/BjnNowak/geocomputation/main/data/eu_flows_clean.csv")
eu_flows_sf = od::od_to_sf(eu_flows_clean, mp_with_countries |> transmute(tolower(iso_a3)))
# plot(eu_flows_sf) # Example plot: it works!
# nrow(eu_flows_sf) # 1600
eu_flows_top_500 = eu_flows_sf |>
  arrange(desc(trade_value_usd_exp)) |>
  slice(1:500)

# test without russia 
eu_flows_no_russia <- eu_flows_top_500%>%
  filter(reporter_iso!='rus',partner_iso!='rus')


###############################################
# Third map : NDVI raster for Asia and Russia #
###############################################

asia<-mp_with_countries%>%
  filter(continent=='Asia'|name=='Russia')
  #filter(continent=='Asia'|name=='Russia'|continent=='Europe')

# Load raster
url<-'https://zenodo.org/records/10476056/files/smoothed_NDVI_May_2020.tif?download=1'

ndvi<-terra::rast(url)%>%
  # reproject to Robinson
  project(method="near", "+proj=robin", mask=TRUE)%>%
  # crop to Asia borders
  crop(asia,mask=TRUE)

# Set band name to NDVI
names(ndvi)<-'NDVI'

##################
# Make final map #
##################

# Color palette for buffers 
pal<-moma.colors("Flash" , n=22, type="continuous")
alp<-1 # optional parameter to add transparencies to buffer
col_lv1<-alpha(pal[1],alp)
col_lv2<-alpha(pal[6],alp)
col_lv3<-alpha(pal[9],alp)
col_lv4<-alpha(pal[12],alp)
col_lv5<-alpha(pal[15],alp)


col_world <- "#073B4C"
col_borders <- "grey80"
col_back <- "#1D201F"


pal_dis<-moma.colors("Lupi" , n=3, type="continuous")
pal_dis<-moma.colors("ustwo" , n=5, type="discrete")

alp_dorl<-0.05 # optional parameter to add transparencies to buffer
col_fossil <- alpha(pal_dis[1],alp_dorl)
col_nuke <- alpha(pal_dis[3],alp_dorl)
col_renew <- alpha(pal_dis[5],alp_dorl)

#kp_dorl <- c('ISL','FRO','NOR','FIN')

# color for Europe flows
col_trade <- 'white'

# NDVI color palette set from {scico}
pal_ndvi <- scico(17, palette = 'tokyo')

# Robinson bounding box
xlims<-c(-2200000,4500000)
ylims<-c(-2000000,8000000)

grat <- st_graticule(lat = c(-89.9, seq(-80, 80, 20), 89.9))

g = ggplot()+
  # Add basemap
  geom_sf(mp,mapping=aes(geometry=geometry),fill="#151529",color=alpha("white",0.15),lwd=0.1)+
  
  # Third map
  ###########
tidyterra::geom_spatraster(
  #data = ndvi%>%filter(NDVI>0) , 
  data = ndvi,
  aes(fill = NDVI),
  na.rm = TRUE,
  maxcell = 20e+05 # Low res for tests
  #maxcell = 300e+05
)+
  
  # First map
  ###########
# Add successive buffers
geom_sf(
  buff_list[[5]],mapping=aes(geometry=geom),
  fill=col_lv5,color=alpha("white",0)  
)+
  geom_sf(
    buff_list[[4]],mapping=aes(geometry=geom),
    fill=col_lv4,color=alpha("white",0)  
  )+
  geom_sf(
    buff_list[[3]],mapping=aes(geometry=geom),
    fill=col_lv3,color=alpha("white",0)  
  )+
  geom_sf(
    buff_list[[2]],mapping=aes(geometry=geom),
    fill=col_lv2,color=alpha("white",0)  
  )+
  geom_sf(
    buff_list[[1]],mapping=aes(geometry=geom),
    fill=col_lv1,color=alpha("white",0)  
  )+
  # Add countries borders above buffers
  geom_sf(mp_with_countries,mapping=aes(geometry=geometry),fill=NA,color=alpha("white",0.05),lwd=0.15)+
  # Add capitals labels
  geom_richtext(
    main_cp%>%filter(NAME%in%sel),
    #main_cp%>%head(100),
    mapping=aes(x=lon,y=lat,label=label),
    color=alpha("white",0.5), size=15, hjust=1,lineheight=0.15,
    family="ral",
    fill = NA, label.color = NA, # remove background and outline
    label.padding = grid::unit(rep(0, 4), "pt") # remove padding
    
  )+
  
  # Second map
  ############
# # Add main circles for Dorling cartogram
geom_circle(
   data = d3,
   #d3%>%filter(adm0_a3%in%kp_dorl),
   aes(x0 = X, y0 = Y, r = rad),
   color=alpha("white",0.25),
   fill="#6C809A",alpha=0.25,
   linewidth=0.05
 )+
  
# Add slices for Dorling cartogram
 geom_polygon(
   renew,
   #renew%>%filter(iso%in%kp_dorl),
   mapping=aes(x,y,group=iso),
   fill=col_renew,color=NA
 )+ 
 geom_polygon(
   nuke,
   #nuke%>%filter(iso%in%kp_dorl),
   mapping=aes(x,y,group=iso),
   fill=col_nuke,color=NA
 )+
 geom_polygon(
   fossil,
   #fossil%>%filter(iso%in%kp_dorl),
   mapping=aes(x,y,group=iso),
   fill=col_fossil,color=NA
 )+
  
  #geom_text(data = d3,aes(x = X, y = Y, label=adm0_a3),size=20)+

# Add flows
geom_sf(
  #eu_flows_top_500,
  eu_flows_no_russia, # looks much better without flows from Russia
  mapping=aes(size=trade_value_usd_exp,alpha=trade_value_usd_exp,geometry=geometry),
  color = col_trade
  #size=0.01
)+
  
  # Add graticule
  geom_sf(
    grat, mapping=aes(geometry=geometry),
    color=alpha("white",0.15)
  )+
  guides(fill='none',size='none',alpha='none')+
  scale_alpha(range=c(0.05,0.35))+
  # Color gradient for NDVI
  scale_fill_gradientn(
    colors=pal_ndvi,na.value = NA,
    limits=c(0,1),
    breaks=seq(0.1,0.9,0.1)
  )+
  # Center map
  scale_x_continuous(limits=xlims)+
  scale_y_continuous(limits=ylims)+
  # Custom theme (color background can be changed here)
  theme_void()+
  theme(plot.background = element_rect(fill="#191930",color="#191930"))
# g
g

ggsave("/tmp/test-map.png", g, width=15.6,height=23.4,unit='cm',dpi=600)
browseURL("/tmp/test-map.png")







