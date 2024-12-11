# (PART) Extensions {-}

# Making maps with R {#adv-map}



## Prerequisites {-}

- This chapter requires the following packages that we have already been using:


``` r
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)
```

- The main package used in this chapter is **tmap**. 
We recommend you to install its development version from the [r-universe](https://r-universe.dev/) repository, which is updated more frequently than the CRAN version:


``` r
install.packages("tmap", repos = c("https://r-tmap.r-universe.dev",
                                   "https://cloud.r-project.org"))
```

- It uses the following visualization packages (also install **shiny** if you want to develop interactive mapping applications):


``` r
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package
```

- You also need to read-in a couple of datasets as follows for Section \@ref(spatial-ras):


``` r
nz_elev = rast(system.file("raster/nz_elev.tif", package = "spDataLarge"))
```

## Introduction

A satisfying and important aspect of geographic research is communicating the results.
Map-making\index{map-making} --- the art of cartography --- is an ancient skill involving communication, attention to detail, and an element of creativity.
Static mapping in R is straightforward with the `plot()` function, as we saw in Section \@ref(basic-map).
It is possible to create advanced maps using base R methods [@murrell_r_2016].
The focus of this chapter, however, is cartography with dedicated map-making packages.
When learning a new skill, it makes sense to gain depth-of-knowledge in one area before branching out.
Map-making is no exception, hence this chapter's coverage of one package (**tmap**) in depth rather than many superficially.

In addition to being fun and creative, cartography also has important practical applications.
A carefully crafted map can be the best way of communicating the results of your work, but poorly designed maps can leave a bad impression.
Common design issues include poor placement, size and readability of text and careless selection of colors, as outlined in the [style guide](https://files.taylorandfrancis.com/TJOM-suppmaterial-quick-guide.pdf) of the *Journal of Maps*.
Furthermore, poor map-making can hinder the communication of results [@brewer_designing_2015]:

> Amateur-looking maps can undermine your audience’s ability to understand important information and weaken the presentation of a professional data investigation.
Maps have been used for several thousand years for a wide variety of purposes.
Historic examples include maps of buildings and land ownership in the Old Babylonian dynasty more than 3000 years ago and Ptolemy's world map in his masterpiece *Geography*\index{geography} nearly 2000 years ago [@talbert_ancient_2014].

Map-making has historically been an activity undertaken only by, or on behalf of, the elite.
This has changed with the emergence of open source mapping software such as the R package **tmap** and the 'print layout' in QGIS\index{QGIS}, which allow anyone to make high-quality maps, enabling 'citizen science'.
Maps are also often the best way to present the findings of geocomputational research in a way that is accessible.
Map-making is therefore a critical part of geocomputation\index{geocomputation} and its emphasis is not only on describing, but also *changing* the world.

This chapter shows how to make a wide range of maps.
The next section covers a range of static maps, including aesthetic considerations, facets and inset maps.
Sections \@ref(animated-maps) to \@ref(mapping-applications) cover animated and interactive maps (including web maps and mapping applications).
Finally, Section \@ref(other-mapping-packages) covers a range of alternative map-making packages including **ggplot2** and **cartogram**.

## Static maps

\index{map-making!static maps}
Static maps are the most common type of visual output from geocomputation.
They are usually stored in standard formats including `.png` and `.pdf` for *graphical* raster and vector outputs, respectively.
Initially, static maps were the only type of maps that R could produce.
Things have advanced with the release of **sp** [see @pebesma_classes_2005], and many map-making techniques, functions, and packages have been developed since then.
However, despite the innovation of interactive mapping, static plotting was still the emphasis of geographic data visualization in R a decade later [@cheshire_spatial_2015].

The generic `plot()` function is often the fastest way to create static maps from vector and raster spatial objects (see Sections \@ref(basic-map) and \@ref(basic-map-raster)).
Sometimes, simplicity and speed are priorities, especially during the development phase of a project, and this is where `plot()` excels.
The base R approach is also extensible, with `plot()` offering dozens of arguments.
Another approach is the **grid** package which allows low-level control of static maps, as illustrated in chapter [14](https://www.stat.auckland.ac.nz/~paul/RG2e/chapter14.html) of @murrell_r_2016.
This part of the book focuses on **tmap** and emphasizes the essential aesthetic and layout options.

\index{tmap (package)}
**tmap** is a powerful and flexible map-making package with sensible defaults.
It has a concise syntax that allows for the creation of attractive maps with minimal code which will be familiar to **ggplot2** users.
It also has the unique capability to generate static and interactive maps using the same code via `tmap_mode()`.
Finally, it accepts a wider range of spatial classes (including **sf** and **terra** objects) than alternatives such as **ggplot2**.

### tmap basics

\index{tmap (package)!basics}
Like **ggplot2**, **tmap** is based on the idea of a 'grammar of graphics' [@wilkinson_grammar_2005].
This involves a separation between the input data and the aesthetics (how data are visualized): each input dataset can be 'mapped' in a range of different ways including location on the map (defined by data's `geometry`), color, and other visual variables.
The basic building block is `tm_shape()` (which defines input data: a vector or raster object), followed by one or more layer elements such as `tm_fill()` and `tm_dots()`.
This layering is demonstrated in the chunk below, which generates the maps presented in Figure \@ref(fig:tmshape):


``` r
# Add fill layer to nz shape
tm_shape(nz) +
  tm_fill() 
# Add border layer to nz shape
tm_shape(nz) +
  tm_borders() 
# Add fill and border layers to nz shape
tm_shape(nz) +
  tm_fill() +
  tm_borders() 
```

<div class="figure" style="text-align: center">
<img src="figures/tmshape-1.png" alt="New Zealand's shape plotted with fill (left), border (middle) and fill and border (right) layers added using tmap functions." width="100%" />
<p class="caption">(\#fig:tmshape)New Zealand's shape plotted with fill (left), border (middle) and fill and border (right) layers added using tmap functions.</p>
</div>

The object passed to `tm_shape()` in this case is `nz`, an `sf` object representing the regions of New Zealand (see Section \@ref(intro-sf) for more on `sf` objects).
Layers are added to represent `nz` visually, with `tm_fill()` and `tm_borders()` creating shaded areas (left panel) and border outlines (middle panel) in Figure \@ref(fig:tmshape), respectively.

\index{map-making!layers}
This is an intuitive approach to map-making:
the common task of *adding* new layers is undertaken by the addition operator `+`, followed by `tm_*()`.
The asterisk (\*) refers to a wide range of layer types which have self-explanatory names including:

- `tm_fill()`: shaded areas for (multi)polygons
- `tm_borders()`: border outlines for (multi)polygons
- `tm_polygons()`: both, shaded areas and border outlines for (multi)polygons
- `tm_lines()`: lines for (multi)linestrings<!--tm_iso()`?-->
- `tm_symbols()`: symbols for (multi)points, (multi)linestrings, and (multi)polygons
- `tm_raster()`: colored cells of raster data (there is also `tm_rgb()` for rasters with three layers)
- `tm_text()`: text information for (multi)points, (multi)linestrings, and (multi)polygons

This layering is illustrated in the right panel of Figure \@ref(fig:tmshape), the result of adding a border *on top of* the fill layer.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">`qtm()` is a handy function to create **q**uick **t**hematic **m**aps (hence the snappy name).
It is concise and provides a good default visualization in many cases:
`qtm(nz)`, for example, is equivalent to `tm_shape(nz) + tm_fill() + tm_borders()`.
Further, layers can be added concisely using multiple `qtm()` calls, such as `qtm(nz) + qtm(nz_height)`.
The disadvantage is that it makes aesthetics of individual layers harder to control, explaining why we avoid teaching it in this chapter.</div>\EndKnitrBlock{rmdnote}

### Map objects {#map-obj}

A useful feature of **tmap** is its ability to store *objects* representing maps.
The code chunk below demonstrates this by saving the last plot in Figure \@ref(fig:tmshape) as an object of class `tmap` (note the use of `tm_polygons()` which condenses `tm_fill()  + tm_borders()` into a single function):


``` r
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)
#> [1] "tmap"
```

`map_nz` can be plotted later, for example by adding other layers (as shown below) or simply running `map_nz` in the console, which is equivalent to `print(map_nz)`.

New *shapes* can be added with `+ tm_shape(new_obj)`.
In this case, `new_obj` represents a new spatial object to be plotted on top of preceding layers.
When a new shape is added in this way, all subsequent aesthetic functions refer to it, until another new shape is added.
This syntax allows the creation of maps with multiple shapes and layers, as illustrated in the next code chunk which uses the function `tm_raster()` to plot a raster layer (with `col_alpha` set to make the layer semi-transparent):


``` r
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(col_alpha = 0.7)
```

Building on the previously created `map_nz` object, the preceding code creates a new map object `map_nz1` that contains another shape (`nz_elev`) representing average elevation across New Zealand (see Figure \@ref(fig:tmlayers), left).
More shapes and layers can be added, as illustrated in the code chunk below which creates `nz_water`, representing New Zealand's [territorial waters](https://en.wikipedia.org/wiki/Territorial_waters), and adds the resulting lines to an existing map object.


``` r
nz_water = st_union(nz) |>
  st_buffer(22200) |> 
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()
```

There is no limit to the number of layers or shapes that can be added to `tmap` objects, and the same shape can even be used multiple times.
The final map illustrated in Figure \@ref(fig:tmlayers) is created by adding a layer representing high points (stored in the object `nz_height`) onto the previously created `map_nz2` object with `tm_symbols()` (see `?tm_symbols` for details on **tmap**'s point plotting functions).
The resulting map, which has four layers, is illustrated in the right-hand panel of Figure \@ref(fig:tmlayers):


``` r
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_symbols()
```

\index{map-making!metaplot}
A useful and little known feature of **tmap** is that multiple map objects can be arranged in a single 'metaplot' with `tmap_arrange()`.
This is demonstrated in the code chunk below which plots `map_nz1` to `map_nz3`, resulting in Figure \@ref(fig:tmlayers).


``` r
tmap_arrange(map_nz1, map_nz2, map_nz3)
```

<div class="figure" style="text-align: center">
<img src="figures/tmlayers-1.png" alt="Maps with added layers to the final map of Figure 9.1." width="100%" />
<p class="caption">(\#fig:tmlayers)Maps with added layers to the final map of Figure 9.1.</p>
</div>

More elements can also be added with the `+` operator.
Aesthetic settings, however, are controlled by arguments to layer functions.

### Visual variables

\index{map-making!aesthetics}
\index{map-making!visual variables}
The plots in the previous section demonstrate **tmap**'s default aesthetic settings.
Gray shades are used for `tm_fill()` and  `tm_symbols()` layers and a continuous black line is used to represent lines created with `tm_lines()`.
Of course, these default values and other aesthetics can be overridden.
The purpose of this section is to show how.

There are two main types of map aesthetics: those that change with the data and those that are constant.
Unlike **ggplot2**, which uses the helper function `aes()` to represent variable aesthetics, **tmap** accepts a few aesthetic arguments, depending on a selected layer type:

- `fill`: fill color of a polygon
- `col`: color of a polygon border, line, point, or raster
- `lwd`: line width
- `lty`: line type
- `size`: size of a symbol
- `shape`: shape of a symbol

Additionally, we may customize the fill and border color transparency using `fill_alpha` and `col_alpha`.

To map a variable to an aesthetic, pass its column name to the corresponding argument, and to set a fixed aesthetic, pass the desired value instead.^[
If there is a clash between a fixed value and a column name, the column name takes precedence. This can be verified by running the next code chunk after running `nz$red = 1:nrow(nz)`.
]
The impact of setting these with fixed values is illustrated in Figure \@ref(fig:tmstatic).


``` r
ma1 = tm_shape(nz) + tm_polygons(fill = "red")
ma2 = tm_shape(nz) + tm_polygons(fill = "red", fill_alpha = 0.3)
ma3 = tm_shape(nz) + tm_polygons(col = "blue")
ma4 = tm_shape(nz) + tm_polygons(lwd = 3)
ma5 = tm_shape(nz) + tm_polygons(lty = 2)
ma6 = tm_shape(nz) + tm_polygons(fill = "red", fill_alpha = 0.3,
                                 col = "blue", lwd = 3, lty = 2)
tmap_arrange(ma1, ma2, ma3, ma4, ma5, ma6)
```

<div class="figure" style="text-align: center">
<img src="figures/tmstatic-1.png" alt="Impact of changing commonly used fill and border aesthetics to fixed values." width="100%" />
<p class="caption">(\#fig:tmstatic)Impact of changing commonly used fill and border aesthetics to fixed values.</p>
</div>

Like base R plots, arguments defining aesthetics can also receive values that vary.
Unlike the base R code below (which generates the left panel in Figure \@ref(fig:tmcol)), **tmap** aesthetic arguments will not accept a numeric vector:


``` r
plot(st_geometry(nz), col = nz$Land_area)  # works
tm_shape(nz) + tm_fill(fill = nz$Land_area) # fails
#> Error: palette should be a character value
```

Instead `fill` (and other aesthetics that can vary such as `lwd` for line layers and `size` for point layers) requires a character string naming an attribute associated with the geometry to be plotted.
Thus, one would achieve the desired result as follows (Figure \@ref(fig:tmcol), right panel):


``` r
tm_shape(nz) + tm_fill(fill = "Land_area")
```

<div class="figure" style="text-align: center">
<img src="figures/tmcol-1.png" alt="Comparison of base (left) and tmap (right) handling of a numeric color field." width="45%" /><img src="figures/tmcol-2.png" alt="Comparison of base (left) and tmap (right) handling of a numeric color field." width="45%" />
<p class="caption">(\#fig:tmcol)Comparison of base (left) and tmap (right) handling of a numeric color field.</p>
</div>

Each visual variable has three related additional arguments, with suffixes of `.scale`, `.legend`, and `.free`.
For example, the `tm_fill()` function has arguments such as `fill`, `fill.scale`, `fill.legend`, and `fill.free`.
The `.scale` argument determines how the provided values are represented on the map and in the legend (Section \@ref(scales)), while the `.legend` argument is used to customize the legend settings, such as its title, orientation, or position (Section \@ref(legends)).
The `.free` argument is relevant only for maps with many facets to determine if each facet has the same or different scale and legend.

### Scales

\index{tmap (package)!scales}
Scales control how the values are represented on the map and in the legend, and they largely depend on the selected visual variable. 
For example, when our visual variable is `col`, then `col.scale` controls how the colors of spatial objects are related to the provided values; and when our visual variable is `size`, then `size.scale` controls how the sizes represent the provided values.
By default, the used scale is `tm_scale()`, which selects the visual settings automatically given by the input data type (factor, numeric, and integer).

\index{tmap (package)!color breaks}
Let's see how the scales work by customizing polygons' fill colors.
Color settings are an important part of map design -- they can have a major impact on how spatial variability is portrayed as illustrated in Figure \@ref(fig:tmpal).
This figure shows four ways of coloring regions in New Zealand depending on median income, from left to right (and demonstrated in the code chunk below):

- The default setting uses 'pretty' breaks, described in the next paragraph
- `breaks` allows you to manually set the breaks
- `n` sets the number of bins into which numeric variables are categorized
- `values` defines the color scheme, for example, `BuGn`


``` r
tm_shape(nz) + tm_polygons(fill = "Median_income")
tm_shape(nz) + tm_polygons(fill = "Median_income",
                        fill.scale = tm_scale(breaks = c(0, 30000, 40000, 50000)))
tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(n = 10))
tm_shape(nz) + tm_polygons(fill = "Median_income",
                           fill.scale = tm_scale(values = "BuGn"))
```

<div class="figure" style="text-align: center">
<img src="figures/tmpal-1.png" alt="Color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette." width="100%" />
<p class="caption">(\#fig:tmpal)Color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette.</p>
</div>

\BeginKnitrBlock{rmdnote}<div class="rmdnote">All of the above arguments (`breaks`, `n`, and `values`) also work for other types of visual variables.
For example, `values` expects a vector of colors or a palette name for `fill.scale` or `col.scale`, a vector of sizes for `size.scale`, or a vector of symbols for `shape.scale`.</div>\EndKnitrBlock{rmdnote}

\index{tmap (package)!break styles}
We are also able to customize scales using a family of functions that start with the `tm_scale_` prefix.
The most important ones are `tm_scale_intervals()`, `tm_scale_continuous()`, and `tm_scale_categorical()`.



\index{tmap (package)!interval scale}
The `tm_scale_intervals()` function splits the input data values into a set of intervals.
In addition to manually setting `breaks`, **tmap** allows users to specify algorithms to create breaks with the `style` argument automatically.
The default is `tm_scale_intervals(style = "pretty")`, which rounds breaks into whole numbers where possible and spaces them evenly.
Other options are listed below and presented in Figure \@ref(fig:break-styles).

- `style = "equal"`: divides input values into bins of equal range and is appropriate for variables with a uniform distribution (not recommended for variables with a skewed distribution as the resulting map may end up having little color diversity)
- `style = "quantile"`: ensures the same number of observations fall into each category (with the potential downside that bin ranges can vary widely)
- `style = "jenks"`: identifies groups of similar values in the data and maximizes the differences between categories
- `style = "log10_pretty"`: a common logarithmic (the logarithm to base 10) version of the regular pretty style used for variables with a right-skewed distribution

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Although `style` is an argument of **tmap** functions, in fact it originates as an argument in `classInt::classIntervals()` --- see the help page of this function for details.</div>\EndKnitrBlock{rmdnote}

<div class="figure" style="text-align: center">
<img src="figures/break-styles-1.png" alt="Different interval scale methods set using the style argument in tmap." width="100%" />
<p class="caption">(\#fig:break-styles)Different interval scale methods set using the style argument in tmap.</p>
</div>

\index{tmap (package)!continuous scale}
The `tm_scale_continuous()` function presents a continuous color field and is particularly suited for continuous rasters (Figure \@ref(fig:concat), left panel).
In case of variables with q skewed distribution, you can also use its variants -- `tm_scale_continuous_log()` and `tm_scale_continuous_log1p()`.
\index{tmap (package)!categorical scale}
Finally, `tm_scale_categorical()` was designed to represent categorical values and ensures that each category receives a unique color (Figure \@ref(fig:concat), right panel).

<div class="figure" style="text-align: center">
<img src="figures/concat-1.png" alt="Continuous and categorical scales in tmap." width="100%" />
<p class="caption">(\#fig:concat)Continuous and categorical scales in tmap.</p>
</div>

\index{tmap (package)!palettes}
Palettes define the color ranges associated with the bins and determined by the `tm_scale_*()` functions, and its `breaks` and `n` arguments described above.
It expects a vector of colors or a new color palette name, which can be found interactively with `cols4all::c4a_gui()`.
You can also add a `-` as the color palette name prefix to reverse the palette order.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">All of the default `values` of the visual variables, such as default color palettes for different types of input variables, can be found with `tmap_options()`.
For example, run `tmap_options()$values.var`.</div>\EndKnitrBlock{rmdnote}

\index{color palettes}
There are three main groups of color palettes\index{map-making!color palettes}: categorical, sequential and diverging (Figure \@ref(fig:colpal)), and each of them serves a different purpose.^[
A fourth group of color palettes, called bivariate, also exists.
They are used when we want to represent relations between two variables on one map.
]
Categorical palettes consist of easily distinguishable colors and are most appropriate for categorical data without any particular order such as state names or land cover classes.
Colors should be intuitive: rivers should be blue, for example, and pastures green.
Avoid too many categories: maps with large legends and many colors can be uninterpretable.^[`fill = "MAP_COLORS"` can be used in maps with a large number of individual polygons (for example, a map of individual countries) to create unique fill colors for adjacent polygons.]

The second group is sequential palettes.
These follow a gradient, for example from light to dark colors (light colors often tend to represent lower values), and are appropriate for continuous (numeric) variables.
Sequential palettes can be single (`greens` goes from light to dark green, for example) or multi-color/hue (`yl_gn_bu` is gradient from light yellow to blue via green, for example), as demonstrated in the code chunk below --- output not shown, run the code yourself to see the results!


``` r
tm_shape(nz) + 
  tm_polygons("Median_income", fill.scale = tm_scale(values = "greens"))
tm_shape(nz) + 
  tm_polygons("Median_income", fill.scale = tm_scale(values = "yl_gn_bu"))
```

The third group, diverging palettes, typically range between three distinct colors (purple-white-green in Figure \@ref(fig:colpal)) and are usually created by joining two single-color sequential palettes with the darker colors at each end.
Their main purpose is to visualize the difference from an important reference point, e.g., a certain temperature, the median household income or the mean probability for a drought event.
The reference point's value can be adjusted in **tmap** using the `midpoint` argument.


``` r
tm_shape(nz) + 
  tm_polygons("Median_income",
              fill.scale = tm_scale_continuous(values = "pu_gn_div", 
                                               midpoint = 28000))
```

<div class="figure" style="text-align: center">
<img src="figures/colpal-1.png" alt="Examples of categorical, sequential and diverging palettes." width="75%" />
<p class="caption">(\#fig:colpal)Examples of categorical, sequential and diverging palettes.</p>
</div>

There are two important principles for consideration when working with colors: perceptibility and accessibility.
Firstly, colors on maps should match our perception. 
This means that certain colors are viewed through our experience and also cultural lenses.
For example, green colors usually represent vegetation or lowlands, and blue is connected with water or coolness.
Color palettes should also be easy to understand to effectively convey information.
It should be clear which values are lower and which are higher, and colors should change gradually.
Secondly, changes in colors should be accessible to the largest number of people.
Therefore, it is important to use colorblind friendly palettes as often as possible.^[See the "Color vision" options and the "Color Blind Friendliness" panel in `cols4all::c4a_gui()`.]

### Legends

\index{tmap (package)!legends}
After we decided on our visual variable and its properties, we should move our attention toward the related map legend style.
Using the `tm_legend()` function, we may change its title, position, orientation, or even disable it.
The most important argument in this function is `title`, which sets the title of the associated legend.
In general, a map legend title should provide two pieces of information: what the legend represents and what the units are of the presented variable.
The following code chunk demonstrates this functionality by providing a more attractive name than the variable name `Land_area` (note the use of `expression()` to create superscript text):


``` r
legend_title = expression("Area (km"^2*")")
tm_shape(nz) +
  tm_polygons(fill = "Land_area", fill.legend = tm_legend(title = legend_title))
```

The default legend orientation in **tmap** is `"portrait"`, however, an alternative legend orientation, `"landscape"`, is also possible.
Other than that, we can also customize the location of the legend using the `position` argument.


``` r
tm_shape(nz) +
  tm_polygons(fill = "Land_area",
              fill.legend = tm_legend(title = legend_title,
                                      orientation = "landscape",
                                      position = tm_pos_out("center", "bottom")))
```



The legend position (and also the position of several other map elements in **tmap**) can be customized using one of a few functions.
The two most important are:

- `tm_pos_out()`: the default, adds the legend outside of the map frame area.
We can customize its location with two values that represent the horizontal position (`"left"`, `"center"`, or `"right"`), and the vertical position (`"bottom"`, `"center"`, or `"top"`)
- `tm_pos_in()`: puts the legend inside of the map frame area. 
We may decide on its position using two arguments, where the first one can be `"left"`, `"center"`, or `"right"`, and the second one can be  `"bottom"`, `"center"`, or `"top"`.

Alternatively, we may just provide a vector of two values (or two numbers between 0 and 1) here -- and in such case, the legend will be put inside the map frame.

### Layouts

\index{tmap (package)!layouts}
The map layout refers to the combination of all map elements into a cohesive map.
Map elements include among others the objects to be mapped, the map grid, the scale bar, the title, and margins, while the color settings covered in the previous section relate to the palette and breakpoints used to affect how the map looks.
Both may result in subtle changes that can have an equally large impact on the impression left by your maps.

Additional map elements such as graticules \index{tmap (package)!graticules}, north arrows\index{tmap (package)!north arrows}, scale bars\index{tmap (package)!scale bars} and map titles have their own functions: `tm_graticules()`, `tm_compass()`, `tm_scalebar()`, and `tm_title()` (Figure \@ref(fig:na-sb)).^[Another additional map elements include `tm_grid()`, `tm_logo()` and `tm_credits()`.]


``` r
map_nz + 
  tm_graticules() +
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scalebar(breaks = c(0, 100, 200), text.size = 1, position = c("left", "top")) +
  tm_title("New Zealand")
```

<div class="figure" style="text-align: center">
<img src="figures/na-sb-1.png" alt="Map with additional elements: a north arrow and scale bar." width="65%" />
<p class="caption">(\#fig:na-sb)Map with additional elements: a north arrow and scale bar.</p>
</div>

**tmap** also allows a wide variety of layout settings to be changed, some of which, produced using the following code (see `args(tm_layout)` or `?tm_layout` for a full list), are illustrated in Figure \@ref(fig:layout1).


``` r
map_nz + tm_layout(scale = 4)
map_nz + tm_layout(bg.color = "lightblue")
map_nz + tm_layout(frame = FALSE)
```

<div class="figure" style="text-align: center">
<img src="figures/layout1-1.png" alt="Layout options specified by (from left to right) scale, bg.color, and frame arguments." width="100%" />
<p class="caption">(\#fig:layout1)Layout options specified by (from left to right) scale, bg.color, and frame arguments.</p>
</div>

The other arguments in `tm_layout()` provide control over many more aspects of the map in relation to the canvas on which it is placed.
Here are some useful layout settings (some of which are illustrated in Figure \@ref(fig:layout2)):

- Margin settings including `inner.margin` and `outer.margin`
- Font settings controlled by `fontface` and `fontfamily`
- Legend settings including options such as `legend.show` (whether or not to show the legend) `legend.orientation`, `legend.position`, and `legend.frame`
- Frame width (`frame.lwd`) and an option to allow double lines (`frame.double.line`)
- Color settings controlling `color.sepia.intensity` (how *yellowy* the map looks) and `color.saturation` (a color-grayscale)

<div class="figure" style="text-align: center">
<img src="figures/layout2-1.png" alt="Selected layout options." width="100%" />
<p class="caption">(\#fig:layout2)Selected layout options.</p>
</div>

### Faceted maps

\index{map-making!faceted maps}
\index{tmap (package)!faceted maps}
Faceted maps, also referred to as 'small multiples', are composed of many maps arranged side-by-side, and sometimes stacked vertically [@meulemans_small_2017].
Facets enable the visualization of how spatial relationships change with respect to another variable, such as time.
The changing populations of settlements, for example, can be represented in a faceted map with each panel representing the population at a particular moment in time.
The time dimension could be represented via another *visual variable* such as color.
However, this risks cluttering the map because it will involve multiple overlapping points (cities do not tend to move over time!).

Typically all individual facets in a faceted map contain the same geometry data repeated multiple times, once for each column in the attribute data (this is the default plotting method for `sf` objects, see Chapter \@ref(spatial-class)).
However, facets can also represent shifting geometries such as the evolution of a point pattern over time.
This use case of a faceted plot is illustrated in Figure \@ref(fig:urban-facet).


``` r
urb_1970_2030 = urban_agglomerations |> 
  filter(year %in% c(1970, 1990, 2010, 2030))

tm_shape(world) +
  tm_polygons() +
  tm_shape(urb_1970_2030) +
  tm_symbols(fill = "black", col = "white", size = "population_millions") +
  tm_facets_wrap(by = "year", nrow = 2)
```

<div class="figure" style="text-align: center">
<img src="figures/urban-facet-1.png" alt="Faceted map showing the top 30 largest urban agglomerations from 1970 to 2030 based on population projections by the United Nations." width="100%" />
<p class="caption">(\#fig:urban-facet)Faceted map showing the top 30 largest urban agglomerations from 1970 to 2030 based on population projections by the United Nations.</p>
</div>

The preceding code chunk demonstrates key features of faceted maps created using the `tm_facets_wrap()` function:

- Shapes that do not have a facet variable are repeated (countries in `world` in this case)
- The `by` argument which varies depending on a variable (`"year"` in this case)
- The `nrow`/`ncol` setting specifying the number of rows and columns that facets should be arranged into

Alternatively, it is possible to use the `tm_facets_grid()` function that allows to have facets based on up to three different variables: one for `rows`, one for `columns`, and possibly one for `pages`.

In addition to their utility for showing changing spatial relationships, faceted maps are also useful as the foundation for animated maps (see Section \@ref(animated-maps)).

### Inset maps

\index{map-making!inset maps}
\index{tmap (package)!inset maps}
An inset map is a smaller map rendered within or next to the main map. 
It could serve many different purposes, including providing a context (Figure \@ref(fig:insetmap1)) or bringing some non-contiguous regions closer to ease their comparison (Figure \@ref(fig:insetmap2)).
They could be also used to focus on a smaller area in more detail or to cover the same area as the map, but representing a different topic.

In the example below, we create a map of the central part of New Zealand's Southern Alps.
Our inset map will show where the main map is in relation to the whole New Zealand.
The first step is to define the area of interest, which can be done by creating a new spatial object, `nz_region`.


``` r
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000,
                      ymin = 5130000, ymax = 5210000),
                    crs = st_crs(nz_height)) |> 
  st_as_sfc()
```

In the second step, we create a base-map showing New Zealand's Southern Alps area. 
This is a place where the most important message is stated. 


``` r
nz_height_map = tm_shape(nz_elev, bbox = nz_region) +
  tm_raster(col.scale = tm_scale_continuous(values = "YlGn"),
            col.legend = tm_legend(position = c("left", "top"))) +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 1) +
  tm_scalebar(position = c("left", "bottom"))
