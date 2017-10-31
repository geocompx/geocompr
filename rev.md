We are very grateful for the detailed comments on chapters 1:5 in *Geocomputation with R*.
We have acted on the majority of these already and we think the vital 'foundations' part of the book is more readable, accurate and cohesive as a result.

For an overview of the bulk of the work done please see the Pull Request where we put the changes addressing these reviews: https://github.com/Robinlovelace/geocompr/pull/109

As you'll see this contains 100+ commits and over 500 lines of code and text changed, plus plenty of conversation between authors discussing the best way to address the comments.
We're confident that the majority of changes have been addressed directly however we do have a few questions:

- What does the reviewer mean when they refer to `%>%` with reference to `intermediate objects`?
- What were the cartographic conventions that Figure 2.6 was breaking? We've improved the figure greatly in any case and used as the basis for questions in Chapter 2. Any further suggestions, or links to resources on cartographic conventions, appreciated.
- Does our updated description of the target audience in the preface (http://robinlovelace.net/geocompr/preface.html) seem appropriate?

# Work in Progress

- [JANNES] I don't think that Java's memory management is much simpler than that of C++ when one uses properly types like std::vector.
- [JANNES] 2.2 raster - "You can also specify a no-data value in the header of a raster, frequently -9999 (in R we often use NA)." This, and earlier sentences, pre-suppose that a raster is actually a file on disk, most likely something like an asciigrid file, but doesn't make this assumption explicit. As this is very often not the case, I think this information is confusing, and not needed: do NetCDF files have a header? It's irrelevant.
- [JAKUB] Another example is that in section 2.2, describing when I might want to use a RasterStack versus a RasterBrick (or vice versa). You mention that RasterBricks are faster. It seems like the ability to create a RasterStack from a file on disk (as opposed to in memory?) is an advantage of a RasterStack. When would this be useful? I have a computer science degree and am having a hard time figuring out what the advantage truly is, and I’m sure my students would be harder pressed to figure it out. 

# TO DO IN THE FUTURE 

- [ISSUE OPENED] Topical and functional indices before publishing.
- [ISSUE OPENED] Likewise, in section 4.3.3 and 4.3.4, examples with landsat, satellite, and/or RStoolbox packages could be helpful. Maybe we use these packages in further chapters, and can then reference these here.
- [ISSUE OPENED] CRSs - look at non-geographers' work too (eg. I think in Waller&Gotway and Banerjee et al.) Consider covering post-WGS84 datums (sorry, datums are the plural of datum in geodesy) for the US readership.
- [ISSUE OPENED] the references need to be seriously checked as lots of the inserted author strings are wrong.
- [FUTURE CHAPTERS] One example is at the end of section 2.2.2: “You can also do this with the rasterVis package which provides more advanced methods for plotting raster objects.” What more advanced methods? That might be helpful to know, even if you don’t go into details about how to carry out those advanced methods. 
- [FUTURE CHAPTERS] Lastly on this, section 5.6 can be much expanded, as visualization is such an important part of geography and geographic analysis.
- [FUTURE CHAPTERS - chapter 6] CRSs - This seems good, especially if you have examples of where mismatched CRSs can cause problems and how to solve those problems.
- [FUTURE CHAPTERS] I was missing a section on raster/vector integration.
- [ISSUE OPENED] Figure 4.6 is interesting: is this raster data? Can raster deal with this problem? - https://github.com/Robinlovelace/geocompr/issues/110

# CANNOT FIND IT

- [CANNOT FIND IT] In Ch 3, they appear to claim that %>% doesn't involve intermediate objects. This is only superficially correct, as R's garbage collector removes both those that the user can see, as in bizarro pipes: ->.; in the . object, and those created under NSE. The claim should be removed.
- [CANNOT FIND IT] st_relates: not found. 

# FIXED

- [FIXED] In Ch 4, they buffer on geographical coordinates; this seems inappropriate, and should be re-considered.
- [FIXED] In section 1, Introduction, you seem to say that “a form that is scriptable and therefore easily reproducible and ‘computational’” is inaccessible. To me, that seems more accessible, not less.
- [FIXED] In section 3.2.1, the text says small_countries is those nations smaller than 100,000 km2. However, the code has 10,000, not 100,000.
- [FIXED] In section 3.2.2, you produce a “non-spatial data frame with eight rows, one per continent”, although there are 7 continents. Please explain this discrepancy.
- [FIXED] Right after this, you say Table 3.2 has “results for the top 3 most populous continents”, although this table has the 3 most populous countries.
- [FIXED] In the caption for Figure 4.1, you refer to a “circle of 20 degrees in radius around planet Earth.” This is confusing and misleading, as it implies the buffer size is larger than the earth. I think you mean 20 degrees around an origin at 0 N, and 0 E. 
- [FIXED] Prior to Table 5.3, you say you are getting n = 2 drivers, although the table has 5 instead of 2.
- [FIXED] "R is a multi-platform, open source language for statistical computing" - it is a language and an environment.
- [FIXED] Java’s compiled language - compiled Java programs
- [FIXED] python package osgeo mentioned twice
- [FIXED] "The package sf (covered in Chapter 2), for example, builds on its predecessor sp." It is not clear to me what this sentence means. - ... with sf (Table 1.2) and [sentence does not end]
- [FIXED] In 2003, Hornik et al. (2003) published an extended review of spatial packages - the link is correct but the text reference should be Bivand (2003).
- [FIXED] citation("sp") - The first reference for sp is missing, and is: Pebesma, E.J., R.S. Bivand, 2005. Classes and methods for spatial data in R. R News 5 (2), 9--13.
- [FIXED] "Now more than 200 packages rely on sp, making it an important part of the R ecosystem." I believe quite a bit more than 200, making 200 not such a relevant number. 
- [FIXED] Package raster does not provide a `raster` class.
- [FIXED] "thereby overcoming one of R’s major limitations when working on raster data." - when working on large raster data.
- [FIXED] could be placed in script called [typo]
- [FIXED] R pkg tabularaster is available from CRAN. 
- [FIXED] The MULTIPOLYGON ((1 5, 4 4, 4 1, 2 2, 1 5), (0 2, 1 2, 1 3, 0 3, 0 2)) example is wrong: st_as_sfc("MULTIPOLYGON ((1 5, 4 4, 4 1, 2 2, 1 5), (0 2, 1 2, 1 3, 0 3, 0 2))") OGR: Corrupt data Error in CPL_sfc_from_wkt(x) : OGR error
- [FIXED] 2.1.4.3 reveals a misunderstanding of simple features, when writing "A simple feature collection (sfc) is a list of sfg objects" It should read "A collection of simple feature geometries is a list of sfg objects ..." : simple features have both, geometry and attributes.
- [FIXED] in 4.2, I get this warning: buff = st_buffer(x = center, dist = 20) Warning message: In st_buffer.sfc(st_geometry(x), dist, nQuadSegs) : st_buffer does not correctly buffer longitude/latitude data, dist needs to be in decimal degrees.
but don't see it in the output of the book. What should readers of the book now think?
- [FIXED]  The explanation comes a few paragraphs down, but I don't think it accurately pins down the problem. Why not compute the buffer in EPSG 32630? 
- [FIXED] (please refer also to the help page of st_join() - missing closing brace
- [FIXED] Then the might struggle to find [...]
- [FIXED] First line in 5.3: instead of geodatabases you may want to use "spatial databases", as geodatabase is strongly associated with ESRI, and is one of the many spatial databases.
- [FIXED] 5.2 What is a geolibrary? - We have fixed this by changing it to spatial library, and provided an example here: https://github.com/Robinlovelace/geocompr/commit/43e4a33a697792c06df3d7d3f1a56a6c620e7ea7
- [FIXED] I would not harm if the book would somewhere explain what is meant by a feature, and by a simple feature.
- [FIXED - issue opened] st_proj_info(type = "ellps") still works, but may have to disappear when Proj.4 version 10 appears.
- [FIXED] "Correspondingly, there is also only one possible proj4string for a specific epsg-code." You would wish this were true; they may however differ (subtly) from one proj.4 version to another.
- [FIXED] The comparison of R and C++ does not make much sense: for most of the audience of this book, R should be considered a program that can be used to carry out data analysis, and C++ a computer language that can be used to create programs for this.
- [FIXED] geostatistical community - spatial statistical community 
- [FIXED] In Ch 5, they do not seem to look at KML files, but probably should; they are mentioned, but not exemplified. Maybe Google Earth or similar are very yesterday now, but they are not that irrelevant.
- [FIXED] In section 3.2.1, at the end, please provide an example using the -> operator. You claim that the code producing world7 is easier to understand than the code producing world8, although to me, the reverse is true. Maybe having the -> example will help me see the value in the %>% chaining operator.
- [FIXED] By frequently speaking to the reader using the "you" form, the book gets the feeling of a tutorial.
- [FIXED] "These packages help overcome the criticism that R has “limited interactive [plotting] facilities" - the functionality refered to is javascript, interfaced from R; the actual plotting limitations of R are not changed by it.
- [FIXED] Fig 2.2: "The subset of the Simple Features class hierarchy supported by sf." Two remarks: (i) sf supports all 17 types., (ii) it is not clear what the arrows indicate. Is there a direct arrow intended from LINESTRING to GEOMETRYCOLLECTION?
- [FIXED] "This enables non-spatial data operations to work alongside spatial operations" -- but not in the tidyverse.
- [FIXED] MULTIPOLYGON s : this reads odd; I would replace it with MULTIPOLYGON geometries.
- [FIXED] Decision about the sf figure
- [FIXED] It mentions a lot of how much sf is bleeding edge; I think these comments are no longer relevant, and certainly not by the time this book gets published.
- [FIXED] Ch 1: GDS, GSD, Geographical information science; needs clean up.
- [FIXED] blazzingly/blazingly
- [FIXED] "Many people believe that R and Python are battling for supremacy in the field of data science." I think this sentence gives a wrong message. 
- [FIXED] "sf is not feature complete": the authors would do well in reporting which features of the simple feature access standard they find missing. - We have removed this phrase - agreed it's not useful if no example is given and whether or not something is 'complete' or not is subjective.
- [FIXED] "The transition from sp to sf will likely take many years," : the transition of what, or by whom? - This has been fixed - we were refering to the transition of R packages.
- [FIXED] These numbers represent point’s distance from an origin along the x (horizontal) and y (vertical) axis. - this is only the case for Cartesian coordinates.  - Clarified in the text and demonstrated with an exmaple of London
- [FIXED] I’d prefer exercises at the end. That makes them easier to find, and if you want to refer to some in the middle of the chapter, something like “see exercise 4.2 for practice on this concept” could be added.
- [FIXED] I find the frequent use of "of course" in this chapter (chapter 4) somewhat disturbing: very little here actually is "of course".
- [FIXED] - [JAKUB] A third example is towards the end of section 3.2.3. You distinguish data.frame objects from sf objects in the situation of reversing the order of parameters in the left_join function. What are the implications of having the sf output versus the data.frame output? Why would I want to ensure I choose one over the other.
- [FIXED] This might be related to my next comment, which is that you use the term “sticky geometry column” before we explain what “sticky” means here.
    - Fixed in https://github.com/Robinlovelace/geocompr/commit/db001dce67d8c8e8b66a3b67b85b3e3726fe904d
- [FIXED] The book uses the word "reproducible" a lot, but does not introduce it, define it, or discuss why it is a good (or required) thing.
    - https://github.com/Robinlovelace/geocompr/commit/88fc0eec41d3efeb227aaef99ad2326c09f5f35c
- [FIXED] Fig 2.6 breaks with many cartographic conventions.
    - I'm not sure which cartographic conventions you're referring to and would be grateful for clarification. However I agree the map was shoddy. It's been updated with various improvements including an equal area CRS, circle area (not diameter) proportional to population, centroids in the largest polygon and a better heading and caption.
    - See https://github.com/Robinlovelace/geocompr/commit/7e5e41cd7af09f2211a9b49b970dd2d6eea49864
- [FIXED] On the flip side of this, please provide examples of the [[ and $ operators on raster data. 
- [FIXED] Examples of the origin() and extend() commands. 
- [FIXED] "This column is usually named ‘geom’ or ‘geometry’" - depends, not if you mostly import your data from a spatial database. footnote/RMD Note: geom, geometry (name of the geometry column -> can have also another name when importing from spatial databases)
- [FIXED] Add possible KML example.
- [FIXED] Section 4.2.3.1 (Non-overlapping joins) is empty.
- [FIXED] 2.1.2 does not answer the question "Why Simple Features?" but answers the question "why use package sf and not sp?"
    - https://github.com/Robinlovelace/geocompr/commit/678cd3a98ce1b3aeabf232efe6eb4a8a4ba50907
- [FIXED] 4.2.1: instead of mentioning a lot of options while forwarding to a future section for what is meant, I think this section would work better when it would start with a simple example. Introducing earlier what is meant by a spatial relation may also clarify this chapter.
    - https://github.com/Robinlovelace/geocompr/commit/9341211cbbee8cc3d949a424b34aaa186af1861b
- [FIXED] Since figure 2.9 (right) plots long/lat coordinates to a flat surface, you may want to explain which projection it uses.
- [THAT'S A PROPER LINK] The url for downloading National Park Service units in section 5.2 seems wrong, as it is duplicated in the code. 
- [FIXED] The book does not make explicit who its target audience is. (2) The book fails to mention what its audience is. See https://github.com/Robinlovelace/geocompr/issues/103