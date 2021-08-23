# Conclusion {#conclusion}

## Prerequisites {-}

Like the introduction, this concluding chapter contains few code chunks.
But its prerequisites are demanding.
It assumes that you have:

- read through and attempted the exercises in all the chapters of Part I (Foundations);
<!-- - grasped the diversity of methods that build on these foundations, by following the code and prose in Part II (Extensions); -->
- considered how you can use geocomputation\index{geocomputation} to solve real-world problems, at work and beyond, after engaging with Part III (Applications).

## Introduction

The aim of this chapter is to synthesize the contents, with reference to recurring themes/concepts, and to inspire future directions of application and development.
<!-- Section \@ref(concepts) reviews the content covered in the previous chapters but at a high level. -->
<!-- Previous chapters focus on the details of packages, functions, and arguments needed for geocomputation with R. -->
<!-- This chapter focuses on concepts that recur throughout the book and how they may be useful. -->
Section \@ref(package-choice) discusses the wide range of options for handling geographic data in R.
Choice is a key feature of open source software; the section provides guidance on choosing between the various options.
Section \@ref(gaps) describes gaps in the book's contents and explains why some areas of research were deliberately omitted, while others were emphasized.
This discussion leads to the question (which is answered in Section \@ref(next)): having read this book, where to go next?
Section \@ref(benefit) returns to the wider issues raised in Chapter \@ref(intro).
In it we consider geocomputation as part of a wider 'open source approach' that ensures methods are publicly accessible, reproducible\index{reproducibility} and supported by collaborative communities.
This final section of the book also provides some pointers on how to get involved.

<!-- Section \@ref(next) -->

<!-- ## Concepts for geocomputation {#concepts} -->

## Package choice

A characteristic of R\index{R} is that there are often multiple ways to achieve the same result.
The code chunk below illustrates this by using three functions, covered in Chapters \@ref(attr) and \@ref(geometric-operations), to combine the 16 regions of New Zealand into a single geometry:


```r
library(spData)
nz_u1 = sf::st_union(nz)
nz_u2 = aggregate(nz["Population"], list(rep(1, nrow(nz))), sum)
nz_u3 = dplyr::summarise(nz, t = sum(Population))
identical(nz_u1, nz_u2$geometry)
#> [1] TRUE
identical(nz_u1, nz_u3$geom)
#> [1] TRUE
```

Although the classes, attributes and column names of the resulting objects `nz_u1` to `nz_u3` differ, their geometries are identical.
This is verified using the base R function `identical()`.^[
The first operation, undertaken by the function `st_union()`\index{vector!union}, creates an object of class `sfc` (a simple feature column).
The latter two operations create `sf` objects, each of which *contains* a simple feature column.
Therefore, it is the geometries contained in simple feature columns, not the objects themselves, that are identical.
]
Which to use?
It depends: the former only processes the geometry data contained in `nz` so is faster, while the other options performed attribute operations, which may be useful for subsequent steps.

The wider point is that there are often multiple options to choose from when working with geographic data in R, even within a single package.
The range of options grows further when more R packages are considered: you could achieve the same result using the older **sp** package, for example.
We recommend using **sf** and the other packages showcased in this book, for reasons outlined in Chapter \@ref(spatial-class), but it's worth being aware of alternatives and being able to justify your choice of software.

A common (and sometimes controversial) choice is between **tidyverse**\index{tidyverse (package)} and base R approaches.
We cover both and encourage you to try both before deciding which is more appropriate for different tasks.
The following code chunk, described in Chapter \@ref(attr), shows how attribute data subsetting works in each approach, using the base R operator `[` and the `select()` function from the **tidyverse** package **dplyr**.
The syntax differs but the results are (in essence) the same:


```r
library(dplyr)                          # attach tidyverse package
nz_name1 = nz["Name"]                   # base R approach
nz_name2 = nz %>% select(Name)          # tidyverse approach
identical(nz_name1$Name, nz_name2$Name) # check results
#> [1] TRUE
```