```

The third step consists of the inset map creation. 
It gives a context and helps to locate the area of interest. 
Importantly, this map needs to clearly indicate the location of the main map, for example by stating its borders.


``` r
nz_map = tm_shape(nz) + tm_polygons() +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) + tm_borders(lwd = 3) +
  tm_layout(bg.color = "lightblue")
```

One of the main differences between regular charts (e.g., scatterplots) and maps is that the input data determine the aspect ratio of maps.
Thus, in this case, we need to calculate the aspect ratios of our two main datasets, `nz_region` and `nz`.
The following function, `norm_dim()` returns the normalized width (`"w"`) and height (`"h"`) of the object (as `"snpc"` units understood by the graphic device).


``` r
library(grid)
norm_dim = function(obj){
    bbox = st_bbox(obj)
    width = bbox[["xmax"]] - bbox[["xmin"]]
    height = bbox[["ymax"]] - bbox[["ymin"]]
    w = width / max(width, height)
    h = height / max(width, height)
    return(unit(c(w, h), "snpc"))
}
main_dim = norm_dim(nz_region)
ins_dim = norm_dim(nz)
```

Next, knowing the aspect ratios, we need to specify the sizes and locations of our two maps -- the main map and the inset map -- using the `viewport()` function.
A viewport is part of a graphics device we use to draw the graphical elements at a given moment.
The viewport of our main map is just the representation of its aspect ratio.


``` r
main_vp = viewport(width = main_dim[1], height = main_dim[2])
```

On the other hand, the viewport of the inset map needs to specify its size and location.
Here, we would make the inset map twice smaller as the main one by multiplying the width and height by 0.5, and we will locate it 0.5 cm from the bottom right of the main map frame.


``` r
ins_vp = viewport(width = ins_dim[1] * 0.5, height = ins_dim[2] * 0.5,
                  x = unit(1, "npc") - unit(0.5, "cm"), y = unit(0.5, "cm"),
                  just = c("right", "bottom"))
