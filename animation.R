library(wbstats)
library(rnaturalearth)
library(viridis)
library(gganimate)
library(sf)
library(tidyverse)
options(scipen = 999)

wb_data_create <- function(indicator, our_name, year, ...){
        df <- wb(indicator = indicator, startdate = year, enddate = year, ...) %>%
                as_data_frame() %>%
                select(iso_a2=iso2c, value) %>%
                mutate(indicator = our_name) %>%
                spread(indicator, value)
        return(df)
}

data_pop <- seq(1963, 2013, by=5) %>%
        set_names(.) %>%
        map_df(~wb_data_create(.x, indicator = "SP.POP.TOTL",
                               our_name = "pop",
                               country = "countries_only"), .id='year') %>%
        spread(year, pop)

world_sf_temporal <- ne_countries(returnclass = 'sf') %>%
        left_join(., data_pop, by = c('iso_a2')) %>%
        mutate(area_km2 = raster::area(as(., "Spatial")) / 1000000) %>%
        select(iso_a2, name_long, continent, region_un, subregion, type, area_km2, `1963`:`2013`) %>%
        gather(year, pop, `1963`:`2013`)

p <- ggplot(world_sf_temporal, aes(fill = round(pop/1000000, 2), frame = year)) +
        geom_sf() +
        scale_fill_viridis(name='Population (mln):', trans = "log10",
                           breaks=c(0.1, 1, 10, 100, 1000), option = "B") +
        scale_y_continuous(expand = c(0,0)) +
        scale_x_continuous(expand = c(0,0)) +
        theme_void() +
        # theme(legend.position = c(.15, .4)) +
        coord_sf()

gganimate(p, filename = 'plot1.gif')

world_sf_temporal2 <- filter(world_sf_temporal, !(continent %in% c("Seven seas (open ocean)", "Antarctica")))

p2 <- ggplot(world_sf_temporal2, aes(fill = round(pop/1000000, 2), frame = year)) +
        geom_sf() +
        scale_fill_viridis(name='Population (mln):', trans = "log10",
                           breaks=c(0.1, 1, 10, 100, 1000), option = "B") +
        scale_y_continuous(expand = c(0,0)) +
        scale_x_continuous(expand = c(0,0)) +
        theme_void() +
        facet_wrap(~continent, scales='free') +
        coord_sf()

gganimate(p2, filename = 'plot2.gif')

world_sf_temporal3 <- filter(world_sf_temporal, continent == 'Africa')

p3 <- ggplot(world_sf_temporal3, aes(fill = round(pop/1000000, 2), frame = year)) +
        geom_sf() +
        scale_fill_viridis(name='Population (mln):', trans = "log10",
                           breaks=c(0.1, 1, 10, 100, 1000), option = "B") +
        scale_y_continuous(expand = c(0,0)) +
        scale_x_continuous(expand = c(0,0)) +
        theme_void() +
        facet_wrap(~name_long, scales='free') +
        coord_sf()

gganimate(p3, filename = 'plot3.gif')
