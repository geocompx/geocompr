# Aim: generate plot to show the concept of spatial congruence
devtools::install_github("robinlovelace/ukboundaries")
library(sf)
library(tmap)
library(ukboundaries)
# data(package = "ukboundaries") # see datasets available
sel_wetherby = grepl("001|002", msoa2011_lds$geo_label)
aggzones = msoa2011_lds[sel_wetherby, ]

# find lsoas in the aggzones (there must be a neater way...)
lsoa_touching = lsoa2011_simple[aggzones, ]
lsoa_cents = st_centroid(lsoa_touching)
lsoa_cents = lsoa_cents[aggzones, ]
congruent = lsoa2011_simple[lsoa_cents, ]

# same for ed zones
ed_touching = ed1981[aggzones, ]
ed_cents = st_centroid(ed_touching)
ed_cents = ed_cents[aggzones, ]
incongruent = ed1981[ed_cents, ]

# Bind the two types of shape together


tmap_mode("view")
qtm(aggzones, borders = "black") +
  qtm(congruent, fill = "blue", borders = "grey") +
  qtm(incongruent, fill = "yellow", borders = "white")