```

Finally, we combine the two maps by creating a new, blank canvas, printing out the main map, and then placing the inset map inside of the main map viewport.


``` r
grid.newpage()
print(nz_height_map, vp = main_vp)
pushViewport(main_vp)
print(nz_map, vp = ins_vp)
```

<div class="figure" style="text-align: center">
<img src="figures/insetmap1-1.png" alt="Inset map providing a context -- location of the central part of the Southern Alps in New Zealand." width="100%" />
<p class="caption">(\#fig:insetmap1)Inset map providing a context -- location of the central part of the Southern Alps in New Zealand.</p>
</div>

Inset maps can be saved to file either by using a graphic device (see Section \@ref(visual-outputs)) or the `tmap_save()` function and its arguments: `insets_tm` and `insets_vp`.

Inset maps are also used to create one map of non-contiguous areas.
Probably, the most often used example is a map of the United States, which consists of the contiguous United States, Hawaii and Alaska.
It is very important to find the best projection for each individual inset in these types of cases (see Chapter \@ref(reproj-geo-data) to learn more).
We can use US National Atlas Equal Area for the map of the contiguous United States by putting its EPSG code in the `crs` argument of `tm_shape()`.


``` r
us_states_map = tm_shape(us_states, crs = "EPSG:9311") + 
  tm_polygons() + 
  tm_layout(frame = FALSE)