Again the question arises: which to use?
Again the answer is: it depends.
Each approach has advantages: the pipe syntax is popular and appealing to some, while base R\index{R!base} is more stable, and is well known to others.
Choosing between them is therefore largely a matter of preference.
However, if you do choose to use **tidyverse**\index{tidyverse (package)} functions to handle geographic data, beware of a number of pitfalls (see the supplementary article [`tidyverse-pitfalls`](https://geocompr.github.io/geocompkg/articles/tidyverse-pitfalls.html) on the website that supports this book).

While commonly needed operators/functions were covered in depth --- such as the base R `[` subsetting operator and the **dplyr** function `filter()` --- there are many other functions for working with geographic data, from other packages, that have not been mentioned.
Chapter \@ref(intro) mentions 20+ influential packages for working with geographic data, and only a handful of these are demonstrated in subsequent chapters.
There are hundreds more.
As of early 2019, there are nearly 200 packages mentioned in the Spatial [Task View](https://cran.r-project.org/web/views/);
more packages and countless functions for geographic data are developed each year, making it impractical to cover them all in a single book.



The rate of evolution in R's spatial ecosystem may seem overwhelming, but there are strategies to deal with the wide range of options.
Our advice is to start by learning one approach *in depth* but to have a general understand of the *breadth* of options available.
<!-- In other words, don't become 'a Jack of all trades, master of none' but 'master of (at least) one geographic package/approach and knowledgeable of many'. -->
This advice applies equally to solving geographic problems in R (Section \@ref(next) covers developments in other languages) as it does to other fields of knowledge and application.

Of course, some packages perform much better than others, making package selection an important decision.
From this diversity, we have focused on packages that are future-proof (they will work long into the future), high performance (relative to other R packages) and complementary.
But there is still overlap in the packages we have used, as illustrated by the diversity of packages for making maps, for example (see Chapter \@ref(adv-map)).

Package overlap is not necessarily a bad thing.
It can increase resilience, performance (partly driven by friendly competition and mutual learning between developers) and choice, a key feature of open source software.
In this context the decision to use a particular approach, such as the **sf**/**tidyverse**/**raster** ecosystem advocated in this book should be made with knowledge of alternatives.
The **sp**/**rgdal**/**rgeos** ecosystem that **sf**\index{sf} is designed to supersede, for example, can do many of the things covered in this book and, due to its age, is built on by many other packages.^[
At the time of writing 452 package `Depend` or `Import`  **sp**, showing that its data structures are widely used and have been extended in many directions.
The equivalent number for **sf** was 69 in October 2018; with the growing popularity of **sf**, this is set to grow.
]
Although best known for point pattern analysis, the **spatstat** package also supports raster\index{raster} and other vector geometries [@baddeley_spatstat_2005].
At the time of writing (October 2018) 69 packages depend on it, making it more than a package: **spatstat** is an alternative R-spatial ecosystem.

It is also being aware of promising alternatives that are under development.
The package **stars**, for example, provides a new class system for working with spatiotemporal data.
If you are interested in this topic, you can check for updates on the package's [source code](https://github.com/r-spatial/stars) and the broader [SpatioTemporal Task View](https://cran.r-project.org/web/views/SpatioTemporal.html).
The same principle applies to other domains: it is important to justify software choices and review software decisions based on up-to-date information. 



## Gaps and overlaps {#gaps}

There are a number of gaps in, and some overlaps between, the topics covered in this book.
We have been selective, emphasizing some topics while omitting others.
We have tried to emphasize topics that are most commonly needed in real-world applications such as geographic data operations, projections, data read/write and visualization.
These topics appear repeatedly in the chapters, a substantial area of overlap designed to consolidate these essential skills for geocomputation\index{geocomputation}.
<!-- We could add more content to this paragraph, e.g. by linking to specific chapters -->
<!-- and mentioning other areas of overlap -->

On the other hand, we have omitted topics that are less commonly used, or which are covered in-depth elsewhere.
Statistical topics including point pattern analysis, spatial interpolation (kriging) and spatial epidemiology, for example, are only mentioned with reference to other topics such as the machine learning\index{machine learning} techniques covered in Chapter \@ref(spatial-cv) (if at all).
There is already excellent material on these methods, including statistically orientated chapters in @bivand_applied_2013 and a book on point pattern analysis by @baddeley_spatial_2015.
<!-- one could also add @brunsdon_introduction_2015 -->
<!-- Todo: add citations to these materials (RL) -->
Other topics which received limited attention were remote sensing and using R alongside (rather than as a bridge to) dedicated GIS\index{GIS} software.
There are many resources on these topics, including @wegmann_remote_2016 and the GIS-related teaching materials available from [Marburg University](https://moc.online.uni-marburg.de/doku.php).

Instead of covering spatial statistical modeling and inference techniques, we focussed on machine learning\index{machine learning} (see Chapters \@ref(spatial-cv) and \@ref(eco)).
Again, the reason was that there are already excellent resources on these topics, especially with ecological use cases, including @zuur_mixed_2009, @zuur_beginners_2017 and freely available teaching material and code on *Geostatistics & Open-source Statistical Computing* by David Rossiter, hosted at [css.cornell.edu/faculty/dgr2](http://www.css.cornell.edu/faculty/dgr2/teach/) and the [*granolarr*](https://sdesabbata.github.io/granolarr/) project by [Stefano De Sabbata](https://stefanodesabbata.com/) [at the University of Leicester](https://www2.le.ac.uk/departments/geography/people/stefano-de-sabbata) for an introduction to R\index{R} for geographic data science\index{data science}.
There are also excellent resources on spatial statistics\index{spatial!statistics} using Bayesian modeling, a powerful framework for modeling and uncertainty estimation [@blangiardo_spatial_2015;@krainski_advanced_2018].
<!-- @Robinlovelace, as far as I remember blangiardo also were using epidemiological use cases. Zuur et al. also agreed to write a book on spatial, and spatial-temporal models for medical, public health and epidemiological data analysis using R-INLA -> see highstat.com -->

<!-- maybe, we should put this into the preface as well? -->
Finally, we have largely omitted big data\index{big data} analytics.
This might seem surprising since especially geographic data can become big really fast. 
But the prerequisite for doing big data analytics is to know how to solve a problem on a small dataset.
Once you have learned that, you can apply the exact same techniques on big data questions, though of course you need to expand your toolbox. 
The first thing to learn is to handle geographic data queries.
This is because big data\index{big data} analytics often boil down to extracting a small amount of data from a database for a specific statistical analysis.
For this, we have provided an introduction to spatial databases\index{spatial database} and how to use a GIS\index{GIS} from within R in Chapter \@ref(gis).
If you really have to do the analysis on a big or even the complete dataset, hopefully, the problem you are trying to solve is embarrassingly parallel.
For this, you need to learn a system that is able to do this parallelization efficiently such as Hadoop, GeoMesa (http://www.geomesa.org/) or GeoSpark [@huang_geospark_2017].
But still, you are applying the same techniques and concepts you have used on small datasets to answer a big data\index{big data} question, the only difference is that you then do it in a big data setting.

<!-- Likewise, there are gaps and overlaps in the contents of this book, which are worth considering before we consider next steps in Section \@ref(next). -->
<!-- More than 15 years ago, before most of the packages used in this book had been developed,  -->

## Where to go next? {#next}

As indicated in the previous sections, the book has covered only a fraction of the R's geographic ecosystem, and there is much more to discover.
We have progressed quickly, from geographic data models in Chapter \@ref(spatial-class), to advanced applications in Chapter \@ref(eco).
Consolidation of skills learned, discovery of new packages and approaches for handling geographic data, and application of the methods to new datasets and domains are suggested future directions.
<!-- It is impossible to become an expert in any area by reading a single book, and skills must be practiced. -->
This section expands on this general advice by suggesting specific 'next steps', highlighted in **bold** below.
<!-- and ordered by difficulty, beginning with continue to improve your knowledge of R. -->
<!-- JM: the end of the last section is already giving pointers where to go next, maybe, we can marry the two sections, or at least the part on the stuff we have omitted? -->

In addition to learning about further geographic methods and applications with R\index{R}, for example with reference to the work cited in the previous section, deepening your understanding of **R itself** is a logical next step.
R's fundamental classes such as `data.frame` and `matrix` are the foundation of `sf` and `raster` classes, so studying them will improve your understanding of geographic data.
This can be done with reference to documents that are part of R, and which can be found with the command `help.start()` and additional resources on the subject such as those by @wickham_advanced_2014 and @chambers_extending_2016.
<!-- creating and querying simple spatial in Chapter \ref(spatial-class) -->
<!-- maybe we should add info about places to learn more r-spatial stuff (aka github, twitter, ...?)? -->

<!-- Many directions of travel could be taken after taking the geocomputational steps -->
Another software-related direction for future learning is **discovering geocomputation with other languages**.
There are good reasons for learning R as a language for geocomputation, as described in Chapter \@ref(intro), but it is not the only option.^[
R's strengths relevant to our definition of geocomputation include its emphasis on scientific reproducibility\index{reproducibility}, widespread use in academic research and unparalleled support for statistical modeling of geographic data.
Furthermore, we advocate learning one language (R) for geocomputation\index{geocomputation} in depth before delving into other languages/frameworks because of the costs associated with context switching.
It is preferable to have expertise in one language than basic knowledge of many.
]
It would be possible to study *Geocomputation with: Python*\index{Python}, *C++*\index{C++}, *JavaScript*\index{JavaScript}, *Scala*\index{Scala} or *Rust*\index{Rust} in equal depth.
Each has evolving geospatial capabilities.
[**rasterio**](https://github.com/mapbox/rasterio), for example, is a Python package
<!-- for raster data offering a high-performance interface to GDAL -->
that could supplement/replace the **raster** package used in this book --- see @garrard_geoprocessing_2016 and online tutorials such as [automating-gis-processes](https://automating-gis-processes.github.io/CSC18) for more on the Python\index{Python} ecosystem.
Dozens of geospatial libraries have been developed in C++\index{C++}, including well known libraries such as GDAL\index{GDAL} and GEOS\index{GEOS}, and less well known libraries such as the **[Orfeo Toolbox](https://github.com/orfeotoolbox/OTB)** for processing remote sensing (raster) data.
[**Turf.js**](https://github.com/Turfjs/turf) is an example of the potential for doing geocomputation with JavaScript.
\index{Scala}
\index{JavaScript}
[GeoTrellis](https://geotrellis.io/) provides functions for working with raster and vector data in the Java-based language Scala.
And [WhiteBoxTools](https://github.com/jblindsay/whitebox-tools) provides an example of a rapidly evolving command-line GIS implemented in Rust.
\index{Rust}
\index{WhiteboxTools}
Each of these packages/libraries/languages has advantages for geocomputation and there are many more to discover, as documented in the curated list of open source geospatial resources [Awesome-Geospatial](https://github.com/sacridini/Awesome-Geospatial).

There is more to geocomputation\index{geocomputation} than software, however.
We can recommend **exploring and learning new research topics and methods** from academic and theoretical perspectives.
Many methods that have been written about have yet to be implemented.
Learning about geographic methods and potential applications can therefore be rewarding, before writing any code.
An example of geographic methods that are increasingly implemented in R is sampling strategies for scientific applications.
A next step in this case is to read-up on relevant articles in the area such as @brus_sampling_2018, which is accompanied by reproducible code and tutorial content hosted at [github.com/DickBrus/TutorialSampling4DSM](https://github.com/DickBrus/TutorialSampling4DSM).
<!-- One question: is any of these suggestions better than R? Or put differently, what would be the benefit of learning geocomputation with these additional programming languages, if one already has learned Geocomputation with R? -->

<!-- misc ideas: -->
<!-- - learning the geocomputation history (e.g. great papers by S. Openshaw) -->
<!-- - learning about new geocomputation methods (not implemented) -->
<!-- - reading about new non-spatial methods and be inspired (e.g. from fields of image analysis or geometry) -->
<!-- - combining methods from outside R with R -->
<!-- - creating new methods (reference to ch 10) -->

## The open source approach {#benefit}
<!-- What about: Advocating the open-source approach-->
<!-- I think we want to be broader than that: being open source *enables* positive impact (RL) -->

This is a technical book so it makes sense for the next steps, outlined in the previous section, to also be technical.
However, there are wider issues worth considering in this final section, which returns to our definition of geocomputation\index{geocomputation}.
One of the elements of the term introduced in Chapter \@ref(intro) was that geographic methods should have a positive impact.
<!-- This section is based on the premise that the key ingredients that make-up 'geocomputation', and maximize its ability to have a positive impact, depend on a wider . -->
Of course, how to define and measure 'positive' is a subjective, philosophical question, beyond the scope of this book.
Regardless of your worldview, consideration of the impacts of geocomputational work is a useful exercise:
the potential for positive impacts can provide a powerful motivation for future learning and, conversely, new methods can open-up many possible fields of application.
These considerations lead to the conclusion that geocomputation is part of a wider 'open source approach'.
<!-- Engagement with this approach, and the community that supports it, can have tangible benefits. -->
<!-- Consideration of real-world impacts leads to the conclusion that  -->

Section \@ref(what-is-geocomputation) presented other terms that mean roughly the same thing as geocomputation, including geographic data science\index{data science} (GDS) and 'GIScience'.
Both capture the essence of working with geographic data, but geocomputation has advantages: it concisely captures the 'computational' way of working with geographic data advocated in this book --- implemented in code and therefore encouraging reproducibility --- and builds on desirable ingredients of its early definition [@openshaw_geocomputation_2000]:

- The *creative* use of geographic data
- Application to *real-world problems*
- Building 'scientific' tools
- Reproducibility\index{reproducibility}

<!-- It is noteworthy that only the last of these ingredients is predominantly technical. -->
<!-- What is the point of building a new geographic method (tool) if its only purpose is to increase sales of perfume? -->
<!-- BOOM! None. -->

<!-- A bit of a rapid jump to reproducibility, I suggest another paragraph goes before this one (RL) -->
We added the final ingredient: reproducibility was barely mentioned in early work on geocomputation, yet a strong case can be made for it being a vital component of the first two ingredients.
Reproducibility\index{reproducibility}

- encourages *creativity* by shifting the focus away from the basics (which are readily available through shared code) and towards applications;
- discourages people from 'reinventing the wheel': there is no need to re-do what others have done if their methods can be used by others; and
<!-- that nobody has yet thought of. -->
- makes research more conducive to real world applications, by enabling anyone in any sector to apply your methods in new areas.

If reproducibility is the defining asset of geocomputation (or command-line GIS) it is worth considering what makes it reproducible.
This brings us to the 'open source approach', which has three main components:

- A command-line interface\index{command-line interface} (CLI), encouraging scripts recording geographic work to be shared and reproduced
- Open source software, which can be inspected and potentially improved by anyone in the world
- An active developer community, which collaborates and self-organizes to build complementary and modular tools

Like the term geocomputation\index{geocomputation}, the open source approach is more than a technical entity.
It is a community composed of people interacting daily with shared aims: to produce high performance tools, free from commercial or legal restrictions, that are accessible for anyone to use.
The open source approach to working with geographic data has advantages that transcend the technicalities of how the software works, encouraging learning, collaboration and an efficient division of labor.

There are many ways to engage in this community, especially with the emergence of code hosting sites, such as GitHub, which encourage communication and collaboration.
A good place to start is simply browsing through some of the source code, 'issues' and 'commits' in a geographic package of interest.
A quick glance at the `r-spatial/sf` GitHub repository, which hosts the code underlying the **sf**\index{sf} package, shows that 40+ people have contributed to the codebase and documentation.
Dozens more people have contributed by asking question and by contributing to 'upstream' packages that **sf** uses.
More than 600 issues have been closed on its [issue tracker](https://github.com/r-spatial/sf/issues), representing a huge amount of work to make **sf** faster, more stable and user-friendly.
This example, from just one package out of dozens, shows the scale of the intellectual operation underway to make R a highly effective and continuously evolving language for geocomputation.
<!-- This is what we mean by the open source approach: collaboration between people with shared aims. -->

It is instructive to watch the incessant development activity happen in public fora such as GitHub, but it is even more rewarding to become an active participant.
This is one of the greatest features of the open source approach: it encourages people to get involved.
This book itself is a result of the open source approach:
it was motivated by the amazing developments in R's geographic capabilities over the last two decades, but made practically possible by dialogue and code sharing on platforms for collaboration.
We hope that in addition to disseminating useful methods for working with geographic data, this book inspires you to take a more open source approach.
Whether it's raising a constructive issue alerting developers to problems in their package; making the work done by you and the organizations you work for open; or simply helping other people by passing on the knowledge you've learned, getting involved can be a rewarding experience.
<!-- The benefits of reproducibility can be illustrated with the example of using geocomputation to increase sales of perfume. -->
<!-- If the methods are hidden and cannot reproduced, few people can benefit (except for the perfume company who commissioned the work!). -->
<!-- If the underlying code is made open and reproducible, by contrast, the methods can be re-purposed or improved (which would also benefit the perfume company). -->
<!-- Reproducibility encourages socially but also economically beneficial collaboration.^[ -->
<!-- One accessible way to contribute upstream is creating a reprex (reproducible example) to highlight a bug in the package's issue tracker, as outlined in Section \@ref(scripts). -->
<!-- ] -->

<!-- Like any worthwhile intellectual endeavor or nascent academic field, geocomputation is diverse and contested. -->