```

The rest of our objects, `hawaii` and `alaska`, already have proper projections; therefore, we just need to create two separate maps:


``` r
hawaii_map = tm_shape(hawaii) +
  tm_polygons() + 
  tm_title("Hawaii") +
  tm_layout(frame = FALSE, bg.color = NA, 
            title.position = c("LEFT", "BOTTOM"))
alaska_map = tm_shape(alaska) +
  tm_polygons() + 
  tm_title("Alaska") +
  tm_layout(frame = FALSE, bg.color = NA)
```

The final map is created by combining, resizing and arranging these three maps:


``` r
us_states_map
print(hawaii_map, vp = grid::viewport(0.35, 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = grid::viewport(0.15, 0.15, width = 0.3, height = 0.3))
```

<div class="figure" style="text-align: center">
<img src="figures/insetmap2-1.png" alt="Map of the United States." width="100%" />
<p class="caption">(\#fig:insetmap2)Map of the United States.</p>
</div>

The code presented above is compact and can be used as the basis for other inset maps, but the results, in Figure \@ref(fig:insetmap2), provide a poor representation of the locations and sizes of Hawaii and Alaska.
For a more in-depth approach, see the [`us-map`](https://geocompx.github.io/geocompkg/articles/us-map.html) vignette from the **geocompkg**.

## Animated maps

\index{map-making!animated maps}
\index{tmap (package)!animated maps}
Faceted maps, described in Section \@ref(faceted-maps), can show how spatial distributions of variables change (e.g., over time), but the approach has disadvantages.
Facets become tiny when there are many of them.
Furthermore, the fact that each facet is physically separated on the screen or page means that subtle differences between facets can be hard to detect.

Animated maps solve these issues.
Although they depend on digital publication, this is becoming less of an issue as more and more content moves online.
Animated maps can still enhance paper reports: you can always link readers to a webpage containing an animated (or interactive) version of a printed map to help make it come alive.
There are several ways to generate animations in R, including with animation packages such as **gganimate**, which builds on **ggplot2** (see Section \@ref(other-mapping-packages)).
This section focuses on creating animated maps with **tmap** because its syntax will be familiar from previous sections and the flexibility of the approach.

Figure \@ref(fig:urban-animated) is a simple example of an animated map.
Unlike the faceted plot, it does not squeeze multiple maps into a single screen and allows the reader to see how the spatial distribution of the world's most populous agglomerations evolve over time (see the book's website for the animated version).

<div class="figure" style="text-align: center">
<img src="images/urban-animated.gif" alt="Animated map showing the top 30 largest urban agglomerations from 1950 to 2030 based on population projects by the United Nations. Animated version available online at: r.geocompx.org." width="100%" />
<p class="caption">(\#fig:urban-animated)Animated map showing the top 30 largest urban agglomerations from 1950 to 2030 based on population projects by the United Nations. Animated version available online at: r.geocompx.org.</p>
</div>



The animated map illustrated in Figure \@ref(fig:urban-animated) can be created using the same **tmap** techniques that generate faceted maps, demonstrated in Section \@ref(faceted-maps).
There are two differences, however, related to arguments in `tm_facets_wrap()`:

- `nrow = 1, ncol = 1` are added to keep one moment in time as one layer
- `free.coords = FALSE`, which maintains the map extent for each map iteration

These additional arguments are demonstrated in the subsequent code chunk^[There is also a shortcut for this approach: `tm_facets_pagewise()`.]:


``` r
urb_anim = tm_shape(world) + tm_polygons() + 
  tm_shape(urban_agglomerations) + tm_symbols(size = "population_millions") +
  tm_facets_wrap(by = "year", nrow = 1, ncol = 1, free.coords = FALSE)
```

The resulting `urb_anim` represents a set of separate maps for each year.
The final stage is to combine them and save the result as a `.gif` file with `tmap_animation()`.
The following command creates the animation illustrated in Figure \@ref(fig:urban-animated), with a few elements missing, that we will add during the exercises:


``` r
tmap_animation(urb_anim, filename = "urb_anim.gif", delay = 25)
```

Another illustration of the power of animated maps is provided in Figure \@ref(fig:animus).
This shows the development of states in the United States, which first formed in the east and then incrementally to the west and finally into the interior.
Code to reproduce this map can be found in the script `code/09-usboundaries.R` in the book GitHub repository.



<div class="figure" style="text-align: center">
<img src="https://user-images.githubusercontent.com/1825120/38543030-5794b6f0-3c9b-11e8-9da9-10ec1f3ea726.gif" alt="Animated map showing population growth, state formation and boundary changes in the United States, 1790-2010. Animated version available online at r.geocompx.org." width="100%" />
<p class="caption">(\#fig:animus)Animated map showing population growth, state formation and boundary changes in the United States, 1790-2010. Animated version available online at r.geocompx.org.</p>
</div>

## Interactive maps

\index{map-making!interactive maps}
\index{tmap (package)!interactive maps}
While static and animated maps can enliven geographic datasets, interactive maps can take them to a new level.
Interactivity can take many forms, the most common and useful of which is the ability to pan around and zoom into any part of a geographic dataset overlaid on a 'web map' to show context.
Less advanced interactivity levels include pop-ups which appear when you click on different features, a kind of interactive label.
More advanced levels of interactivity include the ability to tilt and rotate maps, as demonstrated in the **mapdeck** example below, and the provision of "dynamically linked" sub-plots which automatically update when the user pans and zooms [@pezanowski_senseplace3_2018].

The most important type of interactivity, however, is the display of geographic data on interactive or 'slippy' web maps.
The release of the **leaflet** package in 2015 (that uses the leaflet JavaScript library) revolutionized interactive web map creation from within R, and a number of packages have built on these foundations adding new features (e.g., **leaflet.extras2**) and making the creation of web maps as simple as creating static maps (e.g., **mapview** and **tmap**).
This section illustrates each approach in the opposite order.
We will explore how to make slippy maps with **tmap** (the syntax of which we have already learned), **mapview**\index{mapview (package)}, **mapdeck**\index{mapdeck (package)} and finally **leaflet**\index{leaflet (package)} (which provides low-level control over interactive maps).

A unique feature of **tmap** mentioned in Section \@ref(static-maps) is its ability to create static and interactive maps using the same code.
Maps can be viewed interactively at any point by switching to view mode, using the command `tmap_mode("view")`.
This is demonstrated in the code below, which creates an interactive map of New Zealand based on the `tmap` object `map_nz`, created in Section \@ref(map-obj), and illustrated in Figure \@ref(fig:tmview):


``` r
tmap_mode("view")
map_nz
```

<div class="figure" style="text-align: center">
<iframe src="https://geocompx.org/static/img/tmview-1.html" width="100%" height="400px" data-external="1"></iframe>
<p class="caption">(\#fig:tmview)Interactive map of New Zealand created with tmap in view mode. Interactive version available online at: r.geocompx.org.</p>
</div>

Now that the interactive mode has been 'turned on', all maps produced with **tmap** will launch (another way to create interactive maps is with the `tmap_leaflet()` function).
Notable features of this interactive mode include the ability to specify the basemap  with `tm_basemap()` (or `tmap_options()`) as demonstrated below (result not shown):


``` r
map_nz + tm_basemap(server = "OpenTopoMap")
```

An impressive and little-known feature of **tmap**'s view mode is that it also works with faceted plots.
The argument `sync` in `tm_facets_wrap()` can be used in this case to produce multiple maps with synchronized zoom and pan settings, as illustrated in Figure \@ref(fig:sync), which was produced by the following code:


``` r
world_coffee = left_join(world, coffee_data, by = "name_long")
facets = c("coffee_production_2016", "coffee_production_2017")
tm_shape(world_coffee) + tm_polygons(facets) + 
  tm_facets_wrap(nrow = 1, sync = TRUE)
```

<div class="figure" style="text-align: center">
<img src="images/interactive-facets.png" alt="Faceted interactive maps of global coffee production in 2016 and 2017 in sync, demonstrating tmap's view mode in action." width="100%" />
<p class="caption">(\#fig:sync)Faceted interactive maps of global coffee production in 2016 and 2017 in sync, demonstrating tmap's view mode in action.</p>
</div>

Switch **tmap** back to plotting mode with the same function:


``` r
tmap_mode("plot")
#> ℹ tmap mode set to "plot".
```

If you are not proficient with **tmap**, the quickest way to create interactive maps in R may be with **mapview**\index{mapview (package)}.
The following 'one liner' is a reliable way to interactively explore a wide range of geographic data formats:


``` r
mapview::mapview(nz)
```

<div class="figure" style="text-align: center">
<img src="images/mapview.png" alt="Illustration of mapview in action." width="100%" />
<p class="caption">(\#fig:mapview)Illustration of mapview in action.</p>
</div>

**mapview** has a concise syntax, yet, it is powerful.
By default, it has some standard GIS functionality such as mouse position information, attribute queries (via pop-ups), scale bar, and zoom-to-layer buttons.
It also offers advanced controls including the ability to 'burst' datasets into multiple layers and the addition of multiple layers with `+` followed by the name of a geographic object. 
Additionally, it provides automatic coloring of attributes via the `zcol` argument.
In essence, it can be considered a data-driven **leaflet** API\index{API} (see below for more information about **leaflet**). 
Given that **mapview** always expects a spatial object (including `sf` and `SpatRaster`) as its first argument, it works well at the end of piped expressions. 
Consider the following example where **sf** is used to intersect lines and polygons and then is visualized with **mapview** (Figure \@ref(fig:mapview2)).


``` r
library(mapview)
oberfranken = subset(franconia, district == "Oberfranken")
trails |>
  st_transform(st_crs(oberfranken)) |>
  st_intersection(oberfranken) |>
  st_collection_extract("LINESTRING") |>
  mapview(color = "red", lwd = 3, layer.name = "trails") +
  mapview(franconia, zcol = "district") +
  breweries
```

<div class="figure" style="text-align: center">
<img src="images/mapview-example.png" alt="Using mapview at the end of an sf-based pipe expression." width="100%" />
<p class="caption">(\#fig:mapview2)Using mapview at the end of an sf-based pipe expression.</p>
</div>

One important thing to keep in mind is that **mapview** layers are added via the `+` operator (similar to **ggplot2** or **tmap**).
By default, **mapview** uses the leaflet JavaScript library to render the output maps, which is user-friendly and has a lot of features.
However, some alternative rendering libraries could be more performant (work more smoothly on larger datasets).
**mapview** allows to set alternative rendering libraries (`"leafgl"` and `"mapdeck"`) in the `mapviewOptions()`.^[You may also try to use `mapviewOptions(georaster = TRUE)` for more performant visualizations of large raster data.]
For further information on **mapview**, see the package's website at: [r-spatial.github.io/mapview/](https://r-spatial.github.io/mapview/articles/).

There are other ways to create interactive maps with R.
The **googleway** package\index{googleway (package)}, for example, provides an interactive mapping interface that is flexible and extensible
(see the [`googleway-vignette`](https://cran.r-project.org/package=googleway/vignettes/googleway-vignette.html) for details).
Another approach by the same author is **[mapdeck](https://github.com/SymbolixAU/mapdeck)**, which provides access to Uber's `Deck.gl` framework\index{mapdeck (package)}.
Its use of WebGL enables it to interactively visualize large datasets up to millions of points.
The package uses Mapbox [access tokens](https://docs.mapbox.com/help/getting-started/access-tokens/), which you must register for before using the package.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Note that the following block assumes the access token is stored in your R environment as `MAPBOX=your_unique_key`.
This can be added with `usethis::edit_r_environ()`.</div>\EndKnitrBlock{rmdnote}

A unique feature of **mapdeck** is its provision of interactive 2.5D perspectives, illustrated in Figure \@ref(fig:mapdeck).
This means you can can pan, zoom and rotate around the maps, and view the data 'extruded' from the map.
Figure \@ref(fig:mapdeck), generated by the following code chunk, visualizes road traffic crashes in the UK, with bar height representing casualties per area.




``` r
library(mapdeck)
set_token(Sys.getenv("MAPBOX"))
crash_data = read.csv("https://git.io/geocompr-mapdeck")
crash_data = na.omit(crash_data)
ms = mapdeck_style("dark")
mapdeck(style = ms, pitch = 45, location = c(0, 52), zoom = 4) |>
  add_grid(data = crash_data, lat = "lat", lon = "lng", cell_size = 1000,
           elevation_scale = 50, colour_range = hcl.colors(6, "plasma"))
```

<div class="figure" style="text-align: center">
<img src="images/mapdeck-mini.png" alt="Map generated by mapdeck, representing road traffic casualties across the UK. Height of 1-km cells represents number of crashes." width="100%" />
<p class="caption">(\#fig:mapdeck)Map generated by mapdeck, representing road traffic casualties across the UK. Height of 1-km cells represents number of crashes.</p>
</div>

You can zoom and drag the map in the browser, in addition to rotating and tilting it when pressing `Cmd`/`Ctrl`.
Multiple layers can be added with the pipe operator, as demonstrated in the [`mapdeck` vignettes](https://cran.r-project.org/package=mapdeck/vignettes/mapdeck.html). 
**mapdeck** also supports `sf` objects, as can be seen by replacing the `add_grid()` function call in the preceding code chunk with `add_polygon(data = lnd, layer_id = "polygon_layer")`, to add polygons representing London to an interactive tilted map.



Last is **leaflet** which is the most mature and widely used interactive mapping package in R\index{leaflet (package)}.
**leaflet** provides a relatively low-level interface to the Leaflet JavaScript library and many of its arguments can be understood by reading the documentation of the original JavaScript library (see [leafletjs.com](https://leafletjs.com/)).

Leaflet maps are created with `leaflet()`, the result of which is a `leaflet` map object which can be piped to other **leaflet** functions.
This allows multiple map layers and control settings to be added interactively, as demonstrated in the code below which generates Figure \@ref(fig:leaflet) (see [rstudio.github.io/leaflet/](https://rstudio.github.io/leaflet/) for details).


``` r
pal = colorNumeric("RdYlBu", domain = cycle_hire$nbikes)
leaflet(data = cycle_hire) |> 
  addProviderTiles(providers$CartoDB.Positron) |>
  addCircles(col = ~pal(nbikes), opacity = 0.9) |> 
  addPolygons(data = lnd, fill = FALSE) |> 
  addLegend(pal = pal, values = ~nbikes) |> 
  setView(lng = -0.1, 51.5, zoom = 12) |> 
  addMiniMap()
```

<div class="figure" style="text-align: center">
<img src="images/leaflet-1.png" alt="The leaflet package in action, showing cycle hire points in London. See interactive version [online](https://geocompr.github.io/img/leaflet.html)." width="100%" />
<p class="caption">(\#fig:leaflet)The leaflet package in action, showing cycle hire points in London. See interactive version [online](https://geocompr.github.io/img/leaflet.html).</p>
</div>

## Mapping applications

\index{map-making!mapping applications}
The interactive web maps demonstrated in Section \@ref(interactive-maps) can go far.
Careful selection of layers to display, basemaps and pop-ups can be used to communicate the main results of many projects involving geocomputation.
But the web mapping approach to interactivity has limitations:

- Although the map is interactive in terms of panning, zooming and clicking, the code is static, meaning the user interface is fixed
- All map content is generally static in a web map, meaning that web maps cannot scale to handle large datasets easily
- Additional layers of interactivity, such a graphs showing relationships between variables and 'dashboards', are difficult to create using the web mapping-approach

Overcoming these limitations involves going beyond static web mapping and toward geospatial frameworks and map servers.
Products in this field include [GeoDjango](https://docs.djangoproject.com/en/4.0/ref/contrib/gis/)\index{GeoDjango} (which extends the Django web framework and is written in [Python](https://github.com/django/django))\index{Python}, [MapServer](https://github.com/mapserver/mapserver)\index{MapServer} (a framework for developing web applications, largely written in C and C++)\index{C++} and [GeoServer](https://github.com/geoserver/geoserver) (a mature and powerful map server written in Java\index{Java}).
Each of these is scalable, enabling maps to be served to thousands of people daily, assuming there is sufficient public interest in your maps!
The bad news is that such server-side solutions require much skilled developer time to set up and maintain, often involving teams of people with roles such as a dedicated geospatial database administrator ([DBA](https://wiki.gis.com/wiki/index.php/Database_administrator)).

Fortunately for R programmers, web mapping applications can now be rapidly created with **shiny**.\index{shiny (package)}
As described in the open source book [Mastering Shiny](https://mastering-shiny.org/), **shiny** is an R package and framework for converting R code into interactive web applications [@wickham_mastering_2021].
You can embed interactive maps in shiny apps thanks to functions such as <!--`tmap::renderTmap()` and -->[`leaflet::renderLeaflet()`](https://rstudio.github.io/leaflet/shiny.html).
This section gives some context, teaches the basics of **shiny** from a web mapping perspective, and culminates in a full-screen mapping application in less than 100 lines of code.

**shiny** is well documented at [shiny.posit.co](https://shiny.posit.co/), which highlights the two components of every **shiny** app: 'front end' (the bit the user sees) and 'back end' code.
In **shiny** apps, these elements are typically created in objects named `ui` and `server` within an R script named `app.R`, which lives in an 'app folder'.
This allows web mapping applications to be represented in a single file, such as the [`CycleHireApp/app.R`](https://github.com/geocompx/geocompr/blob/main/apps/CycleHireApp/app.R) file in the book's GitHub repo.

\BeginKnitrBlock{rmdnote}<div class="rmdnote">In **shiny** apps these are often split into `ui.R` (short for user interface) and `server.R` files, naming conventions used by `shiny-server`, a server-side Linux application for serving shiny apps on public-facing websites.
`shiny-server` also serves apps defined by a single `app.R` file in an 'app folder'.
Learn more at: https://github.com/rstudio/shiny-server.</div>\EndKnitrBlock{rmdnote}

Before considering large apps, it is worth seeing a minimal example, named 'lifeApp', in action.^[
The word 'app' in this context refers to 'web application' and should not be confused with smartphone apps, the more common meaning of the word.
]
The code below defines and launches --- with the command `shinyApp()` --- a lifeApp, which provides an interactive slider allowing users to make countries appear with progressively lower levels of life expectancy (see Figure \@ref(fig:lifeApp)):


``` r
library(shiny)    # for shiny apps
library(leaflet)  # renderLeaflet function
library(spData)   # loads the world dataset 
ui = fluidPage(
  sliderInput(inputId = "life", "Life expectancy", 49, 84, value = 80),
      leafletOutput(outputId = "map")
  )
server = function(input, output) {
  output$map = renderLeaflet({
    leaflet() |> 
      # addProviderTiles("OpenStreetMap.BlackAndWhite") |>
      addPolygons(data = world[world$lifeExp < input$life, ])})
}
shinyApp(ui, server)
```

<div class="figure" style="text-align: center">
<img src="images/shiny-app.png" alt="Screenshot showing minimal example of a web mapping application created with shiny." width="100%" />
<p class="caption">(\#fig:lifeApp)Screenshot showing minimal example of a web mapping application created with shiny.</p>
</div>

The **user interface** (`ui`) of lifeApp is created by `fluidPage()`.
This contains input and output 'widgets' --- in this case, a `sliderInput()` (many other `*Input()` functions are available) and a `leafletOutput()`.
These are arranged row-wise by default, explaining why the slider interface is placed directly above the map in Figure \@ref(fig:lifeApp) (see `?column` for adding content column-wise).

The **server side** (`server`) is a function with `input` and `output` arguments.
`output` is a list of objects containing elements generated by `render*()` function --- `renderLeaflet()` which in this example generates `output$map`.
Input elements such as `input$life` referred to in the server must relate to elements that exist in the `ui` --- defined by `inputId = "life"` in the code above.
The function `shinyApp()` combines both the `ui` and `server` elements and serves the results interactively via a new R process.
When you move the slider in the map shown in Figure \@ref(fig:lifeApp), you are actually causing R code to re-run, although this is hidden from view in the user interface.

Building on this basic example and knowing where to find help (see `?shiny`), the best way forward now may be to stop reading and start programming!
The recommended next step is to open the previously mentioned [`CycleHireApp/app.R`](https://github.com/geocompx/geocompr/blob/main/apps/CycleHireApp/app.R) script in an integrated development environment (IDE) of choice, modify it and re-run it repeatedly.
The example contains some of the components of a web mapping application implemented in **shiny** and should 'shine' a light on how they behave.

The `CycleHireApp/app.R` script contains **shiny** functions that go beyond those demonstrated in the simple 'lifeApp' example, deployed at [shiny.robinlovelace.net/CycleHireApp](https://shiny.robinlovelace.net/CycleHireApp).
These include `reactive()` and `observe()`, (for creating outputs that respond to the user interface, see `?reactive`) and `leafletProxy()` (for modifying a `leaflet` object that has already been created).
Such elements enable web mapping applications implemented in **shiny** [@lovelace_propensity_2017].
A range of 'events' can be programmed including advanced functionality such as drawing new layers or subsetting data, as described in the shiny section of RStudio's **leaflet** [website](https://rstudio.github.io/leaflet/shiny.html).

\BeginKnitrBlock{rmdnote}<div class="rmdnote">There are a number of ways to run a **shiny** app.
For RStudio users, the simplest way is probably to click on the 'Run App' button located in the top right of the source pane when an `app.R`, `ui.R` or `server.R` script is open.
**shiny** apps can also be initiated by using `runApp()` with the first argument being the folder containing the app code and data: `runApp("CycleHireApp")` in this case (which assumes a folder named `CycleHireApp` containing the `app.R` script is in your working directory).
You can also launch apps from a Unix command line with the command `Rscript -e 'shiny::runApp("CycleHireApp")'`.</div>\EndKnitrBlock{rmdnote}

Experimenting with apps such as `CycleHireApp` will build not only your knowledge of web mapping applications in R, but also your practical skills.
Changing the contents of `setView()`, for example, will change the starting bounding box that the user sees when the app is initiated.
Such experimentation should not be done at random, but with reference to relevant documentation, starting with `?shiny`, and motivated by a desire to solve problems such as those posed in the exercises.

**shiny** used in this way can make prototyping mapping applications faster and more accessible than ever before (deploying **shiny** apps, https://shiny.posit.co/deploy/, is a separate topic beyond the scope of this chapter).
Even if your applications are eventually deployed using different technologies, **shiny** undoubtedly allows web mapping applications to be developed in relatively few lines of code (86 in the case of CycleHireApp).
That does not stop shiny apps getting rather large.
The Propensity to Cycle Tool (PCT) hosted at [pct.bike](https://www.pct.bike/), for example, is a national mapping tool funded by the UK's Department for Transport.
The PCT is used by dozens of people each day and has multiple interactive elements based on more than 1000 lines of [code](https://github.com/npct/pct-shiny/blob/master/regions_www/m/server.R) [@lovelace_propensity_2017].

While such apps undoubtedly take time and effort to develop, **shiny** provides a framework for reproducible prototyping that should aid the development process.
One potential problem with the ease of developing prototypes with **shiny** is the temptation to start programming too early, before the purpose of the mapping application has been envisioned in detail.
For that reason, despite advocating **shiny**, we recommend starting with the longer established technology of a pen and paper as the first stage for interactive mapping projects.
This way your prototype web applications should be limited not by technical considerations, but by your motivations and imagination.

<div class="figure" style="text-align: center">
<iframe src="https://shiny.robinlovelace.net/CycleHireApp/" width="690" height="400px" data-external="1"></iframe>
<p class="caption">(\#fig:CycleHireApp-html)CycleHireApp, a simple web mapping application for finding the closest cycle hiring station based on your location and requirement of cycles. Interactive version available online at: r.geocompx.org.</p>
</div>

## Other mapping packages

**tmap** provides a powerful interface for creating a wide range of static maps (Section \@ref(static-maps)) and also supports interactive maps (Section \@ref(interactive-maps)).
But there are many other options for creating maps in R.
The aim of this section is to provide a taste of some of these and pointers for additional resources: map-making is a surprisingly active area of R package development, so there is more to learn than can be covered here.

The most mature option is to use `plot()` methods provided by core spatial packages **sf** and **terra**, covered in Sections \@ref(basic-map) and \@ref(basic-map-raster), respectively.
What we have not mentioned in those sections was that plot methods for vector and raster objects can be combined when the results draw onto the same plot area (elements such as keys in **sf** plots and multi-band rasters will interfere with this).
This behavior is illustrated in the subsequent code chunk which generates Figure \@ref(fig:nz-plot).
`plot()` has many other options which can be explored by following links in the `?plot` help page and the fifth **sf** vignette [`sf5`](https://cran.r-project.org/package=sf/vignettes/sf5.html).


``` r
g = st_graticule(nz, lon = c(170, 175), lat = c(-45, -40, -35))
plot(nz_water, graticule = g, axes = TRUE, col = "blue")
terra::plot(nz_elev / 1000, add = TRUE, axes = FALSE)
plot(st_geometry(nz), add = TRUE)
```

<div class="figure" style="text-align: center">
<img src="figures/nz-plot-1.png" alt="Map of New Zealand created with plot(). The legend to the right refers to elevation (1000 m above sea level)." width="100%" />
<p class="caption">(\#fig:nz-plot)Map of New Zealand created with plot(). The legend to the right refers to elevation (1000 m above sea level).</p>
</div>

The **tidyverse**\index{tidyverse (package)} plotting package **ggplot2** also supports `sf` objects with `geom_sf()`\index{ggplot2 (package)}.
The syntax is similar to that used by **tmap**:
an initial `ggplot()` call is followed by one or more layers, that are added with `+ geom_*()`, where `*` represents a layer type such as `geom_sf()` (for `sf` objects) or `geom_points()` (for points).

**ggplot2** plots graticules by default.
The default settings for the graticules can be overridden using `scale_x_continuous()`, `scale_y_continuous()` or [`coord_sf(datum = NA)`](https://github.com/tidyverse/ggplot2/issues/2071).
Other notable features include the use of unquoted variable names encapsulated in `aes()` to indicate which aesthetics vary and switching data sources using the `data` argument, as demonstrated in the code chunk below which creates Figure \@ref(fig:nz-gg2):


``` r
library(ggplot2)
g1 = ggplot() + geom_sf(data = nz, aes(fill = Median_income)) +
  geom_sf(data = nz_height) +
  scale_x_continuous(breaks = c(170, 175))
g1
```

Another benefit of maps based on **ggplot2** is that they can easily be given a level of interactivity when printed using the function `ggplotly()` from the **plotly** package\index{plotly (package)}.
Try `plotly::ggplotly(g1)`, for example, and compare the result with other **plotly** mapping functions described at: [blog.cpsievert.me](https://blog.cpsievert.me/2018/03/30/visualizing-geo-spatial-data-with-sf-and-plotly/).



An advantage of **ggplot2** is that it has a strong user community and many add-on packages.
It includes **ggspatial**, which enhances **ggplot2**'s mapping capabilities by providing options to add a north arrow (`annotation_north_arrow()`) and a scale bar (`annotation_scale()`), or to add background tiles (`annotation_map_tile()`).
It also accepts various spatial data classes with `layer_spatial()`.
Thus, we are able to plot `SpatRaster` objects from **terra** using this function as seen in Figure \@ref(fig:nz-gg2).


``` r
library(ggspatial)
ggplot() + 
  layer_spatial(nz_elev) +
  geom_sf(data = nz, fill = NA) +
  annotation_scale() +
  scale_x_continuous(breaks = c(170, 175)) +
  scale_fill_continuous(na.value = NA)
```

<div class="figure" style="text-align: center">
<img src="figures/nz-gg2-1.png" alt="Comparison of map of New Zealand created with ggplot2 alone (left) and ggplot2 and ggspatial (right)." width="45%" /><img src="figures/nz-gg2-2.png" alt="Comparison of map of New Zealand created with ggplot2 alone (left) and ggplot2 and ggspatial (right)." width="45%" />
<p class="caption">(\#fig:nz-gg2)Comparison of map of New Zealand created with ggplot2 alone (left) and ggplot2 and ggspatial (right).</p>
</div>

At the same time, **ggplot2** has a few drawbacks, for example the `geom_sf()` function is not always able to create a desired legend to use from the spatial [data](https://github.com/tidyverse/ggplot2/issues/2037).
Good additional **ggplot2** resources can be found in the open source [ggplot2 book](https://ggplot2-book.org/) [@wickham_ggplot2_2016] and in the descriptions of the multitude of '**gg**packages' such as **ggrepel** and **tidygraph**.

We have covered mapping with **sf**, **terra** and **ggplot2** first because these packages are highly flexible, allowing for the creation of a wide range of static maps.
Before we cover mapping packages for plotting a specific type of map (in the next paragraph), it is worth considering alternatives to the packages already covered for general-purpose mapping (Table \@ref(tab:map-gpkg)).

<table>
<caption>(\#tab:map-gpkg)(\#tab:map-gpkg)Selected general-purpose mapping packages.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Package </th>
   <th style="text-align:left;"> Title </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> ggplot2 </td>
   <td style="text-align:left;width: 9cm; "> Create Elegant Data Visualisations Using the Grammar of Graphics </td>
  </tr>
  <tr>
   <td style="text-align:left;"> googleway </td>
   <td style="text-align:left;width: 9cm; "> Accesses Google Maps APIs to Retrieve Data and Plot Maps </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ggspatial </td>
   <td style="text-align:left;width: 9cm; "> Spatial Data Framework for ggplot2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> leaflet </td>
   <td style="text-align:left;width: 9cm; "> Create Interactive Web Maps with Leaflet </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mapview </td>
   <td style="text-align:left;width: 9cm; "> Interactive Viewing of Spatial Data in R </td>
  </tr>
  <tr>
   <td style="text-align:left;"> plotly </td>
   <td style="text-align:left;width: 9cm; "> Create Interactive Web Graphics via 'plotly.js' </td>
  </tr>
  <tr>
   <td style="text-align:left;"> rasterVis </td>
   <td style="text-align:left;width: 9cm; "> Visualization Methods for Raster Data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tmap </td>
   <td style="text-align:left;width: 9cm; "> Thematic Maps </td>
  </tr>
</tbody>
</table>



Table \@ref(tab:map-gpkg) shows a range of mapping packages that are available, and there are many others not listed in this table.
Of note is **mapsf**, which can generate a range of geographic visualizations including choropleth, 'proportional symbol' and 'flow' maps.
These are documented in the [`mapsf`](https://cran.r-project.org/package=mapsf/vignettes/mapsf.html)\index{mapsf (package)} vignette.

Several packages focus on specific map types, as illustrated in Table \@ref(tab:map-spkg).
Such packages create cartograms that distort geographical space, create line maps, transform polygons into regular or hexagonal grids, visualize complex data on grids representing geographic topologies, and create 3D visualizations.



Table: (\#tab:map-spkg)Selected specific-purpose mapping packages, with associated metrics.

|Package   |Title                                                    |
|:---------|:--------------------------------------------------------|
|cartogram |Create Cartograms with R                                 |
|geogrid   |Turn Geospatial Polygons into Regular or Hexagonal Grids |
|geofacet  |'ggplot2' Faceting Utilities for Geographical Data       |
|linemap   |Line Maps                                                |
|tanaka    |Design Shaded Contour Lines (or Tanaka) Maps             |
|rayshader |Create Maps and Visualize Data in 2D and 3D              |


<!-- another: https://github.com/riatelab/fisheye -->

All of the aforementioned packages, however, have different approaches for data preparation and map creation.
In the next paragraph, we focus solely on the **cartogram** package [@R-cartogram]\index{cartogram (package)}.
Therefore, we suggest to read the [geogrid](https://github.com/jbaileyh/geogrid)\index{geogrid (package)}, [geofacet](https://github.com/hafen/geofacet)\index{geofacet (package)}, [linemap](https://github.com/riatelab/linemap)\index{linemap (package)}, [tanaka](https://github.com/riatelab/tanaka)\index{tanaka (package)}, and [rayshader](https://github.com/tylermorganwall/rayshader)\index{rayshader (package)} documentations to learn more about them.

A cartogram is a map in which the geometry is proportionately distorted to represent a mapping variable. 
Creation of this type of map is possible in R with **cartogram**, which allows for creating contiguous and non-contiguous area cartograms.
It is not a mapping package per se, but it allows for construction of distorted spatial objects that could be plotted using any generic mapping package.

The `cartogram_cont()` function creates contiguous area cartograms.
It accepts an `sf` object and name of the variable (column) as inputs.
Additionally, it is possible to modify the `intermax` argument -- maximum number of iterations for the cartogram transformation.
For example, we could represent median income in New Zeleand's regions as a contiguous cartogram (Figure \@ref(fig:cartomap1), right panel) as follows:


``` r
library(cartogram)
nz_carto = cartogram_cont(nz, "Median_income", itermax = 5)
tm_shape(nz_carto) + tm_polygons("Median_income")
```

<div class="figure" style="text-align: center">
<img src="figures/cartomap1-1.png" alt="Comparison of standard map (left) and contiguous area cartogram (right)." width="100%" />
<p class="caption">(\#fig:cartomap1)Comparison of standard map (left) and contiguous area cartogram (right).</p>
</div>

**cartogram** also offers creation of non-contiguous area cartograms using  `cartogram_ncont()` and Dorling cartograms using `cartogram_dorling()`.
Non-contiguous area cartograms are created by scaling down each region based on the provided weighting variable.
Dorling cartograms consist of circles with their area proportional to the weighting variable.
The code chunk below demonstrates creation of non-contiguous area and Dorling cartograms of US states' population (Figure \@ref(fig:cartomap2)):


``` r
us_states9311 = st_transform(us_states, "EPSG:9311")
us_states9311_ncont = cartogram_ncont(us_states9311, "total_pop_15")
us_states9311_dorling = cartogram_dorling(us_states9311, "total_pop_15")
```

<div class="figure" style="text-align: center">
<img src="figures/cartomap2-1.png" alt="Comparison of non-contiguous area cartogram (left) and Dorling cartogram (right)." width="100%" />
<p class="caption">(\#fig:cartomap2)Comparison of non-contiguous area cartogram (left) and Dorling cartogram (right).</p>
</div>

## Exercises


These exercises rely on a new object, `africa`.
Create it using the `world` and `worldbank_df` datasets from the **spData** package as follows:

``` r
library(spData)
africa = world |> 
  filter(continent == "Africa", !is.na(iso_a2)) |> 
  left_join(worldbank_df, by = "iso_a2") |> 
  select(name, subregion, gdpPercap, HDI, pop_growth) |> 
  st_transform("ESRI:102022") |> 
  st_make_valid() |> 
  st_collection_extract("POLYGON")
```

We will also use `zion` and `nlcd` datasets from **spDataLarge**:

``` r
zion = read_sf((system.file("vector/zion.gpkg", package = "spDataLarge")))
nlcd = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
```

E1. Create a map showing the geographic distribution of the Human Development Index (`HDI`) across Africa with base **graphics** (hint: use `plot()`) and **tmap** packages (hint: use `tm_shape(africa) + ...`).

- Name two advantages of each based on the experience.
- Name three other mapping packages and an advantage of each.
- Bonus: create three more maps of Africa using these three other packages.



E2. Extend the **tmap** created for the previous exercise so the legend has three bins: "High" (`HDI` above 0.7), "Medium" (`HDI` between 0.55 and 0.7) and "Low" (`HDI` below 0.55). 
Bonus: improve the map aesthetics, for example by changing the legend title, class labels and color palette.



E3. Represent `africa`'s subregions on the map. 
Change the default color palette and legend title.
Next, combine this map and the map created in the previous exercise into a single plot.



E4. Create a land cover map of Zion National Park.

- Change the default colors to match your perception of the land cover categories
- Add a scale bar and north arrow and change the position of both to improve the map's aesthetic appeal
- Bonus: Add an inset map of Zion National Park's location in the context of the state of Utah. (Hint: an object representing Utah can be subset from the `us_states` dataset.) 





E5. Create facet maps of countries in Eastern Africa:

- With one facet showing HDI and the other representing population growth (hint: using variables `HDI` and `pop_growth`, respectively)
- With a 'small multiple' per country



E6. Building on the previous facet map examples, create animated maps of East Africa:

- Showing each country in order
- Showing each country in order with a legend showing the HDI



E7. Create an interactive map of HDI in Africa:

- With **tmap**
- With **mapview**
- With **leaflet**
- Bonus: For each approach, add a legend (if not automatically provided) and a scale bar



E8. Sketch on paper ideas for a web mapping application that could be used to make transport or land-use policies more evidence-based:

- In the city you live, for a couple of users per day
- In the country you live, for dozens of users per day
- Worldwide for hundreds of users per day and large data serving requirements



E9. Update the code in `coffeeApp/app.R` so that instead of centering on Brazil the user can select which country to focus on:

- Using `textInput()`
- Using `selectInput()`



E10. Reproduce Figure 9.1 and Figure 9.7 as closely as possible using the **ggplot2** package.



E11. Join `us_states` and `us_states_df` together and calculate a poverty rate for each state using the new dataset.
Next, construct a continuous area cartogram based on total population. 
Finally, create and compare two maps of the poverty rate: (1) a standard choropleth map and (2) a map using the created cartogram boundaries.
What is the information provided by the first and the second map?
How do they differ from each other?



E12. Visualize population growth in Africa. 
Next, compare it with the maps of a hexagonal and regular grid created using the **geogrid** package.
