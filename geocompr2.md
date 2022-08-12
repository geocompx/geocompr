--- 
title: 'Geocomputation with R'
author: 'Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
date: '2022-08-12'
site: bookdown::bookdown_site
output: bookdown::pdf
#output: bookdown::bs4_book
documentclass: krantz
#documentclass: book
mainhangulfont: "NanumMyeongjo"
#mainfont: "NanumMyeongjoOTF"
monofont: "Source Code Pro"
monofontoptions: "Scale=0.7"
bibliography:
  - geocompr.bib
  - packages.bib
biblio-style: apalike
link-citations: yes
colorlinks: yes
graphics: yes
description: "Geocomputation with R is for people who want to analyze, visualize and model geographic data with open source software. It is based on R, a statistical programming language that has powerful data processing, visualization, and geospatial capabilities. The book equips you with the knowledge and skills to tackle a wide range of issues manifested in geographic data, including those with scientific, societal, and environmental implications. This book will interest people from many backgrounds, especially Geographic Information Systems (GIS) users interested in applying their domain-specific knowledge in a powerful open source language for data science, and R users interested in extending their skills to handle spatial data."
github-repo: "Robinlovelace/geocompr"
cover-image: "images/cover.png"
url: https://geocompr.robinlovelace.net/
---
































\newpage

\vspace*{5cm}

\thispagestyle{empty}

\begin{center} \Large \emph{For Katy  } \end{center}

\vspace*{2cm}
\begin{center} \Large \emph{Dla Jagody} \end{center}

\vspace*{2cm}
\begin{center} \Large \emph{F{\"u}r meine Katharina und alle unsere Kinder  } \end{center}

# Foreword (1st Edition) {-}

Doing 'spatial' in R has always been about being broad, seeking to provide and integrate tools from geography, geoinformatics, geocomputation and spatial statistics for anyone interested in joining in: joining in asking interesting questions, contributing fruitful research questions, and writing and improving code.
That is, doing 'spatial' in R has always included open source code, open data and reproducibility.

Doing 'spatial' in R has also sought to be open to interaction with many branches of applied spatial data analysis, and also to implement new advances in data representation and methods of analysis to expose them to cross-disciplinary scrutiny. 
As this book demonstrates, there are often alternative workflows from similar data to similar results, and we may learn from comparisons with how others create and understand their workflows.
This includes learning from similar communities around Open Source GIS and complementary languages such as Python, Java and so on.

R's wide range of spatial capabilities would never have evolved without people willing to share what they were creating or adapting.
This might include teaching materials, software, research practices (reproducible research, open data), and combinations of these. 
R users have also benefitted greatly from 'upstream' open source geo libraries such as GDAL, GEOS and PROJ.

This book is a clear example that, if you are curious and willing to join in, you can find things that need doing and that match your aptitudes.
With advances in data representation and workflow alternatives, and ever increasing numbers of new users often without applied quantitative command-line exposure, a book of this kind has really been needed.
Despite the effort involved, the authors have supported each other in pressing forward to publication.

So, this fresh book is ready to go; its authors have tried it out during many tutorials and workshops, so readers and instructors will be able to benefit from knowing that the contents have been and continue to be tried out on people like them.
Engage with the authors and the wider R-spatial community, see value in having more choice in building your workflows and most important, enjoy applying what you learn here to things you care about.

Roger Bivand

Bergen, September 2018

# Preface {-}

## Who this book is for {-}

This book is for people who want to analyze, visualize and model geographic data with open source software.
It is based on R, a statistical programming language that has powerful data processing, visualization and geospatial capabilities.
The book covers a wide range of topics and will be of interest to a wide range of people from many different backgrounds, especially:

- People who have learned spatial analysis skills using a desktop Geographic Information System (GIS), such as [QGIS](http://qgis.org/en/site/), [ArcGIS](http://desktop.arcgis.com/en/arcmap/), [GRASS](https://grass.osgeo.org/) or [SAGA](http://www.saga-gis.org/en/index.html), who want access to a powerful (geo)statistical and visualization programming language and the benefits of a command-line approach [@sherman_desktop_2008]:

  > With the advent of 'modern' GIS software, most people want to point and click their way through life. That’s good, but there is a tremendous amount of flexibility and power waiting for you with the command line.

- Graduate students and researchers from fields specializing in geographic data including Geography, Remote Sensing, Planning, GIS and Geographic Data Science
- Academics and post-graduate students working with geographic data --- in fields such as Geology, Regional Science, Biology and Ecology, Agricultural Sciences, Archaeology, Epidemiology, Transport Modeling, and broadly defined Data Science --- who require the power and flexibility of R for their research
- Applied researchers and analysts in public, private or third-sector organizations who need the reproducibility, speed and flexibility of a command-line language such as R in applications dealing with spatial data as diverse as Urban and Transport Planning, Logistics, Geo-marketing (store location analysis) and Emergency Planning

The book is designed for intermediate-to-advanced R users interested in geocomputation and R beginners who have prior experience with geographic data.
If you are new to both R and geographic data, do not be discouraged: we provide links to further materials and describe the nature of spatial data from a beginner's perspective in Chapter \@ref(spatial-class) and in links provided below.

## How to read this book {-}

The book is divided into three parts:

1. Part I: Foundations, aimed at getting you up-to-speed with geographic data in R.
2. Part II: Extensions, which covers advanced techniques.
3. Part III: Applications, to real-world problems.

The chapters get progressively harder in each so we recommend reading the book in order.
A major barrier to geographical analysis in R is its steep learning curve.
The chapters in Part I aim to address this by providing reproducible code on simple datasets that should ease the process of getting started.

An important aspect of the book from a teaching/learning perspective is the **exercises** at the end of each chapter.
Completing these will develop your skills and equip you with the confidence needed to tackle a range of geospatial problems.
Solutions to the exercises can be found in an online booklet that accompanies Geocomputation with R, hosted at [geocompr.github.io/solutions](https://geocompr.github.io/solutions/).
To learn how to this booklet was created, and how to update solutions in files such as [_01-ex.Rmd](https://github.com/Robinlovelace/geocompr/blob/main/_01-ex.Rmd), see this [blog post](https://geocompr.github.io/post/2022/geocompr-solutions/).
For more blog posts and extended examples see the book's supporting website at [geocompr.github.io](https://geocompr.github.io/).

Impatient readers are welcome to dive straight into the practical examples, starting in Chapter \@ref(spatial-class).
However, we recommend reading about the wider context of *Geocomputation with R* in Chapter \@ref(intro) first.
If you are new to R, we also recommend learning more about the language before attempting to run the code chunks provided in each chapter (unless you're reading the book for an understanding of the concepts).
Fortunately for R beginners R has a supportive community that has developed a wealth of resources that can help.
We particularly recommend three tutorials:  [R for Data Science](http://r4ds.had.co.nz/) [@grolemund_r_2016] and [Efficient R Programming](https://csgillespie.github.io/efficientR/) [@gillespie_efficient_2016], especially [Chapter 2](https://csgillespie.github.io/efficientR/set-up.html#r-version) (on installing and setting-up R/RStudio) and [Chapter 10](https://csgillespie.github.io/efficientR/learning.html) (on learning to learn), and  [An introduction to R](http://colinfay.me/intro-to-r/) [@rcoreteam_introduction_2021].

## Why R? {-}

Although R has a steep learning curve, the command-line approach advocated in this book can quickly pay off.
As you'll learn in subsequent chapters, R is an effective tool for tackling a wide range of geographic data challenges.
We expect that, with practice, R will become the program of choice in your geospatial toolbox for many applications.
Typing and executing commands at the command-line is, in many cases, faster than pointing-and-clicking around the graphical user interface (GUI) of a desktop GIS.
For some applications such as Spatial Statistics and modeling R may be the *only* realistic way to get the work done.

As outlined in Section \@ref(why-use-r-for-geocomputation), there are many reasons for using R for geocomputation:
R is well-suited to the interactive use required in many geographic data analysis workflows compared with other languages.
R excels in the rapidly growing fields of Data Science (which includes data carpentry, statistical learning techniques and data visualization) and Big Data (via efficient interfaces to databases and distributed computing systems).
Furthermore R enables a reproducible workflow: sharing scripts underlying your analysis will allow others to build-on your work.
To ensure reproducibility in this book we have made its source code available at [github.com/Robinlovelace/geocompr](https://github.com/Robinlovelace/geocompr#geocomputation-with-r).
There you will find script files in the `code/` folder that generate figures:
when code generating a figure is not provided in the main text of the book, the name of the script file that generated it is provided in the caption (see for example the caption for Figure \@ref(fig:zones)).

Other languages such as Python, Java and C++ can be used for geocomputation and there are excellent resources for learning geocomputation *without R*, as discussed in Section \@ref(software-for-geocomputation).
None of these provide the unique combination of package ecosystem, statistical capabilities, visualization options, powerful IDEs offered by the R community.
Furthermore, by teaching how to use one language (R) in depth, this book will equip you with the concepts and confidence needed to do geocomputation in other languages.

## Real-world impact {-}

한글테스트!\index{한글테스트}

*Geocomputation with R* will equip you with knowledge and skills to tackle a wide range of issues, including those with scientific, societal and environmental implications, manifested in geographic data.
As described in Section \@ref(what-is-geocomputation), geocomputation is not only about using computers to process geographic data:
it is also about real-world impact.
If you are interested in the wider context and motivations behind this book, read on; these are covered in Chapter \@ref(intro).

## Acknowledgements {-}



Many thanks to everyone who contributed directly and indirectly via the code hosting and collaboration site GitHub, including the following people who contributed direct via pull requests: prosoitos, florisvdh, katygregg, rsbivand, iod-ine, KiranmayiV, defuneste, zmbc, cuixueqin, erstearns, FlorentBedecarratsNM, dcooley, marcosci, appelmar, MikeJohnPage, eyesofbambi, nickbearman, tyluRp, babayoshihiko, giocomai, KHwong12, LaurieLBaker, MarHer90, mdsumner, pat-s, darrellcarvalho, e-clin, gisma, ateucher, annakrystalli, andtheWings, kant, gavinsimpson, Himanshuteli, yutannihilation, jimr1603, jbixon13, olyerickson, yvkschaefer, katiejolly, kwhkim, layik, mpaulacaldas, mtennekes, mvl22, ganes1410, richfitz, wdearden, yihui, adambhouston, chihinl, cshancock, ec-nebi, gregor-d, jasongrahn, p-kono, pokyah, schuetzingit, sdesabbata, tim-salabim, tszberkowitz.
Special thanks to Marco Sciaini, who not only created the front cover image, but also published the code that generated it (see `code/frontcover.R` in the book's GitHub repo). 
Dozens more people contributed online, by raising and commenting on issues, and by providing feedback via social media.
The `#geocompr` hashtag will live on!

We would like to thank John Kimmel from CRC Press, who has worked with us over two years to take our ideas from an early book plan into production via four rounds of peer review.
The reviewers deserve special mention here: their detailed feedback and expertise substantially improved the book's structure and content.

We thank Patrick Schratz and Alexander Brenning from the University of Jena for fruitful discussions on and input into Chapters \@ref(spatial-cv) and \@ref(eco).
We thank Emmanuel Blondel from the Food and Agriculture Organization of the United Nations for expert input into the section on web services;
Michael Sumner for critical input into many areas of the book, especially the discussion of algorithms in Chapter 10;
Tim Appelhans and David Cooley for key contributions to the visualization chapter (Chapter 8);
and Katy Gregg, who proofread every chapter and greatly improved the readability of the book.

Countless others could be mentioned who contributed in myriad ways.
The final thank you is for all the software developers who make geocomputation with R possible.
Edzer Pebesma (who created the **sf** package), Robert Hijmans (who created **raster**) and Roger Bivand (who laid the foundations for much R-spatial software) have made high performance geographic computing possible in R.

<!--chapter:end:index.Rmd-->

\mainmatter

# Introduction {#intro}
<!--rl-->

This book is about using the power of computers to *do things* with geographic data.
It teaches a range of spatial skills, including: reading, writing and manipulating geographic data; making static and interactive maps; applying geocomputation\index{geocomputation} to solve real-world problems; and modeling geographic phenomena.
By demonstrating how various geographic operations can be linked, in reproducible 'code chunks' that intersperse the prose, the book also teaches a transparent and thus scientific workflow.
Learning how to use the wealth of geospatial tools available from the R command line can be exciting, but creating *new ones* can be truly liberating.
Using the command-line driven approach taught throughout, and programming techniques covered in Chapter \@ref(algorithms)\index{algorithm}, can help remove constraints on your creativity imposed by software.
After reading the book and completing the exercises, you should therefore feel empowered with a strong understanding of the possibilities opened up by R's\index{R} impressive geographic capabilities, new skills to solve real-world problems with geographic data, and the ability to communicate your work with maps and reproducible code.

Over the last few decades free and open source software for geospatial (FOSS4G\index{FOSS4G}) has progressed at an astonishing rate.
Thanks to organizations such as OSGeo, geographic data analysis is no longer the preserve of those with expensive hardware and software: anyone can now download and run high-performance spatial libraries.
Open source Geographic Information Systems (GIS\index{GIS}), such as [QGIS](http://qgis.org/en/site/)\index{QGIS}, have made geographic analysis accessible worldwide.
GIS programs tend to emphasize graphical user interfaces\index{graphical user interface} (GUIs), with the unintended consequence of discouraging reproducibility\index{reproducibility} (although many can be used from the command line as we'll see in Chapter \@ref(gis)).
R, by contrast, emphasizes the command line interface\index{command-line interface} (CLI).
A simplistic comparison between the different approaches is illustrated in Table \@ref(tab:gdsl).

\begin{table}

\caption[Differences between GUI and CLI]{(\#tab:gdsl)Differences in emphasis between software packages (Graphical User Interface (GUI) of Geographic Information Systems (GIS) and R).}
\centering
\begin{tabular}[t]{lll}
\toprule
Attribute & Desktop GIS (GUI) & R\\
\midrule
Home disciplines & Geography & Computing, Statistics\\
Software focus & Graphical User Interface & Command line\\
Reproducibility & Minimal & Maximal\\
\bottomrule
\end{tabular}
\end{table}

This book is motivated by the importance of reproducibility\index{reproducibility} for scientific research (see the note below).
It aims to make reproducible geographic data analysis\index{geographic data analysis} workflows more accessible, and demonstrate the power of open geospatial software available from the command-line.
"Interfaces to other software are part of R" [@eddelbuettel_extending_2018].
This means that in addition to outstanding 'in house' capabilities, R allows access to many other spatial software libraries, explained in Section \@ref(why-use-r-for-geocomputation) and demonstrated in Chapter \@ref(gis).
Before going into the details of the software, however, it is worth taking a step back and thinking about what we mean by geocomputation\index{geocomputation}.

\BeginKnitrBlock{rmdnote}
Reproducibility is a major advantage of command-line interfaces, but what does it mean in practice?
We define it as follows: "A process in which the same results can be generated by others using publicly accessible code."

This may sound simple and easy to achieve (which it is if you carefully maintain your R code in script files), but has profound implications for teaching and the scientific process [@pebesma_r_2012].
\EndKnitrBlock{rmdnote}
\index{reproducibility}

## What is geocomputation?
<!--rl-->

Geocomputation\index{geocomputation!definition} is a young term, dating back to the first conference on the subject in 1996.^[
The conference took place at the University of Leeds, where one of the authors (Robin) is currently based.
The 21^st^ GeoComputation conference was also hosted at the University of Leeds, during which Robin and Jakub presented, led a workshop on 'tidy' spatial data analysis and collaborated on the book (see www.geocomputation.org for more on the conference series, and papers/presentations spanning two decades).
]
What distinguished geocomputation from the (at the time) commonly used term 'quantitative geography', its early advocates proposed, was its emphasis on "creative and experimental" applications [@longley_geocomputation_1998] and the development of new tools and methods [@openshaw_geocomputation_2000]:
"GeoComputation is about using the various different types of geodata and about developing relevant geo-tools within the overall context of a 'scientific' approach."
This book aims to go beyond teaching methods and code; by the end of it you should be able to use your geocomputational skills, to do "practical work that is beneficial or useful" [@openshaw_geocomputation_2000].

Our approach differs from early adopters such as Stan Openshaw, however, in its emphasis on reproducibility and collaboration.
At the turn of the 21^st^ Century, it was unrealistic to expect readers to be able to reproduce code examples, due to barriers preventing access to the necessary hardware, software and data.
Fast-forward two decades and things have progressed rapidly.
Anyone with access to a laptop with ~4GB RAM can realistically expect to be able to install and run software for geocomputation on publicly accessible datasets, which are more widely available than ever before (as we will see in Chapter \@ref(read-write)).^[
A laptop with 4GB running a modern operating system such as Ubuntu 22.04 onward should also be able to reproduce the contents of this book.
A laptop with this specification or above can be acquired second-hand for ~US$100 in most countries today.
Financial and hardware barriers to geocomputation that existed in 1990s and early 2000s, when high-performance computers were unaffordable for most people, have now been removed.
]
Unlike early works in the field, all the work presented in this book is reproducible using code and example data supplied alongside the book, in R\index{R} packages such as **spData**, the installation of which is covered in Chapter \@ref(spatial-class).

Geocomputation\index{geocomputation} is closely related to other terms including: Geographic Information Science (GIScience); Geomatics; Geoinformatics; Spatial Information Science; Geoinformation Engineering [@longley_geographic_2015]; and Geographic Data Science\index{Geographic Data Science} (GDS).
Each term shares an emphasis on a 'scientific' (implying reproducible and falsifiable) approach influenced by GIS\index{GIS!definition}, although their origins and main fields of application differ.
GDS, for example, emphasizes 'data science' skills and large datasets, while Geoinformatics tends to focus on data structures.
But the overlaps between the terms are larger than the differences between them and we use geocomputation as a rough synonym encapsulating all of them:
they all seek to use geographic data for applied scientific work.
Unlike early users of the term, however, we do not seek to imply that there is any cohesive academic field called 'Geocomputation' (or 'GeoComputation' as Stan Openshaw called it).
Instead, we define the term as follows: working with geographic data in a computational way, focusing on code, reproducibility\index{reproducibility} and modularity.

Geocomputation is a recent term but is influenced by old ideas.
It can be seen as a part of Geography\index{Geography}, which has a 2000+ year history [@talbert_ancient_2014];
and an extension of *Geographic Information Systems* (GIS\index{GIS}) [@neteler_open_2008], which emerged in the 1960s [@coppock_history_1991].

Geography\index{Geography} has played an important role in explaining and influencing humanity's relationship with the natural world long before the invention of the computer, however.
Alexander von Humboldt's\index{von Humboldt} travels to South America in the early 1800s illustrates this role:
not only did the resulting observations lay the foundations for the traditions of physical and plant geography, they also paved the way towards policies to protect the natural world [@wulf_invention_2015].
This book aims to contribute to the 'Geographic Tradition' [@livingstone_geographical_1992] by harnessing the power of modern computers and open source software.

The book's links to older disciplines were reflected in suggested titles for the book: *Geography with R* and *R for GIS*.
Each has advantages.
The former conveys the message that it comprises much more than just spatial data: 
non-spatial attribute data are inevitably interwoven with geometry data, and Geography\index{Geography} is about more than where something is on the map.
The latter communicates that this is a book about using R as a GIS\index{GIS}, to perform spatial operations on *geographic data* [@bivand_applied_2013].
However, the term GIS conveys some connotations (see Table \@ref(tab:gdsl)) which simply fail to communicate one of R's\index{R} greatest strengths:
its console-based ability to seamlessly switch between geographic and non-geographic data processing, modeling and visualization tasks.
By contrast, the term geocomputation\index{geocomputation} implies reproducible and creative programming.\index{GIS!connotations}
Of course, (geocomputational) algorithms\index{algorithm} are powerful tools that can become highly complex.
However, all algorithms are composed of smaller parts.
By teaching you its foundations and underlying structure, we aim to empower you to create your own innovative solutions to geographic data problems.

## Why use R for geocomputation?
<!--rl-->

Early geographers used a variety of tools including barometers, compasses and [sextants](https://en.wikipedia.org/wiki/Sextant) to advance knowledge about the world [@wulf_invention_2015]. 
It was only with the invention of the marine [chronometer](https://en.wikipedia.org/wiki/Marine_chronometer) in 1761 that it became possible to calculate longitude at sea, enabling ships to take more direct routes.

Nowadays such lack of geographic data is hard to imagine.
Every smartphone has a global positioning (GPS\index{GPS}) receiver and a multitude of sensors on devices ranging from satellites and semi-autonomous vehicles to citizen scientists incessantly measure every part of the world.
The rate of data produced is overwhelming.
An autonomous vehicle, for example, can generate 100 GB of data per day [@theeconomist_autonomous_2016].
Remote sensing\index{remote sensing} data from satellites has become too large to analyze the corresponding data with a single computer, leading to initiatives such as  [OpenEO](http://r-spatial.org/2016/11/29/openeo.html).

This 'geodata revolution' drives demand for high performance computer hardware and efficient, scalable software to handle and extract signal from the noise, to understand and perhaps change the world.
Spatial databases\index{spatial database} enable storage and generation of manageable subsets from the vast geographic data stores, making interfaces for gaining knowledge from them vital tools for the future.
R is one such tool, with advanced analysis, modeling and visualization capabilities.
In this context the focus of the book is not on the language itself [see @wickham_advanced_2019].
Instead we use R as a 'tool for the trade' for understanding the world, similar to Humboldt's\index{von Humboldt} use of tools to gain a deep understanding of nature in all its complexity and interconnections [see @wulf_invention_2015].
Although programming can seem like a reductionist activity, the aim is to teach geocomputation\index{geocomputation} with R not only for fun, but for understanding the world.

R is a multi-platform, open source language and environment for statistical computing and graphics ([r-project.org/](https://www.r-project.org/)).
With a wide range of packages, R also supports advanced geospatial statistics\index{statistics}, modeling and visualization.
\index{R!language}
New integrated development environments (IDEs\index{IDE}) such as RStudio\index{RStudio} have made R more user-friendly for many, easing map making with a panel dedicated to interactive visualization.

At its core, R is an object-oriented, [functional programming language](https://adv-r.hadley.nz/fp.html) [@wickham_advanced_2019], and was specifically designed as an interactive interface to other software [@chambers_extending_2016]. 
The latter also includes many 'bridges' to a treasure trove of GIS\index{GIS} software, 'geolibraries' and functions (see Chapter \@ref(gis)).
It is thus ideal for quickly creating 'geo-tools', without needing to master lower level languages (compared to R) such as C\index{C}, FORTRAN\index{FORTRAN} or Java\index{Java} (see Section \@ref(software-for-geocomputation)). 
\index{R}
This can feel like breaking free from the metaphorical 'glass ceiling' imposed by GUI-based or proprietary geographic information systems (see Table \@ref(tab:gdsl) for a definition of GUI\index{graphical user interface}).
Furthermore, R facilitates access to other languages:
the packages **Rcpp** and **reticulate** enable access to C++\index{C++} and Python\index{Python} code, for example.
This means R can be used as a 'bridge' to a wide range of geospatial programs (see Section \@ref(software-for-geocomputation)).

Another example showing R's flexibility and evolving geographic capabilities is interactive map making\index{map making!interactive}.
As we'll see in Chapter \@ref(adv-map), the statement that R has "limited interactive [plotting] facilities" [@bivand_applied_2013] is no longer true.
This is demonstrated by the following code chunk, which creates Figure \@ref(fig:interactive) (the functions that generate the plot are covered in Section \@ref(interactive-maps)).




```r
library(leaflet)
popup = c("Robin", "Jakub", "Jannes")
leaflet() |>
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") |>
  addMarkers(lng = c(-3, 23, 11),
             lat = c(52, 53, 49), 
             popup = popup)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/interactive} 

}

\caption[Where the authors are from.]{The blue markers indicate where the authors are from. The basemap is a tiled image of the Earth at night provided by NASA. Interact with the online version at geocompr.robinlovelace.net, for example by zooming in and clicking on the popups.}(\#fig:interactive)
\end{figure}

\index{map making!interactive}

It would have been difficult to produce Figure \@ref(fig:interactive) using R a few years ago, let alone as an interactive map.
This illustrates R's flexibility and how, thanks to developments such as **knitr** and **leaflet**, it can be used as an interface to other software, a theme that will recur throughout this book.
The use of R code, therefore, enables teaching geocomputation with reference to reproducible examples representing real world phenomena, rather than just abstract concepts.

## Software for geocomputation
<!--rl-->

R is a powerful language for geocomputation but there are many other options for geographic data analysis providing thousands of geographic functions\index{function}.
Awareness of other languages for geocomputation will help decide when a different tool may be more appropriate for a specific task, and place R in the wider geospatial ecosystem.
This section briefly introduces the languages [C++](https://isocpp.org/)\index{C++}, [Java](https://www.oracle.com/java/index.html)\index{Java} and [Python](https://www.python.org/)\index{Python} for geocomputation, in preparation for Chapter \@ref(gis).

An important feature of R (and Python) is that it is an interpreted language.
This is advantageous because it enables interactive programming in a Read–Eval–Print Loop (REPL):\index{REPL}
code entered into the console is immediately executed and the result is printed, rather than waiting for the intermediate stage of compilation.
On the other hand, compiled languages such as C++\index{C++} and Java\index{Java} tend to run faster (once they have been compiled).

C++\index{C++} provides the basis for many GIS packages such as [QGIS](https://www.qgis.org/)\index{QGIS}, [GRASS](https://grass.osgeo.org/)\index{GRASS} and [SAGA](http://www.saga-gis.org/)\index{SAGA} so it is a sensible starting point.
Well-written C++\index{C++} is very fast, making it a good choice for performance-critical applications such as processing large geographic datasets, but is harder to learn than Python or R.
C++\index{C++} has become more accessible with the **Rcpp** package, which provides a good 'way in' to C\index{C!language} programming for R users.
Proficiency with such low-level languages opens the possibility of creating new, high-performance 'geoalgorithms' and a better understanding of how GIS software works (see Chapter \@ref(algorithms)).

Java\index{Java} is another important and versatile language for geocomputation.
GIS packages gvSig, OpenJump and uDig are all written in Java\index{Java}.
There are many GIS libraries written in Java, including GeoTools and JTS, the Java Topology Suite (GEOS\index{GEOS} is a C++\index{C++} port of JTS).
Furthermore, many map server applications use Java\index{Java} including Geoserver/Geonode, deegree and 52°North WPS.

Java's\index{Java} object-oriented syntax is similar to that of C++\index{C++}.
A major advantage of Java\index{Java} is that it is platform-independent (which is unusual for a compiled language) and is highly scalable, making it a suitable language for IDEs\index{IDE} such as RStudio\index{RStudio}, with which this book was written.
Java has fewer tools for statistical modeling and visualization than Python or R, although it can be used for data science [@brzustowicz_data_2017].

Python\index{Python} is an important language for geocomputation especially because many Desktop GIS\index{GIS} such as GRASS\index{GRASS}, SAGA\index{SAGA} and QGIS\index{QGIS} provide a Python API\index{API} (see Chapter \@ref(gis)).
Like R\index{R}, it is a [popular](https://stackoverflow.blog/2017/10/10/impressive-growth-r/) tool for data science.
Both languages are object-oriented, and have many areas of overlap, leading to initiatives such as the **reticulate** package that facilitates access to Python\index{Python} from R and the [Ursa Labs](https://ursalabs.org/) initiative to support portable libraries to the benefit of the entire open source data science ecosystem.

In practice both R and Python have their strengths and to some extent which you use is less important than the domain of application and communication of results.
Learning either will provide a head-start in learning the other.
However, there are major advantages of R\index{R} over Python\index{Python} for geocomputation\index{geocomputation}.
This includes its much better support of the geographic data models vector and raster in the language itself (see Chapter \@ref(spatial-class)) and corresponding visualization possibilities (see Chapters \@ref(spatial-class) and \@ref(adv-map)).
Equally important, R has unparalleled support for statistics\index{statistics}, including spatial statistics\index{spatial!statistics}, with hundreds of packages (unmatched by Python\index{Python}) supporting thousands of statistical methods.

The major advantage of Python is that it is a *general-purpose* programming language.
It is used in many domains, including desktop software, computer games, websites and data science\index{data science}.
Python\index{Python} is often the only shared language between different (geocomputation) communities and can be seen as the 'glue' that holds many GIS\index{GIS} programs together.
Many geoalgorithms\index{geoalgorithm}, including those in QGIS\index{QGIS} and ArcMap, can be accessed from the Python command line, making it well-suited as a starter language for command-line GIS.^[
Python modules providing access to geoalgorithms\index{geoalgorithm} include `grass.script` for GRASS\index{GRASS},
`saga-python` for SAGA-GIS\index{SAGA},
`processing` for QGIS\index{QGIS} and `arcpy` for ArcGIS\index{ArcGIS}.
]

For spatial statistics\index{spatial!statistics} and predictive modeling, however, R is second-to-none.
This does not mean you must choose either R or Python: Python\index{Python} supports most common statistical techniques (though R tends to support new developments in spatial statistics earlier) and many concepts learned from Python can be applied to the R\index{R} world.
<!--rl:toDo-->
<!--to update! -->
Like R, Python also supports geographic data analysis and manipulation with packages such as **osgeo**, **Shapely**, **NumPy** and **PyGeoProcessing** [@garrard_geoprocessing_2016].

## R's spatial ecosystem {#r-ecosystem}

There are many ways to handle geographic data in R, with dozens of packages\index{R-spatial} in the area.^[
An overview of R's spatial ecosystem can be found in the CRAN\index{CRAN} Task View on the Analysis of Spatial Data
(see https://cran.r-project.org/web/views/Spatial.html).
]
In this book we endeavor to teach the state-of-the-art in the field whilst ensuring that the methods are future-proof.
Like many areas of software development, R's spatial ecosystem is rapidly evolving (Figure \@ref(fig:cranlogs)).
Because R is open source, these developments can easily build on previous work, by 'standing on the shoulders of giants', as Isaac Newton put it in [1675](http://digitallibrary.hsp.org/index.php/Detail/Object/Show/object_id/9285).
This approach is advantageous because it encourages collaboration and avoids 'reinventing the wheel'.
The package **sf**\index{sf} (covered in Chapter \@ref(spatial-class)), for example, builds on its predecessor **sp**.

A surge in development time (and interest) in 'R-spatial\index{R-spatial}' has followed the award of a grant by the R Consortium for the development of support for Simple Features, an open-source standard and model to store and access vector geometries. 
This resulted in the **sf** package (covered in Section \@ref(intro-sf)).
Multiple places reflect the immense interest in **sf**. 
This is especially true for the [R-sig-Geo Archives](https://stat.ethz.ch/pipermail/r-sig-geo/), a long-standing open access email list containing much R-spatial wisdom accumulated over the years.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/01-cranlogs} 

}

\caption[The popularity of spatial packages in R.]{Downloads of selected R packages for working with geographic data from early 2013 to present. The y axis shows the average number of dailly downloads from the popular cloud.r-project.org CRAN mirror with a 91-day rolling window (log scale).}(\#fig:cranlogs)
\end{figure}

It is noteworthy that shifts in the wider R community, as exemplified by the data processing package **dplyr** (released in [2014](https://cran.r-project.org/src/contrib/Archive/dplyr/)) influenced shifts in R's spatial ecosystem. 
Alongside other packages that have a shared style and emphasis on 'tidy data' (including, e.g., **ggplot2**), **dplyr** was placed in the **tidyverse** 'metapackage'\index{tidyverse (package)} in late [2016](https://cran.r-project.org/src/contrib/Archive/tidyverse/).
<!--rl:toDo-->
<!-- add reference -->
The **tidyverse**\index{tidyverse (package)} approach, with its focus on long-form data and fast intuitively named functions, has become immensely popular.
This has led to a demand for 'tidy geographic data' which has been partly met by **sf**.
An obvious feature of the **tidyverse** is the tendency for packages to work in harmony.
<!--rl:toDo-->
<!--is the next sentence still valid? -->
There is no equivalent **geoverse**, but there are attempts at harmonization between packages hosted in the [r-spatial](https://github.com/r-spatial/discuss/issues/11) organization and a growing number of packages use **sf**\index{sf} (Table \@ref(tab:revdep)). 

\begin{table}

\caption[Top 5 most downloaded packages depending on sf.]{(\#tab:revdep)The top 5 most downloaded packages that depend on sf, in terms of average number of downloads per day over the previous month. As of 2022-04-22  there are  332  packages which import sf.}
\centering
\begin{tabular}[t]{lr}
\toprule
Package & Downloads\\
\midrule
spdep & 1419\\
lwgeom & 1000\\
stars & 940\\
leafem & 863\\
mapview & 760\\
\bottomrule
\end{tabular}
\end{table}

Parallel group of developments relates to the [rspatial](https://github.com/rspatial) set of packages.^[Note the difference between "r-spatial", organization containing packages such as **sf**, and "rspatial", organization responsible for **terra**.]
Its main member is the **terra** package for spatial raster handling (see Section \@ref(an-introduction-to-terra)).

## The history of R-spatial

There are many benefits of using recent spatial packages such as **sf**, but it also important to be aware of the history of R's spatial capabilities: many functions, use-cases and teaching material are contained in older packages.
These can still be useful today, provided you know where to look.
\index{R!history}
\index{R-spatial!history}

R's spatial capabilities originated in early spatial packages in the S language [@bivand_implementing_2000].
\index{S}
The 1990s saw the development of numerous S scripts and a handful of packages for spatial statistics\index{statistics}.
R packages arose from these and by 2000 there were R packages for various spatial methods "point pattern analysis, geostatistics, exploratory spatial data analysis and spatial econometrics", according to an [article](http://www.geocomputation.org/2000/GC009/Gc009.htm) presented at GeoComputation 2000 [@bivand_open_2000].
Some of these, notably **spatial**, **sgeostat** and **splancs** are still available on CRAN\index{CRAN} [@rowlingson_splancs_1993; @rowlingson_splancs_2017;@venables_modern_2002; @majure_sgeostat_2016].

A subsequent article in R News (the predecessor of [The R Journal](https://journal.r-project.org/)) contained an overview of spatial statistical software in R at the time, much of which was based on previous code written for S/S-PLUS\index{S} [@ripley_spatial_2001].
This overview described packages for spatial smoothing and interpolation, including **akima** and **geoR** [@akima_akima_2016; @jr_geor_2016], and point pattern analysis, including **splancs** [@rowlingson_splancs_2017] and **spatstat** [@baddeley_spatial_2015].

The following R News issue (Volume 1/3) put spatial packages in the spotlight again, with a more detailed introduction to **splancs** and a commentary on future prospects regarding spatial statistics [@bivand_more_2001].
Additionally, the issue introduced two packages for testing spatial autocorrelation that eventually became part of **spdep** [@bivand_spdep_2017].
Notably, the commentary mentions the need for standardization of spatial interfaces, efficient mechanisms for exchanging data with GIS\index{GIS}, and handling of spatial metadata such as coordinate reference systems (CRS\index{CRS}).

**maptools** (written by Nicholas Lewin-Koh; @bivand_maptools_2017) is another important package from this time.
Initially **maptools** just contained a wrapper around [shapelib](http://shapelib.maptools.org/) and permitted the reading of ESRI Shapefiles\index{Shapefile} into geometry nested lists. 
The corresponding and nowadays obsolete S3 class\index{S3 class} called "Map" stored this list alongside an attribute data frame. 
The work on the "Map" class representation was nevertheless important since it directly fed into **sp** prior to its publication on CRAN\index{CRAN}.

In 2003 Roger Bivand published an extended review of spatial packages.
It proposed a class system to support the "data objects offered by GDAL"\index{GDAL}, including 'fundamental' point, line, polygon, and raster types.
Furthermore, it suggested interfaces to external libraries should form the basis of modular R packages [@hornik_approaches_2003].
To a large extent these ideas were realized in the packages **rgdal** and **sp**.
These provided a foundation for spatial data analysis with R, as described in *Applied Spatial Data Analysis with R* (ASDAR) [@bivand_applied_2013], first published in 2008.
Ten years later, R's spatial capabilities have evolved substantially but they still build on ideas set-out by @hornik_approaches_2003:
interfaces to GDAL\index{GDAL} and PROJ\index{PROJ}, for example, still power R's high-performance geographic data I/O and CRS\index{CRS} transformation capabilities (see Chapters \@ref(reproj-geo-data) and \@ref(read-write), respectively).

**rgdal**, released in 2003, provided GDAL\index{GDAL} bindings for R which greatly enhanced its ability to import data from previously unavailable geographic data formats.
The initial release supported only raster drivers but subsequent enhancements provided support for coordinate reference systems (via the PROJ library), reprojections and import of vector file formats (see Chapter \@ref(read-write) for more on file formats). 
Many of these additional capabilities were developed by Barry Rowlingson and released in the **rgdal** codebase in 2006 [see @rowlingson_rasp:_2003 and the [R-help](https://stat.ethz.ch/pipermail/r-help/2003-January/028413.html) email list for context].

**sp**, released in 2005, overcame R's inability to distinguish spatial and non-spatial objects [@pebesma_classes_2005].
**sp** grew from a [workshop](http://spatial.nhh.no/meetings/vienna/index.html) in Vienna in 2003 and was hosted at sourceforge before migrating to [R-Forge](https://r-forge.r-project.org).
Prior to 2005, geographic coordinates were generally treated like any other number. 
**sp** changed this with its classes and generic methods supporting points, lines, polygons and grids, and attribute data.

**sp** stores information such as bounding box\index{bounding box}, coordinate reference system\index{CRS} and attributes in slots in `Spatial` objects using the S4 class\index{S4 class} system,
enabling data operations to work on geographic data (see Section \@ref(why-simple-features)).
Further, **sp** provides generic methods such as `summary()` and `plot()` for geographic data.
In the following decade, **sp** classes rapidly became popular for geographic data in R and the number of packages that depended on it increased from around 20 in 2008 to over 100 in 2013 [@bivand_applied_2013].
Now that number is more than 500 packages depending on **sp** (compared with a similar number for the **sf** package which is growing faster), making it an important part of the R ecosystem. 
Prominent R packages using **sp** include: **gstat**, for spatial and spatio-temporal geostatistics\index{spatial!statistics}; **geosphere**, for spherical trigonometry; and **adehabitat** used for the analysis of habitat selection by animals [@R-gstat; @calenge_package_2006; @hijmans_geosphere_2016].



While **rgdal** and **sp** solved many spatial issues, it was not until **rgeos** was developed during a Google Summer of Code project in 2010 [@R-rgeos] that geometry operations could be undertaken on **sp** objects.
Functions such as `gIntersection()` enabled users to find spatial relationships between geographic objects and to modify their geometries (see Chapter \@ref(geometric-operations) for details on geometric operations with **sf**).

A limitation of the **sp** ecosystem was its limited support for raster data.
This was overcome by **raster**\index{raster}, first released in 2010 [@R-raster].
**raster**'s class system and functions enabled a range of raster operations, capabilities now implemented in the **terra** package, which superscedes **raster**, as outlined in Section \@ref(raster-data).
An important capability of **raster** and **terra** is their ability to work with datasets that are too large to fit into RAM (R's interface to PostGIS\index{PostGIS} also supports off-disk operations, on geographic vector datasets).
**raster** and **terra** also supports map algebra, as described in Section \@ref(map-algebra).

In parallel with these developments of class systems and methods came the support for R as an interface to dedicated GIS software.
**GRASS** [@bivand_using_2000] and follow-on packages **spgrass6** and **rgrass7** (for GRASS\index{GRASS} GIS 6 and 7, respectively) were prominent examples in this direction [@bivand_rgrass7_2016;@bivand_spgrass6_2016].
Other examples of bridges between R and GIS include **RSAGA** [@R-RSAGA, first published in 2008]\index{RSAGA (package)}, **RPyGeo** [@brenning_arcgis_2012, first published in 2008], **RQGIS** [@muenchow_rqgis:_2017, first published in 2016]\index{RQGIS (package)}, and **rqgisprocess** \index{rqgisprocess (package)} (see Chapter \@ref(gis)).
<!--toDo-->
<!-- rqgisprocess ref! -->

Visualization was not a focus initially, with the bulk of R-spatial development focused on analysis and geographic operations.
**sp** provided methods for map making using both the base and lattice plotting system but demand was growing for advanced map making capabilities.
**RgoogleMaps** first released in 2009, allowed to overlay R spatial data on top of 'basemap' tiles from online services such as Google Maps or OpenStreetMap [@loecher_rgooglemaps_2015].
\index{ggplot2 (package)}
It was followed by the **ggmap** package that added similar 'basemap' tiles capabilities to **ggplot2** [@kahle_ggmap_2013].
Though **ggmap** facilitated map-making with **ggplot2**, its utility was limited by the need to `fortify` spatial objects, which means converting them into long data frames.
While this works well for points it is computationally inefficient for lines and polygons, since each coordinate (vertex) is converted into a row, leading to huge data frames to represent complex geometries.
Although geographic visualization tended to focus on vector data, raster visualization is supported in **raster** and received a boost with the release of **rasterVis**, which is described in a book on the subject of spatial and temporal data visualization [@lamigueiro_displaying_2018].
Since then map making in R has become a hot topic, with dedicated packages such as **tmap**, **leaflet**, **rayshader** and **mapview** gaining popularity, as highlighted in Chapter \@ref(adv-map).

Since 2018, when the First Edition of Geocomputation with R was published, the development of geographic R packages has accelerated. 
\index{terra (package)}
**terra**, a successor of the **raster** package, was firstly released in 2020 [@hijmans_terra_2021], bringing several benefits to R users working with raster datasets: it  is faster and has more a straightforward user interface than its predecessor, as described in Section \@ref(raster-data).

In mid-2021, a substantial (and in some cases breaking) change was made to the **sf** package by incorporating spherical geometry calculations.
Since then, by default, many spatial operations on data with geographic CRSs use the S2 spherical geometry engine as a back-end, as described in Section \@ref(s2).
Additional ways of representing and working with geographic data in R since 2018 also include the **stars** and **lidR** packages.
**stars**, which integrates closely with **sf**, handles raster and vector data cubes [@pebesma_stars_2021].
**lidR** processes of airborne LiDAR (Light Detection and Ranging) point clouds [@Roussel2020].
\index{stars (package)}
\index{lidR (package)}

This modernization had several motivations, including the emergence of new technologies and standard, and the impacts from spatial software development outside of the R environment [@bivand_progress_2021].
The most important external factor affecting most spatial software, including R spatial packages, were the major updates, including many breaking changes to the PROJ library\index{PROJ} that had begun in 2018.
Most importantly, these changes forced the replacement of 'proj-string' representations of coordinate reference systems with 'Well Known Text', as described in Section \@ref(crs-intro) and Chapter \@ref(reproj-geo-data).

\index{rayshader (package)}
Since 2018, the progress of spatial visualization tools in R has been related to a few factors.
Firstly, new types of spatial plots were developed, including the **rayshader** package offering a combination of raytracing and multiple hill-shading methods to produce 2D and 3D data visualizations [@morganwall_rayshader_2021].
\index{ggplot2 (package)}
Secondly, **ggplot2** gained new spatial capabilities, mostly thanks to the **ggspatial** package that adds some spatial visualization elements, including scale bars and north arrows [@dunnington_ggspatial_2021] and **gganimate** that enables smooth and customizable spatial animations [@pedersen_gganimate_2020].
Thirdly, performance of visualizing large spatial dataset was improved.
This especially relates to automatic plotting of downscaled rasters in **tmap** and the possibility of using high-performance interactive rendering platforms in the **mapview** package, such as `"leafgl"` and `"mapdeck"`.
Lastly, some of the existing mapping tools have been rewritten to minimize dependencies, improve user interface, or allow for easier creation of extensions.
This includes the **mapsf** package (successor of **cartography**) [@giraud_mapsf_2021] and version 4 of the **tmap** package, in which most of the internal code was revised.

<!-- toDo: rl-->
<!-- question: should we add a paragraph about the following stuff here?-->
<!-- add info about specialized packages - sfnetworks, landscapemetrics, gdalcubes, rgee, etc. -->
<!-- better to add review papers, including Robin's, mine, etc. -->
<!-- interoperbility? -->
<!-- @hesselbarth_opensource_2021 -->
<!-- @lovelace_open_2021a -->

<!-- spatstat?? -->

In late 2021, the planned retirement of **rgdal**, **rgeos** and **maptools** at the end of 2023 was announced on [the R-sig-Geo mailing list](https://stat.ethz.ch/pipermail/r-sig-geo/2021-September/028760.html) by Roger Bivand.
This would have a large impact on existing workflows applying these packages, but also will influence the packages that depend on **rgdal**, **rgeos** or **maptools**. 
Therefore, Bivand's suggestion is to plan a transition to more modern tools, including **sf** and **terra**, as explained in this book's next chapters.

## Exercises


E1. Think about the terms 'GIS'\index{GIS}, 'GDS' and 'geocomputation' described above. Which (if any) best describes the work you would like to do using geo* methods and software and why?

E2. Provide three reasons for using a scriptable language such as R for geocomputation instead of using a graphical user interface (GUI) based GIS such as QGIS\index{QGIS}.

E3. In the year 2000 Stan Openshaw wrote that geocomputation involved "practical work that is beneficial or useful" to others. Think about a practical problem and possible solutions that could be informed with new evidence derived from the analysis, visualisation or modelling of geographic data. With a pen and paper (or computational equivalent) sketch inputs and possible outputs illustrating how geocomputation could help.

<!--toDo: rl -->
<!--add solutions!-->

<!--chapter:end:01-introduction.Rmd-->

# (PART) Foundations {-}

# Geographic data in R {#spatial-class}

## Prerequisites {-}

This is the first practical chapter of the book, and therefore it comes with some software requirements.
You need access to a computer with a recent version of R installed (R [4.2.0](https://stat.ethz.ch/pipermail/r-announce/2022/000683.html) or a later version).
We recommend not only reading the prose but also *running the code* in each chapter to build your geocomputational skills.

To keep track of your learning journey, it may be worth starting by creating a new folder on your computer to save your R scripts, outputs and other things related to Geocomputation with R as you go.
You can also [download](https://github.com/Robinlovelace/geocompr/archive/refs/heads/main.zip) or [clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) the [source code](https://github.com/Robinlovelace/geocompr) underlying the book to support your learning.
We strongly recommend installing an integrated development environment (IDE) such as [RStudio](https://www.rstudio.com/products/rstudio/download/#download) (recommended for most people) or [VS Code](https://github.com/REditorSupport/vscode-R) when writing/running/testing R code.^[
We recommend using [RStudio projects](https://r4ds.had.co.nz/workflow-projects.html), [VS Code workspaces](https://code.visualstudio.com/docs/editor/workspaces) or similar system to manage your projects.
A quick way to do this with RStudio is via the **rstudioapi** package.
Open a new project called 'geocompr-learning' in your home directory with the following command from the R console in RStudio, for example: `rstudioapi::openProject("~/geocompr-learning")`.
]

If you are new to R, we recommend following introductory R resources such as [Hands on Programming with R](https://rstudio-education.github.io/hopr/starting.html) by Garrett Grolemund or an [Introduction to R](https://cengel.github.io/R-intro/) by Claudia Engel before you dive into Geocomputation with R code.
Organize your work (e.g., with RStudio projects) and give scripts sensible names such as `chapter-02-notes.R` to document the code as you learn.
\index{R!pre-requisites}

After you have got a good set-up, it's time to run some code!
Unless you already have these packages installed, the first thing to do is to install foundational R packages used in this chapter, with the following commands:^[
**spDataLarge** is not on CRAN\index{CRAN}, meaning it must be installed via *r-universe*  or with the following command: `remotes::install_github("Nowosad/spDataLarge")`.
]


```r
install.packages("sf")
install.packages("terra")
install.packages("spData")
install.packages("spDataLarge", repos = "https://nowosad.r-universe.dev")
```

\index{R!installation}
\BeginKnitrBlock{rmdnote}
If you're running Mac or Linux, the previous command to install **sf** may not work first time.
These operating systems (OSs) have 'systems requirements' that are described in the package's [README](https://github.com/r-spatial/sf).
Various OS-specific instructions can be found online, such as the article *Installation of R 4.0 on Ubuntu 20.04* on the blog [rtask.thinkr.fr](https://rtask.thinkr.fr/installation-of-r-4-0-on-ubuntu-20-04-lts-and-tips-for-spatial-packages/).
\EndKnitrBlock{rmdnote}

The packages needed to reproduce Part 1 of this book can be installed with the following command: `remotes::install_github("geocompr/geocompkg")`.
This command uses the function `install_packages()` from the **remotes** package to install source code hosted on the GitHub code hosting, version and collaboration platform.
The following command will install **all** dependencies required to reproduce the entire book (warning: this may take several minutes): `remotes::install_github("geocompr/geocompkg", dependencies = TRUE)`

The packages needed to run the code presented in this chapter can be 'loaded' (technically they are attached) with the `library()` function as follows:


```r
library(sf)          # classes and functions for vector data
#> Linking to GEOS 3.8.0, GDAL 3.0.4, PROJ 6.3.1; sf_use_s2() is TRUE
```

The output from `library(sf)` reports which versions of key geographic libraries such as GEOS the package is using, as outlined in Section \@ref(intro-sf).


```r
library(terra)      # classes and functions for raster data
```

The other packages that were installed contain data that will be used in the book:


```r
library(spData)        # load geographic data
library(spDataLarge)   # load larger geographic data
```

## Introduction {#intro-spatial-class}

This chapter will provide brief explanations of the fundamental geographic data models:\index{data models} vector and raster.
We will introduce the theory behind each data model and the disciplines in which they predominate, before demonstrating their implementation in R.

The *vector data model* represents the world using points, lines and polygons.
These have discrete, well-defined borders, meaning that vector datasets usually have a high level of precision (but not necessarily accuracy as we will see in Section \@ref(units)).
The *raster data model* divides the surface up into cells of constant size.
Raster datasets are the basis of background images used in web-mapping and have been a vital source of geographic data since the origins of aerial photography and satellite-based remote sensing devices.
Rasters aggregate spatially specific features to a given resolution, meaning that they are consistent over space and scalable (many worldwide raster datasets are available).

Which to use?
The answer likely depends on your domain of application:

- Vector data tends to dominate the social sciences because human settlements tend to have discrete borders
- Raster dominates many environmental sciences because of the reliance on remote sensing data

There is much overlap in some fields and raster and vector datasets can be used together:
ecologists and demographers, for example, commonly use both vector and raster data.
Furthermore, it is possible to convert between the two forms (see Section \@ref(raster-vector)).
Whether your work involves more use of vector or raster datasets, it is worth understanding the underlying data model before using them, as discussed in subsequent chapters.
This book uses **sf** and **terra** packages to work with vector data and raster datasets, respectively.

## Vector data

\BeginKnitrBlock{rmdnote}
Take care when using the word 'vector' as it can have two meanings in this book:
geographic vector data and the `vector` class (note the `monospace` font) in R.
The former is a data model, the latter is an R class just like `data.frame` and `matrix`.
Still, there is a link between the two: the spatial coordinates which are at the heart of the geographic vector data model can be represented in R using `vector` objects.
\EndKnitrBlock{rmdnote}

The geographic vector data model\index{vector data model} is based on points located within a coordinate reference system\index{coordinate reference system|see {CRS}} (CRS\index{CRS}).
Points can represent self-standing features (e.g., the location of a bus stop) or they can be linked together to form more complex geometries such as lines and polygons.
Most point geometries contain only two dimensions (3-dimensional CRSs contain an additional $z$ value, typically representing height above sea level).

In this system London, for example, can be represented by the coordinates `c(-0.1, 51.5)`.
This means that its location is -0.1 degrees east and 51.5 degrees north of the origin.
The origin in this case is at 0 degrees longitude (the Prime Meridian) and 0 degree latitude (the Equator) in a geographic ('lon/lat') CRS (Figure \@ref(fig:vectorplots), left panel).
The same point could also be approximated in a projected CRS with 'Easting/Northing' values of `c(530000, 180000)` in the [British National Grid](https://en.wikipedia.org/wiki/Ordnance_Survey_National_Grid), meaning that London is located 530 km *East* and 180 km *North* of the $origin$ of the CRS.
This can be verified visually: slightly more than 5 'boxes' --- square areas bounded by the gray grid lines 100 km in width --- separate the point representing London from the origin (Figure \@ref(fig:vectorplots), right panel).

The location of National Grid's\index{National Grid} origin, in the sea beyond South West Peninsular, ensures that most locations in the UK have positive Easting and Northing values.^[
The origin we are referring to, depicted in blue in Figure \@ref(fig:vectorplots), is in fact the 'false' origin.
The 'true' origin, the location at which distortions are at a minimum, is located at 2° W and 49° N.
This was selected by the Ordnance Survey to be roughly in the center of the British landmass longitudinally.
]
There is more to CRSs, as described in Sections \@ref(crs-intro) and \@ref(reproj-geo-data) but, for the purposes of this section, it is sufficient to know that coordinates consist of two numbers representing distance from an origin, usually in $x$ then $y$ dimensions.



\begin{figure}[t]

{\centering \includegraphics[width=0.49\linewidth]{figures/vector_lonlat} \includegraphics[width=0.49\linewidth]{figures/vector_projected} 

}

\caption[Illustration of vector (point) data.]{Illustration of vector (point) data in which location of London (the red X) is represented with reference to an origin (the blue circle). The left plot represents a geographic CRS with an origin at 0° longitude and latitude. The right plot represents a projected CRS with an origin located in the sea west of the South West Peninsula.}(\#fig:vectorplots)
\end{figure}

**sf** provides classes for geographic vector data and a consistent command-line interface to important low level libraries for geocomputation:

- [GDAL](https://gdal.org/)\index{GDAL}, for reading, writing and manipulating a wide range of geographic data formats, covered in Chapter \@ref(read-write)
- [PROJ](https://proj.org/), a powerful library for coordinate system transformations, which underlies the content covered in Chapter \@ref(reproj-geo-data)
- [GEOS](https://libgeos.org/)\index{GEOS}, a planar geometry engine for operations such as calculating buffers and centroids on data with a projected CRS, covered in Chapter \@ref(geometric-operations)
- [S2](https://s2geometry.io/), a spherical geometry engine written in C++ developed by Google, via the [**s2**](https://r-spatial.github.io/s2/) package, covered in Section \@ref(s2) below and in Chapter \@ref(reproj-geo-data)
<!-- - [liblwgeom](https://github.com/postgis/postgis/tree/master/liblwgeom), a geometry engine used by PostGIS, via the [**lwgeom**](https://r-spatial.github.io/lwgeom/) package -->

Information about these interfaces is printed by **sf** the first time the package is loaded: the message `Linking to GEOS 3.8.0, GDAL 3.0.4, PROJ 6.3.1; sf_use_s2() is TRUE` that appears below the `library(sf)` command at the beginning of this chapter tells us the versions of linked GEOS, GDAL and PROJ libraries (these vary between computers and over time) and whether or not the S2 interface is turned on.
Nowadays, we take it for granted, however, only the tight integration with different geographic libraries makes reproducible geocomputation possible in the first place.

A neat feature of **sf** is that you can change the default geometry engine used on unprojected data: 'switching off' S2 can be done with the command `sf::sf_use_s2(FALSE)`, meaning that the planar geometry engine GEOS will be used by default for all geometry operations, including geometry operations on unprojected data.
As we will see in Section \@ref(s2), planar geometry is based on 2 dimensional space.
Planar geometry engines such as GEOS assume 'flat' (projected) coordinates while spherical geometry engines such as S2 assume unprojected (lon/lat) coordinates.

This section introduces **sf** classes in preparation for subsequent chapters (Chapters \@ref(geometric-operations) and \@ref(read-write) cover the GEOS and GDAL interface, respectively).

### An introduction to simple features {#intro-sf}

Simple features is an [open standard](http://portal.opengeospatial.org/files/?artifact_id=25355) developed and endorsed by the Open Geospatial Consortium (OGC), a not-for-profit organization whose activities we will revisit in a later chapter (in Section \@ref(file-formats)).
\index{simple features |see {sf}}
Simple Features is a hierarchical data model that represents a wide range of geometry types.
Of 18 geometry types supported by the specification, only 7 are used in the vast majority of geographic research (see Figure \@ref(fig:sf-ogc));
these core geometry types are fully supported by the R package **sf** [@pebesma_simple_2018].^[
The full OGC standard includes rather exotic geometry types including 'surface' and 'curve' geometry types, which currently have limited application in real world applications.
All 18 types can be represented with the **sf** package, although at the time of writing (2022) plotting only works for the 'core 7'.
]

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{figures/sf-classes} 

}

\caption{Simple feature types fully supported by sf.}(\#fig:sf-ogc)
\end{figure}

**sf** can represent all common vector geometry types (raster data classes are not supported by **sf**): points, lines, polygons and their respective 'multi' versions (which group together features of the same type into a single feature).
\index{sf}
\index{sf (package)|see {sf}}
**sf** also supports geometry collections, which can contain multiple geometry types in a single object.
**sf** provides the same functionality (and more) previously provided in three packages --- **sp** for data classes [@R-sp], **rgdal** for data read/write via an interface to GDAL and PROJ [@R-rgdal] and **rgeos** for spatial operations via an interface to GEOS [@R-rgeos].


To re-iterate the message from Chapter 1, geographic R packages have a long history of interfacing with lower level libraries, and **sf** continues this tradition with a unified interface to recent versions GEOS for geometry operations, the GDAL library for reading and writing geographic data files, and the PROJ library for representing and transforming projected coordinate reference systems.
Through **s2**,
<!-- **s2** functions have replaced **lwgeom** ones (Bivand 2021). -->
<!-- and **lwgeom**, **sf** also has an inter to PostGIS's [`liblwgeom`](https://github.com/postgis/postgis/tree/master/liblwgeom) library  -->
"an R interface to Google's spherical geometry library [`s2`](https://s2geometry.io/), **sf** also has access to fast and accurate "measurements and operations on non-planar geometries" [@bivand_progress_2021].
Since **sf** version 1.0.0, launched in [June 2021](https://cran.r-project.org/src/contrib/Archive/sf/), **s2** functionality is now used by [default](https://r-spatial.org/r/2020/06/17/s2.html) on geometries with geographic (longitude/latitude) coordinate systems, a unique feature of **sf** that differs from spatial libraries that only support GEOS for geometry operations such as the Python package [GeoPandas](geopandas/geopandas/issues/2098).
We will discuss **s2** in subsequent chapters.
<!-- Todo: link to them, e.g. (RL 2021-11) -->
<!-- See sections \@ref(s2) and \@ref(buffers) for further details. -->

**sf**'s ability to integrate multiple powerful libraries for geocomputation into a single framework is a notable achievement that reduces 'barriers to entry' into the world of reproducible geographic data analysis with high-performance libraries.
**sf**'s functionality is well documented on its website at [r-spatial.github.io/sf/](https://r-spatial.github.io/sf/index.html) which contains 7 vignettes.
These can be viewed offline as follows:


```r
vignette(package = "sf") # see which vignettes are available
vignette("sf1")          # an introduction to the package
```



As the first vignette explains, simple feature objects in R are stored in a data frame, with geographic data occupying a special column, usually named 'geom' or 'geometry'.
We will use the `world` dataset provided by **spData**, loaded at the beginning of this chapter, to show what `sf` objects and how they work.
`world` is an '`sf` data frame' containing spatial and attribute columns, the names of which are returned by the function `names()` (the last column in this example contains the geographic information):


```r
class(world)
#> [1] "sf"         "tbl_df"     "tbl"        "data.frame"
names(world)
#>  [1] "iso_a2"    "name_long" "continent" "region_un" "subregion" "type"     
#>  [7] "area_km2"  "pop"       "lifeExp"   "gdpPercap" "geom"
```

The contents of this `geom` column give `sf` objects their spatial powers: `world$geom` is a '[list column](https://adv-r.hadley.nz/vectors-chap.html#list-columns)' that contains all the coordinates of the country polygons.
\index{list column}
`sf` objects can be plotted quickly with the base R function `plot()`;
the following command creates Figure \@ref(fig:world-all).


```r
plot(world)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/world-all-1} 

}

\caption[A spatial plot of the world using the sf package.]{A spatial plot of the world using the sf package, with a facet for each attribute.}(\#fig:world-all)
\end{figure}

Note that instead of creating a single map by default for geographic objects, as most GIS programs do, `plot()`ing `sf` objects results in a map for each variable in the datasets.
This behavior can be useful for exploring the spatial distribution of different variables and is discussed further in Section \@ref(basic-map).

More broadly, treating geographic objects as regular data frames with spatial powers has many advantages, especially if you are already used to working with data frames.
The commonly used `summary()` function, for example, provides a useful overview of the variables within the `world` object.


```r
summary(world["lifeExp"])
#>     lifeExp                geom    
#>  Min.   :50.6   MULTIPOLYGON :177  
#>  1st Qu.:65.0   epsg:4326    :  0  
#>  Median :72.9   +proj=long...:  0  
#>  Mean   :70.9                      
#>  3rd Qu.:76.8                      
#>  Max.   :83.6                      
#>  NA's   :10
```

Although we have only selected one variable for the `summary()` command, it also outputs a report on the geometry.
This demonstrates the 'sticky' behavior of the geometry columns of **sf** objects, meaning the geometry is kept unless the user deliberately removes them, as we'll see in Section \@ref(vector-attribute-manipulation).
The result provides a quick summary of both the non-spatial and spatial data contained in `world`: the mean average life expectancy is 71 years (ranging from less than 51 to more than 83 years with a median of 73 years) across all countries.

\BeginKnitrBlock{rmdnote}
The word `MULTIPOLYGON` in the summary output above refers to the geometry type of features (countries) in the `world` object.
This representation is necessary for countries with islands such as Indonesia and Greece.
Other geometry types are described in Section \@ref(geometry).
\EndKnitrBlock{rmdnote}

It is worth taking a deeper look at the basic behavior and contents of this simple feature object, which can usefully be thought of as a '**s**patial data **f**rame'.

`sf` objects are easy to subset: the code below shows how to return an object containing only the first two rows and the first three columns of the `world` object.
The output shows two major differences compared with a regular `data.frame`: the inclusion of additional geographic metadata (`Geometry type`, `Dimension`, `Bounding box` and coordinate reference system information on the line beginning `Geodetic CRS` CRS information), and the presence of a 'geometry column', here named `geom`:


```r
world_mini = world[1:2, 1:3]
world_mini
#> Simple feature collection with 2 features and 3 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -180 ymin: -18.3 xmax: 180 ymax: -0.95
#> Geodetic CRS:  WGS 84
#> # A tibble: 2 x 4
#>   iso_a2 name_long continent                                                geom
#>   <chr>  <chr>     <chr>                                      <MULTIPOLYGON [°]>
#> 1 FJ     Fiji      Oceania   (((-180 -16.6, -180 -16.5, -180 -16, -180 -16.1, -~
#> 2 TZ     Tanzania  Africa    (((33.9 -0.95, 31.9 -1.03, 30.8 -1.01, 30.4 -1.13,~
```

All this may seem rather complex, especially for a class system that is supposed to be 'simple'!
However, there are good reasons for organizing things this way and using **sf** to work with vector geographic datasets.

Before describing each geometry type that the **sf** package supports, it is worth taking a step back to understand the building blocks of `sf` objects. 
Section \@ref(sf) shows how simple features objects are data frames, with special geometry columns.
These spatial columns are often called `geom` or `geometry`: `world$geom` refers to the spatial element of the `world` object described above.
These geometry columns are 'list columns' of class `sfc` (see Section \@ref(sfc)).
In turn, `sfc` objects are composed of one or more objects of class `sfg`: simple feature geometries that we describe in Section \@ref(sfg).
\index{sf!sfc}
\index{simple feature columns|see {sf!sfc}}

To understand how the spatial components of simple features work, it is vital to understand simple feature geometries.
For this reason we cover each currently supported simple features geometry type in Section \@ref(geometry) before moving on to describe how these can be represented in R using `sf` objects, which are based on `sfg` and `sfc` objects.

\BeginKnitrBlock{rmdnote}
The preceding code chunk uses `=` to create a new object called `world_mini` in the command `world_mini = world[1:2, 1:3]`.
This is called assignment.
An equivalent command to achieve the same result is `world_mini <- world[1:2, 1:3]`.
Although 'arrow assigment' is more commonly used, we use 'equals assignment' because it's slightly faster to type and easier to teach due to compatibility with commonly used languages such as Python and JavaScript.
Which to use is largely a matter of preference as long as you're consistent (packages such as **styler** can be used to change style).
\EndKnitrBlock{rmdnote}

### Why simple features?

Simple features is a widely supported data model that underlies data structures in many GIS applications including QGIS\index{QGIS} and PostGIS\index{PostGIS}.
A major advantage of this is that using the data model ensures your work is cross-transferable to other set-ups, for example importing from and exporting to spatial databases.
\index{sf!why simple features}

A more specific question from an R perspective is "why use the **sf** package when **sp** is already tried and tested"?
There are many reasons (linked to the advantages of the simple features model):

- Fast reading and writing of data
- Enhanced plotting performance
- **sf** objects can be treated as data frames in most operations
- **sf** function names are relatively consistent and intuitive (all begin with `st_`)
- **sf** functions can be combined with the `|>` operator and works well with the [tidyverse](http://tidyverse.org/) collection of R packages\index{tidyverse}.

**sf**'s support for **tidyverse** packages is exemplified by the provision of the `read_sf()` function for reading geographic vector datasets.
Unlike the function `st_read()`, which returns attributes stored in a base R `data.frame` (and which provides more verbose messages, not shown in the code chunk below), `read_sf()` returns data as a **tidyverse** `tibble`.
This is demonstrated below (see Section \@ref(iovec)) on reading geographic vector data):


```r
world_dfr = st_read(system.file("shapes/world.shp", package = "spData"))
#> Reading layer `world' from data source 
#>   `/usr/local/lib/R/site-library/spData/shapes/world.shp' using driver `ESRI Shapefile'
#> Simple feature collection with 177 features and 10 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -180 ymin: -89.9 xmax: 180 ymax: 83.6
#> Geodetic CRS:  WGS 84
world_tbl = read_sf(system.file("shapes/world.shp", package = "spData"))
class(world_dfr)
#> [1] "sf"         "data.frame"
class(world_tbl)
#> [1] "sf"         "tbl_df"     "tbl"        "data.frame"
```

As described in Chapter \@ref(attr), which shows how to manipulate `sf` objects with **tidyverse** functions, **sf** is now the go-to package for analysis of spatial vector data in R (not withstanding the **spatstat** package ecosystem which provides numerous functions for spatial statistics).
Many popular packages build on **sf**, as shown by the rise in its popularity in terms of number of downloads per day, as shown in Section \@ref(r-ecosystem) in the previous chapter.
Transitioning established packages and workflows away from legacy packages **rgeos** and **rgdal** takes time [@bivand_progress_2021], but the process was given a sense of urgency by messages printed when they were loaded, which state that they "will be retired by the end of 2023".
This means that anyone still using these packages should "**transition to sf/stars/terra functions using GDAL and PROJ at your earliest convenience**". 

In other words, **sf** is future proof but **sp** is not.
For workflows that depend on the legacy class system, `sf` objects can be converted from and to the `Spatial` class of the **sp** package as follows:


```r
library(sp)
world_sp = as(world, "Spatial") # from an sf object to sp
# sp functions ...
world_sf = st_as_sf(world_sp)           # from sp to sf
```

### Basic map making {#basic-map}

Basic maps are created in **sf** with `plot()`.
By default this creates a multi-panel plot, one sub-plot for each variable of the object, as illustrated in the left-hand panel in Figure \@ref(fig:sfplot).
A legend or 'key' with a continuous color is produced if the object to be plotted has a single variable (see the right-hand panel).
Colors can also be set with `col = `, although this will not create a continuous palette or a legend. 
\index{map making!basic}


```r
plot(world[3:6])
plot(world["pop"])
```

\begin{figure}[t]

{\centering \includegraphics[width=0.49\linewidth]{02-spatial-data_files/figure-latex/sfplot-1} \includegraphics[width=0.49\linewidth]{02-spatial-data_files/figure-latex/sfplot-2} 

}

\caption[Plotting with sf.]{Plotting with sf, with multiple variables (left) and a single variable (right).}(\#fig:sfplot)
\end{figure}

Plots are added as layers to existing images by setting `add = TRUE`.^[
`plot()`ing of **sf** objects uses `sf:::plot.sf()` behind the scenes.
`plot()` is a generic method that behaves differently depending on the class of object being plotted.
]
To demonstrate this, and to provide a insight into the contents of Chapters \@ref(attr) and \@ref(spatial-operations) on attribute and spatial data operations, the subsequent code chunk filters countries in Asia and combines them into a single feature:


```r
world_asia = world[world$continent == "Asia", ]
asia = st_union(world_asia)
```

We can now plot the Asian continent over a map of the world.
Note that the first plot must only have one facet for `add = TRUE` to work.
If the first plot has a key, `reset = FALSE` must be used (result not shown):


```r
plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")
```

Adding layers in this way can be used to verify the geographic correspondence between layers: 
the `plot()` function is fast to execute and requires few lines of code, but does not create interactive maps with a wide range of options.
For more advanced map making we recommend using dedicated visualization packages such as **tmap** (see Chapter \@ref(adv-map)).

There are various ways to modify maps with **sf**'s `plot()` method.
Because **sf** extends base R plotting methods `plot()`'s arguments such as `main =` (which specifies the title of the map) work with `sf` objects (see `?graphics::plot` and `?par`).^[
Note: many plot arguments are ignored in facet maps, when more than one `sf` column is plotted.
]
\index{base plot|see {map making}}
\index{map making!base plotting}

Figure \@ref(fig:contpop) illustrates this flexibility by overlaying circles, whose diameters (set with `cex =`) represent country populations, on a map of the world.
An unprojected version of this figure can be created with the following commands (see exercises at the end of this chapter and the script [`02-contplot.R`](https://github.com/Robinlovelace/geocompr/blob/main/code/02-contpop.R) to reproduce Figure \@ref(fig:contpop)):


```r
plot(world["continent"], reset = FALSE)
cex = sqrt(world$pop) / 10000
world_cents = st_centroid(world, of_largest = TRUE)
plot(st_geometry(world_cents), add = TRUE, cex = cex)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/contpop-1} 

}

\caption[Country continents and 2015 populations.]{Country continents (represented by fill color) and 2015 populations (represented by circles, with area proportional to population).}(\#fig:contpop)
\end{figure}

The code above uses the function `st_centroid()` to convert one geometry type (polygons) to another (points) (see Chapter \@ref(geometric-operations)), the aesthetics of which are varied with the `cex` argument.

\index{bounding box}
**sf**'s plot method also has arguments specific to geographic data. `expandBB`, for example, can be used to plot an `sf` object in context:
it takes a numeric vector of length four that expands the bounding box of the plot relative to zero in the following order: bottom, left, top, right.
This is used to plot India in the context of its giant Asian neighbors, with an emphasis on China to the east, in the following code chunk, which generates Figure \@ref(fig:china) (see exercises below on adding text to plots):^[
Note the use of `st_geometry(india)` to return only the geometry associated with the object to prevent attributes being plotted in a simple feature column (`sfc`) object.
An alternative is to use `india[0]`, which returns an `sf` object that contains no attribute data..
]


```r
india = world[world$name_long == "India", ]
plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3)
plot(st_geometry(world_asia), add = TRUE)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{02-spatial-data_files/figure-latex/china-1} 

}

\caption{India in context, demonstrating the expandBB argument.}(\#fig:china)
\end{figure}



Note the use of `lwd` to emphasize India in the plotting code.
See Section \@ref(other-mapping-packages) for other visualization techniques for representing a range of geometry types, the subject of the next section.

### Geometry types {#geometry}

Geometries are the basic building blocks of simple features.
Simple features in R can take on one of the 18 geometry types supported by the **sf** package.
\index{geometry types|see {sf!geometry types}}
\index{sf!geometry types}
In this chapter we will focus on the seven most commonly used types: `POINT`, `LINESTRING`, `POLYGON`, `MULTIPOINT`, `MULTILINESTRING`, `MULTIPOLYGON` and `GEOMETRYCOLLECTION`.
Find the whole list of possible feature types in [the PostGIS manual ](http://postgis.net/docs/using_postgis_dbmanagement.html).

Generally, well-known binary (WKB) or well-known text (WKT) are the standard encoding for simple feature geometries.
\index{well-known text}
\index{WKT|see {well-known text}}
\index{well-known binary}
WKB representations are usually hexadecimal strings easily readable for computers.
This is why GIS and spatial databases use WKB to transfer and store geometry objects.
WKT, on the other hand, is a human-readable text markup description of simple features. 
Both formats are exchangeable, and if we present one, we will naturally choose the WKT representation.

The basis for each geometry type is the point. 
A point is simply a coordinate in 2D, 3D or 4D space (see `vignette("sf1")` for more information) such as (see left panel in Figure \@ref(fig:sfcs)):
\index{sf!point}

- `POINT (5 2)`

\index{sf!linestring}
A linestring is a sequence of points with a straight line connecting the points, for example (see middle panel in Figure \@ref(fig:sfcs)):

- `LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2)`

A polygon is a sequence of points that form a closed, non-intersecting ring.
Closed means that the first and the last point of a polygon have the same coordinates (see right panel in Figure \@ref(fig:sfcs)).^[
By definition, a polygon has one exterior boundary (outer ring) and can have zero or more interior boundaries (inner rings), also known as holes.
A polygon with a hole would be, for example, `POLYGON ((1 5, 2 2, 4 1, 4 4, 1 5), (2 4, 3 4, 3 3, 2 3, 2 4))`
]
\index{sf!hole}

- Polygon without a hole: `POLYGON ((1 5, 2 2, 4 1, 4 4, 1 5))`

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/sfcs-1} 

}

\caption{Illustration of point, linestring and polygon geometries.}(\#fig:sfcs)
\end{figure}



So far we have created geometries with only one geometric entity per feature.
However, **sf** also allows multiple geometries to exist within a single feature (hence the term 'geometry collection') using "multi" version of each geometry type:
\index{sf!multi features}

- Multipoint: `MULTIPOINT (5 2, 1 3, 3 4, 3 2)`
- Multilinestring: `MULTILINESTRING ((1 5, 4 4, 4 1, 2 2, 3 2), (1 2, 2 4))`
- Multipolygon: `MULTIPOLYGON (((1 5, 2 2, 4 1, 4 4, 1 5), (0 2, 1 2, 1 3, 0 3, 0 2)))`

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/multis-1} 

}

\caption{Illustration of multi* geometries.}(\#fig:multis)
\end{figure}

Finally, a geometry collection can contain any combination of geometries including (multi)points and linestrings (see Figure \@ref(fig:geomcollection)):
\index{sf!geometry collection}

- Geometry collection: `GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2), LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))`

\begin{figure}[t]

{\centering \includegraphics[width=0.33\linewidth]{02-spatial-data_files/figure-latex/geomcollection-1} 

}

\caption{Illustration of a geometry collection.}(\#fig:geomcollection)
\end{figure}

### The sf class {#sf}

Simple features consist of two main parts: geometries and non-geographic attributes.
Figure \@ref(fig:02-sfdiagram) shows how an sf object is created -- geometries come from an `sfc` object, while attributes are taken from a `data.frame` or `tibble`.
To learn more about building sf geometries from scratch read the following Sections \@ref(sfg) and \@ref(sfc).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/02-sfdiagram} 

}

\caption{Building blocks of sf objects.}(\#fig:02-sfdiagram)
\end{figure}

Non-geographic attributes represent the name of the feature or other attributes such as measured values, groups, and other things.
\index{sf!class}
To illustrate attributes, we will represent a temperature of 25°C in London on June 21^st^, 2017.
This example contains a geometry (the coordinates), and three attributes with three different classes (place name, temperature and date).^[
Other attributes might include an urbanity category (city or village), or a remark if the measurement was made using an automatic station.
]
Objects of class `sf` represent such data by combining the attributes (`data.frame`) with the simple feature geometry column (`sfc`).
They are created with `st_sf()` as illustrated below, which creates the London example described above:


```r
lnd_point = st_point(c(0.1, 51.5))                 # sfg object
lnd_geom = st_sfc(lnd_point, crs = 4326)           # sfc object
lnd_attrib = data.frame(                           # data.frame object
  name = "London",
  temperature = 25,
  date = as.Date("2017-06-21")
  )
lnd_sf = st_sf(lnd_attrib, geometry = lnd_geom)    # sf object
```

What just happened? First, the coordinates were used to create the simple feature geometry (`sfg`).
Second, the geometry was converted into a simple feature geometry column (`sfc`), with a CRS.
Third, attributes were stored in a `data.frame`, which was combined with the `sfc` object with `st_sf()`.
This results in an `sf` object, as demonstrated below (some output is omitted):


```r
lnd_sf
#> Simple feature collection with 1 features and 3 fields
#> ...
#>     name temperature       date         geometry
#> 1 London          25 2017-06-21 POINT (0.1 51.5)
```


```r
class(lnd_sf)
#> [1] "sf"         "data.frame"
```

The result shows that `sf` objects actually have two classes, `sf` and `data.frame`.
Simple features are simply data frames (square tables), but with spatial attributes stored in a list column, usually called `geometry`, as described in Section \@ref(intro-sf).
This duality is central to the concept of simple features:
most of the time a `sf` can be treated as and behaves like a `data.frame`.
Simple features are, in essence, data frames with a spatial extension.



### Simple feature geometries (sfg) {#sfg}

The `sfg` class represents the different simple feature geometry types in R: point, linestring, polygon (and their 'multi' equivalents, such as multipoints) or geometry collection.
\index{simple feature geometries|see {sf!sfg}}

Usually you are spared the tedious task of creating geometries on your own since you can simply import an already existing spatial file.
However, there are a set of functions to create simple feature geometry objects (`sfg`) from scratch if needed.
The names of these functions are simple and consistent, as they all start with the `st_`  prefix and end with the name of the geometry type in lowercase letters:

- A point: `st_point()`
- A linestring: `st_linestring()`
- A polygon: `st_polygon()`
- A multipoint: `st_multipoint()`
- A multilinestring: `st_multilinestring()`
- A multipolygon: `st_multipolygon()`
- A geometry collection: `st_geometrycollection()`

`sfg` objects can be created from three base R data types:

1. A numeric vector: a single point
2. A matrix: a set of points, where each row represents a point, a multipoint or linestring
3. A list: a collection of objects such as matrices, multilinestrings or geometry collections

The function `st_point()` creates single points from numeric vectors:


```r
st_point(c(5, 2))                 # XY point
#> POINT (5 2)
st_point(c(5, 2, 3))              # XYZ point
#> POINT Z (5 2 3)
st_point(c(5, 2, 1), dim = "XYM") # XYM point
#> POINT M (5 2 1)
st_point(c(5, 2, 3, 1))           # XYZM point
#> POINT ZM (5 2 3 1)
```

The results show that XY (2D coordinates), XYZ (3D coordinates) and XYZM (3D with an additional variable, typically measurement accuracy) point types are created from vectors of length 2, 3, and 4, respectively. 
The XYM type must be specified using the `dim` argument (which is short for dimension).

By contrast, use matrices in the case of multipoint (`st_multipoint()`) and linestring (`st_linestring()`) objects:


```r
# the rbind function simplifies the creation of matrices
## MULTIPOINT
multipoint_matrix = rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)
#> MULTIPOINT ((5 2), (1 3), (3 4), (3 2))
## LINESTRING
linestring_matrix = rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)
#> LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2)
```

Finally, use lists for the creation of multilinestrings, (multi-)polygons and geometry collections:


```r
## POLYGON
polygon_list = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
st_polygon(polygon_list)
#> POLYGON ((1 5, 2 2, 4 1, 4 4, 1 5))
```


```r
## POLYGON with a hole
polygon_border = rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole = rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list = list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)
#> POLYGON ((1 5, 2 2, 4 1, 4 4, 1 5), (2 4, 3 4, 3 3, 2 3, 2 4))
```


```r
## MULTILINESTRING
multilinestring_list = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
st_multilinestring((multilinestring_list))
#> MULTILINESTRING ((1 5, 4 4, 4 1, 2 2, 3 2), (1 2, 2 4))
```


```r
## MULTIPOLYGON
multipolygon_list = list(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))),
                         list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2))))
st_multipolygon(multipolygon_list)
#> MULTIPOLYGON (((1 5, 2 2, 4 1, 4 4, 1 5)), ((0 2, 1 2, 1 3, 0 3, 0 2)))
```


```r
## GEOMETRYCOLLECTION
geometrycollection_list = list(st_multipoint(multipoint_matrix),
                              st_linestring(linestring_matrix))
st_geometrycollection(geometrycollection_list)
#> GEOMETRYCOLLECTION (MULTIPOINT (5 2, 1 3, 3 4, 3 2),
#>   LINESTRING (1 5, 4 4, 4 1, 2 2, 3 2))
```

### Simple feature columns (sfc) {#sfc}

One `sfg` object contains only a single simple feature geometry. 
A simple feature geometry column (`sfc`) is a list of `sfg` objects, which is additionally able to contain information about the coordinate reference system in use.
For instance, to combine two simple features into one object with two features, we can use the `st_sfc()` function. 
\index{sf!simple feature columns (sfc)}
This is important since `sfc` represents the geometry column in **sf** data frames:


```r
# sfc POINT
point1 = st_point(c(5, 2))
point2 = st_point(c(1, 3))
points_sfc = st_sfc(point1, point2)
points_sfc
#> Geometry set for 2 features 
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 1 ymin: 2 xmax: 5 ymax: 3
#> CRS:           NA
#> POINT (5 2)
#> POINT (1 3)
```

In most cases, an `sfc` object contains objects of the same geometry type.
Therefore, when we convert `sfg` objects of type polygon into a simple feature geometry column, we would also end up with an `sfc` object of type polygon, which can be verified with `st_geometry_type()`. 
Equally, a geometry column of multilinestrings would result in an `sfc` object of type multilinestring:


```r
# sfc POLYGON
polygon_list1 = list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 = st_polygon(polygon_list1)
polygon_list2 = list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 = st_polygon(polygon_list2)
polygon_sfc = st_sfc(polygon1, polygon2)
st_geometry_type(polygon_sfc)
#> [1] POLYGON POLYGON
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON MULTIPOINT ... TRIANGLE
```


```r
# sfc MULTILINESTRING
multilinestring_list1 = list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
multilinestring1 = st_multilinestring((multilinestring_list1))
multilinestring_list2 = list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                            rbind(c(1, 7), c(3, 8)))
multilinestring2 = st_multilinestring((multilinestring_list2))
multilinestring_sfc = st_sfc(multilinestring1, multilinestring2)
st_geometry_type(multilinestring_sfc)
#> [1] MULTILINESTRING MULTILINESTRING
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON MULTIPOINT ... TRIANGLE
```

It is also possible to create an `sfc` object from `sfg` objects with different geometry types:


```r
# sfc GEOMETRY
point_multilinestring_sfc = st_sfc(point1, multilinestring1)
st_geometry_type(point_multilinestring_sfc)
#> [1] POINT           MULTILINESTRING
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON MULTIPOINT ... TRIANGLE
```

As mentioned before, `sfc` objects can additionally store information on the coordinate reference systems (CRS).
The default value is `NA` (*Not Available*), as can be verified with `st_crs()`:


```r
st_crs(points_sfc)
#> Coordinate Reference System: NA
```

All geometries in `sfc` objects must have the same CRS.
A CRS can be specified with the `crs` argument of `st_sfc()` (or `st_sf()`), which takes a **CRS identifier** provided as a text string, such as `crs = "EPSG:4326"` (see Section \@ref(crs-in-r) for other CRS representations and details on what this means).


```r
# Set the CRS with an identifier referring to an 'EPSG' CRS code:
points_sfc_wgs = st_sfc(point1, point2, crs = "EPSG:4326")
st_crs(points_sfc_wgs) # print CRS (only first 4 lines of output shown)
#> Coordinate Reference System:
#>   User input: EPSG:4326 
#>   wkt:
#> GEOGCRS["WGS 84",
#> ...
```

### The sfheaders package



**sfheaders** is an R package that speeds-up the construction, conversion and manipulation of `sf` objects [@cooley_sfheaders_2020].
It focuses on building `sf` objects from vectors, matrices and data frames, rapidly, and without depending on the **sf** library; and exposing its underlying C++ code through header files (hence the name, **sfheaders**).
This approach enables others to extend it using compiled and fast-running code.
Every core **sfheaders** function has a corresponding C++ implementation, as described in [the `Cpp` vignette](https://dcooley.github.io/sfheaders/articles/Cpp.html).
For most people, the R functions will be more than sufficient to benefit from the computational speed of the package.
**sfheaders** was developed separately from **sf**, but aims to be fully compatible, creating valid `sf` objects of the type described in preceding sections.

The simplest use-case for **sfheaders** is demonstrated in the code chunks below with examples of building `sfg`, `sfc`, and `sf` objects showing:

- A vector converted to `sfg_POINT`
- A matrix converted to `sfg_LINESTRING`
- A data frame converted to `sfg_POLYGON`

We will start by creating the simplest possible `sfg` object, a single coordinate pair, assigned to a vector named `v`:


```r
v = c(1, 1)
v_sfg_sfh = sfheaders::sfg_point(obj = v)
```


```r
v_sfg_sfh # printing without sf loaded
#>      [,1] [,2]
#> [1,]    1    1
#> attr(,"class")
#> [1] "XY"    "POINT" "sfg" 
```



The example above shows how the `sfg` object `v_sfg_sfh` is printed when **sf** is not loaded, demonstrating its underlying structure.
When **sf** is loaded (as is the case here), the result of the above command is indistinguishable from `sf` objects:


```r
v_sfg_sf = st_point(v)
print(v_sfg_sf) == print(v_sfg_sfh)
#> POINT (1 1)
#> POINT (1 1)
#> [1] TRUE
```



The next examples shows how **sfheaders** creates `sfg` objects from matrices and data frames:


```r
# matrices
m = matrix(1:8, ncol = 2)
sfheaders::sfg_linestring(obj = m)
#> LINESTRING (1 5, 2 6, 3 7, 4 8)
# data.frames
df = data.frame(x = 1:4, y = 4:1)
sfheaders::sfg_polygon(obj = df)
#> POLYGON ((1 4, 2 3, 3 2, 4 1, 1 4))
```

Reusing the objects `v`, `m`, and `df` we can also build simple feature columns (`sfc`) as follows (outputs not shown):


```r
sfheaders::sfc_point(obj = v)
sfheaders::sfc_linestring(obj = m)
sfheaders::sfc_polygon(obj = df)
```

Similarly, `sf` objects can be created as follows:


```r
sfheaders::sf_point(obj = v)
sfheaders::sf_linestring(obj = m)
sfheaders::sf_polygon(obj = df)
```

In each of these examples the CRS (coordinate reference system) is not defined.
If you plan on doing any calculations or geometric operations using **sf** functions, we encourage you to set the CRS (see Chapter \@ref(reproj-geo-data) for details):


```r
df_sf = sfheaders::sf_polygon(obj = df)
st_crs(df_sf) = "EPSG:4326"
```

**sfheaders** is also good at 'deconstructing' and 'reconstructing' `sf` objects, meaning converting geometry columns into data frames that contain data on the coordinates of each vertex and geometry feature (and multi-feature) ids.
It is fast and reliable at 'casting' geometry columns to different types, a topic covered in Chapter \@ref(geometric-operations).
Benchmarks, in the package's [documentation](https://dcooley.github.io/sfheaders/articles/examples.html#performance) and in test code developed for this book, show it is much faster than the `sf` package for such operations.

### Spherical geometry operations with S2 {#s2}

Spherical geometry engines are based on the fact that world is round while simple mathematical procedures for geocomputation, such as calculating a straight line between two points or the area enclosed by a polygon, assume planar (projected) geometries.
Since **sf** version 1.0.0, R supports spherical geometry operations 'out of the box', thanks to its interface to Google's S2 spherical geometry engine via the **s2** interface package.
S2 is perhaps best known as an example of a Discrete Global Grid System (DGGS).
Another example is the [H3](https://eng.uber.com/h3/) global hexagonal hierarchical spatial index  [@bondaruk_assessing_2020].

Although potentially useful for describing locations anywhere on Earth using character strings such as [e66ef376f790adf8a5af7fca9e6e422c03c9143f](https://developers.google.com/maps/documentation/gaming/concepts_playable_locations), the main benefit of **sf**'s interface to S2 is its provision of drop-in functions for calculations such as distance, buffer, and area calculations, as described in **sf**'s built in documentation which can be opened with the command [`vignette("sf7")`](https://r-spatial.github.io/sf/articles/sf7.html).

**sf** can run in two modes with respect to S2: on and off.
By default the S2 geometry engine is turned on, as can be verified with the following command:


```r
sf_use_s2()
#> [1] TRUE
```

An example of the consequences of turning the geometry engine off is shown below, by creating buffers around the `india` object created earlier in the chapter (note the warnings emitted when S2 is turned off):


```r
india_buffer_with_s2 = st_buffer(india, 1)
sf_use_s2(FALSE)
#> Spherical geometry (s2) switched off
india_buffer_without_s2 = st_buffer(india, 1)
#> Warning in st_buffer.sfc(st_geometry(x), dist, nQuadSegs, endCapStyle =
#> endCapStyle, : st_buffer does not correctly buffer longitude/latitude data
#> dist is assumed to be in decimal degrees (arc_degrees).
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/s2example-1} 

}

\caption{Example of the consequences of turning off the S2 geometry engine. Both representations of a buffer around India were created with the same command but the purple polygon object was created with S2 switched on, resulting in a buffer of 1 m. The larger light green polygon was created with S2 switched off, resulting in a buffer with inaccurate units of degrees longitude/latitude.}(\#fig:s2example)
\end{figure}

Throughout this book we will assume that S2 is turned on, unless explicitly stated.
Turn it on again with the following command.


```r
sf_use_s2(TRUE)
#> Spherical geometry (s2) switched on
```

\BeginKnitrBlock{rmdnote}
Although the **sf**'s used of S2 makes sense in many cases, in some cases there are good reasons for turning S2 off for the duration of an R session or even for an entire project.
As documented in issue [1771](https://github.com/r-spatial/sf/issues/1771) in **sf**'s GitHub repo, the default behavior can make code that would work with S2 turned off (and with older versions of **sf**) fail.
These edge cases include operations on polygons that are not valid according to S2's stricter definition.
If you see error message such as `#> Error in s2_geography_from_wkb ...` it may be worth trying the command that generated the error message again, after turning off S2. 
To turn off S2 for the entirety of a project you can create a file called .Rprofile in the root directory (the main folder) of your project containing the command `sf::sf_use_s2(FALSE)`.
\EndKnitrBlock{rmdnote}

## Raster data

The spatial raster data model represents the world with the continuous grid of cells (often also called pixels; Figure \@ref(fig:raster-intro-plot):A).
This data model often refers to so-called regular grids, in which each cell has the same, constant size -- and we will focus on the regular grids in this book only.
However, several other types of grids exist, including rotated, sheared, rectilinear, and curvilinear grids (see Chapter 1 of @pebesma_spatial_2022 or Chapter 2 of @tennekes_elegant_2022).

The raster data model usually consists of a raster header\index{raster!header}
and a matrix (with rows and columns) representing equally spaced cells (often also called pixels; Figure \@ref(fig:raster-intro-plot):A).^[
Depending on the file format the header is part of the actual image data file, e.g., GeoTIFF, or stored in an extra header or world file, e.g., ASCII grid formats. 
There is also the headerless (flat) binary raster format which should facilitate the import into various software programs.]
The raster header\index{raster!header} defines the coordinate reference system, the extent and the origin.
\index{raster}
\index{raster data model}
The origin (or starting point) is frequently the coordinate of the lower-left corner of the matrix (the **terra** package, however, uses the upper left corner, by default (Figure  \@ref(fig:raster-intro-plot):B)).
The header defines the extent via the number of columns, the number of rows and the cell size resolution.
Hence, starting from the origin, we can easily access and modify each single cell by either using the ID of a cell (Figure  \@ref(fig:raster-intro-plot):B) or by explicitly specifying the rows and columns.
This matrix representation avoids storing explicitly the coordinates for the four corner points (in fact it only stores one coordinate, namely the origin) of each cell corner as would be the case for rectangular vector polygons.
This and map algebra (Section \@ref(map-algebra)) makes raster processing much more efficient and faster than vector data processing.
However, in contrast to vector data, the cell of one raster layer can only hold a single value.
The value might be numeric or categorical (Figure \@ref(fig:raster-intro-plot):C).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/raster-intro-plot-1} 

}

\caption[Raster data types.]{Raster data types: (A) cell IDs, (B) cell values, (C) a colored raster map.}(\#fig:raster-intro-plot)
\end{figure}

Raster maps usually represent continuous phenomena such as elevation, temperature, population density or spectral data.
Discrete features such as soil or land-cover classes can also be represented in the raster data model.
Both uses of raster datasets are illustrated in Figure \@ref(fig:raster-intro-plot2), which shows how the borders of discrete features may become blurred in raster datasets.
Depending on the nature of the application, vector representations of discrete features may be more suitable.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/raster-intro-plot2-1} 

}

\caption{Examples of continuous and categorical rasters.}(\#fig:raster-intro-plot2)
\end{figure}

### R packages for working with raster data

Over the last two decades, several packages for reading and processing raster datasets have been developed.
As outlined in Section \@ref(the-history-of-r-spatial), chief among them was **raster**, which led to a step change in R's raster capabilities when it was launched in 2010 and the premier package in the space until the development of **terra** and **stars**.
Both more recently developed package provide powerful and performant functions for working with raster datasets and there is substantial overlap between their possible use cases.
In this book we focus on **terra**, which replaces the older and (in most cases) slower **raster**.
Before learning about the how **terra**'s class system works, this section describes similarities and differences between **terra** and **stars**; this knowledge will help decide which is most appropriate in different situations.

First, **terra** focuses on the most common raster data model (regular grids), while **stars** also allows storing less popular models (including regular, rotated, sheared, rectilinear, and curvilinear grids).
While **terra** usually handle one or multi-layered rasters^[It also has an additional class `SpatRasterDataset` for storing many collections of datasets.], the **stars** package provides ways to store raster data cubes -- a raster object with many layers (e.g., bands), for many moments in time (e.g., months), and many attributes (e.g., sensor type A and sensor type B).
Importantly, in both packages, all layers or elements of a data cube must have the same spatial dimensions and extent.
Second, both packages allow to either read all of the raster data into memory or just to read its metadata -- this is usually done automatically based on the input file size.
However, they store raster values very differently. 
**terra** is based on C++ code and mostly uses C++ pointers.
**stars** stores values as lists of arrays for smaller rasters or just a file path for larger ones.
Third, **stars** functions are closely related to the vector objects and functions in **sf**, while **terra** uses its own class of objects for vector data, namely `SpatVector`.
Fourth, both packages have a different approach for how various functions work on their objects.
The **terra** package mostly relies on a large number of built-in functions, where each function has a specific purpose (e.g., resampling or cropping).
On the other hand, **stars** uses some build-in functions (usually with names starting with `st_`), has its own methods for existing R functions (e.g., `split()` or `aggregate()`), and also for existing **dplyr** functions (e.g., `filter()` or `slice()`).

Importantly, it is straightforward to convert objects from **terra** to **stars** (using `st_as_stars()`) and the other way round (using `rast()`).
We also encourage you to read @pebesma_spatial_2022 for the most comprehensive introduction to the **stars** package.

### An introduction to terra

The **terra** package supports raster objects in R.
Like its predecessor **raster** (created by the same developer, Robert Hijmans), it provides an extensive set of functions to create, read, export, manipulate and process raster datasets.
**terra**'s functionality is largely the same as the more mature **raster** package, but there are some differences: **terra** functions are usually more computationally efficient than **raster** equivalents.
<!-- todo: add evidence (RL 2021-11) -->
On the other hand, the **raster** class system is popular and used by many other packages.
You can seamlessly translate between the two types of object to ensure backwards compatibility with older scripts and packages, for example, with the functions [`raster()`](https://rspatial.github.io/raster/reference/raster.html), [`stack()`](https://rspatial.github.io/raster/reference/stack.html), and `brick()` in the **raster** package (see the previous chapter for more on the evolution of R packages for working with geographic data).



In addition to functions for raster data manipulation, **terra** provides many low-level functions that can form a foundation for developing new tools for working with raster datasets.
\index{terra (package)|see {terra}}
**terra** also lets you work on large raster datasets that are too large to fit into the main memory.
In this case, **terra** provides the possibility to divide the raster into smaller chunks, and processes these iteratively instead of loading the whole raster file into RAM.

For the illustration of **terra** concepts, we will use datasets from the **spDataLarge**.
It consists of a few raster objects and one vector object covering an area of the Zion National Park (Utah, USA).
For example, `srtm.tif` is a digital elevation model of this area (for more details, see its documentation `?srtm`).
First, let's create a `SpatRaster` object named `my_rast`:


```r
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
my_rast = rast(raster_filepath)
class(my_rast)
#> [1] "SpatRaster"
#> attr(,"package")
#> [1] "terra"
```

Typing the name of the raster into the console, will print out the raster header (dimensions, resolution, extent, CRS) and some additional information (class, data source, summary of the raster values): 


```r
my_rast
#> class       : SpatRaster 
#> dimensions  : 457, 465, 1  (nrow, ncol, nlyr)
#> resolution  : 0.000833, 0.000833  (x, y)
#> extent      : -113, -113, 37.1, 37.5  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#> source      : srtm.tif 
#> name        : srtm 
#> min value   : 1024 
#> max value   : 2892
```

Dedicated functions report each component: `dim()` returns the number of rows, columns and layers; `ncell()` the number of cells (pixels); `res()` the spatial resolution; `ext()` its spatial extent; and `crs()` its coordinate reference system (raster reprojection is covered in Section \@ref(reproj-ras)).
`inMemory()` reports whether the raster data is stored in memory or on disk.

`help("terra-package")` returns a full list of all available **terra** functions.

### Basic map making {#basic-map-raster}

Similar to the **sf** package, **terra** also provides `plot()` methods for its own classes.
\index{map making!basic raster}


```r
plot(my_rast)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{02-spatial-data_files/figure-latex/basic-new-raster-plot-1} 

}

\caption{Basic raster plot.}(\#fig:basic-new-raster-plot)
\end{figure}

There are several other approaches for plotting raster data in R that are outside the scope of this section, including:

- `plotRGB()` function from the **terra** package to create *a Red-Green-Blue plot* based on three layers in a `SpatRaster` object
- Packages such as **tmap** to create static and interactive maps of raster and vector objects (see Chapter \@ref(adv-map)) 
- Functions, for example `levelplot()` from the **rasterVis** package, to create facets, a common technique for visualizing change over time

### Raster classes {#raster-classes}

The `SpatRaster` class represents rasters object in **terra**.
The easiest way to create a raster object in R is to read-in a raster file from disk or from a server (Section \@ref(raster-data-read).
\index{raster!class}


```r
single_raster_file = system.file("raster/srtm.tif", package = "spDataLarge")
single_rast = rast(raster_filepath)
```

The **terra** package supports numerous drivers with the help of the GDAL library.
Rasters from files are usually not read entirely into RAM, with an exception of their header and a pointer to the file itself.

Rasters can also be created from scratch using the same `rast()` function.
This is illustrated in the subsequent code chunk, which results in a new `SpatRaster` object.
The resulting raster consists of 36 cells (6 columns and 6 rows specified by `nrows` and `ncols`) centered around the Prime Meridian and the Equator (see `xmin`, `xmax`, `ymin` and `ymax` parameters).
The default CRS of raster objects is WGS84, but can be changed with the `crs` argument.
This means the unit of the resolution is in degrees which we set to 0.5 (`resolution`). 
Values (`vals`) are assigned to each cell: 1 to cell 1, 2 to cell 2, and so on.
Remember: `rast()` fills cells row-wise (unlike `matrix()`) starting at the upper left corner, meaning the top row contains the values 1 to 6, the second 7 to 12, etc.


```r
new_raster = rast(nrows = 6, ncols = 6, resolution = 0.5, 
                  xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
                  vals = 1:36)
```

For other ways of creating raster objects, see `?rast`.

The `SpatRaster` class also handles multiple layers, which typically correspond to a single multispectral satellite file or a time-series of rasters.


```r
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(multi_raster_file)
multi_rast
#> class       : SpatRaster 
#> dimensions  : 1428, 1128, 4  (nrow, ncol, nlyr)
#> resolution  : 30, 30  (x, y)
#> extent      : 301905, 335745, 4111245, 4154085  (xmin, xmax, ymin, ymax)
#> coord. ref. : WGS 84 / UTM zone 12N (EPSG:32612) 
#> source      : landsat.tif 
#> names       : landsat_1, landsat_2, landsat_3, landsat_4 
#> min values  :      7550,      6404,      5678,      5252 
#> max values  :     19071,     22051,     25780,     31961
```

`nlyr()` retrieves the number of layers stored in a `SpatRaster` object:


```r
nlyr(multi_rast)
#> [1] 4
```

For multi-layer raster objects, layers can be selected with `terra::subset()`.^[
The `[[` and `$` operators can also be used to select layers, for example with commands `multi_rast$landsat_1` and `multi_rast[["landsat_1"]]`.
]
It accepts a layer number or its name as the second argument:


```r
multi_rast3 = subset(multi_rast, 3)
multi_rast4 = subset(multi_rast, "landsat_4")
```

The opposite operation, combining several `SpatRaster` objects into one, can be done using the `c` function:


```r
multi_rast34 = c(multi_rast3, multi_rast4)
```

\BeginKnitrBlock{rmdnote}
Most `SpatRaster` objects do not store raster values, but rather a pointer to the file itself.
This has a significant side-effect -- they cannot be directly saved to `".rds"` or `".rda"` files or used in cluster computing.
In these cases, there are two possible solutions: (1) use of the `wrap()` function that creates a special kind of temporary object that can be saved as an R object or used in cluster computing, or (2) save the object as a regular raster with `writeRaster()`.
\EndKnitrBlock{rmdnote}

<!--jn:toDo-->
<!--consider new section with other data models-->
<!-- e.g. point clouds, data cubes, meshes, etc. -->

## Geographic and projected Coordinate Reference Systems {#crs-intro}

\index{CRS!introduction}
Vector and raster spatial data types share concepts intrinsic to spatial data.
Perhaps the most fundamental of these is the Coordinate Reference System (CRS), which defines how the spatial elements of the data relate to the surface of the Earth (or other bodies).
CRSs are either geographic or projected, as introduced at the beginning of this chapter (see Figure \@ref(fig:vectorplots)).
This section explains each type, laying the foundations for Chapter \@ref(reproj-geo-data), which provides a deep dive into setting, transforming and querying CRSs.

### Geographic coordinate systems

\index{CRS!geographic}
Geographic coordinate systems identify any location on the Earth's surface using two values --- longitude and latitude (see left panel of Figure \@ref(fig:vector-crs)). 
*Longitude* is location in the East-West direction in angular distance from the Prime Meridian plane.
*Latitude* is angular distance North or South of the equatorial plane.
Distances in geographic CRSs are therefore not measured in meters.
This has important consequences, as demonstrated in Section \@ref(reproj-geo-data).

The surface of the Earth in geographic coordinate systems is represented by a spherical or ellipsoidal surface.
Spherical models assume that the Earth is a perfect sphere of a given radius -- they have the advantage of simplicity but, at the same time, they are inaccurate: the Earth is not a sphere!
Ellipsoidal models are defined by two parameters: the equatorial radius and the polar radius.
These are suitable because the Earth is compressed: the equatorial radius is around 11.5 km longer than the polar radius [@maling_coordinate_1992].^[
The degree of compression is often referred to as *flattening*, defined in terms of the equatorial radius ($a$) and polar radius ($b$) as follows: $f = (a - b) / a$. The terms *ellipticity* and *compression* can also be used.
Because $f$ is a rather small value, digital ellipsoid models use the 'inverse flattening' ($rf = 1/f$) to define the Earth's compression.
Values of $a$ and $rf$ in various ellipsoidal models can be seen by executing `sf_proj_info(type = "ellps")`.
]

Ellipsoids are part of a wider component of CRSs: the *datum*.
This contains information on what ellipsoid to use and the precise relationship between the Cartesian coordinates and location on the Earth's surface.
There are two types of datum --- geocentric (such as `WGS84`) and local (such as `NAD83`).
You can see examples of these two types of datums in Figure \@ref(fig:datum-fig).
Black lines represent a *geocentric datum*, whose center is located in the Earth's center of gravity and is not optimized for a specific location.
In a *local datum*, shown as a purple dashed line, the ellipsoidal surface is shifted to align with the surface at a particular location.
These allow local variations in Earth's surface, for example due to large mountain ranges, to be accounted for in a local CRS.
This can be seen in Figure \@ref(fig:datum-fig), where the local datum is fitted to the area of Philippines, but is misaligned with most of the rest of the planet's surface. 
Both datums in Figure \@ref(fig:datum-fig) are put on top of a geoid - a model of global mean sea level.^[Please note that the geoid on the Figure exaggerates the bumpy surface of the geoid by a factor of 10,000 to highlight the irregular shape of the planet.]

(ref:datum-fig) Geocentric and local geodetic datums shown on top of a geoid (in false color and the vertical exaggeration by 10,000 scale factor). Image of the geoid is adapted from the work of @essd-11-647-2019.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/02_datum_fig} 

}

\caption[Geocentric and local geodetic datums on a geoid.]{(ref:datum-fig)}(\#fig:datum-fig)
\end{figure}

### Projected coordinate reference systems 

\index{CRS!projected}
All projected CRSs are based on a geographic CRS, described in the previous section, and rely on map projections to convert the three-dimensional surface of the Earth into Easting and Northing (x and y) values in a projected CRS.
Projected CRSs are based on Cartesian coordinates on an implicitly flat surface (right panel of Figure \@ref(fig:vector-crs)).
They have an origin, x and y axes, and a linear unit of measurement such as meters.

This transition cannot be done without adding some deformations.
Therefore, some properties of the Earth's surface are distorted in this process, such as area, direction, distance, and shape.
A projected coordinate system can preserve only one or two of those properties.
Projections are often named based on a property they preserve: equal-area preserves area, azimuthal preserve direction, equidistant preserve distance, and conformal preserve local shape.

There are three main groups of projection types - conic, cylindrical, and planar (azimuthal).
In a conic projection, the Earth's surface is projected onto a cone along a single line of tangency or two lines of tangency. 
Distortions are minimized along the tangency lines and rise with the distance from those lines in this projection.
Therefore, it is the best suited for maps of mid-latitude areas.
A cylindrical projection maps the surface onto a cylinder.
This projection could also be created by touching the Earth's surface along a single line of tangency or two lines of tangency. 
Cylindrical projections are used most often when mapping the entire world.
A planar projection projects data onto a flat surface touching the globe at a point or along a line of tangency. 
It is typically used in mapping polar regions.
`sf_proj_info(type = "proj")` gives a list of the available projections supported by the PROJ library.

A quick summary of different projections, their types, properties, and suitability can be found in @map_1993 and at https://www.geo-projections.com/.
We will expand on CRSs and explain how to project from one CRS to another in Chapter \@ref(reproj-geo-data).
For now, it is sufficient to know:

- That coordinate systems are a key component of geographic objects
- Knowing which CRS your data is in, and whether it is in geographic (lon/lat) or projected (typically meters), is important and has consequences for how R handles spatial and geometry operations
- CRSs of `sf` objects can be queried with the function `st_crs()`, CRSs of `terra` objects can be queried with the function `crs()`

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/02_vector_crs} 

}

\caption[Examples of geographic and projected CRSs (vector data).]{Examples of geographic (WGS 84; left) and projected (NAD83 / UTM zone 12N; right) coordinate systems for a vector data type.}(\#fig:vector-crs)
\end{figure}

## Units
<!--rl-->

<!-- https://cran.r-project.org/web/packages/units/vignettes/measurement_units_in_R.html -->
An important feature of CRSs is that they contain information about spatial units.
Clearly, it is vital to know whether a house's measurements are in feet or meters, and the same applies to maps.
It is good cartographic practice to add a *scale bar* or some other distance indicator onto maps to demonstrate the relationship between distances on the page or screen and distances on the ground.
Likewise, it is important to formally specify the units in which the geometry data or cells are measured to provide context, and ensure that subsequent calculations are done in context.

A novel feature of geometry data in `sf` objects is that they have *native support* for units.
This means that distance, area and other geometric calculations in **sf** return values that come with a `units` attribute, defined by the **units** package [@pebesma_measurement_2016].
This is advantageous, preventing confusion caused by different units (most CRSs use meters, some use feet) and providing information on dimensionality.
This is demonstrated in the code chunk below, which calculates the area of Luxembourg:
\index{units}
\index{sf!units}


```r
luxembourg = world[world$name_long == "Luxembourg", ]
```


```r
st_area(luxembourg) # requires the s2 package in recent versions of sf
#> 2.41e+09 [m^2]
```

The output is in units of square meters (m^2^), showing that the result represents two-dimensional space.
This information, stored as an attribute (which interested readers can discover with `attributes(st_area(luxembourg))`), can feed into subsequent calculations that use units, such as population density (which is measured in people per unit area, typically per km^2^).
Reporting units prevents confusion.
To take the Luxembourg example, if the units remained unspecified, one could incorrectly assume that the units were in hectares.
To translate the huge number into a more digestible size, it is tempting to divide the results by a million (the number of square meters in a square kilometer):


```r
st_area(luxembourg) / 1000000
#> 2409 [m^2]
```

However, the result is incorrectly given again as square meters.
The solution is to set the correct units with the **units** package:


```r
units::set_units(st_area(luxembourg), km^2)
#> 2409 [km^2]
```

Units are of equal importance in the case of raster data.
However, so far **sf** is the only spatial package that supports units, meaning that people working on raster data should approach changes in the units of analysis (for example, converting pixel widths from imperial to decimal units) with care.
The `my_rast` object (see above) uses a WGS84 projection with decimal degrees as units.
Consequently, its resolution is also given in decimal degrees but you have to know it, since the `res()` function simply returns a numeric vector.


```r
res(my_rast)
#> [1] 0.000833 0.000833
```

If we used the UTM projection, the units would change.


```r
repr = project(my_rast, "EPSG:26912")
res(repr)
#> [1] 83.5 83.5
```

Again, the `res()` command gives back a numeric vector without any unit, forcing us to know that the unit of the UTM projection is meters.

## Exercises {#ex2}


E1. Use `summary()` on the geometry column of the `world` data object that is included in the **spData** package. What does the output tell us about:

- Its geometry type?
- The number of countries?
- Its coordinate reference system (CRS)?
    


E2. Run the code that 'generated' the map of the world in Section 2.2.3 (Basic map making).
Find two similarities and two differences between the image on your computer and that in the book.

- What does the `cex` argument do (see `?plot`)?
- Why was `cex` set to the `sqrt(world$pop) / 10000`?
- Bonus: experiment with different ways to visualize the global population.



E3. Use `plot()` to create maps of Nigeria in context (see Section 2.2.3).

- Adjust the `lwd`, `col` and `expandBB` arguments of `plot()`. 
- Challenge: read the documentation of `text()` and annotate the map.



E4. Create an empty `SpatRaster` object called `my_raster` with 10 columns and 10 rows.
Assign random values between 0 and 10 to the new raster and plot it.



E5. Read-in the `raster/nlcd.tif` file from the **spDataLarge** package. 
What kind of information can you get about the properties of this file?



E6. Check the CRS of the `raster/nlcd.tif` file from the **spDataLarge** package. 
What kind of information you can learn from it?

<!--chapter:end:02-spatial-data.Rmd-->

# Attribute data operations {#attr}

## Prerequisites {-}

- This chapter requires the following packages to be installed and attached:


```r
library(sf)      # vector data package introduced in Chapter 2
library(terra)   # raster data package introduced in Chapter 2
library(dplyr)   # tidyverse package for data frame manipulation
```

- It relies on **spData**, which loads datasets used in the code examples of this chapter:


```r
library(spData)  # spatial data package introduced in Chapter 2
```

- Also ensure you have installed the **tidyr** package, or the **tidyverse** of which it is a part, if you want to run data 'tidying' operations in Section \@ref(vec-attr-creation).

## Introduction

Attribute data is non-spatial information associated with geographic (geometry) data.
A bus stop provides a simple example: its position would typically be represented by latitude and longitude coordinates (geometry data), in addition to its name.
The [Elephant & Castle / New Kent Road](https://www.openstreetmap.org/relation/6610626) stop in London, for example has coordinates of -0.098 degrees longitude and 51.495 degrees latitude which can be represented as `POINT (-0.098 51.495)` in the `sfc` representation described in Chapter \@ref(spatial-class).
Attributes such as the name *attribute*\index{attribute} of the POINT feature (to use Simple Features terminology) are the topic of this chapter.



Another example is the elevation value (attribute) for a specific grid cell in raster data.
Unlike the vector data model, the raster data model stores the coordinate of the grid cell indirectly, meaning the distinction between attribute and spatial information is less clear.
To illustrate the point, think of a pixel in the 3^rd^ row and the 4^th^ column of a raster matrix.
Its spatial location is defined by its index in the matrix: move from the origin four cells in the x direction (typically east and right on maps) and three cells in the y direction (typically south and down).
The raster's *resolution* defines the distance for each x- and y-step which is specified in a *header*.
The header is a vital component of raster datasets which specifies how pixels relate to geographic coordinates (see also Chapter \@ref(spatial-operations)).

This teaches how to manipulate geographic objects based on attributes such as the names of bus stops in a vector dataset and elevations of pixels in a raster dataset.
For vector data, this means techniques such as subsetting and aggregation (see Sections \@ref(vector-attribute-subsetting) and \@ref(vector-attribute-aggregation)).
Sections \@ref(vector-attribute-joining) and \@ref(vec-attr-creation) demonstrate how to join data onto simple feature objects using a shared ID and how to create new variables, respectively.
Each of these operations has a spatial equivalent:
the `[` operator in base R, for example, works equally for subsetting objects based on their attribute and spatial objects; you can also join attributes in two geographic datasets using spatial joins.
This is good news: skills developed in this chapter are cross-transferable.
Chapter \@ref(spatial-operations) extends the methods presented here to the spatial world.

After a deep dive into various types of *vector* attribute operations in the next section, *raster* attribute data operations are covered in Section \@ref(manipulating-raster-objects), which demonstrates how to create raster layers containing continuous and categorical attributes and extracting cell values from one or more layer (raster subsetting). 
Section \@ref(summarizing-raster-objects) provides an overview of 'global' raster operations which can be used to summarize entire raster datasets.

## Vector attribute manipulation

Geographic vector datasets are well supported in R thanks to the `sf` class, which extends base R's `data.frame`.
Like data frames, `sf` objects have one column per attribute variable (such as 'name') and one row per observation or *feature* (e.g., per bus station).
`sf` objects differ from basic data frames because they have a `geometry` column of class `sfc` which can contain a range of geographic entities (single and 'multi' point, line, and polygon features) per row.
This was described in Chapter \@ref(spatial-class), which demonstrated how *generic methods* such as `plot()` and `summary()` work with `sf` objects.
**sf** also provides generics that allow `sf` objects to behave like regular data frames, as shown by printing the class's methods:


```r
methods(class = "sf") # methods for sf objects, first 12 shown
```


```r
#>  [1] aggregate             cbind                 coerce               
#>  [4] initialize            merge                 plot                 
#>  [7] print                 rbind                 [                    
#> [10] [[<-                  $<-                   show                 
```



Many of these (`aggregate()`, `cbind()`, `merge()`, `rbind()` and `[`) are for manipulating data frames.
`rbind()`, for example, is binds rows two data frames together, one 'on top' of the other.
`$<-` creates new columns. 
A key feature of `sf` objects is that they store spatial and non-spatial data in the same way, as columns in a `data.frame`.

\BeginKnitrBlock{rmdnote}
The geometry column of `sf` objects is typically called `geometry` or `geom` but any name can be used.
The following command, for example, creates a geometry column named g:
  
`st_sf(data.frame(n = world$name_long), g = world$geom)`

This enables geometries imported from spatial databases to have a variety of names such as `wkb_geometry` and `the_geom`.
\EndKnitrBlock{rmdnote}

`sf` objects can also extend the `tidyverse` classes for data frames, `tibble` and `tbl`.
\index{tidyverse (package)}.
Thus **sf** enables the full power of R's data analysis capabilities to be unleashed on geographic data, whether you use base R or tidyverse functions for data analysis.
\index{tibble}
**sf** objects can also be used with the high-performance data processing package **data.table** although, as documented in the issue [`Rdatatable/data.table#2273`](https://github.com/Rdatatable/data.table/issues/2273), is not fully [compatible](https://github.com/Rdatatable/data.table/issues/5352) with `sf` objects.
Before using these capabilities it is worth re-capping how to discover the basic properties of vector data objects.
Let's start by using base R functions to learn about the `world` dataset from the **spData** package:


```r
class(world) # it's an sf object and a (tidy) data frame
#> [1] "sf"         "tbl_df"     "tbl"        "data.frame"
dim(world)   # it is a 2 dimensional object, with 177 rows and 11 columns
#> [1] 177  11
```

`world` contains ten non-geographic columns (and one geometry list column) with almost 200 rows representing the world's countries.
The function `st_drop_geometry()` keeps only the attributes data of an `sf` object, in other words removing its geometry:


```r
world_df = st_drop_geometry(world)
class(world_df)
#> [1] "tbl_df"     "tbl"        "data.frame"
ncol(world_df)
#> [1] 10
```

Dropping the geometry column before working with attribute data can be useful; data manipulation processes can run faster when they work only on the attribute data and geometry columns are not always needed.
For most cases, however, it makes sense to keep the geometry column, explaining why the column is 'sticky' (it remains after most attribute operations unless specifically dropped).
Non-spatial data operations on `sf` objects only change an object's geometry when appropriate (e.g., by dissolving borders between adjacent polygons following aggregation).
Becoming skilled at geographic attribute data manipulation means becoming skilled at manipulating data frames.

For many applications, the tidyverse\index{tidyverse (package)} package **dplyr** offers an effective approach for working with data frames.
Tidyverse compatibility is an advantage of **sf** over its predecessor **sp**, but there are some pitfalls to avoid (see the supplementary `tidyverse-pitfalls` vignette at [geocompr.github.io](https://geocompr.github.io/geocompkg/articles/tidyverse-pitfalls.html) for details).

### Vector attribute subsetting

Base R subsetting methods include the operator `[` and the function `subset()`.
The key **dplyr** subsetting functions are  `filter()` and `slice()` for subsetting rows, and `select()` for subsetting columns.
Both approaches preserve the spatial components of attribute data in `sf` objects, while using the operator `$` or the **dplyr** function `pull()` to return a single attribute column as a vector will lose the geometry data, as we will see.
\index{attribute!subsetting}
This section focuses on subsetting `sf` data frames; for further details on subsetting vectors and non-geographic data frames we recommend reading section section [2.7](https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Index-vectors) of An Introduction to R [@rcoreteam_introduction_2021] and Chapter [4](https://adv-r.hadley.nz/subsetting.html) of Advanced R Programming [@wickham_advanced_2019], respectively.

The `[` operator can subset both rows and columns. 
Indices placed inside square brackets placed directly after a data frame object name specify the elements to keep.
The command `object[i, j]` means 'return the rows represented by `i` and the columns represented by `j`, where `i` and `j` typically contain integers or `TRUE`s and `FALSE`s (indices can also be character strings, indicating row or column names).
`object[5, 1:3]`, for example, means 'return data containing the 5th row and columns 1 to 3: the result should be a data frame with only 1 row and 3 columns, and a fourth geometry column if it's an `sf` object.
Leaving `i` or `j` empty returns all rows or columns, so `world[1:5, ]` returns the first five rows and all 11 columns.
The examples below demonstrate subsetting with base R.
Guess the number of rows and columns in the `sf` data frames returned by each command and check the results on your own computer (see the end of the chapter for more exercises):


```r
world[1:6, ]    # subset rows by position
world[, 1:3]    # subset columns by position
world[1:6, 1:3] # subset rows and columns by position
world[, c("name_long", "pop")] # columns by name
world[, c(T, T, F, F, F, F, F, T, T, F, F)] # by logical indices
world[, 888] # an index representing a non-existent column
```



A demonstration of the utility of using `logical` vectors for subsetting is shown in the code chunk below.
This creates a new object, `small_countries`, containing nations whose surface area is smaller than 10,000 km^2^:


```r
i_small = world$area_km2 < 10000
summary(i_small) # a logical vector
#>    Mode   FALSE    TRUE 
#> logical     170       7
small_countries = world[i_small, ]
```

The intermediary `i_small` (short for index representing small countries) is a logical vector that can be used to subset the seven smallest countries in the `world` by surface area.
A more concise command, which omits the intermediary object, generates the same result:


```r
small_countries = world[world$area_km2 < 10000, ]
```

The base R function `subset()` provides another way to achieve the same result:


```r
small_countries = subset(world, area_km2 < 10000)
```

Base R functions are mature, stable and widely used, making them a rock solid choice, especially in contexts where reproducibility and reliability are key.
**dplyr** functions enable 'tidy' workflows which some people (the authors of this book included) find intuitive and productive for interactive data analysis, especially when combined with code editors such as RStudio that enable [auto-completion](https://support.rstudio.com/hc/en-us/articles/205273297-Code-Completion-in-the-RStudio-IDE) of column names.
Key functions for subsetting data frames (including `sf` data frames) with **dplyr** functions are demonstrated below.
<!-- The sentence below seems to be untrue based on the benchmark below. -->
<!-- `dplyr` is also faster than base R for some operations, due to its C++\index{C++} backend. -->
<!-- Something on dbplyr? I've never seen anyone use it regularly for spatial data 'in the wild' so leaving out the bit on integration with dbs for now (RL 2021-10) -->
<!-- The main **dplyr** subsetting functions are `select()`, `slice()`, `filter()` and `pull()`. -->



`select()` selects columns by name or position.
For example, you could select only two columns, `name_long` and `pop`, with the following command:


```r
world1 = dplyr::select(world, name_long, pop)
names(world1)
#> [1] "name_long" "pop"       "geom"
```

Note: as with the equivalent command in base R (`world[, c("name_long", "pop")]`), the sticky `geom` column remains.
`select()` also allows selecting a range of columns with the help of the `:` operator: 


```r
# all columns between name_long and pop (inclusive)
world2 = dplyr::select(world, name_long:pop)
```

You can remove specific columns with the `-` operator:


```r
# all columns except subregion and area_km2 (inclusive)
world3 = dplyr::select(world, -subregion, -area_km2)
```

Subset and rename columns at the same time with the `new_name = old_name` syntax:


```r
world4 = dplyr::select(world, name_long, population = pop)
```

It is worth noting that the command above is more concise than base R equivalent, which requires two lines of code:


```r
world5 = world[, c("name_long", "pop")] # subset columns by name
names(world5)[names(world5) == "pop"] = "population" # rename column manually
```

`select()` also works with 'helper functions' for more advanced subsetting operations, including `contains()`, `starts_with()` and `num_range()` (see the help page with `?select` for details).

Most **dplyr** verbs return a data frame, but you can extract a single column as a vector with `pull()`.
<!-- Note: I have commented out the statement below because it is not true for `sf` objects, it's a bit confusing that the behaviour differs between data frames and `sf` objects. -->
<!-- The subsetting operator in base R (see `?[`), by contrast, tries to return objects in the lowest possible dimension. -->
<!-- This means selecting a single column returns a vector in base R as demonstrated in code chunk below which returns a numeric vector representing the population of countries in the `world`: -->
You can get the same result in base R with the list subsetting operators `$` and `[[`, the three following commands return the same numeric vector:


```r
pull(world, pop)
world$pop
world[["pop"]]
```

<!-- Commenting out the following because it's confusing and covered better in other places (RL, 2021-10) -->
<!-- To turn off this behavior, set the `drop` argument to `FALSE`,  -->





`slice()` is the row-equivalent of `select()`.
The following code chunk, for example, selects rows 1 to 6:


```r
slice(world, 1:6)
```

`filter()` is **dplyr**'s equivalent of base R's `subset()` function.
It keeps only rows matching given criteria, e.g., only countries with and area below a certain threshold, or with a high average of life expectancy, as shown in the following examples:


```r
world7 = filter(world ,area_km2 < 10000) # countries with a small area
world7 = filter(world, lifeExp > 82)      # with high life expectancy
```

The standard set of comparison operators can be used in the `filter()` function, as illustrated in Table \@ref(tab:operators): 



\begin{table}

\caption[Comparison operators that return Booleans.]{(\#tab:operators)Comparison operators that return Booleans (TRUE/FALSE).}
\centering
\begin{tabular}[t]{ll}
\toprule
Symbol & Name\\
\midrule
== & Equal to\\
!= & Not equal to\\
>, < & Greater/Less than\\
>=, <= & Greater/Less than or equal\\
\&, |, ! & Logical operators: And, Or, Not\\
\bottomrule
\end{tabular}
\end{table}

### Chaining commands with pipes

Key to workflows using **dplyr** functions is the ['pipe'](http://r4ds.had.co.nz/pipes.html) operator `%>%` (or since R `4.1.0` the native pipe `|>`), which takes its name from the Unix pipe `|` [@grolemund_r_2016].
Pipes enable expressive code: the output of a previous function becomes the first argument of the next function, enabling *chaining*.
This is illustrated below, in which only countries from Asia are filtered from the `world` dataset, next the object is subset by columns (`name_long` and `continent`) and the first five rows (result not shown).


```r
world7 = world |>
  filter(continent == "Asia") |>
  dplyr::select(name_long, continent) |>
  slice(1:5)
```

The above chunk shows how the pipe operator allows commands to be written in a clear order:
the above run from top to bottom (line-by-line) and left to right.
An alternative to piped operations is nested function calls, which are harder to read:


```r
world8 = slice(
  dplyr::select(
    filter(world, continent == "Asia"),
    name_long, continent),
  1:5)
```

Another alternative is to split the operations into multiple self-contained lines, which is recommended when developing new R packages, an approach which has the advantage of saving intermediate results with distinct names which can be later inspected for debugging purposes (an approach which has disadvantages of being verbose and cluttering the global environment when undertaking interactive analysis):


```r
world9_filtered = filter(world, continent == "Asia")
world9_selected = dplyr::select(world9_filtered, continent)
world9 = slice(world9_selected, 1:5)
```

Each approach has advantages and disadvantages, the importance of which depend on your programming style and applications.
For interactive data analysis, the focus of this chapter, we find piped operations fast and intuitive, especially when combined with [RStudio](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts-in-the-RStudio-IDE)/[VSCode](https://github.com/REditorSupport/vscode-R/wiki/Keyboard-shortcuts) shortcuts for creating pipes and [auto-completing](https://support.rstudio.com/hc/en-us/articles/205273297-Code-Completion-in-the-RStudio-IDE) variable names.

### Vector attribute aggregation

\index{attribute!aggregation}
\index{aggregation}
Aggregation involves summarizing data with one or more 'grouping variables', typically from columns in the data frame to be aggregated (geographic aggregation is covered in the next chapter).
An example of attribute aggregation is calculating the number of people per continent based on country-level data (one row per country).
The `world` dataset contains the necessary ingredients: the columns `pop` and `continent`, the population and the grouping variable, respectively.
The aim is to find the `sum()` of country populations for each continent, resulting in a smaller data frame (aggregation is a form of data reduction and can be a useful early step when working with large datasets).
This can be done with the base R function `aggregate()` as follows:


```r
world_agg1 = aggregate(pop ~ continent, FUN = sum, data = world,
                       na.rm = TRUE)
class(world_agg1)
#> [1] "data.frame"
```

The result is a non-spatial data frame with six rows, one per continent, and two columns reporting the name and population of each continent (see Table \@ref(tab:continents) with results for the top 3 most populous continents).

`aggregate()` is a [generic function](https://adv-r.hadley.nz/s3.html#s3-methods) which means that it behaves differently depending on its inputs. 
**sf** provides the method `aggregate.sf()` which is activated automatically when `x` is an `sf` object and a `by` argument is provided:


```r
world_agg2 = aggregate(world["pop"], list(world$continent), FUN = sum, 
                       na.rm = TRUE)
class(world_agg2)
#> [1] "sf"         "data.frame"
nrow(world_agg2)
#> [1] 8
```

The resulting `world_agg2` object is a spatial object containing 8 features representing the continents of the world (and the open ocean).
`group_by() |> summarize()` is the **dplyr** equivalent of `aggregate()`, with the variable name provided in the `group_by()` function specifying the grouping variable and information on what is to be summarized passed to the `summarize()` function, as shown below:


```r
world_agg3 = world |>
  group_by(continent) |>
  summarize(pop = sum(pop, na.rm = TRUE))
```

The approach may seem more complex but it has benefits: flexibility, readability, and control over the new column names.
This flexibility is illustrated in the command below, which calculates not only the population but also the area and number of countries in each continent:


```r
world_agg4  = world |> 
  group_by(continent) |> 
  summarize(pop = sum(pop, na.rm = TRUE), `area_sqkm` = sum(area_km2), n = n())
```

In the previous code chunk `pop`, `area_sqkm` and `n` are column names in the result, and `sum()` and `n()` were the aggregating functions.
These aggregating functions return `sf` objects with rows representing continents and geometries containing the multiple polygons representing each land mass and associated islands (this works thanks to the geometric operation 'union', as explained in Section \@ref(geometry-unions)).

Let's combine what we have learned so far about **dplyr** functions, by chaining multiple commands to summarize attribute data about countries worldwide by continent.
The following command calculates population density (with `mutate()`), arranges continents by the number countries they contain (with `dplyr::arrange()`), and keeps only the 3 most populous continents (with `dplyr::slice_max()`), the result of which is presented in Table \@ref(tab:continents)):


```r
world_agg5 = world |> 
  st_drop_geometry() |>                      # drop the geometry for speed
  dplyr::select(pop, continent, area_km2) |> # subset the columns of interest  
  group_by(continent) |>                     # group by continent and summarize:
  summarize(Pop = sum(pop, na.rm = TRUE), Area = sum(area_km2), N = n()) |>
  mutate(Density = round(Pop / Area)) |>     # calculate population density
  slice_max(Pop, n = 3) |>                   # keep only the top 3
  arrange(desc(N))                           # arrange in order of n. countries
```

\begin{table}

\caption[Top 3 most populous continents.]{(\#tab:continents)The top 3 most populous continents ordered by number of countries.}
\centering
\begin{tabular}[t]{lrrrr}
\toprule
continent & Pop & Area & N & Density\\
\midrule
Africa & 1154946633 & 29946198 & 51 & 39\\
Asia & 4311408059 & 31252459 & 47 & 138\\
Europe & 669036256 & 23065219 & 39 & 29\\
\bottomrule
\end{tabular}
\end{table}

\BeginKnitrBlock{rmdnote}
More details are provided in the help pages (which can be accessed via `?summarize` and `vignette(package = "dplyr")` and Chapter 5 of [R for Data Science](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarize). 
\EndKnitrBlock{rmdnote}

###  Vector attribute joining

Combining data from different sources is a common task in data preparation. 
Joins do this by combining tables based on a shared 'key' variable.
**dplyr** has multiple join functions including `left_join()` and `inner_join()` --- see `vignette("two-table")` for a full list.
These function names follow conventions used in the database language [SQL](http://r4ds.had.co.nz/relational-data.html) [@grolemund_r_2016, Chapter 13]; using them to join non-spatial datasets to `sf` objects is the focus of this section.
**dplyr** join functions work the same on data frames and `sf` objects, the only important difference being the `geometry` list column.
The result of data joins can be either an `sf` or `data.frame` object.
The most common type of attribute join on spatial data takes an `sf` object as the first argument and adds columns to it from a `data.frame` specified as the second argument.
\index{join}
\index{attribute!join}

To demonstrate joins, we will combine data on coffee production with the `world` dataset.
The coffee data is in a data frame called `coffee_data` from the **spData** package (see `?coffee_data` for details).
It has 3 columns:
`name_long` names major coffee-producing nations and `coffee_production_2016` and `coffee_production_2017` contain estimated values for coffee production in units of 60-kg bags in each year.
A 'left join', which preserves the first dataset, merges `world` with `coffee_data`:


```r
world_coffee = left_join(world, coffee_data)
#> Joining, by = "name_long"
class(world_coffee)
#> [1] "sf"         "tbl_df"     "tbl"        "data.frame"
```

Because the input datasets share a 'key variable' (`name_long`) the join worked without using the `by` argument (see `?left_join` for details).
The result is an `sf` object identical to the original `world` object but with two new variables (with column indices 11 and 12) on coffee production.
This can be plotted as a map, as illustrated in Figure \@ref(fig:coffeemap), generated with the `plot()` function below:


```r
names(world_coffee)
#>  [1] "iso_a2"                 "name_long"              "continent"             
#>  [4] "region_un"              "subregion"              "type"                  
#>  [7] "area_km2"               "pop"                    "lifeExp"               
#> [10] "gdpPercap"              "geom"                   "coffee_production_2016"
#> [13] "coffee_production_2017"
plot(world_coffee["coffee_production_2017"])
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{03-attribute-operations_files/figure-latex/coffeemap-1} 

}

\caption[World coffee production by country.]{World coffee production (thousand 60-kg bags) by country, 2017. Source: International Coffee Organization.}(\#fig:coffeemap)
\end{figure}

For joining to work, a 'key variable' must be supplied in both datasets.
By default **dplyr** uses all variables with matching names.
In this case, both `world_coffee` and `world` objects contained a variable called `name_long`, explaining the message `Joining, by = "name_long"`.
In the majority of cases where variable names are not the same, you have two options:

1. Rename the key variable in one of the objects so they match.
2. Use the `by` argument to specify the joining variables.

The latter approach is demonstrated below on a renamed version of `coffee_data`:


```r
coffee_renamed = rename(coffee_data, nm = name_long)
world_coffee2 = left_join(world, coffee_renamed, by = c(name_long = "nm"))
```



Note that the name in the original object is kept, meaning that `world_coffee` and the new object `world_coffee2` are identical.
Another feature of the result is that it has the same number of rows as the original dataset.
Although there are only 47 rows of data in `coffee_data`, all 177 country records are kept intact in `world_coffee` and `world_coffee2`:
rows in the original dataset with no match are assigned `NA` values for the new coffee production variables.
What if we only want to keep countries that have a match in the key variable?
In that case an inner join can be used:


```r
world_coffee_inner = inner_join(world, coffee_data)
#> Joining, by = "name_long"
nrow(world_coffee_inner)
#> [1] 45
```

Note that the result of `inner_join()` has only 45 rows compared with 47 in `coffee_data`.
What happened to the remaining rows?
We can identify the rows that did not match using the `setdiff()` function as follows:


```r
setdiff(coffee_data$name_long, world$name_long)
#> [1] "Congo, Dem. Rep. of" "Others"
```

The result shows that `Others` accounts for one row not present in the `world` dataset and that the name of the `Democratic Republic of the Congo` accounts for the other:
it has been abbreviated, causing the join to miss it.
The following command uses a string matching (regex) function from the **stringr** package to confirm what `Congo, Dem. Rep. of` should be:


```r
(drc = stringr::str_subset(world$name_long, "Dem*.+Congo"))
#> [1] "Democratic Republic of the Congo"
```





To fix this issue, we will create a new version of `coffee_data` and update the name.
`inner_join()`ing the updated data frame returns a result with all 46 coffee-producing nations:


```r
coffee_data$name_long[grepl("Congo,", coffee_data$name_long)] = drc
world_coffee_match = inner_join(world, coffee_data)
#> Joining, by = "name_long"
nrow(world_coffee_match)
#> [1] 46
```

It is also possible to join in the other direction: starting with a non-spatial dataset and adding variables from a simple features object.
This is demonstrated below, which starts with the `coffee_data` object and adds variables from the original `world` dataset.
In contrast with the previous joins, the result is *not* another simple feature object, but a data frame in the form of a **tidyverse** tibble:
the output of a join tends to match its first argument:


```r
coffee_world = left_join(coffee_data, world)
#> Joining, by = "name_long"
class(coffee_world)
#> [1] "tbl_df"     "tbl"        "data.frame"
```

\BeginKnitrBlock{rmdnote}
In most cases, the geometry column is only useful in an `sf` object.
The geometry column can only be used for creating maps and spatial operations if R 'knows' it is a spatial object, defined by a spatial package such as **sf**.
Fortunately, non-spatial data frames with a geometry list column (like `coffee_world`) can be coerced into an `sf` object as follows: `st_as_sf(coffee_world)`. 
\EndKnitrBlock{rmdnote}

This section covers the majority of joining use cases.
For more information, we recommend reading the chapter [Relational data](https://r4ds.had.co.nz/relational-data.html?q=join#relational-data) in @grolemund_r_2016, the [join vignette](https://geocompr.github.io/geocompkg/articles/join.html) in the **geocompkg** package that accompanies this book, and [documentation](https://asardaes.github.io/table.express/articles/joins.html) describing joins with **data.table** and other packages.
Spatial joins are covered in the next chapter (Section \@ref(spatial-joining)).

### Creating attributes and removing spatial information {#vec-attr-creation}

Often, we would like to create a new column based on already existing columns.
For example, we want to calculate population density for each country.
For this we need to divide a population column, here `pop`, by an area column, here `area_km2` with unit area in square kilometers.
Using base R, we can type:


```r
world_new = world # do not overwrite our original data
world_new$pop_dens = world_new$pop / world_new$area_km2
```

Alternatively, we can use one of **dplyr** functions - `mutate()` or `transmute()`.
`mutate()` adds new columns at the penultimate position in the `sf` object (the last one is reserved for the geometry):


```r
world |> 
  mutate(pop_dens = pop / area_km2)
```

The difference between `mutate()` and `transmute()` is that the latter drops all other existing columns (except for the sticky geometry column):


```r
world |> 
  transmute(pop_dens = pop / area_km2)
```

`unite()` from the **tidyr** package (which provides many useful functions for reshaping datasets, including `pivot_longer()`) pastes together existing columns.
For example, we want to combine the `continent` and `region_un` columns into a new column named `con_reg`.
Additionally, we can define a separator (here: a colon `:`) which defines how the values of the input columns should be joined, and if the original columns should be removed (here: `TRUE`):


```r
world_unite = world |>
  tidyr::unite("con_reg", continent:region_un, sep = ":", remove = TRUE)
```

The resulting `sf` object has a new column called `con_reg` representing the continent and region of each country, e.g. `South America:Americas` for Argentina and other South America countries.
**tidyr**'s `separate()` function does the opposite of `unite()`: it splits one column into multiple columns using either a regular expression or character positions.


```r
world_separate = world_unite |>
  tidyr::separate(con_reg, c("continent", "region_un"), sep = ":")
```



The **dplyr** function `rename()` and the base R function `setNames()` are useful for renaming columns.
The first replaces an old name with a new one.
The following command, for example, renames the lengthy `name_long` column to simply `name`:


```r
world |> 
  rename(name = name_long)
```

`setNames()` changes all column names at once, and requires a character vector with a name matching each column.
This is illustrated below, which outputs the same `world` object, but with very short names: 




```r
new_names = c("i", "n", "c", "r", "s", "t", "a", "p", "l", "gP", "geom")
world_new_names = world |>
  setNames(new_names)
```

Each of these attribute data operations preserve the geometry of the simple features.
Sometimes it makes sense to remove the geometry, for example to speed-up aggregation.
Do this with `st_drop_geometry()`, **not** manually with commands such as `select(world, -geom)`, as shown below.^[
`st_geometry(world_st) = NULL` also works to remove the geometry from `world`, but overwrites the original object.
]


```r
world_data = world |> st_drop_geometry()
class(world_data)
#> [1] "tbl_df"     "tbl"        "data.frame"
```

## Manipulating raster objects
<!--jn-->

In contrast to the vector data model underlying simple features (which represents points, lines and polygons as discrete entities in space), raster data represent continuous surfaces.
This section shows how raster objects work by creating them *from scratch*, building on Section \@ref(an-introduction-to-terra).
Because of their unique structure, subsetting and other operations on raster datasets work in a different way, as demonstrated in Section \@ref(raster-subsetting).
\index{raster!manipulation}

The following code recreates the raster dataset used in Section \@ref(raster-classes), the result of which is illustrated in Figure \@ref(fig:cont-raster).
This demonstrates how the `rast()` function works to create an example raster named `elev` (representing elevations).


```r
elev = rast(nrows = 6, ncols = 6, resolution = 0.5, 
            xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
            vals = 1:36)
```

The result is a raster object with 6 rows and 6 columns (specified by the `nrow` and `ncol` arguments), and a minimum and maximum spatial extent in x and y direction (`xmin`, `xmax`, `ymin`, `ymax`).
The `vals` argument sets the values that each cell contains: numeric data ranging from 1 to 36 in this case.
Raster objects can also contain categorical values of class `logical` or `factor` variables in R.
The following code creates the raster datasets shown in Figure \@ref(fig:cont-raster):


```r
grain_order = c("clay", "silt", "sand")
grain_char = sample(grain_order, 36, replace = TRUE)
grain_fact = factor(grain_char, levels = grain_order)
grain = rast(nrows = 6, ncols = 6, resolution = 0.5, 
             xmin = -1.5, xmax = 1.5, ymin = -1.5, ymax = 1.5,
             vals = grain_fact)
```



The raster object stores the corresponding look-up table or "Raster Attribute Table" (RAT) as a list of data frames, which can be viewed with `cats(grain)` (see `?cats()` for more information).
Each element of this list is a layer of the raster.
It is also possible to use the function `levels()` for retrieving and adding new or replacing existing factor levels:


```r
levels(grain) = data.frame(value = c(0, 1, 2), wetness = c("wet", "moist", "dry"))
levels(grain)
#> [[1]]
#>   value wetness
#> 1     0     wet
#> 2     1   moist
#> 3     2     dry
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{03-attribute-operations_files/figure-latex/cont-raster-1} 

}

\caption[Raster datasets with numeric and categorical values.]{Raster datasets with numeric (left) and categorical values (right).}(\#fig:cont-raster)
\end{figure}

\BeginKnitrBlock{rmdnote}
Categorical raster objects can also store information about the colors associated with each value using a color table.
The color table is a data frame with three (red, green, blue) or four (alpha) columns, where each row relates to one value.
Color tables in **terra** can be viewed or set with the `coltab()` function (see `?coltab`).
Importantly, saving a raster object with a color table to a file (e.g., GeoTIFF) will also save the color information.
\EndKnitrBlock{rmdnote}

### Raster subsetting

Raster subsetting is done with the base R operator `[`, which accepts a variety of inputs:
\index{raster!subsetting}

- Row-column indexing
- Cell IDs
- Coordinates (see Section \@ref(spatial-raster-subsetting))
- Another spatial object (see Section \@ref(spatial-raster-subsetting))

Here, we only show the first two options since these can be considered non-spatial operations.
If we need a spatial object to subset another or the output is a spatial object, we refer to this as spatial subsetting.
Therefore, the latter two options will be shown in the next chapter (see Section \@ref(spatial-raster-subsetting)).

The first two subsetting options are demonstrated in the commands below ---
both return the value of the top left pixel in the raster object `elev` (results not shown):


```r
# row 1, column 1
elev[1, 1]
# cell ID 1
elev[1]
```

Subsetting of multi-layered raster objects will return the cell value(s) for each layer.
For example, `two_layers = c(grain, elev); two_layers[1]` returns a data frame with one row and two columns --- one for each layer.
To extract all values or complete rows, you can also use `values()`.

Cell values can be modified by overwriting existing values in conjunction with a subsetting operation.
The following code chunk, for example, sets the upper left cell of `elev` to 0 (results not shown):


```r
elev[1, 1] = 0
elev[]
```

Leaving the square brackets empty is a shortcut version of `values()` for retrieving all values of a raster.
Multiple cells can also be modified in this way:


```r
elev[1, c(1, 2)] = 0
```

Replacing values of multilayered rasters can be done with a matrix with as many columns as layers and rows as replaceable cells (results not shown):


```r
two_layers = c(grain, elev) 
two_layers[1] = cbind(c(1), c(4))
two_layers[]
```

### Summarizing raster objects

**terra** contains functions for extracting descriptive statistics\index{statistics} for entire rasters.
Printing a raster object to the console by typing its name returns minimum and maximum values of a raster.
`summary()` provides common descriptive statistics\index{statistics} -- minimum, maximum, quartiles and number of `NA`s for continuous rasters and a number of cells of each class for categorical rasters.
Further summary operations such as the standard deviation (see below) or custom summary statistics can be calculated with `global()`. 
\index{raster!summarizing}


```r
global(elev, sd)
```

\BeginKnitrBlock{rmdnote}
If you provide the `summary()` and `global()` functions with a multi-layered raster object, they will summarize each layer separately, as can be illustrated by running: `summary(c(elev, grain))`.
\EndKnitrBlock{rmdnote}

Additionally, the `freq()` function allows to get the frequency table of categorical values.

Raster value statistics can be visualized in a variety of ways.
Specific functions such as `boxplot()`, `density()`, `hist()` and `pairs()` work also with raster objects, as demonstrated in the histogram created with the command below (not shown):


```r
hist(elev)
```

In case the desired visualization function does not work with raster objects, one can extract the raster data to be plotted with the help of `values()` (Section \@ref(raster-subsetting)).
\index{raster!values}

Descriptive raster statistics belong to the so-called global raster operations.
These and other typical raster processing operations are part of the map algebra scheme, which are covered in the next chapter (Section \@ref(map-algebra)).

\begin{rmdnote}
Some function names clash between packages (e.g., a function with the
name \texttt{extract()} exist in both \textbf{terra} and \textbf{tidyr}
packages). In addition to not loading packages by referring to functions
verbosely (e.g., \texttt{tidyr::extract()}), another way to prevent
function names clashes is by unloading the offending package with
\texttt{detach()}. The following command, for example, unloads the
\textbf{terra} package (this can also be done in the \emph{package} tab
which resides by default in the right-bottom pane in RStudio):
\texttt{detach("package:terra",\ unload\ =\ TRUE,\ force\ =\ TRUE)}. The
\texttt{force} argument makes sure that the package will be detached
even if other packages depend on it. This, however, may lead to a
restricted usability of packages depending on the detached package, and
is therefore not recommended.
\end{rmdnote}

## Exercises


For these exercises we will use the `us_states` and `us_states_df` datasets from the **spData** package.
You must have attached the package, and other packages used in the attribute operations chapter (**sf**, **dplyr**, **terra**) with commands such as `library(spData)` before attempting these exercises:

```r
library(sf)
library(dplyr)
library(terra)
library(spData)
data(us_states)
data(us_states_df)
```

`us_states` is a spatial object (of class `sf`), containing geometry and a few attributes (including name, region, area, and population) of states within the contiguous United States.
`us_states_df` is a data frame (of class `data.frame`) containing the name and additional variables (including median income and poverty level, for the years 2010 and 2015) of US states, including Alaska, Hawaii and Puerto Rico.
The data comes from the United States Census Bureau, and is documented in `?us_states` and `?us_states_df`.

E1. Create a new object called `us_states_name` that contains only the `NAME` column from the `us_states` object using either base R (`[`) or tidyverse (`select()`) syntax.
What is the class of the new object and what makes it geographic?





E2. Select columns from the `us_states` object which contain population data.
Obtain the same result using a different command (bonus: try to find three ways of obtaining the same result).
Hint: try to use helper functions, such as `contains` or `matches` from **dplyr** (see `?contains`).



E3. Find all states with the following characteristics (bonus find *and* plot them):

- Belong to the Midwest region.
- Belong to the West region, have an area below 250,000 km^2^ *and* in 2015 a population greater than 5,000,000 residents (hint: you may need to use the function `units::set_units()` or `as.numeric()`).
- Belong to the South region, had an area larger than 150,000 km^2^ or a total population in 2015 larger than 7,000,000 residents.



E4. What was the total population in 2015 in the `us_states` dataset?
What was the minimum and maximum total population in 2015?



E5. How many states are there in each region?



E6. What was the minimum and maximum total population in 2015 in each region?
What was the total population in 2015 in each region?



E7. Add variables from `us_states_df` to `us_states`, and create a new object called `us_states_stats`.
What function did you use and why?
Which variable is the key in both datasets?
What is the class of the new object?



E8. `us_states_df` has two more rows than `us_states`.
How can you find them? (hint: try to use the `dplyr::anti_join()` function)



E9. What was the population density in 2015 in each state?
What was the population density in 2010 in each state?



E10. How much has population density changed between 2010 and 2015 in each state?
Calculate the change in percentages and map them.



E11. Change the columns' names in `us_states` to lowercase. (Hint: helper functions - `tolower()` and `colnames()` may help.)



E12. Using `us_states` and `us_states_df` create a new object called `us_states_sel`.
The new object should have only two variables - `median_income_15` and `geometry`.
Change the name of the `median_income_15` column to `Income`.



E13. Calculate the change in the number of residents living below the poverty level between 2010 and 2015 for each state. (Hint: See ?us_states_df for documentation on the poverty level columns.)
Bonus: Calculate the change in the *percentage* of residents living below the poverty level in each state.



E14. What was the minimum, average and maximum state's number of people living below the poverty line in 2015 for each region?
Bonus: What is the region with the largest increase in people living below the poverty line?



E15. Create a raster from scratch with nine rows and columns and a resolution of 0.5 decimal degrees (WGS84).
Fill it with random numbers.
Extract the values of the four corner cells. 



E16. What is the most common class of our example raster `grain`?



E17. Plot the histogram and the boxplot of the `dem.tif` file from the **spDataLarge** package (`system.file("raster/dem.tif", package = "spDataLarge")`). 

<!--chapter:end:03-attribute-operations.Rmd-->

# Spatial data operations {#spatial-operations}

## Prerequisites {-}

- This chapter requires the same packages used in Chapter \@ref(attr): 


```r
library(sf)
library(terra)
library(dplyr)
library(spData)
```

- You also need to read in a couple of datasets as follows for Section \@ref(spatial-ras):


```r
elev = rast(system.file("raster/elev.tif", package = "spData"))
grain = rast(system.file("raster/grain.tif", package = "spData"))
```

## Introduction

Spatial operations, including spatial joins between vector datasets and local and focal operations on raster datasets, are a vital part of geocomputation\index{geocomputation}.
This chapter shows how spatial objects can be modified in a multitude of ways based on their location and shape.
Many spatial operations have a non-spatial (attribute) equivalent, so concepts such as subsetting and joining datasets demonstrated in the previous chapter are applicable here.
This is especially true for *vector* operations: Section \@ref(vector-attribute-manipulation) on vector attribute manipulation provides the basis for understanding its spatial counterpart, namely spatial subsetting (covered in Section \@ref(spatial-subsetting)).
Spatial joining (Section \@ref(spatial-joining)) and aggregation (Section \@ref(spatial-aggr)) also have non-spatial counterparts, covered in the previous chapter.

Spatial operations differ from non-spatial operations in a number of ways, however:
Spatial joins, for example, can be done in a number of ways --- including matching entities that intersect with or are within a certain distance of the target dataset --- while the attribution joins discussed in Section \@ref(vector-attribute-joining) in the previous chapter can only be done in one way (except when using fuzzy joins, as described in the documentation of the [**fuzzyjoin**](https://cran.r-project.org/package=fuzzyjoin) package).
Different *types* of spatial relationship between objects, including intersects and disjoint, are described in Section \@ref(topological-relations).
\index{spatial operations}
Another unique aspect of spatial objects is distance: all spatial objects are related through space, and distance calculations can be used to explore the strength of this relationship, as described in the context of vector data in Section \@ref(distance-relations).

Spatial operations on raster objects include subsetting --- covered in Section \@ref(spatial-raster-subsetting) --- and merging several raster 'tiles' into a single object, as demonstrated in Section \@ref(merging-rasters).
*Map algebra* covers a range of operations that modify raster cell values, with or without reference to surrounding cell values.
The concept of map algebra, vital for many applications, is introduced in Section \@ref(map-algebra); local, focal and zonal map algebra operations are covered in sections \@ref(local-operations), \@ref(focal-operations), and \@ref(zonal-operations), respectively. Global map algebra operations, which generate summary statistics representing an entire raster dataset, and distance calculations on rasters, are discussed in Section \@ref(global-operations-and-distances).
In the final section before the exercises (\@ref(merging-rasters)) the process of merging two raster datasets is discussed and demonstrated with reference to a reproducible example.

\BeginKnitrBlock{rmdnote}
It is important to note that spatial operations that use two spatial objects rely on both objects having the same coordinate reference system, a topic that was introduced in Section \@ref(crs-intro) and which will be covered in more depth in Chapter \@ref(reproj-geo-data).
\EndKnitrBlock{rmdnote}

## Spatial operations on vector data {#spatial-vec}

This section provides an overview of spatial operations on vector geographic data represented as simple features in the **sf** package.
Section \@ref(spatial-ras) presents spatial operations on raster datasets using classes and functions from the **terra** package.

### Spatial subsetting

Spatial subsetting is the process of taking a spatial object and returning a new object containing only features that *relate* in space to another object.
Analogous to *attribute subsetting* (covered in Section \@ref(vector-attribute-subsetting)), subsets of `sf` data frames can be created with square bracket (`[`) operator using the syntax `x[y, , op = st_intersects]`, where `x` is an `sf` object from which a subset of rows will be returned, `y` is the 'subsetting object' and `, op = st_intersects` is an optional argument that specifies the topological relation (also known as the binary predicate) used to do the subsetting.
The default topological relation used when an `op` argument is not provided is `st_intersects()`: the command `x[y, ]` is identical to `x[y, , op = st_intersects]` shown above but not `x[y, , op = st_disjoint]` (the meaning of these and other topological relations is described in the next section).
The `filter()` function from the **tidyverse**\index{tidyverse (package)} can also be used but this approach is more verbose, as we will see in the examples below.
\index{vector!subsetting}
\index{spatial!subsetting}

To demonstrate spatial subsetting, we will use the `nz` and `nz_height` datasets in the **spData** package, which contain geographic data on the 16 main regions and 101 highest points in New Zealand, respectively (Figure \@ref(fig:nz-subset)), in a projected coordinate system.
The following code chunk creates an object representing Canterbury, then uses spatial subsetting to return all high points in the region:


```r
canterbury = nz |> filter(Name == "Canterbury")
canterbury_height = nz_height[canterbury, ]
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/nz-subset-1} 

}

\caption[Illustration of spatial subsetting.]{Illustration of spatial subsetting with red triangles representing 101 high points in New Zealand, clustered near the central Canterbuy region (left). The points in Canterbury were created with the `[` subsetting operator (highlighted in gray, right).}(\#fig:nz-subset)
\end{figure}

Like attribute subsetting, the command `x[y, ]` (equivalent to `nz_height[canterbury, ]`) subsets features of a *target* `x` using the contents of a *source* object `y`.
Instead of `y` being a vector of class `logical` or `integer`, however, for spatial subsetting both `x` and `y` must be geographic objects.
Specifically, objects used for spatial subsetting in this way must have the class `sf` or `sfc`: both `nz` and `nz_height` are geographic vector data frames and have the class `sf`, and the result of the operation returns another `sf` object representing the features in the target `nz_height` object that intersect with (in this case high points that are located within) the `canterbury` region. 

Various *topological relations* can be used for spatial subsetting which determine the type of spatial relationship that features in the target object must have with the subsetting object to be selected.
These include *touches*, *crosses* or *within*, as we will see shortly in Section \@ref(topological-relations). 
The default setting `st_intersects` is a 'catch all' topological relation that will return features in the target that *touch*, *cross* or are *within* the source 'subsetting' object.
As indicated above, alternative spatial operators can be specified with the `op =` argument, as demonstrated in the following command which returns the opposite of `st_intersects()`, points that do not intersect with Canterbury (see Section \@ref(topological-relations)):


```r
nz_height[canterbury, , op = st_disjoint]
```

\BeginKnitrBlock{rmdnote}
Note the empty argument --- denoted with `, ,` --- in the preceding code chunk is included to highlight `op`, the third argument in `[` for `sf` objects.
One can use this to change the subsetting operation in many ways.
`nz_height[canterbury, 2, op = st_disjoint]`, for example, returns the same rows but only includes the second attribute column (see `` sf:::`[.sf` `` and the `?sf` for details).
\EndKnitrBlock{rmdnote}

For many applications, this is all you'll need to know about spatial subsetting for vector data: it just works.
If you are impatient to learn about more topological relations, beyond `st_intersects()` and `st_disjoint()`, skip to the next section (\@ref(topological-relations)).
If you're interested in the details, including other ways of subsetting, read on.

Another way of doing spatial subsetting uses objects returned by topological operators.
These objects can be useful in their own right, for example when exploring the graph network of relationships between contiguous regions, but they can also be used for subsetting, as demonstrated in the code chunk below:


```r
sel_sgbp = st_intersects(x = nz_height, y = canterbury)
class(sel_sgbp)
#> [1] "sgbp" "list"
sel_sgbp
#> Sparse geometry binary predicate list of length 101, where the
#> predicate was `intersects'
#> first 10 elements:
#>  1: (empty)
#>  2: (empty)
#>  3: (empty)
#>  4: (empty)
#>  5: 1
#>  6: 1
#>  7: 1
#>  8: 1
#>  9: 1
#>  10: 1
sel_logical = lengths(sel_sgbp) > 0
canterbury_height2 = nz_height[sel_logical, ]
```

The above code chunk creates an object of class `sgbp` (a sparse geometry binary predicate, a list of length `x` in the spatial operation) and then converts it into a logical vector `sel_logical` (containing only `TRUE` and `FALSE` values, something that can also be used by **dplyr**'s filter function).
\index{binary predicate|seealso {topological relations}}
The function `lengths()` identifies which features in `nz_height` intersect with *any* objects in `y`.
In this case 1 is the greatest possible value but for more complex operations one could use the method to subset only features that intersect with, for example, 2 or more features from the source object.

\BeginKnitrBlock{rmdnote}
Note: another way to return a logical output is by setting `sparse = FALSE` (meaning 'return a dense matrix not a sparse one') in operators such as `st_intersects()`. The command `st_intersects(x = nz_height, y = canterbury, sparse = FALSE)[, 1]`, for example, would return an output identical to `sel_logical`.
Note: the solution involving `sgbp` objects is more generalisable though, as it works for many-to-many operations and has lower memory requirements.
\EndKnitrBlock{rmdnote}

The same result can be achieved with the **sf** function `st_filter()` which was [created](https://github.com/r-spatial/sf/issues/1148) to increase compatibility between `sf` objects and **dplyr** data manipulation code:


```r
canterbury_height3 = nz_height |>
  st_filter(y = canterbury, .predicate = st_intersects)
```

<!--toDo:jn-->
<!-- fix pipes -->



At this point, there are three identical (in all but row names) versions of `canterbury_height`, one created using the `[` operator, one created via an intermediary selection object, and another using **sf**'s convenience function `st_filter()`.
<!-- RL: commented out for now as old. Todo: if we ever update that vignette uncomment the next line. -->
<!-- To explore spatial subsetting in more detail, see the supplementary vignettes on `subsetting` and [`tidyverse-pitfalls`](https://geocompr.github.io/geocompkg/articles/) on the [geocompkg website](https://geocompr.github.io/geocompkg/articles/). -->
The next section explores different types of spatial relation, also known as binary predicates, that can be used to identify whether or not two features are spatially related or not.

### Topological relations

Topological relations describe the spatial relationships between objects.
"Binary topological relationships", to give them their full name, are logical statements (in that the answer can only be `TRUE` or `FALSE`) about the spatial relationships between two objects defined by ordered sets of points (typically forming points, lines and polygons) in two or more dimensions [@egenhofer_mathematical_1990].
That may sound rather abstract and, indeed, the definition and classification of topological relations is based on mathematical foundations first published in book form in 1966 [@spanier_algebraic_1995], with the field of algebraic topology continuing into the 21^st^ century [@dieck_algebraic_2008].

Despite their mathematical origins, topological relations can be understood intuitively with reference to visualizations of commonly used functions that test for common types of spatial relationships.
Figure \@ref(fig:relations) shows a variety of geometry pairs and their associated relations.
The third and fourth pairs in Figure \@ref(fig:relations) (from left to right and then down) demonstrate that, for some relations, order is important: while the relations *equals*, *intersects*, *crosses*, *touches* and *overlaps* are symmetrical, meaning that if `function(x, y)` is true, `function(y, x)` will also by true, relations in which the order of the geometries are important such as *contains* and *within* are not.
Notice that each geometry pair has a "DE-9IM" string such as FF2F11212, described in the next section.
\index{topological relations}

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/relations-1} 

}

\caption{Topological relations between vector geometries, inspired by Figures 1 and 2 in Egenhofer and Herring (1990). The relations for which the function(x, y) is true are printed for each geometry pair, with x represented in pink and y represented in blue. The nature of the spatial relationship for each pair is described by the Dimensionally Extended 9-Intersection Model string.}(\#fig:relations)
\end{figure}

In `sf`, functions testing for different types of topological relations are called 'binary predicates', as described in the vignette *Manipulating Simple Feature Geometries*, which can be viewed with the command [`vignette("sf3")`](https://r-spatial.github.io/sf/articles/sf3.html), and in the help page [`?geos_binary_pred`](https://r-spatial.github.io/sf/reference/geos_binary_ops.html).
To see how topological relations work in practice, let's create a simple reproducible example, building on the relations illustrated in Figure \@ref(fig:relations) and consolidating knowledge of how vector geometries are represented from a previous chapter (Section \@ref(geometry)).
Note that to create tabular data representing coordinates (x and y) of the polygon vertices, we use the base R function `cbind()` to create a matrix representing coordinates points, a `POLYGON`, and finally an `sfc` object, as described in Chapter \@ref(spatial-class):


```r
polygon_matrix = cbind(
  x = c(0, 0, 1, 1,   0),
  y = c(0, 1, 1, 0.5, 0)
)
polygon_sfc = st_sfc(st_polygon(list(polygon_matrix)))
```



We will create additional geometries to demonstrate spatial relations with the following commands which, when plotted on top of the polygon created above, relate in space to one another, as shown in Figure \@ref(fig:relation-objects).
Note the use of the function `st_as_sf()` and the argument `coords` to efficiently convert from a data frame containing columns representing coordinates to an `sf` object containing points:


```r
line_sfc = st_sfc(st_linestring(cbind(
  x = c(0.4, 1),
  y = c(0.2, 0.5)
)))
# create points
point_df = data.frame(
  x = c(0.2, 0.7, 0.4),
  y = c(0.1, 0.2, 0.8)
)
point_sf = st_as_sf(point_df, coords = c("x", "y"))
```

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{04-spatial-operations_files/figure-latex/relation-objects-1} 

}

\caption[Demonstration of topological relations.]{Points (point df 1 to 3), line and polygon objects arranged to illustrate topological relations.}(\#fig:relation-objects)
\end{figure}

A simple query is: which of the points in `point_sf` intersect in some way with polygon `polygon_sfc`?
The question can be answered by inspection (points 1 and 3 are touching and within the polygon, respectively).
This question can be answered with the spatial predicate `st_intersects()` as follows:


```r
st_intersects(point_sf, polygon_sfc)
#> Sparse geometry binary predicate... `intersects'
#>  1: 1
#>  2: (empty)
#>  3: 1
```

The result should match your intuition:
positive (`1`) results are returned for the first and third point, and a negative result (represented by an empty vector) for the second are outside the polygon's border.
What may be unexpected is that the result comes in the form of a list of vectors.
This *sparse matrix* output only registers a relation if one exists, reducing the memory requirements of topological operations on multi-feature objects.
As we saw in the previous section, a *dense matrix* consisting of `TRUE` or `FALSE` values is returned when `sparse = FALSE`:


```r
st_intersects(point_sf, polygon_sfc, sparse = FALSE)
#>       [,1]
#> [1,]  TRUE
#> [2,] FALSE
#> [3,]  TRUE
```

In the above output each row represents a feature in the target (argument `x`) object and each column represents a feature in the selecting object (`y`).
In this case, there is only one feature in the `y` object `polygon_sfc` so the result, which can be used for subsetting as we saw in Section \@ref(spatial-subsetting), has only one column.

`st_intersects()` returns `TRUE` even in cases where the features just touch: *intersects* is a 'catch-all' topological operation which identifies many types of spatial relation, as illustrated in Figure \@ref(fig:relations).
More restrictive questions include which points lie within the polygon, and which features are on or contain a shared boundary with `y`?
These can be answered as follows (results not show):


```r
st_within(point_sf, polygon_sfc)
st_touches(point_sf, polygon_sfc)
```

Note that although the first point *touches* the boundary polygon, it is not within it; the third point is within the polygon but does not touch any part of its border.
The opposite of `st_intersects()` is `st_disjoint()`, which returns only objects that do not spatially relate in any way to the selecting object (note `[, 1]` converts the result into a vector):


```r
st_disjoint(point_sf, polygon_sfc, sparse = FALSE)[, 1]
#> [1] FALSE  TRUE FALSE
```

The function `st_is_within_distance()` detects features that *almost touch* the selection object, which has an additional `dist` argument.
It can be used to set how close target objects need to be before they are selected.
Note that although point 2 is more than 0.2 units of distance from the nearest vertex of `polygon_sfc`, it is still selected when the distance is set to 0.2.
This is because distance is measured to the nearest edge, in this case the part of the the polygon that lies directly above point 2 in Figure \@ref(fig:relation-objects).
(You can verify the actual distance between point 2 and the polygon is 0.13 with the command `st_distance(point_sf, polygon_sfc)`.)
The 'is within distance' binary spatial predicate is demonstrated in the code chunk below, the results of which show that every point is within 0.2 units of the polygon:


```r
st_is_within_distance(point_sf, polygon_sfc, dist = 0.2, sparse = FALSE)[, 1]
#> [1] TRUE TRUE TRUE
```




\BeginKnitrBlock{rmdnote}
Functions for calculating topological relations use spatial indices to largely speed up spatial query performance.
They achieve that using the Sort-Tile-Recursive (STR) algorithm.
The `st_join` function, mentioned in the next section, also uses the spatial indexing. 
You can learn more at https://www.r-spatial.org/r/2017/06/22/spatial-index.html.
\EndKnitrBlock{rmdnote}







### DE-9IM strings

Underlying the binary predicates demonstrated in the previous section is the Dimensionally Extended 9-Intersection Model (DE-9IM).
As the cryptic name suggests, this is not an easy topic.
Learning it may be worthwhile, however, to better understand spatial relationships.
Furthermore, advanced uses of DE-9IM include creating custom spatial predicates.
The model was originally labelled "DE + 9IM" by its inventors, referring to the "dimension of the intersections of boundaries, interiors, and exteriors of two features" [@clementini_comparison_1995], but is now referred to as DE-9IM [@shen_classification_2018].
<!-- The model's workings can be demonstrated with reference to two intersecting polygons, as illustrated in Figure \@ref(fig:de-9im). -->



To demonstrate how DE-9IM strings work, let's take a look at the various ways that the first geometry pair in Figure \@ref(fig:relations) relate.
Figure \@ref(fig:de9imgg) illustrates the 9 intersection model (9IM) which shows the intersections between every combination of each object's interior, boundary and exterior: when each component of the first object `x` is arranged as columns and each component of `y` is arranged as rows, a facetted graphic is created with the intersections between each element highlighted.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/de9imgg-1} 

}

\caption{Illustration of how the Dimensionally Extended 9 Intersection Model (DE-9IM) works. Colors not in the legend represent the overlap between different components. The thick lines highlight 2 dimensional intesections, e.g. between the boundary of object x and the interior of object y, shown in the middle top facet.}(\#fig:de9imgg)
\end{figure}

DE-9IM strings are derived from the dimension of each type of relation.
In this case the red intersections in Figure \@ref(fig:de9imgg) have dimensions of 0 (points), 1 (lines), and 2 (polygons), as shown in Table \@ref(tab:de9emtable).

\begin{table}

\caption{(\#tab:de9emtable)Table showing relations between interiors, boundaries and exteriors of geometries x and y.}
\centering
\begin{tabular}[t]{l|l|l|l}
\hline
  & Interior (x) & Boundary (x) & Exterior (x)\\
\hline
Interior (y) & 2 & 1 & 2\\
\hline
Boundary (y) & 1 & 1 & 1\\
\hline
Exterior (y) & 2 & 1 & 2\\
\hline
\end{tabular}
\end{table}

Flattening this matrix 'row-wise' (meaning concatenating the first row, then the second, then the third) results in the string `212111212`.
Another example will serve to demonstrate the system:
the relation shown in Figure \@ref(fig:relations) (the third polygon pair in the third column and 1st row) can be defined in the DE-9IM system as follows:

- The intersections between the *interior* of the larger object `x` and the interior, boundary and exterior of `y` have dimensions of 2, 1 and 2 respectively
- The intersections between the *boundary* of the larger object `x` and the interior, boundary and exterior of `y` have dimensions of F, F and 1 respectively, where 'F' means 'false', the objects are disjoint
- The intersections between the *exterior* of `x` and the interior, boundary and exterior of `y` have dimensions of F, F and 2 respectively: the exterior of the larger object does not touch the interior or boundary of `y`, but the exterior of the smaller and larger objects cover the same area

These three components, when concatenated, create the string `212`, `FF1`, and `FF2`.
This is the same as the result obtained from the function `st_relate()` (see the source code of this chapter to see how other geometries in Figure \@ref(fig:relations) were created):


```r
xy2sfc = function(x, y) st_sfc(st_polygon(list(cbind(x, y))))
x = xy2sfc(x = c(0, 0, 1, 1,   0), y = c(0, 1, 1, 0.5, 0))
y = xy2sfc(x = c(0.7, 0.7, 0.9, 0.7), y = c(0.8, 0.5, 0.5, 0.8))
st_relate(x, y)
#>      [,1]       
#> [1,] "212FF1FF2"
```

Understanding DE-9IM strings allows new binary spatial predicates to be developed.
The help page `?st_relate` contains function definitions for 'queen' and 'rook' relations in which polygons share a border or only a point, respectively.
'Queen' relations mean that 'boundary-boundary' relations (the cell in the second column and the second row in Table \@ref(tab:de9emtable), or the 5th element of the DE-9IM string) must not be empty, corresponding to the pattern `F***T****`, while for 'rook' relations the same element must be 1 (meaning a linear intersection).
These are implemented as follows:


```r
st_queen = function(x, y) st_relate(x, y, pattern = "F***T****")
st_rook = function(x, y) st_relate(x, y, pattern = "F***1****")
```

Building on the object `x` created previously, we can use the newly created functions to find out which elements in the grid are a 'queen' and 'rook' in relation to the middle square of the grid as follows:


```r
grid = st_make_grid(x, n = 3)
grid_sf = st_sf(grid)
grid_sf$queens = lengths(st_queen(grid, grid[5])) > 0
plot(grid, col = grid_sf$queens)
grid_sf$rooks = lengths(st_rook(grid, grid[5])) > 0
plot(grid, col = grid_sf$rooks)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/queens-1} 

}

\caption{Demonstration of custom binary spatial predicates for finding 'queen' (left) and 'rook' (right) relations to the central square in a grid with 9 geometries.}(\#fig:queens)
\end{figure}


<!-- Another of a custom binary spatial predicate is 'overlapping lines' which detects lines that overlap for some or all of another line's geometry. -->
<!-- This can be implemented as follows, with the pattern signifying that the intersection between the two line interiors must be a line: -->



### Spatial joining 

Joining two non-spatial datasets relies on a shared 'key' variable, as described in Section \@ref(vector-attribute-joining).
Spatial data joining applies the same concept, but instead relies on spatial relations, described in the previous section.
As with attribute data, joining adds new columns to the target object (the argument `x` in joining functions), from a source object (`y`).
\index{join!spatial}
\index{spatial!join}

The process is illustrated by the following example: imagine you have ten points randomly distributed across the Earth's surface and you ask, for the points that are on land, which countries are they in?
Implementing this idea in a [reproducible example](https://github.com/Robinlovelace/geocompr/blob/main/code/04-spatial-join.R) will build your geographic data handling skills and show how spatial joins work.
The starting point is to create points that are randomly scattered over the Earth's surface:


```r
set.seed(2018) # set seed for reproducibility
(bb = st_bbox(world)) # the world's bounds
#>   xmin   ymin   xmax   ymax 
#> -180.0  -89.9  180.0   83.6
random_df = data.frame(
  x = runif(n = 10, min = bb[1], max = bb[3]),
  y = runif(n = 10, min = bb[2], max = bb[4])
)
random_points = random_df |> 
  st_as_sf(coords = c("x", "y")) |> # set coordinates
  st_set_crs("EPSG:4326") # set geographic CRS
```

The scenario illustrated in Figure \@ref(fig:spatial-join) shows that the `random_points` object (top left) lacks attribute data, while the `world` (top right) has attributes, including country names shown for a sample of countries in the legend.
Spatial joins are implemented with `st_join()`, as illustrated in the code chunk below.
The output is the `random_joined` object which is illustrated in Figure \@ref(fig:spatial-join) (bottom left).
Before creating the joined dataset, we use spatial subsetting to create `world_random`, which contains only countries that contain random points, to verify the number of country names returned in the joined dataset should be four (see the top right panel of Figure \@ref(fig:spatial-join)).


```r
world_random = world[random_points, ]
nrow(world_random)
#> [1] 4
random_joined = st_join(random_points, world["name_long"])
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/spatial-join-1} 

}

\caption[Illustration of a spatial join.]{Illustration of a spatial join. A new attribute variable is added to random points (top left) from source world object (top right) resulting in the data represented in the final panel.}(\#fig:spatial-join)
\end{figure}

By default, `st_join()` performs a left join, meaning that the result is an object containing all rows from `x` including rows with no match in `y` (see Section \@ref(vector-attribute-joining)), but it can also do inner joins by setting the argument `left = FALSE`.
Like spatial subsetting, the default topological operator used by `st_join()` is `st_intersects()`, which can be changed by setting the `join` argument (see `?st_join` for details).
The example above demonstrates the addition of a column from a polygon layer to a point layer, but same approach works regardless of geometry types.
In such cases, for example when `x` contains polygons, each of which match multiple objects in `y`, spatial joins will result in duplicate features, creates a new row for each match in `y`.

<!-- Idea: demonstrate what happens when there are multiple matches with reprex (low priority, RL: 2021-12) -->

### Non-overlapping joins

Sometimes two geographic datasets do not touch but still have a strong geographic relationship.
The datasets `cycle_hire` and `cycle_hire_osm`, already attached in the **spData** package, provide a good example.
Plotting them shows that they are often closely related but they do not touch, as shown in Figure \@ref(fig:cycle-hire), a base version of which is created with the following code below:
\index{join!non-overlapping}


```r
plot(st_geometry(cycle_hire), col = "blue")
plot(st_geometry(cycle_hire_osm), add = TRUE, pch = 3, col = "red")
```

We can check if any points are the same `st_intersects()` as shown below:


```r
any(st_touches(cycle_hire, cycle_hire_osm, sparse = FALSE))
#> [1] FALSE
```



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/cycle-hire-1} 

}

\caption[The spatial distribution of cycle hire points in London.]{The spatial distribution of cycle hire points in London based on official data (blue) and OpenStreetMap data (red).}(\#fig:cycle-hire)
\end{figure}

Imagine that we need to join the `capacity` variable in `cycle_hire_osm` onto the official 'target' data contained in `cycle_hire`.
This is when a non-overlapping join is needed.
The simplest method is to use the topological operator `st_is_within_distance()`, as demonstrated below using a threshold distance of 20 m (note that this works with projected and unprojected data).


```r
sel = st_is_within_distance(cycle_hire, cycle_hire_osm, dist = 20)
summary(lengths(sel) > 0)
#>    Mode   FALSE    TRUE 
#> logical     304     438
```






This shows that there are 438 points in the target object `cycle_hire` within the threshold distance of `cycle_hire_osm`.
How to retrieve the *values* associated with the respective `cycle_hire_osm` points?
The solution is again with `st_join()`, but with an addition `dist` argument (set to 20 m below):


```r
z = st_join(cycle_hire, cycle_hire_osm, st_is_within_distance, dist = 20)
nrow(cycle_hire)
#> [1] 742
nrow(z)
#> [1] 762
```

Note that the number of rows in the joined result is greater than the target.
This is because some cycle hire stations in `cycle_hire` have multiple matches in `cycle_hire_osm`.
To aggregate the values for the overlapping points and return the mean, we can use the aggregation methods learned in Chapter \@ref(attr), resulting in an object with the same number of rows as the target:


```r
z = z |> 
  group_by(id) |> 
  summarize(capacity = mean(capacity))
nrow(z) == nrow(cycle_hire)
#> [1] TRUE
```

The capacity of nearby stations can be verified by comparing a plot of the capacity of the source `cycle_hire_osm` data with the results in this new object (plots not shown):


```r
plot(cycle_hire_osm["capacity"])
plot(z["capacity"])
```

The result of this join has used a spatial operation to change the attribute data associated with simple features; the geometry associated with each feature has remained unchanged.

### Spatial aggregation {#spatial-aggr}

As with attribute data aggregation, spatial data aggregation *condenses* data: aggregated outputs have fewer rows than non-aggregated inputs.
Statistical *aggregating functions*, such as mean average or sum, summarise multiple values \index{statistics} of a variable, and return a single value per *grouping variable*.
Section \@ref(vector-attribute-aggregation) demonstrated how `aggregate()` and `group_by() |> summarize()` condense data based on attribute variables, this section shows how the same functions work with spatial objects.
\index{aggregation!spatial}

Returning to the example of New Zealand, imagine you want to find out the average height of high points in each region: it is the geometry of the source (`y` or `nz` in this case) that defines how values in the target object (`x` or `nz_height`) are grouped.
This can be done in a single line of code with base R's `aggregate()` method:


```r
nz_agg = aggregate(x = nz_height, by = nz, FUN = mean)
```

The result of the previous command is an `sf` object with the same geometry as the (spatial) aggregating object (`nz`), which you can verify with the command `identical(st_geometry(nz), st_geometry(nz_agg))`.
The result of the previous operation is illustrated in Figure \@ref(fig:spatial-aggregation), which shows the average value of features in `nz_height` within each of New Zealand's 16 regions.
The same result can also be generated by piping the output from `st_join()` into the 'tidy' functions `group_by()` and `summarize()` as follows:

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{04-spatial-operations_files/figure-latex/spatial-aggregation-1} 

}

\caption{Average height of the top 101 high points across the regions of New Zealand.}(\#fig:spatial-aggregation)
\end{figure}


```r
nz_agg2 = st_join(x = nz, y = nz_height) |>
  group_by(Name) |>
  summarize(elevation = mean(elevation, na.rm = TRUE))
```



The resulting `nz_agg` objects have the same geometry as the aggregating object `nz` but with a new column summarizing the values of `x` in each region using the function `mean()`.
Other functions could be used instead of `mean()` here, including `median()`, `sd()` and other functions that return a single value per group.
Note: one difference between the `aggregate()` and `group_by() |> summarize()` approaches is that the former results in `NA` values for unmatching region names while the latter preserves region names.
The 'tidy' approach is thus more flexible in terms of aggregating functions and the column names of the results.
Aggregating operations that also create new geometries are covered in Section \@ref(geometry-unions).


### Joining incongruent layers {#incongruent}

Spatial congruence\index{spatial congruence} is an important concept related to spatial aggregation.
An *aggregating object* (which we will refer to as `y`) is *congruent* with the target object (`x`) if the two objects have shared borders.
Often this is the case for administrative boundary data, whereby larger units --- such as Middle Layer Super Output Areas ([MSOAs](https://www.ons.gov.uk/methodology/geography/ukgeographies/censusgeography)) in the UK or districts in many other European countries --- are composed of many smaller units.

*Incongruent* aggregating objects, by contrast, do not share common borders with the target [@qiu_development_2012].
This is problematic for spatial aggregation (and other spatial operations) illustrated in Figure \@ref(fig:areal-example): aggregating the centroid of each sub-zone will not return accurate results.
Areal interpolation overcomes this issue by transferring values from one set of areal units to another, using a range of algorithms including simple area weighted approaches and more sophisticated approaches such as 'pycnophylactic' methods [@tobler_smooth_1979].

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{04-spatial-operations_files/figure-latex/areal-example-1} 

}

\caption[Illustration of congruent and incongruent areal units.]{Illustration of congruent (left) and incongruent (right) areal units with respect to larger aggregating zones (translucent blue borders).}(\#fig:areal-example)
\end{figure}

The **spData** package contains a dataset named `incongruent` (colored polygons with black borders in the right panel of Figure \@ref(fig:areal-example)) and a dataset named `aggregating_zones` (the two polygons with the translucent blue border in the right panel of Figure \@ref(fig:areal-example)).
Let us assume that the `value` column of `incongruent` refers to the total regional income in million Euros.
How can we transfer the values of the underlying nine spatial polygons into the two polygons of `aggregating_zones`?

The simplest useful method for this is *area weighted* spatial interpolation, which transfers values from the `incongruent` object to a new column in `aggregating_zones` in proportion with the area of overlap: the larger the spatial intersection between input and output features, the larger the corresponding value.
This is implemented in `st_interpolate_aw()`, as demonstrated in the code chunk below.


```r
iv = incongruent["value"] # keep only the values to be transferred
agg_aw = st_interpolate_aw(iv, aggregating_zones, extensive = TRUE)
#> Warning in st_interpolate_aw.sf(iv, aggregating_zones, extensive = TRUE):
#> st_interpolate_aw assumes attributes are constant or uniform over areas of x
agg_aw$value
#> [1] 19.6 25.7
```

In our case it is meaningful to sum up the values of the intersections falling into the aggregating zones since total income is a so-called spatially extensive variable (which increases with area), assuming income is evenly distributed across the smaller zones (hence the warning message above).
This would be different for spatially [intensive](https://geodacenter.github.io/workbook/3b_rates/lab3b.html#spatially-extensive-and-spatially-intensive-variables) variables such as *average* income or percentages, which do not increase as the area increases.
`st_interpolate_aw()` works equally with spatially intensive variables: set the `extensive` parameter to `FALSE` and it will use an average rather than a sum function when doing the aggregation.

### Distance relations 

While topological relations are binary --- a feature either intersects with another or does not --- distance relations are continuous.
The distance between two objects is calculated with the `st_distance()` function.
This is illustrated in the code chunk below, which finds the distance between the highest point in New Zealand and the geographic centroid of the Canterbury region, created in Section \@ref(spatial-subsetting):
\index{sf!distance relations}


```r
nz_heighest = nz_height |> slice_max(n = 1, order_by = elevation)
canterbury_centroid = st_centroid(canterbury)
st_distance(nz_heighest, canterbury_centroid)
#> Units: [m]
#>        [,1]
#> [1,] 115540
```

There are two potentially surprising things about the result:

- It has `units`, telling us the distance is 100,000 meters, not 100,000 inches, or any other measure of distance
- It is returned as a matrix, even though the result only contains a single value

This second feature hints at another useful feature of `st_distance()`, its ability to return *distance matrices* between all combinations of features in objects `x` and `y`.
This is illustrated in the command below, which finds the distances between the first three features in `nz_height` and the Otago and Canterbury regions of New Zealand represented by the object `co`.


```r
co = filter(nz, grepl("Canter|Otag", Name))
st_distance(nz_height[1:3, ], co)
#> Units: [m]
#>        [,1]  [,2]
#> [1,] 123537 15498
#> [2,]  94283     0
#> [3,]  93019     0
```

Note that the distance between the second and third features in `nz_height` and the second feature in `co` is zero.
This demonstrates the fact that distances between points and polygons refer to the distance to *any part of the polygon*:
The second and third points in `nz_height` are *in* Otago, which can be verified by plotting them (result not shown):


```r
plot(st_geometry(co)[2])
plot(st_geometry(nz_height)[2:3], add = TRUE)
```

## Spatial operations on raster data {#spatial-ras}

This section builds on Section \@ref(manipulating-raster-objects), which highlights various basic methods for manipulating raster datasets, to demonstrate more advanced and explicitly spatial raster operations, and uses the objects `elev` and `grain` manually created in Section \@ref(manipulating-raster-objects).
For the reader's convenience, these datasets can be also found in the **spData** package.

### Spatial subsetting {#spatial-raster-subsetting}

The previous chapter (Section \@ref(manipulating-raster-objects)) demonstrated how to retrieve values associated with specific cell IDs or row and column combinations.
Raster objects can also be extracted by location (coordinates) and other spatial objects.
To use coordinates for subsetting, one can 'translate' the coordinates into a cell ID with the **terra** function `cellFromXY()`.
An alternative is to use `terra::extract()` (be careful, there is also a function called `extract()` in the **tidyverse**\index{tidyverse (package)}) to extract values.
Both methods are demonstrated below to find the value of the cell that covers a point located at coordinates of 0.1, 0.1.
\index{raster!subsetting}
\index{spatial!subsetting}


```r
id = cellFromXY(elev, xy = matrix(c(0.1, 0.1), ncol = 2))
elev[id]
# the same as
terra::extract(elev, matrix(c(0.1, 0.1), ncol = 2))
```

<!--jn:toDo-->
<!-- to update? -->
<!-- It is convenient that both functions also accept objects of class `Spatial* Objects`. -->
Raster objects can also be subset with another raster object, as demonstrated in the code chunk below:


```r
clip = rast(xmin = 0.9, xmax = 1.8, ymin = -0.45, ymax = 0.45,
            resolution = 0.3, vals = rep(1, 9))
elev[clip]
# we can also use extract
# terra::extract(elev, ext(clip))
```

This amounts to retrieving the values of the first raster object (in this case `elev`) that fall within the extent of a second raster (here: `clip`), as illustrated in Figure \@ref(fig:raster-subset).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/04_raster_subset} 

}

\caption[Subsetting raster values.]{Original raster (left). Raster mask (middle). Output of masking a raster (right).}(\#fig:raster-subset)
\end{figure}

The example above returned the values of specific cells, but in many cases spatial outputs from subsetting operations on raster datasets are needed.
This can be done with the `[` operator, using `drop = FALSE`.
The code below returns the first two cells of `elev` as a raster object the first two cells on the top row (only the first 2 lines of the output is shown):


```r
elev[1:2, drop = FALSE]    # spatial subsetting with cell IDs
#> class       : SpatRaster 
#> dimensions  : 1, 2, 1  (nrow, ncol, nlyr)
#> ...
```



Another common use case of spatial subsetting is when a raster with `logical` (or `NA`) values is used to mask another raster with the same extent and resolution, as illustrated in Figure \@ref(fig:raster-subset).
In this case, the `[` and `mask()` functions can be used (results not shown):


```r
# create raster mask
rmask = elev
values(rmask) = sample(c(NA, TRUE), 36, replace = TRUE)
```

In the code chunk above, we have created a mask object called `rmask` with values randomly assigned to `NA` and `TRUE`.
Next, we want to keep those values of `elev` which are `TRUE` in `rmask`.
In other words, we want to mask `elev` with `rmask`.


```r
# spatial subsetting
elev[rmask, drop = FALSE]           # with [ operator
mask(elev, rmask)                   # with mask()
```

The above approach can be also used to replace some values (e.g., expected to be wrong) with NA. 


```r
elev[elev < 20] = NA
```

These operations are in fact Boolean local operations since we compare cell-wise two rasters.
The next subsection explores these and related operations in more detail.

### Map algebra

\index{map algebra}
The term 'map algebra' was coined in the late 1970s to describe a "set of conventions, capabilities, and techniques" for the analysis of geographic raster *and* (although less prominently) vector data [@tomlin_map_1994].
<!-- Although the concept never became widely adopted, the term usefully encapsulates and helps classify the range operations that can be undertaken on raster datasets. -->
In this context, we define map algebra more narrowly, as operations that modify or summarise raster cell values, with reference to surrounding cells, zones, or statistical functions that apply to every cell.

Map algebra operations tend to be fast, because raster datasets only implicitly store coordinates, hence the [old adage](https://geozoneblog.wordpress.com/2013/04/19/raster-vs-vector/) "raster is faster but vector is corrector".
The location of cells in raster datasets can be calculated by using its matrix position and the resolution and origin of the dataset (stored in the header).
For the processing, however, the geographic position of a cell is barely relevant as long as we make sure that the cell position is still the same after the processing.
Additionally, if two or more raster datasets share the same extent, projection and resolution, one could treat them as matrices for the processing.

This is the way that map algebra works with the **terra** package.
First, the headers of the raster datasets are queried and (in cases where map algebra operations work on more than one dataset) checked to ensure the datasets are compatible.
Second, map algebra retains the so-called one-to-one locational correspondence, meaning that cells cannot move.
This differs from matrix algebra, in which values change position, for example when multiplying or dividing matrices.

Map algebra (or cartographic modeling with raster data) divides raster operations into four subclasses [@tomlin_geographic_1990], with each working on one or several grids simultaneously:

1. *Local* or per-cell operations
2. *Focal* or neighborhood operations.
Most often the output cell value is the result of a 3 x 3 input cell block
3. *Zonal* operations are similar to focal operations, but the surrounding pixel grid on which new values are computed can have irregular sizes and shapes
4. *Global* or per-raster operations. 
That means the output cell derives its value potentially from one or several entire rasters

This typology classifies map algebra operations by the number of cells used for each pixel processing step and the type of the output.
For the sake of completeness, we should mention that raster operations can also be classified by discipline such as terrain, hydrological analysis, or image classification.
The following sections explain how each type of map algebra operations can be used, with reference to worked examples.

### Local operations

\index{map algebra!local operations}
**Local** operations comprise all cell-by-cell operations in one or several layers.
Raster algebra is a classical use case of local operations -- this includes adding or subtracting values from a raster, squaring and multipling rasters.
Raster algebra also allows logical operations such as finding all raster cells that are greater than a specific value (5 in our example below).
The **terra** package supports all these operations and more, as demonstrated below (Figure \@ref(fig:04-local-operations)):


```r
elev + elev
elev^2
log(elev)
elev > 5
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/04-local-operations} 

}

\caption{Examples of different local operations of the elev raster object: adding two rasters, squaring, applying logarithmic transformation, and performing a logical operation.}(\#fig:04-local-operations)
\end{figure}

Another good example of local operations is the classification of intervals of numeric values into groups such as grouping a digital elevation model into low (class 1), middle (class 2) and high elevations (class 3).
Using the `classify()` command, we need first to construct a reclassification matrix, where the first column corresponds to the lower and the second column to the upper end of the class.
The third column represents the new value for the specified ranges in column one and two.


```r
rcl = matrix(c(0, 12, 1, 12, 24, 2, 24, 36, 3), ncol = 3, byrow = TRUE)
rcl
#>      [,1] [,2] [,3]
#> [1,]    0   12    1
#> [2,]   12   24    2
#> [3,]   24   36    3
```

Here, we assign the raster values in the ranges 0--12, 12--24 and 24--36 are *reclassified* to take values 1, 2 and 3, respectively.


```r
recl = classify(elev, rcl = rcl)
```

The `classify()` function can be also used when we want to reduce the number of classes in our categorical rasters.
We will perform several additional reclassifications in Chapter \@ref(location).

Apart of arithmetic operators, one can also use the `app()`, `tapp()` and `lapp()` functions.
They are more efficient, hence, they are preferable in the presence of large raster datasets. 
Additionally, they allow you to save an output file directly.
The `app()` function applies a function to each cell of a raster and is used to summarize (e.g., calculating the sum) the values of multiple layers into one layer.
`tapp()` is an extension of `app()`, allowing us to select a subset of layers (see the `index` argument) for which we want to perform a certain operation.
Finally, the `lapp()` function allows to apply a function to each cell using layers as arguments -- an application of `lapp()` is presented below.

The calculation of the normalized difference vegetation index (NDVI) is a well-known local (pixel-by-pixel) raster operation.
It returns a raster with values between -1 and 1; positive values indicate the presence of living plants (mostly > 0.2).
NDVI is calculated from red and near-infrared (NIR) bands of remotely sensed imagery, typically from satellite systems such as Landsat or Sentinel.
Vegetation absorbs light heavily in the visible light spectrum, and especially in the red channel, while reflecting NIR light, explaining the NVDI formula:

$$
\begin{split}
NDVI&= \frac{\text{NIR} - \text{Red}}{\text{NIR} + \text{Red}}\\
\end{split}
$$

Let's calculate NDVI for the multispectral satellite file of the Zion National Park.


```r
multi_raster_file = system.file("raster/landsat.tif", package = "spDataLarge")
multi_rast = rast(multi_raster_file)
```

The raster object has four satellite bands - blue, green, red, and near-infrared (NIR).
Our next step should be to implement the NDVI formula into an R function:


```r
ndvi_fun = function(nir, red){
  (nir - red) / (nir + red)
}
```

This function accepts two numerical arguments, `nir` and `red`, and returns a numerical vector with NDVI values.
It can be used as the `fun` argument of `lapp()`.
We just need to remember that our function just needs two bands (not four from the original raster), and they need to be in the NIR, red order.
That is why we subset the input raster with `multi_rast[[c(4, 3)]]` before doing any calculations.


```r
ndvi_rast = lapp(multi_rast[[c(4, 3)]], fun = ndvi_fun)
```

The result, shown on the right panel in Figure \@ref(fig:04-ndvi), can be compared to the RGB image of the same area (left panel of the same Figure).
It allows us to see that the largest NDVI values are connected to areas of dense forest in the northern parts of the area, while the lowest values are related to the lake in the north and snowy mountain ridges.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/04-ndvi} 

}

\caption{RGB image (left) and NDVI values (right) calculated for the example satellite file of the Zion National Park}(\#fig:04-ndvi)
\end{figure}

Predictive mapping is another interesting application of local raster operations.
The response variable corresponds to measured or observed points in space, for example, species richness, the presence of landslides, tree disease or crop yield.
Consequently, we can easily retrieve space- or airborne predictor variables from various rasters (elevation, pH, precipitation, temperature, landcover, soil class, etc.).
Subsequently, we model our response as a function of our predictors using `lm()`, `glm()`, `gam()` or a machine-learning technique. 
Spatial predictions on raster objects can therefore be made by applying estimated coefficients to the predictor raster values, and summing the output raster values (see Chapter \@ref(eco)).

### Focal operations

\index{map algebra!focal operations}
While local functions operate on one cell, though possibly from multiple layers, **focal** operations take into account a central (focal) cell and its neighbors.
The neighborhood (also named kernel, filter or moving window) under consideration is typically of size 3-by-3 cells (that is the central cell and its eight surrounding neighbors), but can take on any other (not necessarily rectangular) shape as defined by the user.
A focal operation applies an aggregation function to all cells within the specified neighborhood, uses the corresponding output as the new value for the the central cell, and moves on to the next central cell (Figure \@ref(fig:focal-example)).
Other names for this operation are spatial filtering and convolution [@burrough_principles_2015].

In R, we can use the `focal()` function to perform spatial filtering. 
We define the shape of the moving window with a `matrix` whose values correspond to weights (see `w` parameter in the code chunk below).
Secondly, the `fun` parameter lets us specify the function we wish to apply to this neighborhood.
Here, we choose the minimum, but any other summary function, including `sum()`, `mean()`, or `var()` can be used.


```r
r_focal = focal(elev, w = matrix(1, nrow = 3, ncol = 3), fun = min)
```

This function also accepts additional arguments, for example, should it remove NAs in the process (`na.rm = TRUE`) or not (`na.rm = FALSE`).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/04_focal_example} 

}

\caption[Illustration of a focal operation.]{Input raster (left) and resulting output raster (right) due to a focal operation - finding the minimum value in 3-by-3 moving windows.}(\#fig:focal-example)
\end{figure}

We can quickly check if the output meets our expectations.
In our example, the minimum value has to be always the upper left corner of the moving window (remember we have created the input raster by row-wise incrementing the cell values by one starting at the upper left corner).
In this example, the weighting matrix consists only of 1s, meaning each cell has the same weight on the output, but this can be changed.

Focal functions or filters play a dominant role in image processing.
Low-pass or smoothing filters use the mean function to remove extremes.
In the case of categorical data, we can replace the mean with the mode, which is the most common value.
By contrast, high-pass filters accentuate features.
The line detection Laplace and Sobel filters might serve as an example here.
Check the `focal()` help page for how to use them in R (this will also be used in the exercises at the end of this chapter).

Terrain processing, the calculation of topographic characteristics such as slope, aspect and flow directions, relies on focal functions.
`terrain()` can be used to calculate these metrics, although some terrain algorithms, including the Zevenbergen and Thorne method to compute slope, are not implemented in this **terra** function.
Many other algorithms --- including curvatures, contributing areas and wetness indices --- are implemented in open source desktop geographic information system (GIS) software.
Chapter \@ref(gis) shows how to access such GIS functionality from within R.

### Zonal operations

\index{map algebra!zonal operations}
Just like focal operations, *zonal* operations apply an aggregation function to multiple raster cells.
However, a second raster, usually with categorical values, defines the *zonal filters* (or 'zones') in the case of zonal operations, as opposed to a predefined neighborhood window in the case of focal operation presented in the previous section.
Consequently, raster cells defining the zonal filter do not necessarily have to be neighbors.
Our grain size raster is a good example, as illustrated in the right panel of Figure \@ref(fig:cont-raster): different grain sizes are spread irregularly throughout the raster.
Finally, the result of a zonal operation is a summary table grouped by zone which is why this operation is also known as *zonal statistics* in the GIS world\index{GIS}. 
This is in contrast to focal operations which return a raster object.

The following code chunk uses the `zonal()` function to calculate the mean elevation associated with each grain size class, for example.


```r
z = zonal(elev, grain, fun = "mean")
z
#>   grain elev
#> 1  clay 14.8
#> 2  silt 21.2
#> 3  sand 18.7
```

This returns the statistics\index{statistics} for each category, here the mean altitude for each grain size class.
Note: it is also possible to get a raster with calculated statistics for each zone by setting the `as.raster` argument to `TRUE`.

### Global operations and distances

*Global* operations are a special case of zonal operations with the entire raster dataset representing a single zone.
The most common global operations are descriptive statistics\index{statistics} for the entire raster dataset such as the minimum or maximum -- we already discussed those in Section \@ref(summarizing-raster-objects).

Aside from that, global operations are also useful for the computation of distance and weight rasters.
In the first case, one can calculate the distance from each cell to a specific target cell.
For example, one might want to compute the distance to the nearest coast (see also `terra::distance()`).
We might also want to consider topography, that means, we are not only interested in the pure distance but would like also to avoid the crossing of mountain ranges when going to the coast.
To do so, we can weight the distance with elevation so that each additional altitudinal meter 'prolongs' the Euclidean distance.
Visibility and viewshed computations also belong to the family of global operations (in the exercises of Chapter \@ref(gis), you will compute a viewshed raster).

### Map algebra counterparts in vector processing

Many map algebra operations have a counterpart in vector processing [@liu_essential_2009].
Computing a distance raster (global operation) while only considering a maximum distance (logical focal operation) is the equivalent to a vector buffer operation (Section \@ref(clipping)).
Reclassifying raster data (either local or zonal function depending on the input) is equivalent to dissolving vector data (Section \@ref(spatial-joining)). 
Overlaying two rasters (local operation), where one contains `NULL` or `NA` values representing a mask, is similar to vector clipping (Section \@ref(clipping)).
Quite similar to spatial clipping is intersecting two layers (Section \@ref(spatial-subsetting)). 
The difference is that these two layers (vector or raster) simply share an overlapping area (see Figure \@ref(fig:venn-clip) for an example).
However, be careful with the wording.
Sometimes the same words have slightly different meanings for raster and vector data models.
Aggregating in the case of vector data refers to dissolving polygons, while it means increasing the resolution in the case of raster data.
In fact, one could see dissolving or aggregating polygons as decreasing the resolution. 
However, zonal operations might be the better raster equivalent compared to changing the cell resolution. 
Zonal operations can dissolve the cells of one raster in accordance with the zones (categories) of another raster using an aggregation function (see above).

### Merging rasters

\index{raster!merge}
Suppose we would like to compute the NDVI (see Section \@ref(local-operations)), and additionally want to compute terrain attributes from elevation data for observations within a study area.
Such computations rely on remotely sensed information. 
The corresponding imagery is often divided into scenes covering a specific spatial extent, and frequently, a study area covers more than one scene.
Then, we would need to merge the scenes covered by our study area. 
In the easiest case, we can just merge these scenes, that is put them side by side.
This is possible, for example, with digital elevation data (SRTM, ASTER).
In the following code chunk we first download the SRTM elevation data for Austria and Switzerland (for the country codes, see the **geodata** function `country_codes()`).
In a second step, we merge the two rasters into one.


```r
aut = geodata::elevation_30s(country = "AUT", path = tempdir())
ch = geodata::elevation_30s(country = "CHE", path = tempdir())
aut_ch = merge(aut, ch)
```

**terra**'s `merge()` command combines two images, and in case they overlap, it uses the value of the first raster.
<!--jn:toDo-->
<!-- gdalUtils is slower (for this files): -->
<!-- two_rast = c(terra::sources(aut)$source, terra::sources(ch)$source) -->
<!-- tf = tempfile(fileext = ".tif") -->
<!-- bench::mark({gdalUtils::mosaic_rasters(two_rast, tf)}) -->
<!-- You can do exactly the same with `gdalUtils::mosaic_rasters()` which is faster, and therefore recommended if you have to merge a multitude of large rasters stored on disk. -->

The merging approach is of little use when the overlapping values do not correspond to each other.
This is frequently the case when you want to combine spectral imagery from scenes that were taken on different dates.
The `merge()` command will still work but you will see a clear border in the resulting image.
On the other hand, the `mosaic()` command lets you define a function for the overlapping area. 
For instance, we could compute the mean value -- this might smooth the clear border in the merged result but it will most likely not make it disappear.
<!-- The following sentences have been commented out and can be removed because the packages, and info, is now out of date -->
<!-- See https://github.com/Robinlovelace/geocompr/pull/424 for discussion -->
<!-- To do so, we need a more advanced approach.  -->
<!-- Remote sensing scientists frequently apply histogram matching or use regression techniques to align the values of the first image with those of the second image. -->
<!-- The packages **landsat** (`histmatch()`, `relnorm()`, `PIF()`), **satellite** (`calcHistMatch()`) and **RStoolbox** (`histMatch()`, `pifMatch()`) provide the corresponding functions for the **raster**'s package objects. -->
For a more detailed introduction to remote sensing with R, see @wegmann_remote_2016.
<!--jn:toDo-->
<!--update the above reference to the 2nd edition-->

## Exercises



```r
library(sf)
library(dplyr)
library(spData)
```

E1. It was established in Section \@ref(spatial-vec) that Canterbury was the region of New Zealand containing most of the 100 highest points in the country.
How many of these high points does the Canterbury region contain?

**Bonus:** plot the result using the `plot()` function to show all of New Zealand, `canterbury` region highlighted in yellow, high points in Canterbury represented by red crosses (hint: `pch = 7`) and high points in other parts of New Zealand represented by blue circles. See the help page `?points` for details with an illustration of different `pch` values.



E2. Which region has the second highest number of `nz_height` points, and how many does it have?



E3. Generalizing the question to all regions: how many of New Zealand's 16 regions contain points which belong to the top 100 highest points in the country? Which regions?

- Bonus: create a table listing these regions in order of the number of points and their name.



E4. Test your knowledge of spatial predicates by finding out and plotting how US states relate to each other and other spatial objects.

The starting point of this exercise is to create an object representing Colorado state in the USA. Do this with the command 
`colorado = us_states[us_states$NAME == "Colorado",]` (base R) or with with the  `filter()` function (tidyverse) and plot the resulting object in the context of US states.

- Create a new object representing all the states that geographically intersect with Colorado and plot the result (hint: the most concise way to do this is with the subsetting method `[`).
- Create another object representing all the objects that touch (have a shared boundary with) Colorado and plot the result (hint: remember you can use the argument `op = st_intersects` and other spatial relations during spatial subsetting operations in base R).
- Bonus: create a straight line from the centroid of the District of Columbia near the East coast to the centroid of California near the West coast of the USA (hint: functions `st_centroid()`, `st_union()` and `st_cast()` described in Chapter 5 may help) and identify which states this long East-West line crosses.













E5. Use `dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))`, and reclassify the elevation in three classes: low (<300), medium and high (>500).
Secondly, read the NDVI raster (`ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))`) and compute the mean NDVI and the mean elevation for each altitudinal class.



E6. Apply a line detection filter to `rast(system.file("ex/logo.tif", package = "terra"))`.
Plot the result.
Hint: Read `?terra::focal()`.



E7. Calculate the Normalized Difference Water Index	(NDWI; `(green - nir)/(green + nir)`) of a Landsat image. 
Use the Landsat image provided by the **spDataLarge** package (`system.file("raster/landsat.tif", package = "spDataLarge")`).
Also, calculate a correlation between NDVI and NDWI for this area (hint: you can use the `layerCor()` function).



E8. A StackOverflow [post](https://stackoverflow.com/questions/35555709/global-raster-of-geographic-distances) shows how to compute distances to the nearest coastline using `raster::distance()`.
Try to do something similar but with `terra::distance()`: retrieve a digital elevation model of Spain, and compute a raster which represents distances to the coast across the country (hint: use `geodata::elevation_30s()`).
Convert the resulting distances from meters to kilometers.
Note: it may be wise to increase the cell size of the input raster to reduce compute time during this operation (`aggregate()`).



E9. Try to modify the approach used in the above exercise by weighting the distance raster with the elevation raster; every 100 altitudinal meters should increase the distance to the coast by 10 km.
Next, compute and visualize the difference between the raster created using the Euclidean distance (E7) and the raster weighted by elevation.

<!--chapter:end:04-spatial-operations.Rmd-->

# Geometry operations {#geometric-operations}

## Prerequisites {-}

- This chapter uses the same packages as Chapter \@ref(spatial-operations) but with the addition of **spDataLarge**, which was installed in Chapter \@ref(spatial-class):


```r
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)
```

## Introduction

So far the book has explained the structure of geographic datasets (Chapter \@ref(spatial-class)), and how to manipulate them based on their non-geographic attributes (Chapter \@ref(attr)) and spatial relations (Chapter \@ref(spatial-operations)).
This chapter focusses on manipulating the geographic elements of geographic objects, for example by simplifying and converting vector geometries, cropping raster datasets, and converting vector objects into rasters and from rasters into vectors.
After reading it --- and attempting the exercises at the end --- you should understand and have control over the geometry column in `sf` objects and the extent and geographic location of pixels represented in rasters in relation to other geographic objects.

Section \@ref(geo-vec) covers transforming vector geometries with 'unary' and 'binary' operations.
Unary operations work on a single geometry in isolation, including simplification (of lines and polygons), the creation of buffers and centroids, and shifting/scaling/rotating single geometries using 'affine transformations' (Sections \@ref(simplification) to \@ref(affine-transformations)).
Binary transformations modify one geometry based on the shape of another, including clipping and geometry unions\index{vector!union}, covered in Sections \@ref(clipping) and \@ref(geometry-unions), respectively.
Type transformations (from a polygon to a line, for example) are demonstrated in Section \@ref(type-trans).

Section \@ref(geo-ras) covers geometric transformations on raster objects.
This involves changing the size and number of the underlying pixels, and assigning them new values.
It teaches how to change the resolution (also called raster aggregation and disaggregation), the extent and the origin of a raster.
These operations are especially useful if one would like to align raster datasets from diverse sources.
Aligned raster objects share a one-to-one correspondence between pixels, allowing them to be processed using map algebra operations, described in Section \@ref(map-algebra). 
The interaction between raster and vector objects is covered in Chapter \@ref(raster-vector). 
It shows how raster values can be 'masked' and 'extracted' by vector geometries.
Importantly it shows how to 'polygonize' rasters and 'rasterize' vector datasets, making the two data models more interchangeable.

## Geometric operations on vector data {#geo-vec}

This section is about operations that in some way change the geometry of vector (`sf`) objects.
It is more advanced than the spatial data operations presented in the previous chapter (in Section \@ref(spatial-vec)), because here we drill down into the geometry:
the functions discussed in this section work on objects of class `sfc` in addition to objects of class `sf`.

### Simplification

\index{vector!simplification} 
Simplification is a process for generalization of vector objects (lines and polygons) usually for use in smaller scale maps.
Another reason for simplifying objects is to reduce the amount of memory, disk space and network bandwidth they consume:
it may be wise to simplify complex geometries before publishing them as interactive maps. 
The **sf** package provides `st_simplify()`, which uses the GEOS implementation of the Douglas-Peucker algorithm to reduce the vertex count.
`st_simplify()` uses the `dTolerance` to control the level of generalization in map units [see @douglas_algorithms_1973 for details].
Figure \@ref(fig:seine-simp) illustrates simplification of a `LINESTRING` geometry representing the river Seine and tributaries.
The simplified geometry was created by the following command:


```r
seine_simp = st_simplify(seine, dTolerance = 2000)  # 2000 m
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/seine-simp-1} 

}

\caption[Simplification in action.]{Comparison of the original and simplified geometry of the seine object.}(\#fig:seine-simp)
\end{figure}

The resulting `seine_simp` object is a copy of the original `seine` but with fewer vertices.
This is apparent, with the result being visually simpler (Figure \@ref(fig:seine-simp), right) and consuming less memory than the original object, as verified below:


```r
object.size(seine)
#> 18096 bytes
object.size(seine_simp)
#> 9112 bytes
```

Simplification is also applicable for polygons.
This is illustrated using `us_states`, representing the contiguous United States.
As we show in Chapter \@ref(reproj-geo-data), GEOS assumes that the data is in a projected CRS and this could lead to unexpected results when using a geographic CRS.
Therefore, the first step is to project the data into some adequate projected CRS, such as US National Atlas Equal Area (epsg = 2163) (on the left in Figure \@ref(fig:us-simp)):


```r
us_states2163 = st_transform(us_states, "EPSG:2163")
us_states2163 = us_states2163
```

`st_simplify()` works equally well with projected polygons:


```r
us_states_simp1 = st_simplify(us_states2163, dTolerance = 100000)  # 100 km
```

A limitation with `st_simplify()` is that it simplifies objects on a per-geometry basis.
This means the 'topology' is lost, resulting in overlapping and 'holey' areal units illustrated in Figure \@ref(fig:us-simp) (middle panel).
`ms_simplify()` from **rmapshaper** provides an alternative that overcomes this issue.
By default it uses the Visvalingam algorithm, which overcomes some limitations of the Douglas-Peucker algorithm [@visvalingam_line_1993].
<!-- https://bost.ocks.org/mike/simplify/ -->
The following code chunk uses this function to simplify `us_states2163`.
The result has only 1% of the vertices of the input (set using the argument `keep`) but its number of objects remains intact because we set `keep_shapes = TRUE`:^[
Simplification of multipolygon objects can remove small internal polygons, even if the `keep_shapes` argument is set to TRUE. To prevent this, you need to set `explode = TRUE`. This option converts all mutlipolygons into separate polygons before its simplification.
]


```r
# proportion of points to retain (0-1; default 0.05)
us_states_simp2 = rmapshaper::ms_simplify(us_states2163, keep = 0.01,
                                          keep_shapes = TRUE)
```


An alternative to simplification is smoothing the boundaries of polygon and linestring geometries, which is implemented in the **smoothr** package. 
Smoothing interpolates the edges of geometries and does not necessarily lead to fewer vertices, but can be especially useful when working with geometries that arise from spatially vectorizing a raster (a topic covered in Chapter \@ref(raster-vector).
**smoothr** implements three techniques for smoothing: a Gaussian kernel regression, Chaikin's corner cutting algorithm, and spline interpolation, which are all described in the package vignette and [website](https://strimas.com/smoothr/). 
Note that similar to `st_simplify()`, the smoothing algorithms don't preserve 'topology'.
The workhorse function of **smoothr** is `smooth()`, where the `method` argument specifies what smoothing technique to use.
Below is an example of using Gaussian kernel regression to smooth the borders of US states by using `method=ksmooth`.
The `smoothness` argument controls the bandwidth of the Gaussian that is used to smooth the geometry and has a default value of 1.


```r
us_states_simp3 = smoothr::smooth(us_states2163, method = 'ksmooth', smoothness = 6)
```

Finally, the visual comparison of the original dataset with the simplified and smoothed versions is shown in (Figure \@ref(fig:us-simp)). Differences can be observed between the outputs of the Douglas-Peucker (`st_simplify`), Visvalingam (`ms_simplify`), and Gaussian kernel regression (`smooth(method=ksmooth`) algorithms.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/us-simp-1} 

}

\caption[Polygon simplification in action.]{Polygon simplification in action, comparing the original geometry of the contiguous United States with simplified versions, generated with functions from sf (top-right), rmapshaper (bottom-left), and smoothr (bottom-right) packages.}(\#fig:us-simp)
\end{figure}

### Centroids

\index{vector!centroids} 
Centroid operations identify the center of geographic objects.
Like statistical measures of central tendency (including mean and median definitions of 'average'), there are many ways to define the geographic center of an object.
All of them create single point representations of more complex vector objects.

The most commonly used centroid operation is the *geographic centroid*.
This type of centroid operation (often referred to as 'the centroid') represents the center of mass in a spatial object (think of balancing a plate on your finger).
Geographic centroids have many uses, for example to create a simple point representation of complex geometries, or to estimate distances between polygons.
They can be calculated with the **sf** function `st_centroid()` as demonstrated in the code below, which generates the geographic centroids of regions in New Zealand and tributaries to the River Seine, illustrated with black points in Figure \@ref(fig:centr).


```r
nz_centroid = st_centroid(nz)
seine_centroid = st_centroid(seine)
```

Sometimes the geographic centroid falls outside the boundaries of their parent objects (think of a doughnut).
In such cases *point on surface* operations can be used to guarantee the point will be in the parent object (e.g., for labeling irregular multipolygon objects such as island states), as illustrated by the red points in Figure \@ref(fig:centr).
Notice that these red points always lie on their parent objects.
They were created with `st_point_on_surface()` as follows:^[
A description of how `st_point_on_surface()` works is provided at https://gis.stackexchange.com/q/76498.
]


```r
nz_pos = st_point_on_surface(nz)
seine_pos = st_point_on_surface(seine)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/centr-1} 

}

\caption[Centroid vs point on surface operations.]{Centroids (black points) and 'points on surface' (red points) of New Zealand's regions (left) and the Seine (right) datasets.}(\#fig:centr)
\end{figure}

Other types of centroids exist, including the *Chebyshev center* and the *visual center*.
We will not explore these here but it is possible to calculate them using R, as we'll see in Chapter \@ref(algorithms).

### Buffers

\index{vector!buffers} 
Buffers are polygons representing the area within a given distance of a geometric feature:
regardless of whether the input is a point, line or polygon, the output is a polygon.
Unlike simplification (which is often used for visualization and reducing file size) buffering tends to be used for geographic data analysis.
How many points are within a given distance of this line?
Which demographic groups are within travel distance of this new shop?
These kinds of questions can be answered and visualized by creating buffers around the geographic entities of interest.

Figure \@ref(fig:buffs) illustrates buffers of different sizes (5 and 50 km) surrounding the river Seine and tributaries.
These buffers were created with commands below, which show that the command `st_buffer()` requires at least two arguments: an input geometry and a distance, provided in the units of the CRS (in this case meters):


```r
seine_buff_5km = st_buffer(seine, dist = 5000)
seine_buff_50km = st_buffer(seine, dist = 50000)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.75\linewidth]{05-geometry-operations_files/figure-latex/buffs-1} 

}

\caption[Buffers around the seine dataset.]{Buffers around the Seine dataset of 5 km (left) and 50 km (right). Note the colors, which reflect the fact that one buffer is created per geometry feature.}(\#fig:buffs)
\end{figure}

\BeginKnitrBlock{rmdnote}
The third and final argument of `st_buffer()` is `nQuadSegs`, which means 'number of segments per quadrant' and is set by default to 30 (meaning circles created by buffers are composed of $4 \times 30 = 120$ lines).
This argument rarely needs to be set.
Unusual cases where it may be useful include when the memory consumed by the output of a buffer operation is a major concern (in which case it should be reduced) or when very high precision is needed (in which case it should be increased).
\EndKnitrBlock{rmdnote}



### Affine transformations

\index{vector!affine transformation} 
Affine transformation is any transformation that preserves lines and parallelism.
However, angles or length are not necessarily preserved.
Affine transformations include, among others, shifting (translation), scaling and rotation.
Additionally, it is possible to use any combination of these.
Affine transformations are an essential part of geocomputation.
For example, shifting is needed for labels placement, scaling is used in non-contiguous area cartograms (see Section \@ref(other-mapping-packages)), and many affine transformations are applied when reprojecting or improving the geometry that was created based on a distorted or wrongly projected map.
The **sf** package implements affine transformation for objects of classes `sfg` and `sfc`.


```r
nz_sfc = st_geometry(nz)
```

Shifting moves every point by the same distance in map units.
It could be done by adding a numerical vector to a vector object.
For example, the code below shifts all y-coordinates by 100,000 meters to the north, but leaves the x-coordinates untouched (left panel of Figure \@ref(fig:affine-trans)). 


```r
nz_shift = nz_sfc + c(0, 100000)
```

Scaling enlarges or shrinks objects by a factor.
It can be applied either globally or locally.
Global scaling increases or decreases all coordinates values in relation to the origin coordinates, while keeping all geometries topological relations intact.
It can be done by subtraction or multiplication of a`sfg` or `sfc` object.



Local scaling treats geometries independently and requires points around which geometries are going to be scaled, e.g., centroids.
In the example below, each geometry is shrunk by a factor of two around the centroids (middle panel in Figure \@ref(fig:affine-trans)).
To achieve that, each object is firstly shifted in a way that its center has coordinates of `0, 0` (`(nz_sfc - nz_centroid_sfc)`). 
Next, the sizes of the geometries are reduced by half (`* 0.5`).
Finally, each object's centroid is moved back to the input data coordinates (`+ nz_centroid_sfc`). 


```r
nz_centroid_sfc = st_centroid(nz_sfc)
nz_scale = (nz_sfc - nz_centroid_sfc) * 0.5 + nz_centroid_sfc
```

Rotation of two-dimensional coordinates requires a rotation matrix:

$$
R =
\begin{bmatrix}
\cos \theta & -\sin \theta \\  
\sin \theta & \cos \theta \\
\end{bmatrix}
$$

It rotates points in a clockwise direction.
The rotation matrix can be implemented in R as:


```r
rotation = function(a){
  r = a * pi / 180 #degrees to radians
  matrix(c(cos(r), sin(r), -sin(r), cos(r)), nrow = 2, ncol = 2)
} 
```

The `rotation` function accepts one argument `a` - a rotation angle in degrees.
Rotation could be done around selected points, such as centroids (right panel of Figure \@ref(fig:affine-trans)).
See `vignette("sf3")` for more examples.


```r
nz_rotate = (nz_sfc - nz_centroid_sfc) * rotation(30) + nz_centroid_sfc
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/affine-trans-1} 

}

\caption[Illustrations of affine transformations.]{Illustrations of affine transformations: shift, scale and rotate.}(\#fig:affine-trans)
\end{figure}





Finally, the newly created geometries can replace the old ones with the `st_set_geometry()` function: 


```r
nz_scale_sf = st_set_geometry(nz, nz_scale)
```

### Clipping {#clipping}

\index{vector!clipping} 
\index{spatial!subsetting} 
Spatial clipping is a form of spatial subsetting that involves changes to the `geometry` columns of at least some of the affected features.

Clipping can only apply to features more complex than points: 
lines, polygons and their 'multi' equivalents.
To illustrate the concept we will start with a simple example:
two overlapping circles with a center point one unit away from each other and a radius of one (Figure \@ref(fig:points)).


```r
b = st_sfc(st_point(c(0, 1)), st_point(c(1, 1))) # create 2 points
b = st_buffer(b, dist = 1) # convert points to circles
plot(b, border = "grey")
text(x = c(-0.5, 1.5), y = 1, labels = c("x", "y"), cex = 3) # add text
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/points-1} 

}

\caption{Overlapping circles.}(\#fig:points)
\end{figure}

Imagine you want to select not one circle or the other, but the space covered by both `x` *and* `y`.
This can be done using the function `st_intersection()`\index{vector!intersection}, illustrated using objects named `x` and `y` which represent the left- and right-hand circles (Figure \@ref(fig:circle-intersection)).


```r
x = b[1]
y = b[2]
x_and_y = st_intersection(x, y)
plot(b, border = "grey")
plot(x_and_y, col = "lightgrey", border = "grey", add = TRUE) # intersecting area
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/circle-intersection-1} 

}

\caption[Overlapping circles showing intersection types.]{Overlapping circles with a gray color indicating intersection between them.}(\#fig:circle-intersection)
\end{figure}

The subsequent code chunk demonstrates how this works for all combinations of the 'Venn' diagram representing `x` and `y`, inspired by [Figure 5.1](http://r4ds.had.co.nz/transform.html#logical-operators) of the book *R for Data Science* [@grolemund_r_2016].

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/venn-clip-1} 

}

\caption{Spatial equivalents of logical operators.}(\#fig:venn-clip)
\end{figure}

### Subsetting and clipping

Clipping objects can change their geometry but it can also subset objects, returning only features that intersect (or partly intersect) with a clipping/subsetting object.
To illustrate this point, we will subset points that cover the bounding box of the circles `x` and `y` in Figure \@ref(fig:venn-clip).
Some points will be inside just one circle, some will be inside both and some will be inside neither.
`st_sample()` is used below to generate a *simple random* distribution of points within the extent of circles `x` and `y`, resulting in output illustrated in Figure \@ref(fig:venn-subset), raising the question: how to subset the points to only return the point that intersects with *both* `x` and `y`?

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/venn-subset-1} 

}

\caption[Randomly distributed points within the bounding box. Note that only one point intersects with both x and y, highlighted with a red circle.]{Randomly distributed points within the bounding box enclosing circles x and y. The point that intersects with both objects x and y is highlighted.}(\#fig:venn-subset)
\end{figure}



```r
bb = st_bbox(st_union(x, y))
box = st_as_sfc(bb)
set.seed(2017)
p = st_sample(x = box, size = 10)
x_and_y = st_intersection(x, y)
```

The code chunk below demonstrates three ways to achieve the same result.
We can use the intersection\index{vector!intersection} of `x` and `y` (represented by `x_and_y` in the previous code chunk) as a subsetting object directly, as shown in the first line in the code chunk below.
We can also find the *intersection* between the input points represented by `p` and the subsetting/clipping object `x_and_y`, as demonstrated in the second line in the code chunk below.
This second approach will return features that partly intersect with `x_and_y` but with modified geometries for spatially extensive features that cross the border of the subsetting object.
The third approach is to create a subsetting object using the binary spatial predicate `st_intersects()`, introduced in the previous chapter.
The results are identical (except superficial differences in attribute names), but the implementation differs substantially:


```r
p_xy1 = p[x_and_y]
p_xy2 = st_intersection(p, x_and_y)
sel_p_xy = st_intersects(p, x, sparse = FALSE)[, 1] &
  st_intersects(p, y, sparse = FALSE)[, 1]
p_xy3 = p[sel_p_xy]
```



Although the example above is rather contrived and provided for educational rather than applied purposes, and we encourage the reader to reproduce the results to deepen your understanding for handling geographic vector objects in R, it raises an important question: which implementation to use?
Generally, more concise implementations should be favored, meaning the first approach above.
We will return to the question of choosing between different implementations of the same technique or algorithm in Chapter \@ref(algorithms).

### Geometry unions

\index{vector!union} 
\index{aggregation!spatial} 
As we saw in Section \@ref(vector-attribute-aggregation), spatial aggregation can silently dissolve the geometries of touching polygons in the same group.
This is demonstrated in the code chunk below in which 49 `us_states` are aggregated into 4 regions using base and **tidyverse**\index{tidyverse (package)} functions (see results in Figure \@ref(fig:us-regions)):


```r
regions = aggregate(x = us_states[, "total_pop_15"], by = list(us_states$REGION),
                    FUN = sum, na.rm = TRUE)
regions2 = us_states |> 
  group_by(REGION) |>
  summarize(pop = sum(total_pop_15, na.rm = TRUE))
```



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/us-regions-1} 

}

\caption[Spatial aggregation on contiguous polygons.]{Spatial aggregation on contiguous polygons, illustrated by aggregating the population of US states into regions, with population represented by color. Note the operation automatically dissolves boundaries between states.}(\#fig:us-regions)
\end{figure}

What is going on in terms of the geometries?
Behind the scenes, both `aggregate()` and `summarize()` combine the geometries and dissolve the boundaries between them using `st_union()`.
This is demonstrated in the code chunk below which creates a united western US: 


```r
us_west = us_states[us_states$REGION == "West", ]
us_west_union = st_union(us_west)
```

The function can take two geometries and unite them, as demonstrated in the code chunk below which creates a united western block incorporating Texas (challenge: reproduce and plot the result):


```r
texas = us_states[us_states$NAME == "Texas", ]
texas_union = st_union(us_west_union, texas)
```



### Type transformations {#type-trans}

\index{vector!geometry casting} 
Geometry casting is a powerful operation that enables transformation of the geometry type.
It is implemented in the `st_cast()` function from the **sf** package.
Importantly, `st_cast()` behaves differently on single simple feature geometry (`sfg`) objects, simple feature geometry column (`sfc`) and simple features objects.

Let's create a multipoint to illustrate how geometry casting works on simple feature geometry (`sfg`) objects:


```r
multipoint = st_multipoint(matrix(c(1, 3, 5, 1, 3, 1), ncol = 2))
```

In this case, `st_cast()` can be useful to transform the new object into a linestring or a polygon (Figure \@ref(fig:single-cast)):


```r
linestring = st_cast(multipoint, "LINESTRING")
polyg = st_cast(multipoint, "POLYGON")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/single-cast-1} 

}

\caption[Examples of casting operations.]{Examples of a linestring and a polygon casted from a multipoint geometry.}(\#fig:single-cast)
\end{figure}

Conversion from multipoint to linestring is a common operation that creates a line object from ordered point observations, such as GPS measurements or geotagged media.
This, in turn, allows to perform spatial operations such as the calculation of the length of the path traveled.
Conversion from multipoint or linestring to polygon is often used to calculate an area, for example from the set of GPS measurements taken around a lake or from the corners of a building lot.

The transformation process can be also reversed using `st_cast()`:


```r
multipoint_2 = st_cast(linestring, "MULTIPOINT")
multipoint_3 = st_cast(polyg, "MULTIPOINT")
all.equal(multipoint, multipoint_2)
#> [1] TRUE
all.equal(multipoint, multipoint_3)
#> [1] TRUE
```

\BeginKnitrBlock{rmdnote}
For single simple feature geometries (`sfg`), `st_cast()` also provides geometry casting from non-multi-types to multi-types (e.g., `POINT` to `MULTIPOINT`) and from multi-types to non-multi-types.
However, when casting from multi-types to non-multi-types only the first element of the old object would remain in the output object.
\EndKnitrBlock{rmdnote}



Geometry casting of simple features geometry column (`sfc`) and simple features objects works the same as for `sfg` in most of the cases. 
One important difference is the conversion between multi-types to non-multi-types.
As a result of this process, multi-objects of `sfc` or `sf` are split into many non-multi-objects.

Table \@ref(tab:sfs-st-cast) shows possible geometry type transformations on simple feature objects.
Single simple feature geometries (represented by the first column in the table) can be transformed into multiple geometry types, represented by the columns in Table \@ref(tab:sfs-st-cast).
Some transformations are not possible: you cannot convert a single point into a multilinestring or a polygon, for example, explaining why the cells `[1, 4:5]` in the table contain NA.
Some transformations split single features input into multiple sub-features, 'expanding' `sf` objects (adding new rows with duplicate attribute values).
When a multipoint geometry consisting of five pairs of coordinates is tranformed into a 'POINT' geometry, for example, the output will contain five features.

\begin{table}

\caption[Geometry casting on simple feature geometries.]{(\#tab:sfs-st-cast)Geometry casting on simple feature geometries (see Section 2.1) with input type by row and output type by column}
\centering
\begin{tabular}[t]{lrrrrrrr}
\toprule
 & POI & MPOI & LIN & MLIN & POL & MPOL & GC\\
\midrule
POI(1) & 1 & 1 & 1 & NA & NA & NA & NA\\
MPOI(1) & 4 & 1 & 1 & 1 & 1 & NA & NA\\
LIN(1) & 5 & 1 & 1 & 1 & 1 & NA & NA\\
MLIN(1) & 7 & 2 & 2 & 1 & NA & NA & NA\\
POL(1) & 5 & 1 & 1 & 1 & 1 & 1 & NA\\
\addlinespace
MPOL(1) & 10 & 1 & NA & 1 & 2 & 1 & 1\\
GC(1) & 9 & 1 & NA & NA & NA & NA & 1\\
\bottomrule
\multicolumn{8}{l}{\textsuperscript{} Note: Values like (1) represent the number of features;}\\
\multicolumn{8}{l}{NA means the operation is not possible. Abbreviations:}\\
\multicolumn{8}{l}{POI, LIN, POL and GC refer to POINT, LINESTRING, POLYGON}\\
\multicolumn{8}{l}{and GEOMETRYCOLLECTION. The MULTI version of these}\\
\multicolumn{8}{l}{geometry types is indicated by a preceding M, e.g., MPOI}\\
\multicolumn{8}{l}{is the acronym for MULTIPOINT.}\\
\end{tabular}
\end{table}

Let's try to apply geometry type transformations on a new object, `multilinestring_sf`, as an example (on the left in Figure \@ref(fig:line-cast)):


```r
multilinestring_list = list(matrix(c(1, 4, 5, 3), ncol = 2), 
                            matrix(c(4, 4, 4, 1), ncol = 2),
                            matrix(c(2, 4, 2, 2), ncol = 2))
multilinestring = st_multilinestring(multilinestring_list)
multilinestring_sf = st_sf(geom = st_sfc(multilinestring))
multilinestring_sf
#> Simple feature collection with 1 feature and 0 fields
#> Geometry type: MULTILINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 1 ymin: 1 xmax: 4 ymax: 5
#> CRS:           NA
#>                             geom
#> 1 MULTILINESTRING ((1 5, 4 3)...
```

You can imagine it as a road or river network. 
The new object has only one row that defines all the lines.
This restricts the number of operations that can be done, for example it prevents adding names to each line segment or calculating lengths of single lines.
The `st_cast()` function can be used in this situation, as it separates one mutlilinestring into three linestrings:


```r
linestring_sf2 = st_cast(multilinestring_sf, "LINESTRING")
linestring_sf2
#> Simple feature collection with 3 features and 0 fields
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 1 ymin: 1 xmax: 4 ymax: 5
#> CRS:           NA
#>                    geom
#> 1 LINESTRING (1 5, 4 3)
#> 2 LINESTRING (4 4, 4 1)
#> 3 LINESTRING (2 2, 4 2)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/line-cast-1} 

}

\caption[Examples of type casting.]{Examples of type casting between MULTILINESTRING (left) and LINESTRING (right).}(\#fig:line-cast)
\end{figure}

The newly created object allows for attributes creation (see more in Section \@ref(vec-attr-creation)) and length measurements:


```r
linestring_sf2$name = c("Riddle Rd", "Marshall Ave", "Foulke St")
linestring_sf2$length = st_length(linestring_sf2)
linestring_sf2
#> Simple feature collection with 3 features and 2 fields
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 1 ymin: 1 xmax: 4 ymax: 5
#> CRS:           NA
#>                    geom         name length
#> 1 LINESTRING (1 5, 4 3)    Riddle Rd   3.61
#> 2 LINESTRING (4 4, 4 1) Marshall Ave   3.00
#> 3 LINESTRING (2 2, 4 2)    Foulke St   2.00
```

## Geometric operations on raster data {#geo-ras}

\index{raster!manipulation} 
Geometric raster operations include the shift, flipping, mirroring, scaling, rotation or warping of images.
These operations are necessary for a variety of applications including georeferencing, used to allow images to be overlaid on an accurate map with a known CRS [@liu_essential_2009].
A variety of georeferencing techniques exist, including:

- Georectification based on known [ground control points](https://www.qgistutorials.com/en/docs/3/georeferencing_basics.html)
- Orthorectification, which also accounts for local topography
- Image [registration](https://en.wikipedia.org/wiki/Image_registration) is used to combine images of the same thing but shot from different sensors by aligning one image with another (in terms of coordinate system and resolution)

R is rather unsuitable for the first two points since these often require manual intervention which is why they are usually done with the help of dedicated GIS software (see also Chapter \@ref(gis)).
On the other hand, aligning several images is possible in R and this section shows among others how to do so.
This often includes changing the extent, the resolution and the origin of an image.
A matching projection is of course also required but is already covered in Section \@ref(reproj-ras).

In any case, there are other reasons to perform a geometric operation on a single raster image.
For instance, in Chapter \@ref(location) we define metropolitan areas in Germany as 20 km^2^ pixels with more than 500,000 inhabitants. 
The original inhabitant raster, however, has a resolution of 1 km^2^ which is why we will decrease (aggregate) the resolution by a factor of 20 (see Section \@ref(define-metropolitan-areas)).
Another reason for aggregating a raster is simply to decrease run-time or save disk space.
Of course, this approach is only recommended if the task at hand allows a coarser resolution of raster data.

### Geometric intersections

\index{raster!intersection} 
In Section \@ref(spatial-raster-subsetting) we have shown how to extract values from a raster overlaid by other spatial objects.
To retrieve a spatial output, we can use almost the same subsetting syntax.
The only difference is that we have to make clear that we would like to keep the matrix structure by setting the `drop` argument to `FALSE`.
This will return a raster object containing the cells whose midpoints overlap with `clip`.


```r
elev = rast(system.file("raster/elev.tif", package = "spData"))
clip = rast(xmin = 0.9, xmax = 1.8, ymin = -0.45, ymax = 0.45,
            resolution = 0.3, vals = rep(1, 9))
elev[clip, drop = FALSE]
#> class       : SpatRaster 
#> dimensions  : 2, 1, 1  (nrow, ncol, nlyr)
#> resolution  : 0.5, 0.5  (x, y)
#> extent      : 1, 1.5, -0.5, 0.5  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#> source      : memory 
#> name        : elev 
#> min value   :   18 
#> max value   :   24
```

For the same operation we can also use the `intersect()` and `crop()` command.

### Extent and origin

\index{raster!merging} 
When merging or performing map algebra on rasters, their resolution, projection, origin and/or extent have to match. Otherwise, how should we add the values of one raster with a resolution of 0.2 decimal degrees to a second raster with a resolution of 1 decimal degree?
The same problem arises when we would like to merge satellite imagery from different sensors with different projections and resolutions. 
We can deal with such mismatches by aligning the rasters.

In the simplest case, two images only differ with regard to their extent.
Following code adds one row and two columns to each side of the raster while setting all new values to `NA` (Figure \@ref(fig:extend-example)).


```r
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_2 = extend(elev, c(1, 2))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/extend-example-1} 

}

\caption[Extending rasters.]{Original raster (left) and the same raster (right) extended by one row on the top and bottom and two columns on the left and right.}(\#fig:extend-example)
\end{figure}

Performing an algebraic operation on two objects with differing extents in R, the **terra** package returns an error.


```r
elev_3 = elev + elev_2
#> Error: [+] extents do not match
```

However, we can align the extent of two rasters with `extend()`. 
Instead of telling the function how many rows or columns should be added (as done before), we allow it to figure it out by using another raster object.
Here, we extend the `elev` object to the extent of `elev_2`. 
The newly added rows and column receive the `NA`.


```r
elev_4 = extend(elev, elev_2)
```

The origin of a raster is the cell corner closest to the coordinates (0, 0).
The `origin()` function returns the coordinates of the origin.
In the below example a cell corner exists with coordinates (0, 0), but that is not necessarily the case.


```r
origin(elev_4)
#> [1] 0 0
```

If two rasters have different origins, their cells do not overlap completely which would make map algebra impossible.
To change the origin -- use `origin()`.^[
If the origins of two raster datasets are just marginally apart, it sometimes is sufficient to simply increase the `tolerance` argument  of `terra::terraOptions()`.
]
Figure \@ref(fig:origin-example) reveals the effect of changing the origin in this way.


```r
# change the origin
origin(elev_4) = c(0.25, 0.25)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/origin-example-1} 

}

\caption{Rasters with identical values but different origins.}(\#fig:origin-example)
\end{figure}

Note that changing the resolution (next section) frequently also changes the origin.

### Aggregation and disaggregation

\index{raster!aggregation} 
\index{raster!disaggregation} 
Raster datasets can also differ with regard to their resolution. 
To match resolutions, one can either decrease  (`aggregate()`) or increase (`disagg()`) the resolution of one raster.^[
Here we refer to spatial resolution.
In remote sensing the spectral (spectral bands), temporal (observations through time of the same area) and radiometric (color depth) resolution are also important.
Check out the `tapp()` example in the documentation for getting an idea on how to do temporal raster aggregation.
]
As an example, we here change the spatial resolution of `dem` (found in the **spDataLarge** package) by a factor of 5 (Figure \@ref(fig:aggregate-example)).
Additionally, the output cell value should correspond to the mean of the input cells (note that one could use other functions as well, such as `median()`, `sum()`, etc.):


```r
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
dem_agg = aggregate(dem, fact = 5, fun = mean)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/aggregate-example-1} 

}

\caption{Original raster (left). Aggregated raster (right).}(\#fig:aggregate-example)
\end{figure}

The `disagg()` function increases the resolution of raster objects, providing two a methods for assigning values to the newly created cells: the default method (`method = "near"`) simply gives all output cells the value of the input cell, and hence duplicates values, leading to a 'blocky' output.
The `bilinear` method uses the four nearest pixel centers of the input image (salmon colored points in Figure \@ref(fig:bilinear)) to compute an average weighted by distance (arrows in Figure \@ref(fig:bilinear).
The value of the output cell is represented by a square in the upper left corner in Figure \@ref(fig:bilinear)).


```r
dem_disagg = disagg(dem_agg, fact = 5, method = "bilinear")
identical(dem, dem_disagg)
#> [1] FALSE
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/bilinear-1} 

}

\caption[Bilinear disaggregation in action.]{The distance-weighted average of the four closest input cells determine the output when using the bilinear method for disaggregation.}(\#fig:bilinear)
\end{figure}

Comparing the values of `dem` and `dem_disagg` tells us that they are not identical (you can also use `compareGeom()` or `all.equal()`).
However, this was hardly to be expected, since disaggregating is a simple interpolation technique.
It is important to keep in mind that disaggregating results in a finer resolution; the corresponding values, however, are only as accurate as their lower resolution source.

### Resampling

\index{raster!resampling}
The above methods of aggregation and disaggregation are only suitable when we want to change the resolution of our raster by the aggregation/disaggregation factor. 
However, what to do when we have two or more rasters with different resolutions and origins?
This is the role of resampling -- a process of computing values for new pixel locations.
In short, this process takes the values of our original raster and recalculates new values for a target raster with custom resolution and origin.

<!--toDo: jn-->
<!-- consider if adding this new figure makes sense -->




There are several methods for estimating values for a raster with different resolutions/origins, as shown in Figure \@ref(fig:resampl).
The main resampling methods include:

- Nearest neighbor: assigns the value of the nearest cell of the original raster to the cell of the target one. This is a fast simple technique that is usually suitable for resampling categorical rasters.
- Bilinear interpolation: assigns a weighted average of the four nearest cells from the original raster to the cell of the target one (Figure \@ref(fig:bilinear)). This is the fastest method that is appropriate for continuous rasters.
- Cubic interpolation: uses values of 16 nearest cells of the original raster to determine the output cell value, applying third-order polynomial functions. Used for continuous rasters and results in a smoother surface that results bilinear interpolation, but is more computationally intensive.
- Cubic spline interpolation: also uses values of 16 nearest cells of the original raster to determine output cell, but applies cubic splines (piecewise third-order polynomial functions) to derive the results. Used for continuous rasters.
- Lanczos windowed sinc resampling: uses values of 36 nearest cells of the original raster to determine the output cell value. Used for continuous rasters.^[
More detailed explanation of this method can be found at https://gis.stackexchange.com/a/14361/20955.
]

The above explanation highlights that only *nearest neighbor* resampling is suitable for categorical rasters, while all the methods can be used (with different outcomes) for continuous rasters.
Additionally, each successive method requires more processing time.

To apply resampling, the **terra** package provides a `resample()` function.
It accepts an input raster (`x`), a raster with target spatial properties (`y`), and a resampling method (`method`).

We need a raster with target spatial properties to see how the `resample()` function works.
For this example, we create `target_rast`, but you would often use an already existing raster object.


```r
target_rast = rast(xmin = 794600, xmax = 798200, 
                   ymin = 8931800, ymax = 8935400,
                   resolution = 150, crs = "EPSG:32717")
```

Next, we need to provide our two raster objects as the first two arguments and one of the resampling methods described above.


```r
dem_resampl = resample(dem, y = target_rast, method = "bilinear")
```

Figure \@ref(fig:resampl) shows a comparison of different resampling methods on the `dem` object.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{05-geometry-operations_files/figure-latex/resampl-1} 

}

\caption{Visual comparison of the original raster and five different resampling methods.}(\#fig:resampl)
\end{figure}

The `resample()` function also has some additional resampling methods, including `sum`, `min`, `q1`, `med`, `q3`, `max`, `average`, `mode`, and `rms`.
All of them calculate a given statistic based on the values of all non-NA contributing grid cells.
For example, `sum` is useful when each raster cell represents a spatially extensive variable (e.g., number of people).
As an effect of using `sum`, the resampled raster should have the sample total number of people as the original one.

As you will see in section \@ref(reproj-ras), raster reprojection is a special case of resampling when our target raster has a different CRS than the original raster.

\index{GDAL}
\BeginKnitrBlock{rmdnote}
Most geometry operations in **terra** are user-friendly, rather fast, and work on large raster objects.
However, there could be some cases, when **terra** is not the most performant either for extensive rasters or many raster files, and some alternatives should be considered.

The most established alternatives come with the GDAL library.
It contains several utility functions, including:

- `gdalinfo` - lists various information about a raster file, including its resolution, CRS, bounding box, and more
- `gdal_translate` - converts raster data between different file formats
- `gdal_rasterize` - converts vector data into raster files
- `gdalwarp` - allows for raster mosaicing, resampling, cropping, and reprojecting

All of the above functions are written in C++, but can be called in R using the **gdalUtilities** package.
Importantly, all of these functions expect a raster file path as an input and often return their output as a raster file (for example, `gdalUtilities::gdal_translate("my_file.tif", "new_file.tif", t_srs = "EPSG:4326")`)
This is very different from the usual **terra** approach, which expects `SpatRaster` objects as inputs.
\EndKnitrBlock{rmdnote}

## Exercises


E1. Generate and plot simplified versions of the `nz` dataset.
Experiment with different values of `keep` (ranging from 0.5 to 0.00005) for `ms_simplify()` and `dTolerance` (from 100 to 100,000) `st_simplify()`.

- At what value does the form of the result start to break down for each method, making New Zealand unrecognizable?
- Advanced: What is different about the geometry type of the results from `st_simplify()` compared with the geometry type of `ms_simplify()`? What problems does this create and how can this be resolved?



E2. In the first exercise in Chapter Spatial data operations it was established that Canterbury region had 70 of the 101 highest points in New Zealand. 
Using `st_buffer()`, how many points in `nz_height` are within 100 km of Canterbury?



E3. Find the geographic centroid of New Zealand. 
How far is it from the geographic centroid of Canterbury?



E4. Most world maps have a north-up orientation.
A world map with a south-up orientation could be created by a reflection (one of the affine transformations not mentioned in this chapter) of the `world` object's geometry.
Write code to do so.
Hint: you need to use a two-element vector for this transformation.
 Bonus: create an upside-down map of your country.
 


E5. Run the code in Section [5.2.6](https://geocompr.robinlovelace.net/geometric-operations.html#subsetting-and-clipping). With reference to the objects created in that section, subset the point in `p` that is contained within `x` *and* `y`.

- Using base subsetting operators.
- Using an intermediary object created with `st_intersection()`\index{vector!intersection}.





E6. Calculate the length of the boundary lines of US states in meters.
Which state has the longest border and which has the shortest?
Hint: The `st_length` function computes the length of a `LINESTRING` or `MULTILINESTRING` geometry.



E7. Read the srtm.tif file into R (`srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))`).
This raster has a resolution of 0.00083 by 0.00083 degrees. 
Change its resolution to 0.01 by 0.01 degrees using all of the method available in the **terra** package.
Visualize the results.
Can you notice any differences between the results of these resampling methods?

<!--chapter:end:05-geometry-operations.Rmd-->

# Raster-vector interactions {#raster-vector}

This chapter requires the following packages:


```r
library(dplyr)
library(terra)
library(sf)
```

## Introduction

\index{raster-vector!interactions} 
This Chapter focuses on interactions between raster and vector geographic data models, introduced in Chapter \@ref(spatial-class).
It includes four main techniques:
raster cropping and masking using vector objects (Section \@ref(raster-cropping));
extracting raster values using different types of vector data (Section \@ref(raster-extraction));
and raster-vector conversion (Sections \@ref(rasterization) and \@ref(spatial-vectorization)).
The above concepts are demonstrated using data used in previous chapters to understand their potential real-world applications.

## Raster cropping

\index{raster-vector!raster cropping} 
Many geographic data projects involve integrating data from many different sources, such as remote sensing images (rasters) and administrative boundaries (vectors).
Often the extent of input raster datasets is larger than the area of interest.
In this case raster **cropping** and **masking** are useful for unifying the spatial extent of input data.
Both operations reduce object memory use and associated computational resources for subsequent analysis steps, and may be a necessary preprocessing step before creating attractive maps involving raster data.

We will use two objects to illustrate raster cropping:

- A `SpatRaster` object `srtm` representing elevation (meters above sea level) in south-western Utah
- A vector (`sf`) object `zion` representing Zion National Park

Both target and cropping objects must have the same projection.
The following code chunk therefore not only reads the datasets from the **spDataLarge** package installed in Chapter \@ref(spatial-class), it also 'reprojects' `zion` (a topic covered in Chapter \@ref(reproj-geo-data)):


```r
srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, crs(srtm))
```

We use `crop()` from the **terra** package to crop the `srtm` raster.
The function reduces the rectangular extent of the object passed to its first argument based on the extent of the object passed to its second argument.
This functionality is demonstrated in the command below, which generates Figure \@ref(fig:cropmask)(B) (note the use of the **terra** function `vect()` to convert the `sf` object `zion` into `zion_vect` which contains the same data but stored in **terra**'s `SpatVector` class for geographic vector data):


```r
zion_vect = vect(zion)
srtm_cropped = crop(srtm, zion_vect)
```

\index{raster-vector!raster masking} 
Related to `crop()` is the **terra** function `mask()`, which sets values outside of the bounds of the object passed to its second argument to `NA`.
The following command therefore masks every cell outside of the Zion National Park boundaries (Figure \@ref(fig:cropmask)(C)):


```r
srtm_masked = mask(srtm, zion_vect)
```

Importantly, we want to use both `crop()` and `mask()` together in most cases. 
This combination of functions would (a) limit the raster's extent to our area of interest and then (b) replace all of the values outside of the area to NA.


```r
srtm_cropped = crop(srtm, zion_vect)
srtm_final = mask(srtm_cropped, zion_vect)
```

Changing the settings of `mask()` yields different results.
Setting `updatevalue = 0`, for example, will set all pixels outside the national park to 0.
Setting `inverse = TRUE` will mask everything *inside* the bounds of the park (see `?mask` for details) (Figure \@ref(fig:cropmask)(D)).


```r
srtm_inv_masked = mask(srtm, zion_vect, inverse = TRUE)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/cropmask-1} 

}

\caption{Illustration of raster cropping and raster masking.}(\#fig:cropmask)
\end{figure}

## Raster extraction

<!--jn:toDo-->
<!-- two possibilities: -->
<!-- 1. explain the need of the use of `vect()` -->
<!-- 2. wait for https://github.com/rspatial/terra/issues/89 -->

\index{raster-vector!raster extraction} 
Raster extraction is the process of identifying and returning the values associated with a 'target' raster at specific locations, based on a (typically vector) geographic 'selector' object.
The results depend on the type of selector used (points, lines or polygons) and arguments passed to the `terra::extract()` function, which we use to demonstrate raster extraction.
The reverse of raster extraction --- assigning raster cell values based on vector objects --- is rasterization, described in Section \@ref(rasterization).

The basic example is of extracting the value of a raster cell at specific **points**.
For this purpose, we will use `zion_points`, which contain a sample of 30 locations within the Zion National Park (Figure \@ref(fig:pointextr)). 
The following command extracts elevation values from `srtm` and creates a data frame with points' IDs (one value per vector's row) and related `srtm` values for each point.
Now, we can add the resulting object to our `zion_points` dataset with the `cbind()` function: 


```r
data("zion_points", package = "spDataLarge")
elevation = terra::extract(srtm, vect(zion_points))
zion_points = cbind(zion_points, elevation)
```



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/pointextr-1} 

}

\caption{Locations of points used for raster extraction.}(\#fig:pointextr)
\end{figure}

Raster extraction also works with **line** selectors.
Then, it extracts one value for each raster cell touched by a line.
However, the line extraction approach is not recommended to obtain values along the transects as it is hard to get the correct distance between each pair of extracted raster values.

In this case, a better approach is to split the line into many points and then extract the values for these points.
To demonstrate this, the code below creates `zion_transect`, a straight line going from northwest to southeast of the Zion National Park, illustrated in Figure \@ref(fig:lineextr)(A) (see Section \@ref(vector-data) for a recap on the vector data model):

<!--toDo:jn-->
<!--fix pipes-->


```r
zion_transect = cbind(c(-113.2, -112.9), c(37.45, 37.2)) |>
  st_linestring() |> 
  st_sfc(crs = crs(srtm)) |>
  st_sf(geometry = _)
```



The utility of extracting heights from a linear selector is illustrated by imagining that you are planning a hike.
The method demonstrated below provides an 'elevation profile' of the route (the line does not need to be straight), useful for estimating how long it will take due to long climbs.

The first step is to add a unique `id` for each transect.
Next, with the `st_segmentize()` function we can add points along our line(s) with a provided density (`dfMaxLength`) and convert them into points with `st_cast()`.


```r
zion_transect$id = 1:nrow(zion_transect)
zion_transect = st_segmentize(zion_transect, dfMaxLength = 250)
zion_transect = st_cast(zion_transect, "POINT")
```

Now, we have a large set of points, and we want to derive a distance between the first point in our transects and each of the subsequent points. 
In this case, we only have one transect, but the code, in principle, should work on any number of transects:


```r
zion_transect = zion_transect |> 
  group_by(id) |> 
  mutate(dist = st_distance(geometry)[, 1]) 
```

Finally, we can extract elevation values for each point in our transects and combine this information with our main object.


```r
zion_elev = terra::extract(srtm, vect(zion_transect))
zion_transect = cbind(zion_transect, zion_elev)
```

The resulting `zion_transect` can be used to create elevation profiles, as illustrated in Figure \@ref(fig:lineextr)(B).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/lineextr-1} 

}

\caption[Line-based raster extraction.]{Location of a line used for raster extraction (left) and the elevation along this line (right).}(\#fig:lineextr)
\end{figure}

The final type of geographic vector object for raster extraction is **polygons**.
Like lines, polygons tend to return many raster values per polygon.
This is demonstrated in the command below, which results in a data frame with column names `ID` (the row number of the polygon) and `srtm` (associated elevation values):

<!--toDo:jn-->
<!--fix pipes-->





```r
zion_srtm_values = terra::extract(x = srtm, y = zion_vect)
```

Such results can be used to generate summary statistics for raster values per polygon, for example to characterize a single region or to compare many regions.
The generation of summary statistics is demonstrated in the code below, which creates the object `zion_srtm_df` containing summary statistics for elevation values in Zion National Park (see Figure \@ref(fig:polyextr)(A)):


```r
group_by(zion_srtm_values, ID) |> 
  summarize(across(srtm, list(min = min, mean = mean, max = max)))
#> # A tibble: 1 x 4
#>      ID srtm_min srtm_mean srtm_max
#>   <dbl>    <int>     <dbl>    <int>
#> 1     1     1122     1818.     2661
```

<!--jn:toDo -->
<!--should we use the tidyverse name or dplyr here?-->
<!--btw we could also add reference to the tidyverse paper somewhere in the book-->

The preceding code chunk used the **tidyverse**\index{tidyverse (package)} to provide summary statistics for cell values per polygon ID, as described in Chapter \@ref(attr).
The results provide useful summaries, for example that the maximum height in the park is around 2,661 meters above see level (other summary statistics, such as standard deviation, can also be calculated in this way).
Because there is only one polygon in the example a data frame with a single row is returned; however, the method works when multiple selector polygons are used.

The similar approach works for counting occurrences of categorical raster values within polygons.
This is illustrated with a land cover dataset (`nlcd`) from the **spDataLarge** package in Figure \@ref(fig:polyextr)(B), and demonstrated in the code below:


```r
nlcd = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
zion2 = st_transform(zion, st_crs(nlcd))
zion_nlcd = terra::extract(nlcd, vect(zion2))
zion_nlcd |> 
  group_by(ID, levels) |>
  count()
#> # A tibble: 7 x 3
#> # Groups:   ID, levels [7]
#>      ID levels         n
#>   <dbl> <fct>      <int>
#> 1     1 Developed   4205
#> 2     1 Barren     98285
#> 3     1 Forest    298299
#> 4     1 Shrubland 203701
#> # ... with 3 more rows
#> # i Use `print(n = ...)` to see more rows
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/polyextr-1} 

}

\caption{Area used for continuous (left) and categorical (right) raster extraction.}(\#fig:polyextr)
\end{figure}

Although the **terra** package offers rapid extraction of raster values within polygons, `extract()` can still be a bottleneck when processing large polygon datasets.
The **exactextractr** package offers a [significantly faster alternative](https://github.com/Robinlovelace/geocompr/issues/813) for extracting pixel values through the `exact_extract()` function. 
The `exact_extract()` function also computes, by default, the fraction of each raster cell overlapped by the polygon, which is more precise (see note below for details). 

\BeginKnitrBlock{rmdnote}
Polygons usually have irregular shapes, and therefore, a polygon can overlap only some parts of a raster's cells. 
To get more detailed results, the `extract()` function has an argument called `exact`. 
With `exact = TRUE`, we get one more column `fraction` in the output data frame, which contains a fraction of each cell that is covered by the polygon.
This could be useful to calculate a weighted mean for continuous rasters or more precise coverage for categorical rasters.
By default, it is `FALSE` as this operation requires more computations. 
The `exactextractr::exact_extract()` function always computes the coverage fraction of the polygon in each cell.
\EndKnitrBlock{rmdnote}



<!--toDo:JN-->
<!-- mention https://github.com/isciences/exactextractr -->

## Rasterization {#rasterization}

\index{raster-vector!rasterization} 
Rasterization is the conversion of vector objects into their representation in raster objects.
Usually, the output raster is used for quantitative analysis (e.g., analysis of terrain) or modeling.
As we saw in Chapter \@ref(spatial-class) the raster data model has some characteristics that make it conducive to certain methods.
Furthermore, the process of rasterization can help simplify datasets because the resulting values all have the same spatial resolution: rasterization can be seen as a special type of geographic data aggregation.

The **terra** package contains the function `rasterize()` for doing this work.
Its first two arguments are, `x`, vector object to be rasterized and, `y`, a 'template raster' object defining the extent, resolution and CRS of the output.
The geographic resolution of the input raster has a major impact on the results: if it is too low (cell size is too large), the result may miss the full geographic variability of the vector data; if it is too high, computational times may be excessive.
There are no simple rules to follow when deciding an appropriate geographic resolution, which is heavily dependent on the intended use of the results.
Often the target resolution is imposed on the user, for example when the output of rasterization needs to be aligned to the existing raster.

To demonstrate rasterization in action, we will use a template raster that has the same extent and CRS as the input vector data `cycle_hire_osm_projected` (a dataset on cycle hire points in London is illustrated in Figure \@ref(fig:vector-rasterization1)(A)) and spatial resolution of 1000 meters:


```r
cycle_hire_osm = spData::cycle_hire_osm
cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
raster_template = rast(ext(cycle_hire_osm_projected), resolution = 1000,
                       crs = st_crs(cycle_hire_osm_projected)$wkt)
```

Rasterization is a very flexible operation: the results depend not only on the nature of the template raster, but also on the type of input vector (e.g., points, polygons) and a variety of arguments taken by the `rasterize()` function.

To illustrate this flexibility we will try three different approaches to rasterization.
First, we create a raster representing the presence or absence of cycle hire points (known as presence/absence rasters).
In this case `rasterize()` requires only one argument in addition to `x` and `y` (the aforementioned vector and raster objects): a value to be transferred to all non-empty cells specified by `field` (results illustrated Figure \@ref(fig:vector-rasterization1)(B)).


```r
ch_raster1 = rasterize(vect(cycle_hire_osm_projected), raster_template,
                       field = 1)
```

The `fun` argument specifies summary statistics used to convert multiple observations in close proximity into associate cells in the raster object.
By default `fun = "last"` is used but other options such as `fun = "length"` can be used, in this case to count the number of cycle hire points in each grid cell (the results of this operation are illustrated in Figure \@ref(fig:vector-rasterization1)(C)).


```r
ch_raster2 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                       fun = "length")
```

The new output, `ch_raster2`, shows the number of cycle hire points in each grid cell.
The cycle hire locations have different numbers of bicycles described by the `capacity` variable, raising the question, what's the capacity in each grid cell?
To calculate that we must `sum` the field (`"capacity"`), resulting in output illustrated in Figure \@ref(fig:vector-rasterization1)(D), calculated with the following command (other summary functions such as `mean` could be used):


```r
ch_raster3 = rasterize(vect(cycle_hire_osm_projected), raster_template, 
                       field = "capacity", fun = sum)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/vector-rasterization1-1} 

}

\caption{Examples of point rasterization.}(\#fig:vector-rasterization1)
\end{figure}

Another dataset based on California's polygons and borders (created below) illustrates rasterization of lines.
After casting the polygon objects into a multilinestring, a template raster is created with a resolution of a 0.5 degree:


```r
california = dplyr::filter(us_states, NAME == "California")
california_borders = st_cast(california, "MULTILINESTRING")
raster_template2 = rast(ext(california), resolution = 0.5,
                        crs = st_crs(california)$wkt)
```

When considering line or polygon rasterization, one useful additional argument is `touches`.
By default it is `FALSE`, but when changed to `TRUE` -- all cells that are touched by a line or polygon border get a value.
Line rasterization with `touches = TRUE` is demonstrated in the code below (Figure \@ref(fig:vector-rasterization2)(A)).


```r
california_raster1 = rasterize(vect(california_borders), raster_template2,
                               touches = TRUE)
```

Compare it to a polygon rasterization, with `touches = FALSE` by default, which selects only cells whose centroids are inside the selector polygon, as illustrated in Figure \@ref(fig:vector-rasterization2)(B).


```r
california_raster2 = rasterize(vect(california), raster_template2) 
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/vector-rasterization2-1} 

}

\caption{Examples of line and polygon rasterizations.}(\#fig:vector-rasterization2)
\end{figure}

## Spatial vectorization

\index{raster-vector!spatial vectorization} 
Spatial vectorization is the counterpart of rasterization (Section \@ref(rasterization)), but in the opposite direction.
It involves converting spatially continuous raster data into spatially discrete vector data such as points, lines or polygons.

\BeginKnitrBlock{rmdnote}
Be careful with the wording!
In R, vectorization refers to the possibility of replacing `for`-loops and alike by doing things like `1:10 / 2` (see also @wickham_advanced_2019).
\EndKnitrBlock{rmdnote}

The simplest form of vectorization is to convert the centroids of raster cells into points.
`as.points()` does exactly this for all non-`NA` raster grid cells (Figure \@ref(fig:raster-vectorization1)).
Note, here we also used `st_as_sf()` to convert the resulting object to the `sf` class.


```r
elev = rast(system.file("raster/elev.tif", package = "spData"))
elev_point = as.points(elev) |> 
  st_as_sf()
```


\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/raster-vectorization1-1} 

}

\caption{Raster and point representation of the elev object.}(\#fig:raster-vectorization1)
\end{figure}

Another common type of spatial vectorization is the creation of contour lines representing lines of continuous height or temperatures (isotherms) for example.
We will use a real-world digital elevation model (DEM) because the artificial raster `elev` produces parallel lines (task for the reader: verify this and explain why this happens).
Contour lines can be created with the **terra** function `as.contour()`, which is itself a wrapper around `filled.contour()`, as demonstrated below (not shown):


```r
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
cl = as.contour(dem)
plot(dem, axes = FALSE)
plot(cl, add = TRUE)
```

Contours can also be added to existing plots with functions such as `contour()`, `rasterVis::contourplot()` or `tmap::tm_iso()`.
As illustrated in Figure \@ref(fig:contour-tmap), isolines can be labelled.

\index{hillshade}

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/05-contour-tmap} 

}

\caption[DEM with hillshading.]{DEM with hillshading, showing the southern flank of Mt. Mongón overlaid with contour lines.}(\#fig:contour-tmap)
\end{figure}

The final type of vectorization involves conversion of rasters to polygons.
This can be done with `terra::as.polygons()`, which converts each raster cell into a polygon consisting of five coordinates, all of which are stored in memory (explaining why rasters are often fast compared with vectors!).

This is illustrated below by converting the `grain` object into polygons and subsequently dissolving borders between polygons with the same attribute values (also see the `dissolve` argument in `as.polygons()`).


```r
grain = rast(system.file("raster/grain.tif", package = "spData"))
grain_poly = as.polygons(grain) |> 
  st_as_sf()
```

The aggregated polygons of the `grain` dataset have rectilinear boundaries which arise from being defined by connecting rectangular pixels.
The **smoothr** package described in Chapter \@ref(geometric-operations) can be used to smooth the edges of the polygons.
As smoothing removes sharp edges in the polygon boundaries, the smoothed polygons will not have the same exact spatial coverage as the original pixels (see the **smoothr** [website](https://strimas.com/smoothr/) for examples).
Caution should therefore be taken when using the smoothed polygons for further analysis.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{06-raster-vector_files/figure-latex/06-raster-vector-40-1} 

}

\caption[Illustration of vectorization.]{Illustration of vectorization of raster (left) into polygons (dissolve = FALSE; center) and aggregated polygons (dissolve = TRUE; right).}(\#fig:06-raster-vector-40)
\end{figure}

## Exercises


Some of the exercises use a vector (`zion_points`) and raster dataset (`srtm`) from the **spDataLarge** package.
They also use a polygonal 'convex hull' derived from the vector dataset (`ch`) to represent the area of interest:

```r
library(sf)
library(terra)
library(spData)
zion_points_path = system.file("vector/zion_points.gpkg", package = "spDataLarge")
zion_points = read_sf(zion_points_path)
srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
ch = st_combine(zion_points) |>
  st_convex_hull() |> 
  st_as_sf()
```

E1. Crop the `srtm` raster using (1) the `zion_points` dataset and (2) the `ch` dataset.
Are there any differences in the output maps?
Next, mask `srtm` using these two datasets.
Can you see any difference now?
How can you explain that?



E2. Firstly, extract values from `srtm` at the points represented in `zion_points`.
Next, extract average values of `srtm` using a 90 buffer around each point from `zion_points` and compare these two sets of values. 
When would extracting values by buffers be more suitable than by points alone?

- Bonus: Implement extraction using the **exactextractr** package and compare the results.



E3. Subset points higher than 3100 meters in New Zealand (the `nz_height` object) and create a template raster with a resolution of 3 km for the extent of the new point dataset. 
Using these two new objects:

- Count numbers of the highest points in each grid cell.
- Find the maximum elevation in each grid cell.



E4. Aggregate the raster counting high points in New Zealand (created in the previous exercise), reduce its geographic resolution by half (so cells are 6 by 6 km) and plot the result.

- Resample the lower resolution raster back to the original resolution of 3 km. How have the results changed?
- Name two advantages and disadvantages of reducing raster resolution.





E5. Polygonize the `grain` dataset and filter all squares representing clay.



- Name two advantages and disadvantages of vector data over raster data.
- When would it be useful to convert rasters to vectors in your work?

<!--chapter:end:06-raster-vector.Rmd-->

# Reprojecting geographic data {#reproj-geo-data}

## Prerequisites {-}

- This chapter requires the following packages:

<!-- TODO: remove warning=FALSE in next chunk to suppress the following message: -->
<!-- #> Warning: multiple methods tables found for 'gridDistance' -->

```r
library(sf)
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)
```

## Introduction {#reproj-intro}

Section \@ref(crs-intro) introduced coordinate reference systems (CRSs), with a focus on the two major types: *geographic* ('lon/lat', with units in degrees longitude and latitude) and *projected* (typically with units of meters from a datum) coordinate systems.
This chapter builds on that knowledge and goes further.
It demonstrates how to set and *transform* geographic data from one CRS to another and, furthermore, highlights specific issues that can arise due to ignoring CRSs that you should be aware of, especially if your data is stored with lon/lat coordinates.
\index{CRS!geographic} 
\index{CRS!projected} 

In many projects there is no need to worry about, let alone convert between, different CRSs.
It is important to know if your data is in a projected or geographic coordinate system, and the consequences of this for geometry operations.
However, if you know the CRS of your data and the consequences for geometry operations (covered in the next section), CRSs should *just work* behind the scenes: people often suddenly need to learn about CRSs when things go wrong.
Having a clearly defined project CRS that all project data is in, plus understanding how and why to use different CRSs, can ensure that things don't go wrong.
Furthermore, learning about coordinate systems will deepen your knowledge of geographic datasets and how to use them effectively.

This chapter teaches the fundamentals of CRSs, demonstrates the consequences of using different CRSs (including what can go wrong), and how to 'reproject' datasets from one coordinate system to another.
In the next section we introduce CRSs in R, followed by Section \@ref(crs-in-r) which shows how to get and set CRSs associated with spatial objects. 
Section \@ref(geom-proj) demonstrates the importance of knowing what CRS your data is in with reference to a worked example of creating buffers.
We tackle questions of when to reproject and which CRS to use in Section \@ref(whenproject) and Section \@ref(which-crs), respectively.
We cover reprojecting vector and raster objects in sections \@ref(reproj-vec-geom) and \@ref(reproj-ras) and modifying map projections in Section \@ref(mapproj).


## Coordinate Reference Systems {#crs-in-r}

\index{CRS!EPSG}
\index{CRS!WKT}
\index{CRS!proj-string}
Most modern geographic tools that require CRS conversions, including core R-spatial packages and desktop GIS software such as QGIS, interface with [PROJ](https://proj.org), an open source C++ library that "transforms coordinates from one coordinate reference system (CRS) to another".
CRSs can be described in many ways, including the following.

1. Simple yet potentially ambiguous statements such as "it's in lon/lat coordinates".
2. Formalised yet now outdated 'proj4 strings' such as `+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs`.
3. With an identifying 'authority:code' text string such as `EPSG:4326`.

Each refers to the same thing: the 'WGS84' coordinate system that forms the basis of Global Positioning System (GPS) coordinates and many other datasets.
But which one is correct?

The short answer is that the third way to identify CRSs is correct: `EPSG:4326` is understood by **sf** (and by extension **stars**) and **terra** packages covered in this book, plus many other software projects for working with geographic data including [QGIS](https://docs.qgis.org/3.16/en/docs/user_manual/working_with_projections/working_with_projections.html) and [PROJ](https://proj.org/development/quickstart.html).
`EPSG:4326` is future-proof.
Furthermore, although it is machine readable, unlike the proj-string representation "EPSG:4326" is short, easy to remember and highly 'findable' online (searching for EPSG:4326 yields a dedicated page on the website [epsg.io](https://epsg.io/4326), for example).
The more concise identifier `4326` is understood by **sf**, but **we recommend the more explicit `AUTHORITY:CODE` representation to prevent ambiguity and to provide context**.

The longer answer is that none of the three descriptions are sufficient and more detail is needed for unambiguous CRS handling and transformations: due to the complexity of CRSs, it is not possible to capture all relevant information about them in such short text strings.
For this reason, the Open Geospatial Consortium (OGC, which also developed the simple features specification that the **sf** package implements) developed an open standard format for describing CRSs that is called WKT (Well Known Text).
This is detailed in a [100+ page document](https://portal.opengeospatial.org/files/18-010r7) that "defines the structure and content of a text string implementation of the abstract model for coordinate reference systems described in ISO 19111:2019" [@opengeospatialconsortium_wellknown_2019].
The WKT representation of the WGS84 CRS, which has the **identifier** `EPSG:4326` is as follows:

<!-- Source: https://spatialreference.org/ref/epsg/4326/prettywkt/ -->
<!-- ``` -->
<!-- GEOGCS["WGS 84", -->
<!--     DATUM["WGS_1984", -->
<!--         SPHEROID["WGS 84",6378137,298.257223563, -->
<!--             AUTHORITY["EPSG","7030"]], -->
<!--         AUTHORITY["EPSG","6326"]], -->
<!--     PRIMEM["Greenwich",0, -->
<!--         AUTHORITY["EPSG","8901"]], -->
<!--     UNIT["degree",0.01745329251994328, -->
<!--         AUTHORITY["EPSG","9122"]], -->
<!--     AUTHORITY["EPSG","4326"]] -->
<!-- ``` -->


```r
st_crs("EPSG:4326")
#> Coordinate Reference System:
#>   User input: EPSG:4326 
#>   wkt:
#> GEOGCRS["WGS 84",
#>     DATUM["World Geodetic System 1984",
#>         ELLIPSOID["WGS 84",6378137,298.257223563,
#>             LENGTHUNIT["metre",1]]],
#>     PRIMEM["Greenwich",0,
#>         ANGLEUNIT["degree",0.0174532925199433]],
#>     CS[ellipsoidal,2],
#>         AXIS["geodetic latitude (Lat)",north,
#>             ORDER[1],
#>             ANGLEUNIT["degree",0.0174532925199433]],
#>         AXIS["geodetic longitude (Lon)",east,
#>             ORDER[2],
#>             ANGLEUNIT["degree",0.0174532925199433]],
#>     USAGE[
#>         SCOPE["unknown"],
#>         AREA["World"],
#>         BBOX[-90,-180,90,180]],
#>     ID["EPSG",4326]]
```

The output of the command shows how the CRS identifier (also known as a Spatial Reference Identifier or [SRID](https://postgis.net/workshops/postgis-intro/projection.html)) works: it is simply a look-up, providing a unique identifier associated with a more complete WKT representation of the CRS.
This raises the question: what happens if there is a mismatch between the identifier and the longer WKT representation of a CRS?
On this point @opengeospatialconsortium_wellknown_2019 is clear, the verbose WKT representation takes precedence over the [identifier](https://docs.opengeospatial.org/is/18-010r7/18-010r7.html#37): 

> Should any attributes or values given in the cited identifier be in conflict with attributes or values given explicitly in the WKT description, the WKT values shall prevail. 

The convention of referring to CRSs identifiers in the form `AUTHORITY:CODE`, which is also used by geographic software written in other [languages](https://jorisvandenbossche.github.io/blog/2020/02/11/geopandas-pyproj-crs/), allows a wide range of formally defined coordinate systems to be referred to.^[
Several
other ways of referring to unique CRSs can be used, with five identifier types (EPSG code, PostGIS SRID, INTERNAL SRID, PROJ4 string, and WKT strings accepted by [QGIS](https://docs.qgis.org/3.16/en/docs/pyqgis_developer_cookbook/crs.html?highlight=srid) and other identifier types such as a more verbose variant of the `EPSG:4326` identifier, `urn:ogc:def:crs:EPSG::4326` @opengeospatialconsortium_wellknown_2019.
]
The most commonly used authority in CRS identifiers is *EPSG*, an acronym for the European Petroleum Survey Group which published a standardized list of CRSs (the EPSG was [taken over](http://wiki.gis.com/wiki/index.php/European_Petroleum_Survey_Group) by the oil and gas body the [Geomatics Committee of the International Association of Oil & Gas Producers](https://www.iogp.org/our-committees/geomatics/) in 2005).
Other authorities can be used in CRS identifiers.
`ESRI:54030`, for example, refers to ESRI's implementation of the Robinson projection, which has the following WKT string (only first 8 lines shown):


```r
sf::st_crs("ESRI:54030")
#> Coordinate Reference System:
#>   User input: ESRI:54030 
#>   wkt:
#> PROJCRS["World_Robinson",
#>     BASEGEOGCRS["WGS 84",
#>         DATUM["World Geodetic System 1984",
#>             ELLIPSOID["WGS 84",6378137,298.257223563,
#>                 LENGTHUNIT["metre",1]]],
#> ...
```




WKT strings are exhaustive, detailed, and precise, allowing for unambiguous CRSs storage and transformations.
They contain all relevant information about any given CRS, including its datum and ellipsoid, prime meridian, projection, and units.^[
Before the emergence of WKT CRS definitions, proj-string was the standard way to specify coordinate operations and store CRSs.
These string representations, built on a key=value form (e.g, `+proj=longlat +datum=WGS84 +no_defs`), have already been, or should in the future be, superseded by WKT representations in most cases.
]

Recent PROJ versions (6+) still allow use of proj-strings to define coordinate operations, but some proj-string keys (`+nadgrids`, `+towgs84`, `+k`, `+init=epsg:`) are either no longer supported or are discouraged.
<!-- ref? (RL 2022-06) -->
<!-- Second line was commented out (RL 2022-06) -->
<!-- only three datums (i.e., WGS84, NAD83, and NAD27) can be directly set in proj-string. -->
Longer explanations of the evolution of CRS definitions and the PROJ library can be found in @bivand_progress_2021, Chapter 2 of @pebesma_spatial_2022, and [blog post by Floris Vanderhaeghe](https://inbo.github.io/tutorials/tutorials/spatial_crs_coding/).
As outlined in the [PROJ documentation](https://proj.org/development/reference/cpp/cpp_general.html) there are different versions of the WKT CRS format including WKT1 and two variants of WKT2, the latter of which (WKT2, 2018 specification) corresponds to the ISO 19111:2019 [@opengeospatialconsortium_wellknown_2019].

## Querying and setting coordinate systems {#crs-setting}

Let's look at how CRSs are stored in R spatial objects and how they can be queried and set.
First we will look at getting and setting CRSs in **vector** geographic data objects, starting with the following example:


```r
vector_filepath = system.file("shapes/world.gpkg", package = "spData")
new_vector = read_sf(vector_filepath)
```

Our new object, `new_vector`, is a data frame of class `sf` that represents countries worldwide (see the help page `?spData::world` for details).
The CRS can be retrieved with the **sf** function `st_crs()`.


```r
st_crs(new_vector) # get CRS
#> Coordinate Reference System:
#>   User input: WGS 84 
#>   wkt:
#>   ...
```



The output is a list containing two main components:

1. `User input` (in this case `WGS 84`, a synonym for `EPSG:4326` which in this case was taken from the input file), corresponding to CRS identifiers described above
1. `wkt`, containing the full WKT string with all relevant information about the CRS.

The `input` element is flexible, and depending on the input file or user input, can contain the `AUTHORITY:CODE` representation (e.g., `EPSG:4326`), the CRS's name (e.g., `WGS 84`), or even the proj-string definition.
The `wkt` element stores the WKT representation, which is used when saving the object to a file or doing any coordinate operations.
Above, we can see that the `new_vector` object has the WGS84 ellipsoid, uses the Greenwich prime meridian, and the latitude and longitude axis order.
In this case, we also have some additional elements, such as `USAGE` explaining the area suitable for the use of this CRS, and `ID` pointing to the CRS's identifier: `EPSG:4326`.

The `st_crs` function also has one helpful feature -- we can retrieve some additional information about the used CRS. 
For example, try to run:

- `st_crs(new_vector)$IsGeographic` to check is the CRS is geographic or not
- `st_crs(new_vector)$units_gdal` to find out the CRS units
- `st_crs(new_vector)$srid` extracts its 'SRID' identifier (when available)
- `st_crs(new_vector)$proj4string` extracts the proj-string representation

In cases when a coordinate reference system (CRS) is missing or the wrong CRS is set, the `st_set_crs()` function can be used (in this case the WKT string remains unchanged because the CRS was already set correctly when the file was read-in):


```r
new_vector = st_set_crs(new_vector, "EPSG:4326") # set CRS
```



Getting and setting CRSs works in a similar way for **raster** geographic data objects.
The `crs()` function in the `terra` package accesses CRS information from a `SpatRaster` object (note the use of the `cat()` function to print it nicely): 


```r
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
my_rast = rast(raster_filepath)
cat(crs(my_rast)) # get CRS
#> GEOGCRS["WGS 84",
#>     DATUM["World Geodetic System 1984",
#>         ELLIPSOID["WGS 84",6378137,298.257223563,
#>             LENGTHUNIT["metre",1]]],
#>     PRIMEM["Greenwich",0,
#>         ANGLEUNIT["degree",0.0174532925199433]],
#>     CS[ellipsoidal,2],
#>         AXIS["geodetic latitude (Lat)",north,
#>             ORDER[1],
#>             ANGLEUNIT["degree",0.0174532925199433]],
#>         AXIS["geodetic longitude (Lon)",east,
#>             ORDER[2],
#>             ANGLEUNIT["degree",0.0174532925199433]],
#>     ID["EPSG",4326]]
```

The output is the WKT representation of CRS. 
The same function, `crs()`, can be also used to set a CRS for raster objects.


```r
crs(my_rast) = "EPSG:26912" # set CRS
```

Here, we can use either the identifier (recommended in most cases) or complete WKT representation.
Alternative methods to set `crs` include proj-string strings or CRSs extracted from other existing object with `crs()`, although these approaches may be less future proof.

Importantly, the `st_crs()` and `crs()` functions do not alter coordinates' values or geometries.
Their role is only to set a metadata information about the object CRS.

In some cases the CRS of a geographic object is unknown, as is the case in the `london` dataset created in the code chunk below, building on the example of London introduced in Section \@ref(vector-data):


```r
london = data.frame(lon = -0.1, lat = 51.5) |> 
  st_as_sf(coords = c("lon", "lat"))
st_is_longlat(london)
#> [1] NA
```

The output `NA` shows that **sf** does not know what the CRS is and is unwilling to guess (`NA` literally means 'not available').
Unless a CRS is manually specified or is loaded from a source that has CRS metadata, **sf** does not make any explicit assumptions about which coordinate systems, other than to say "I don't know".
This behavior makes sense given the diversity of available CRSs but differs from some approaches, such as the GeoJSON file format specification, which makes the simplifying assumption that all coordinates have a lon/lat CRS: `EPSG:4326`.

A CRS can be added to `sf` objects in three main ways:

- By assigning the CRS to a pre-existing object, e.g. with `st_crs(london) = "EPSG:4326"`
- By passing a CRS to the `crs` argument in **sf** functions that create geometry objects such as `st_as_sf(... crs = "EPSG:4326")`. The same argument can also be used to set the CRS when creating raster datasets (e.g., `rast(crs = "EPSG:4326")`)
- With the `st_set_crs()`, which returns a version of the data that has a new CRS, an approach that is demonstrated in the following code chunk


```r
london_geo = st_set_crs(london, "EPSG:4326")
st_is_longlat(london_geo)
#> [1] TRUE
```

<!-- The following example demonstrates how to add CRS metadata to raster datasets. -->
<!-- Todo: add this -->

Datasets without a specified CRS can cause problems: all geographic coordinates have a coordinate system and software can only make good decisions around plotting and and geometry operations if it knows what type of CRS it is working with.

## Geometry operations on projected and unprojected data {#geom-proj}

If no CRS has been set, **sf** uses the GEOS geometry library for many operations.
GEOS is not well suited to lon/lat CRSs, as we will see later in this chapter.
If a CRS has been set, **sf** will use either GEOS or the S2 *spherical geometry engine* depending on the type of CRS.
<!-- Todo: add s2 section -->
<!--jn: s2 section is still missing from the book-->
Since **sf** version 1.0.0, R's ability to work with geographic vector datasets that have lon/lat CRSs has improved substantially, thanks to its integration with S2 introduced in Section \@ref(s2).

To demonstrate the importance of CRSs, we will in this section create a buffer of 100 km around the `london` object created in the previous section.
We will also create a deliberately faulty buffer with a 'distance' of 1 degree, which is roughly equivalent to 100 km (1 degree is about 111 km at the equator).
Before diving into the code, it may be worth skipping briefly ahead to peek at Figure \@ref(fig:crs-buf) to get a visual handle on the outputs that you should be able to reproduce by following the code chunks below.

The first stage is to create three buffers around the `london` and `london_geo` objects created above with boundary distances of 1 degree and 100 km  (or 100,000 m, which can be expressed as `1e5` in scientific notation) from central London:


```r
london_buff_no_crs = st_buffer(london, dist = 1)   # incorrect: no CRS
london_buff_s2 = st_buffer(london_geo, dist = 1e5) # silent use of s2
london_buff_s2_100_cells = st_buffer(london_geo, dist = 1e5, max_cells = 100) 
```

In the first line above, **sf** assumes that the input is projected and generates a result that has a buffer in units of degrees, which is problematic, as we will see.
In the second line, **sf** silently uses the spherical geometry engine S2, introduced in Chapter \@ref(spatial-class), to calculate the extent of the buffer using the default value of `max_cells = 1000` --- set to `100` in line three --- the consequences which will become apparent shortly (see `?s2::s2_buffer_cells` for details).
To highlight the impact of **sf**'s use of the S2 geometry engine for unprojected (geographic) coordinate systems, we will temporarily disable it with the command `sf_use_s2()` (which is on, `TRUE`, by default), in the code chunk below.
Like `london_buff_no_crs`, the new `london_geo` object is a geographic abomination: it has units of degrees, which makes no sense in the vast majority of cases:


```r
sf::sf_use_s2(FALSE)
#> Spherical geometry (s2) switched off
london_buff_lonlat = st_buffer(london_geo, dist = 1) # incorrect result
#> Warning in st_buffer.sfc(st_geometry(x), dist, nQuadSegs, endCapStyle =
#> endCapStyle, : st_buffer does not correctly buffer longitude/latitude data
#> dist is assumed to be in decimal degrees (arc_degrees).
sf::sf_use_s2(TRUE)
#> Spherical geometry (s2) switched on
```

The warning message above hints at issues with performing planar geometry operations on lon/lat data. 
When spherical geometry operations are turned off, with the command `sf::sf_use_s2(FALSE)`, buffers (and other geometric operations) may result in worthless outputs because they use units of latitude and longitude, a poor substitute for proper units of distances such as meters.

\BeginKnitrBlock{rmdnote}
The distance between two lines of longitude, called meridians, is around 111 km at the equator (execute `geosphere::distGeo(c(0, 0), c(1, 0))` to find the precise distance).
This shrinks to zero at the poles.
At the latitude of London, for example, meridians are less than 70 km apart (challenge: execute code that verifies this).
<!-- `geosphere::distGeo(c(0, 51.5), c(1, 51.5))` -->
Lines of latitude, by contrast, are equidistant from each other irrespective of latitude: they are always around 111 km apart, including at the equator and near the poles (see Figures \@ref(fig:crs-buf) to \@ref(fig:wintriproj)).
\EndKnitrBlock{rmdnote}

Do not interpret the warning about the geographic (`longitude/latitude`) CRS as "the CRS should not be set": it almost always should be!
It is better understood as a suggestion to *reproject* the data onto a projected CRS.
This suggestion does not always need to be heeded: performing spatial and geometric operations makes little or no difference in some cases (e.g., spatial subsetting).
But for operations involving distances such as buffering, the only way to ensure a good result (without using spherical geometry engines) is to create a projected copy of the data and run the operation on that.
<!--toDo:rl-->
<!-- jn: idea -- maybe it would be add a table somewhere in the book showing which operations are impacted by s2? -->
This is done in the code chunk below:


```r
london_proj = data.frame(x = 530000, y = 180000) |> 
  st_as_sf(coords = 1:2, crs = "EPSG:27700")
```

The result is a new object that is identical to `london`, but reprojected onto a suitable CRS (the British National Grid, which has an EPSG code of 27700 in this case) that has units of meters.
We can verify that the CRS has changed using `st_crs()` as follows (some of the output has been replaced by `...`):


```r
st_crs(london_proj)
#> Coordinate Reference System:
#>   User input: EPSG:27700 
#>   wkt:
#> PROJCRS["OSGB36 / British National Grid",
#>     BASEGEOGCRS["OSGB36",
#>         DATUM["Ordnance Survey of Great Britain 1936",
#>             ELLIPSOID["Airy 1830",6377563.396,299.3249646,
#>                 LENGTHUNIT["metre",1]]],
#> ...
```

Notable components of this CRS description include the EPSG code (`EPSG: 27700`) and the detailed `wkt` string (only the first 5 lines of which are shown).^[
For a short description of the most relevant projection parameters and related concepts, see the fourth lecture by Jochen Albrecht hosted at
http://www.geography.hunter.cuny.edu/~jochen/GTECH361/lectures/ and information at https://proj.org/usage/projections.html.
Other great resources on projections are spatialreference.org and progonos.com/furuti/MapProj.
]
The fact that the units of the CRS, described in the LENGTHUNIT field, are meters (rather than degrees) tells us that this is a projected CRS: `st_is_longlat(london_proj)` now returns `FALSE` and geometry operations on `london_proj` will work without a warning.
Buffers operations on the `london_proj` will use GEOS and results will returned with proper units of distance.
The following line of code creates a buffer around *projected* data of exactly 100 km:


```r
london_buff_projected = st_buffer(london_proj, 1e5)
```

The geometries of the three `london_buff*` objects that *have* a specified CRS created above (`london_buff_s2`, `london_buff_lonlat` and `london_buff_projected`) created in the preceding code chunks are illustrated in Figure \@ref(fig:crs-buf).



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{07-reproj_files/figure-latex/crs-buf-1} 

}

\caption[Buffers around London with a geographic and projected CRS.]{Buffers around London showing results created with the S2 spherical geometry engine on lon/lat data (left), projected data (middle) and lon/lat data without using spherical geometry (right). The left plot illustrates the result of buffering unprojected data with sf, which calls Google's S2 spherical geometry engine by default with max cells = 1000 (thin line). The thick 'blocky' line illustrates the result of the same operation with max cells = 100.}(\#fig:crs-buf)
\end{figure}

It is clear from Figure \@ref(fig:crs-buf) that buffers based on `s2` and properly projected CRSs are not 'squashed', meaning that every part of the buffer boundary is equidistant to London.
The results that are generated from lon/lat CRSs when `s2` is *not* used, either because the input lacks a CRS or because `sf_use_s2()` is turned off, are heavily distorted, with the result elongated in the north-south axis, highlighting the dangers of using algorithms that assume projected data on lon/lat inputs (as GEOS does).
The results generated using S2 are also distorted, however, although less dramatically.
Both buffer boundaries in Figure \@ref(fig:crs-buf) (left) are jagged, although this may only be apparent or relevant when for the thick boundary representing a buffer created with the `s2` argument `max_cells` set to 100.
<!--toDo:rl-->
<!--jn: maybe it is worth to emphasize that the differences are due to the use of S2 vs GEOS-->
<!--jn: you mention S2 a lot in this section, but not GEOS...-->
The lesson is that results obtained from lon/lat data via S2 will be different from results obtained from using projected data.
The difference between S2 derived buffers and GEOS derived buffers on projected data reduce as the value of `max_cells` increases: the 'right' value for this argument may depend on many factors and the default value 1000 is a reasonable default.
When choosing `max_cells` values, speed of computation should be balanced against resolution of results, in many.
In situations where curved boundaries are advantageous, transforming to a projected CRS before buffering (or performing other geometry operations) may be appropriate.

The importance of CRSs (primarily whether they are projected or geographic) and the impacts of **sf**'s default setting to use S2 for buffers on lon/lat data is clear from the example above.
The subsequent sections go into more depth, exploring which CRS to use when projected CRSs *are* needed and the details of reprojecting vector and raster objects.

## When to reproject? {#whenproject}

\index{CRS!reprojection} 
The previous section showed how to set the CRS manually, with `st_set_crs(london, "EPSG:4326")`.
In real world applications, however, CRSs are usually set automatically when data is read-in.
In many projects the main CRS-related task is to *transform* objects, from one CRS into another.
But when should data be transformed? 
And into which CRS?
There are no clear-cut answers to these questions and CRS selection always involves trade-offs [@maling_coordinate_1992].
However, there are some general principles provided in this section that can help you decide. 

First it's worth considering *when to transform*.
<!--toDo:rl-->
<!--not longer valid-->
In some cases transformation to a projected CRS is essential, such as when using geometric functions such as `st_buffer()`, as Figure \@ref(fig:crs-buf) showed.
Conversely, publishing data online with the **leaflet** package may require a geographic CRS.
Another case is when two objects with different CRSs must be compared or combined, as shown when we try to find the distance between two objects with different CRSs:


```r
st_distance(london_geo, london_proj)
# > Error: st_crs(x) == st_crs(y) is not TRUE
```

To make the `london` and `london_proj` objects geographically comparable one of them must be transformed into the CRS of the other.
But which CRS to use?
The answer depends on context: many projects, especially those involving web mapping, require outputs in EPSG:4326, in which case it is worth transforming the projected object.
If, however, the project requires planar geometry operations rather than spherical geometry operations engine (e.g. to create buffers with smooth edges), it may be worth transforming data with a geographic CRS into an equivalent object with a projected CRS, such as the British National Grid (EPSG:27700).
That is the subject of Section \@ref(reproj-vec-geom).

## Which CRS to use? {#which-crs}

\index{CRS!reprojection} 
\index{projection!World Geodetic System}
The question of *which CRS* is tricky, and there is rarely a 'right' answer:
"There exist no all-purpose projections, all involve distortion when far from the center of the specified frame" [@bivand_applied_2013].
Additionally, you should not be attached just to one projection for every task.
It is possible to use one projection for some part of the analysis, another projection for a different part, and even some other for visualization.
Always try to pick the CRS that serves your goal best!

When selecting **geographic CRSs**, the answer is often [WGS84](https://en.wikipedia.org/wiki/World_Geodetic_System#A_new_World_Geodetic_System:_WGS_84).
It is used not only for web mapping, but also because GPS datasets and thousands of raster and vector datasets are provided in this CRS by default.
WGS84 is the most common CRS in the world, so it is worth knowing its EPSG code: 4326.
This 'magic number' can be used to convert objects with unusual projected CRSs into something that is widely understood.

What about when a **projected CRS** is required?
In some cases, it is not something that we are free to decide:
"often the choice of projection is made by a public mapping agency" [@bivand_applied_2013].
This means that when working with local data sources, it is likely preferable to work with the CRS in which the data was provided, to ensure compatibility, even if the official CRS is not the most accurate.
The example of London was easy to answer because (a) the British National Grid (with its associated EPSG code 27700) is well known and (b) the original dataset (`london`) already had that CRS.

\index{UTM} 
A commonly used default is Universal Transverse Mercator ([UTM](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system)), a set of CRSs that divides the Earth into 60 longitudinal wedges and 20 latitudinal segments.
The transverse Mercator projection used by UTM CRSs is conformal but distorts areas and distances with increasing severity with distance from the center of the UTM zone.
Documentation from the GIS software Manifold therefore suggests restricting the longitudinal extent of projects using UTM zones to 6 degrees from the central meridian (source: [manifold.net](http://www.manifold.net/doc/mfd9/universal_transverse_mercator_projection.htm)).
Therefore, we recommend using UTM only when your focus is on preserving angles for relatively small area!

Almost every place on Earth has a UTM code, such as "60H" which refers to northern New Zealand where R was invented.
UTM EPSG codes run sequentially from 32601 to 32660 for northern hemisphere locations and from 32701 to 32760 for southern hemisphere locations.



To show how the system works, let's create a function, `lonlat2UTM()` to calculate the EPSG code associated with any point on the planet as [follows](https://stackoverflow.com/a/9188972/): 


```r
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) {
    utm + 32600
  } else{
    utm + 32700
  }
}
```

The following command uses this function to identify the UTM zone and associated EPSG code for Auckland and London:




```r
lonlat2UTM(c(174.7, -36.9))
#> [1] 32760
lonlat2UTM(st_coordinates(london))
#> [1] 32630
```

Currently, we also have tools helping us to select a proper CRS, which includes the **crssuggest** package<!--add ref or docs-->.
The main function in this package, `suggest_crs()`, takes a spatial object with geographic CRS and returns a list of possible projected CRSs that could be used for the given area.^[This package also allows to figure out the true CRS of the data without any CRS information attached.]
Another helpful tool is a webpage https://jjimenezshaw.github.io/crs-explorer/ that lists CRSs based on selected location and type.
Important note: while these tools are helpful in many situations, you need to be aware of the properties of the recommended CRS before you apply it.

\index{CRS!custom} 
In cases where an appropriate CRS is not immediately clear, the choice of CRS should depend on the properties that are most important to preserve in the subsequent maps and analysis.
All CRSs are either equal-area, equidistant, conformal (with shapes remaining unchanged), or some combination of compromises of those (section \@ref(projected-coordinate-reference-systems)).
Custom CRSs with local parameters can be created for a region of interest and multiple CRSs can be used in projects when no single CRS suits all tasks.
'Geodesic calculations' can provide a fall-back if no CRSs are appropriate (see [proj.org/geodesic.html](https://proj.org/geodesic.html)).
Regardless of the projected CRS used, the results may not be accurate for geometries covering hundreds of kilometers.

\index{CRS!custom}
When deciding on a custom CRS, we recommend the following:^[
<!--toDo:rl-->
<!-- jn:I we can assume who is the "anonymous reviewer", can we ask him/her to use his/her name? -->
Many thanks to an anonymous reviewer whose comments formed the basis of this advice.
]

\index{projection!Lambert azimuthal equal-area}
\index{projection!Azimuthal equidistant}
\index{projection!Lambert conformal conic}
\index{projection!Stereographic}
\index{projection!Universal Transverse Mercator}

- A Lambert azimuthal equal-area ([LAEA](https://en.wikipedia.org/wiki/Lambert_azimuthal_equal-area_projection)) projection for a custom local projection (set latitude and longitude of origin to the center of the study area), which is an equal-area projection at all locations but distorts shapes beyond thousands of kilometers
- Azimuthal equidistant ([AEQD](https://en.wikipedia.org/wiki/Azimuthal_equidistant_projection)) projections for a specifically accurate straight-line distance between a point and the center point of the local projection
- Lambert conformal conic ([LCC](https://en.wikipedia.org/wiki/Lambert_conformal_conic_projection)) projections for regions covering thousands of kilometers, with the cone set to keep distance and area properties reasonable between the secant lines
- Stereographic ([STERE](https://en.wikipedia.org/wiki/Stereographic_projection)) projections for polar regions, but taking care not to rely on area and distance calculations thousands of kilometers from the center

One possible approach to automatically select a projected CRS specific to a local dataset is to create an azimuthal equidistant ([AEQD](https://en.wikipedia.org/wiki/Azimuthal_equidistant_projection)) projection for the center-point of the study area.
This involves creating a custom CRS (with no EPSG code) with units of meters based on the center point of a dataset.
Note that this approach should be used with caution: no other datasets will be compatible with the custom CRS created and results may not be accurate when used on extensive datasets covering hundreds of kilometers.

The principles outlined in this section apply equally to vector and raster datasets.
Some features of CRS transformation however are unique to each geographic data model.
We will cover the particularities of vector data transformation in Section \@ref(reproj-vec-geom) and those of raster transformation in Section \@ref(reproj-ras).
Next, the last section, shows how to create custom map projections (Section \@ref(mapproj)).

## Reprojecting vector geometries {#reproj-vec-geom}

<!--jn: idea adding info about custom piplines?-->

\index{CRS!reprojection} 
\index{vector!reprojection} 
Chapter \@ref(spatial-class) demonstrated how vector geometries are made-up of points, and how points form the basis of more complex objects such as lines and polygons.
Reprojecting vectors thus consists of transforming the coordinates of these points, which form the vertices of lines and polygons.

Section \@ref(whenproject) contains an example in which at least one `sf` object must be transformed into an equivalent object with a different CRS to calculate the distance between two objects.


```r
london2 = st_transform(london_geo, "EPSG:27700")
```

Now that a transformed version of `london` has been created, using the **sf** function `st_transform()`, the distance between the two representations of London can be found.^[
An alternative to `st_transform()` is `st_transform_proj()` from the **lwgeom**, which enables transformations which bypasses GDAL and can support projections not supported by GDAL.
At the time of writing (2022) we could not find any projections supported by `st_transform_proj()` but not supported by `st_transform()`.
]
It may come as a surprise that `london` and `london2` are just over 2 km apart!^[
The difference in location between the two points is not due to imperfections in the transforming operation (which is in fact very accurate) but the low precision of the manually-created coordinates that created `london` and `london_proj`.
Also surprising may be that the result is provided in a matrix with units of meters.
This is because `st_distance()` can provide distances between many features and because the CRS has units of meters.
Use `as.numeric()` to coerce the result into a regular number.
]


```r
st_distance(london2, london_proj)
#> Units: [m]
#>      [,1]
#> [1,] 2018
```

Functions for querying and reprojecting CRSs are demonstrated below with reference to `cycle_hire_osm`, an `sf` object from **spData** that represents 'docking stations' where you can hire bicycles in London.
The CRS of `sf` objects can be queried --- and as we learned in Section \@ref(reproj-intro) set --- with the function `st_crs()`.
The output is printed as multiple lines of text containing information about the coordinate system:


```r
st_crs(cycle_hire_osm)
#> Coordinate Reference System:
#>   User input: EPSG:4326 
#>   wkt:
#> GEOGCS["WGS 84",
#>     DATUM["WGS_1984",
#>         SPHEROID["WGS 84",6378137,298.257223563,
#>             AUTHORITY["EPSG","7030"]],
#>         AUTHORITY["EPSG","6326"]],
#>     PRIMEM["Greenwich",0,
#>         AUTHORITY["EPSG","8901"]],
#>     UNIT["degree",0.0174532925199433,
#>         AUTHORITY["EPSG","9122"]],
#>     AUTHORITY["EPSG","4326"]]
```

As we saw in Section \@ref(crs-setting), the main CRS components, `User input` and `wkt`, are printed as a single entity, the output of `st_crs()` is in fact a named list of class `crs` with two elements, single character strings named `input` and `wkt`, as shown in the output of the following code chunk:


```r
crs_lnd = st_crs(london_geo)
class(crs_lnd)
#> [1] "crs"
names(crs_lnd)
#> [1] "input" "wkt"
```

Additional elements can be retrieved with the `$` operator, including `Name`, `proj4string` and `epsg` (see [`?st_crs`](https://r-spatial.github.io/sf/reference/st_crs.html) and the CRS and tranformation tutorial on the GDAL [website](https://gdal.org/tutorials/osr_api_tut.html#querying-coordinate-reference-system) for details):


```r
crs_lnd$Name
#> [1] "WGS 84"
crs_lnd$proj4string
#> [1] "+proj=longlat +datum=WGS84 +no_defs"
crs_lnd$epsg
#> [1] 4326
```

As mentioned in Section \@ref(crs-in-r), WKT representation, stored in the `$wkt` element of the `crs_lnd` object is the ultimate source of truth.
This means that the outputs of the previous code chunk are queries from the `wkt` representation provided by PROJ, rather than inherent attributes of the object and its CRS.

Both `wkt` and `User Input` elements of the CRS are changed when the object's CRS is transformed.
In the code chunk below, we create a new version of `cycle_hire_osm` with a projected CRS (only the first 4 lines of the CRS output are shown for brevity):


```r
cycle_hire_osm_projected = st_transform(cycle_hire_osm, "EPSG:27700")
st_crs(cycle_hire_osm_projected)
#> Coordinate Reference System:
#>   User input: EPSG:27700 
#>   wkt:
#> PROJCRS["OSGB36 / British National Grid",
#> ...
```

The resulting object has a new CRS with an EPSG code 27700.
But how to find out more details about this EPSG code, or any code?
One option is to search for it online, 


```r
crs_lnd_new = st_crs("EPSG:27700")
crs_lnd_new$Name
#> [1] "OSGB 1936 / British National Grid"
crs_lnd_new$proj4string
#> [1] "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +units=m +no_defs"
crs_lnd_new$epsg
#> [1] 27700
```

The result shows that the EPSG code 27700 represents the British National Grid, a result that could have been found by searching online for "[EPSG 27700](https://www.google.com/search?q=CRS+27700)".

\BeginKnitrBlock{rmdnote}
Printing a spatial object in the console automatically returns its coordinate reference system.
To access and modify it explicitly, use the `st_crs` function, for example, `st_crs(cycle_hire_osm)`.
\EndKnitrBlock{rmdnote}

## Reprojecting raster geometries {#reproj-ras}

\index{raster!reprojection} 
\index{raster!warping} 
\index{raster!transformation} 
\index{raster!resampling} 
The projection concepts described in the previous section apply equally to rasters.
However, there are important differences in reprojection of vectors and rasters:
transforming a vector object involves changing the coordinates of every vertex but this does not apply to raster data.
Rasters are composed of rectangular cells of the same size (expressed by map units, such as degrees or meters), so it is usually impracticable to transform coordinates of pixels separately.
Raster reprojection involves creating a new raster object, often with a different number of columns and rows than the original.
The attributes must subsequently be re-estimated, allowing the new pixels to be 'filled' with appropriate values.
In other words, raster reprojection can be thought of as two separate spatial operations: a vector reprojection of the raster extent to another CRS (Section \@ref(reproj-vec-geom)), and computation of new pixel values through resampling (Section \@ref(resampling)).
Thus in most cases when both raster and vector data are used, it is better to avoid reprojecting rasters and reproject vectors instead.

\BeginKnitrBlock{rmdnote}
Reprojection of the regular rasters is also known as warping. 
Additionally, there is a second similar operation called "transformation".
Instead of resampling all of the values, it leaves all values intact but recomputes new coordinates for every raster cell, changing the grid geometry.
For example, it could convert the input raster (a regular grid) into a curvilinear grid.
The transformation operation can be performed in R using [the **stars** package](https://r-spatial.github.io/stars/articles/stars5.html).
\EndKnitrBlock{rmdnote}



The raster reprojection process is done with `project()` from the **terra** package.
Like the `st_transform()` function demonstrated in the previous section, `project()` takes a geographic object (a raster dataset in this case) and some CRS representation as the second argument.
On a side note -- the second argument can also be an existing raster object with a different CRS.

Let's take a look at two examples of raster transformation: using categorical and continuous data.
Land cover data are usually represented by categorical maps.
The `nlcd.tif` file provides information for a small area in Utah, USA obtained from [National Land Cover Database 2011](https://www.mrlc.gov/data/nlcd-2011-land-cover-conus) in the NAD83 / UTM zone 12N CRS, as shown in the output of the code chunk below (only first line of output shown):


```r
cat_raster = rast(system.file("raster/nlcd.tif", package = "spDataLarge"))
crs(cat_raster)
#> PROJCRS["NAD83 / UTM zone 12N",
#> ...
```

In this region, 8 land cover classes were distinguished (a full list of NLCD2011 land cover classes can be found at [mrlc.gov](https://www.mrlc.gov/data/legends/national-land-cover-database-2011-nlcd2011-legend)):


```r
unique(cat_raster)
#>       levels
#> 1      Water
#> 2  Developed
#> 3     Barren
#> 4     Forest
#> 5  Shrubland
#> 6 Herbaceous
#> 7 Cultivated
#> 8   Wetlands
```

When reprojecting categorical rasters, the estimated values must be the same as those of the original.
This could be done using the nearest neighbor method (`near`), which sets each new cell value to the value of the nearest cell (center) of the input raster.
An example is reprojecting `cat_raster` to WGS84, a geographic CRS well suited for web mapping.
The first step is to obtain the PROJ definition of this CRS, which can be done, for example using the [http://spatialreference.org](http://spatialreference.org/ref/epsg/wgs-84/) webpage. 
The final step is to reproject the raster with the `project()` function which, in the case of categorical data, uses the nearest neighbor method (`near`):


```r
cat_raster_wgs84 = project(cat_raster, "EPSG:4326", method = "near")
```

Many properties of the new object differ from the previous one, including the number of columns and rows (and therefore number of cells), resolution (transformed from meters into degrees), and extent, as illustrated in Table \@ref(tab:catraster) (note that the number of categories increases from 8 to 9 because of the addition of `NA` values, not because a new category has been created --- the land cover classes are preserved).

\begin{table}

\caption[Key attributes in the original and projected raster datasets]{(\#tab:catraster)Key attributes in the original ('cat\_raster') and projected ('cat\_raster\_wgs84') categorical raster datasets.}
\centering
\begin{tabular}[t]{lrrrrr}
\toprule
CRS & nrow & ncol & ncell & resolution & unique\_categories\\
\midrule
NAD83 & 1359 & 1073 & 1458207 & 31.5275 & 8\\
WGS84 & 1246 & 1244 & 1550024 & 0.0003 & 9\\
\bottomrule
\end{tabular}
\end{table}

Reprojecting numeric rasters (with `numeric` or in this case `integer` values) follows an almost identical procedure.
This is demonstrated below with `srtm.tif` in **spDataLarge** from [the Shuttle Radar Topography Mission (SRTM)](https://www2.jpl.nasa.gov/srtm/), which represents height in meters above sea level (elevation) with the WGS84 CRS:


```r
con_raster = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
crs(con_raster)
#> [1] "GEOGCRS[\"WGS 84\",\n    DATUM[\"World Geodetic System 1984\",\n        ELLIPSOID[\"WGS 84\",6378137,298.257223563,\n            LENGTHUNIT[\"metre\",1]]],\n    PRIMEM[\"Greenwich\",0,\n        ANGLEUNIT[\"degree\",0.0174532925199433]],\n    CS[ellipsoidal,2],\n        AXIS[\"geodetic latitude (Lat)\",north,\n            ORDER[1],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        AXIS[\"geodetic longitude (Lon)\",east,\n            ORDER[2],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n    ID[\"EPSG\",4326]]"
```

We will reproject this dataset into a projected CRS, but *not* with the nearest neighbor method which is appropriate for categorical data.
Instead, we will use the bilinear method which computes the output cell value based on the four nearest cells in the original raster.^[
Other methods mentioned in Section \@ref(resampling) also can be used here.
]
The values in the projected dataset are the distance-weighted average of the values from these four cells:
the closer the input cell is to the center of the output cell, the greater its weight.
The following commands create a text string representing WGS 84 / UTM zone 12N, and reproject the raster into this CRS, using the `bilinear` method:


```r
con_raster_ea = project(con_raster, "EPSG:32612", method = "bilinear")
crs(con_raster_ea)
#> [1] "PROJCRS[\"WGS 84 / UTM zone 12N\",\n    BASEGEOGCRS[\"WGS 84\",\n        DATUM[\"World Geodetic System 1984\",\n            ELLIPSOID[\"WGS 84\",6378137,298.257223563,\n                LENGTHUNIT[\"metre\",1]]],\n        PRIMEM[\"Greenwich\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        ID[\"EPSG\",4326]],\n    CONVERSION[\"UTM zone 12N\",\n        METHOD[\"Transverse Mercator\",\n            ID[\"EPSG\",9807]],\n        PARAMETER[\"Latitude of natural origin\",0,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8801]],\n        PARAMETER[\"Longitude of natural origin\",-111,\n            ANGLEUNIT[\"degree\",0.0174532925199433],\n            ID[\"EPSG\",8802]],\n        PARAMETER[\"Scale factor at natural origin\",0.9996,\n            SCALEUNIT[\"unity\",1],\n            ID[\"EPSG\",8805]],\n        PARAMETER[\"False easting\",500000,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8806]],\n        PARAMETER[\"False northing\",0,\n            LENGTHUNIT[\"metre\",1],\n            ID[\"EPSG\",8807]]],\n    CS[Cartesian,2],\n        AXIS[\"(E)\",east,\n            ORDER[1],\n            LENGTHUNIT[\"metre\",1]],\n        AXIS[\"(N)\",north,\n            ORDER[2],\n            LENGTHUNIT[\"metre\",1]],\n    USAGE[\n        SCOPE[\"unknown\"],\n        AREA[\"World - N hemisphere - 114°W to 108°W - by country\"],\n        BBOX[0,-114,84,-108]],\n    ID[\"EPSG\",32612]]"
```

Raster reprojection on numeric variables also leads to small changes to values and spatial properties, such as the number of cells, resolution, and extent.
These changes are demonstrated in Table \@ref(tab:rastercrs)^[
Another minor change, that is not represented in Table \@ref(tab:rastercrs), is that the class of the values in the new projected raster dataset is `numeric`.
This is because the `bilinear` method works with continuous data and the results are rarely coerced into whole integer values.
This can have implications for file sizes when raster datasets are saved.
]:

\begin{table}

\caption[Key attributes in the original and projected raster datasets]{(\#tab:rastercrs)Key attributes in the original ('con\_raster') and projected ('con\_raster\_ea') continuous raster datasets.}
\centering
\begin{tabular}[t]{lrrrrr}
\toprule
CRS & nrow & ncol & ncell & resolution & mean\\
\midrule
WGS84 & 457 & 465 & 212505 & 0.0008 & 1843\\
UTM zone 12N & 515 & 422 & 217330 & 83.5334 & 1842\\
\bottomrule
\end{tabular}
\end{table}

\BeginKnitrBlock{rmdnote}
Of course, the limitations of 2D Earth projections apply as much to vector as to raster data.
At best we can comply with two out of three spatial properties (distance, area, direction).
Therefore, the task at hand determines which projection to choose. 
For instance, if we are interested in a density (points per grid cell or inhabitants per grid cell) we should use an equal-area projection (see also Chapter \@ref(location)).
\EndKnitrBlock{rmdnote}

## Custom map projections {#mapproj}

Established CRSs captured by `AUTHORITY:CODE` identifiers such as `EPSG:4326` are well suited for many applications.
However, it is desirable to use alternative projections or to create custom CRSs in some cases.
Section \@ref(which-crs) mentioned reasons for using custom CRSs, and provided several possible approaches.
Here, we show how to apply these ideas in R.

One is to take an existing WKT definition of a CRS, modify some of its elements, and then use the new definition for reprojecting.
This can be done for spatial vectors with `st_crs()$wkt` and `st_transform()`, and for spatial rasters with `crs()` and `project()`, as demonstrated in the following example which transforms the `zion` object to a custom azimuthal equidistant (AEQD) CRS.


```r
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
```

Using a custom AEQD CRS requires knowing the coordinates of the center point of a dataset in degrees (geographic CRS).
In our case, this information can be extracted by calculating a centroid of the `zion` area and transforming it into WGS84.


```r
zion_centr = st_centroid(zion)
zion_centr_wgs84 = st_transform(zion_centr, "EPSG:4326")
st_as_text(st_geometry(zion_centr_wgs84))
#> [1] "POINT (-113 37.3)"
```

Next, we can use the newly obtained values to update the WKT definition of the azimuthal equidistant (AEQD) CRS seen below.
Notice that we modified just two values below -- `"Central_Meridian"` to the longitude and `"Latitude_Of_Origin"` to the latitude of our centroid.


```r
my_wkt = 'PROJCS["Custom_AEQD",
 GEOGCS["GCS_WGS_1984",
  DATUM["WGS_1984",
   SPHEROID["WGS_1984",6378137.0,298.257223563]],
  PRIMEM["Greenwich",0.0],
  UNIT["Degree",0.0174532925199433]],
 PROJECTION["Azimuthal_Equidistant"],
 PARAMETER["Central_Meridian",-113.0263],
 PARAMETER["Latitude_Of_Origin",37.29818],
 UNIT["Meter",1.0]]'
```

This approach's last step is to transform our original object (`zion`) to our new custom CRS (`zion_aeqd`).


```r
zion_aeqd = st_transform(zion, my_wkt)
```

Custom projections can also be made interactively, for example, using the [Projection Wizard](https://projectionwizard.org/#) web application [@savric_projection_2016].
This website allows you to select a spatial extent of your data and a distortion property, and returns a list of possible projections.
The list also contains WKT definitions of the projections that you can copy and use for reprojections.
See @opengeospatialconsortium_wellknown_2019 for details on creating custom CRS definitions with WKT strings.

\index{CRS!proj-string}
PROJ strings can also be used to create custom projections, accepting the limitations inherent to projections, especially of geometries covering large geographic areas, mentioned in Section \@ref(crs-in-r).
Many projections have been developed and can be set with the `+proj=` element of PROJ strings, with dozens of projects described in detail on the [PROJ website](https://proj.org/operations/projections/index.html) alone. 

When mapping the world while preserving area relationships the Mollweide projection, illustrated in Figure \@ref(fig:mollproj), is a popular and often sensible choice [@jenny_guide_2017].
To use this projection, we need to specify it using the proj-string element, `"+proj=moll"`, in the `st_transform` function:


```r
world_mollweide = st_transform(world, crs = "+proj=moll")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{07-reproj_files/figure-latex/mollproj-1} 

}

\caption{Mollweide projection of the world.}(\#fig:mollproj)
\end{figure}

It is often desirable to minimize distortion for all spatial properties (area, direction, distance) when mapping the world.
One of the most popular projections to achieve this is [Winkel tripel](http://www.winkel.org/other/Winkel%20Tripel%20Projections.htm), illustrated in Figure \@ref(fig:wintriproj).^[
This projection is used, among others, by the National Geographic Society.
]
The result was created with the following command:


```r
world_wintri = st_transform(world, crs = "+proj=wintri")
```




\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{07-reproj_files/figure-latex/wintriproj-1} 

}

\caption{Winkel tripel projection of the world.}(\#fig:wintriproj)
\end{figure}

<!--jn:toDO-->
<!--check if the following block is still correct-->





Moreover, proj-string parameters can be modified in most CRS definitions, for example the center of the projection can be adjusted using the `+lon_0` and `+lat_0` parameters.
The below code transforms the coordinates to the Lambert azimuthal equal-area projection centered on the longitude and latitude of New York City (Figure \@ref(fig:laeaproj2)).


```r
world_laea2 = st_transform(world,
                           crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=-74 +lat_0=40")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{07-reproj_files/figure-latex/laeaproj2-1} 

}

\caption[Lambert azimuthal equal-area projection centered on New York City.]{Lambert azimuthal equal-area projection of the world centered on New York City.}(\#fig:laeaproj2)
\end{figure}

More information on CRS modifications can be found in the [Using PROJ](https://proj.org/usage/index.html) documentation.

<!--toDo:jn-->
<!--revise the last paragraph-->

<!-- There is more to learn about CRSs. -->
<!-- An excellent resource in this area, also implemented in R, is the website R Spatial. -->
<!-- Chapter 6 from this free online book is recommended reading --- see: [rspatial.org/terra/spatial/6-crs.html](https://rspatial.org/terra/spatial/6-crs.html) -->

## Exercises


E1. Create a new object called `nz_wgs` by transforming `nz` object into the WGS84 CRS.

- Create an object of class `crs` for both and use this to query their CRSs.
- With reference to the bounding box of each object, what units does each CRS use?
- Remove the CRS from `nz_wgs` and plot the result: what is wrong with this map of New Zealand and why?



E2. Transform the `world` dataset to the transverse Mercator projection (`"+proj=tmerc"`) and plot the result.
What has changed and why?
Try to transform it back into WGS 84 and plot the new object.
Why does the new object differ from the original one?



E3. Transform the continuous raster (`con_raster`) into NAD83 / UTM zone 12N using the nearest neighbor interpolation method.
What has changed?
How does it influence the results?



E4. Transform the categorical raster (`cat_raster`) into WGS 84 using the bilinear interpolation method.
What has changed?
How does it influence the results?



<!--toDo:jn-->
<!--improve/replace/modify the following q-->
<!-- E5. Create your own proj-string.  -->
<!-- It should have the Lambert Azimuthal Equal Area (`laea`) projection, the WGS84 ellipsoid, the longitude of projection center of 95 degrees west, the latitude of projection center of 60 degrees north, and its units should be in meters. -->
<!-- Next, subset Canada from the `world` object and transform it into the new projection.  -->
<!-- Plot and compare a map before and after the transformation. -->

<!-- ```{r 06-reproj-40} -->
<!-- new_p4s = "+proj=laea +ellps=WGS84 +lon_0=-95 +lat_0=60 +units=m" -->
<!-- canada = dplyr::filter(world, name_long == "Canada") -->
<!-- new_canada = st_transform(canada, new_p4s) -->
<!-- par(mfrow = c(1, 2)) -->
<!-- plot(st_geometry(canada), graticule = TRUE, axes = TRUE) -->
<!-- plot(st_geometry(new_canada), graticule = TRUE, axes = TRUE) -->
<!-- ``` -->

<!--chapter:end:07-reproj.Rmd-->

# Geographic data I/O {#read-write}

## Prerequisites {-}

This chapter requires the following packages:


```r
library(sf)
library(terra)
library(dplyr)
library(spData)
```

## Introduction

<!--toDo:RL-->
<!--revise and update the following section-->

This chapter is about reading and writing geographic data.
Geographic data *import* is essential for geocomputation\index{geocomputation}: real-world applications are impossible without data.
Data *output* is also vital, enabling others to use valuable new or improved datasets resulting from your work.
Taken together, these processes of import/output can be referred to as data I/O.

Geographic data I/O is often done with few lines of code at the beginning and end of projects.
It is often overlooked as a simple one step process.
However, mistakes made at the outset of projects (e.g. using an out-of-date or in some way faulty dataset) can lead to large problems later down the line, so it is worth putting considerable time into identifying which datasets are *available*, where they can be *found* and how to *retrieve* them.
These topics are covered in Section \@ref(retrieving-data), which describes various *geoportals*, which collectively contain many terabytes of data, and how to use them.
To further ease data access, a number of packages for downloading geographic data have been developed.
These are described in Section \@ref(geographic-data-packages).

There are many geographic file formats, each of which has pros and cons.
These are described in Section \@ref(file-formats).
The process of actually reading and writing such file formats efficiently is not covered until Sections \@ref(data-input) and \@ref(data-output), respectively.
The final Section \@ref(visual-outputs) demonstrates methods for saving visual outputs (maps), in preparation for Chapter \@ref(adv-map) on visualization.

## Retrieving open data {#retrieving-data}

<!--toDo:RL-->
<!--revise and update the following section-->
<!-- we should add http://freegisdata.rtwilson.com/ somewhere -->

\index{open data}
A vast and ever-increasing amount of geographic data is available on the internet, much of which is free to access and use (with appropriate credit given to its providers).
In some ways there is now *too much* data, in the sense that there are often multiple places to access the same dataset.
Some datasets are of poor quality.
In this context, it is vital to know where to look, so the first section covers some of the most important sources.
Various 'geoportals' (web services providing geospatial datasets such as [Data.gov](https://catalog.data.gov/dataset?metadata_type=geospatial)) are a good place to start, providing a wide range of data but often only for specific locations (as illustrated in the updated [Wikipedia page](https://en.wikipedia.org/wiki/Geoportal) on the topic).

\index{geoportals}
Some global geoportals overcome this issue.
The [GEOSS portal](http://www.geoportal.org/) and the [Copernicus Open Access Hub](https://scihub.copernicus.eu/), for example, contain many raster datasets with global coverage.
A wealth of vector datasets can be accessed from the [SEDAC](http://sedac.ciesin.columbia.edu/) portal run by the National Aeronautics and Space Administration (NASA) and the European Union's [INSPIRE geoportal](http://inspire-geoportal.ec.europa.eu/), with global and regional coverage.

Most geoportals provide a graphical interface allowing datasets to be queried based on characteristics such as spatial and temporal extent, the United States Geological Survey's [EarthExplorer](https://earthexplorer.usgs.gov/) being a prime example.
*Exploring* datasets interactively on a browser is an effective way of understanding available layers.
*Downloading* data is best done with code, however, from reproducibility and efficiency perspectives.
Downloads can be initiated from the command line using a variety of techniques, primarily via URLs and APIs\index{API} (see the [Sentinel API](https://scihub.copernicus.eu/twiki/do/view/SciHubWebPortal/APIHubDescription) for example).
Files hosted on static URLs can be downloaded with `download.file()`, as illustrated in the code chunk below which accesses PeRL: Permafrost Region Pond and Lake Database from [doi.pangaea.de](https://doi.pangaea.de/10.1594/PANGAEA.868349):


```r
download.file(url = "https://hs.pangaea.de/Maps/PeRL/PeRL_permafrost_landscapes.zip",
              destfile = "PeRL_permafrost_landscapes.zip", 
              mode = "wb")
unzip("PeRL_permafrost_landscapes.zip")
canada_perma_land = read_sf("PeRL_permafrost_landscapes/canada_perma_land.shp")
```

## Geographic data packages

<!--toDo:RL-->
<!--revise and update the following section-->
<!-- JN: btw -- should we add references to these packages? -->

\index{data packages}
Many R packages have been developed for accessing geographic data, some of which are presented in Table \@ref(tab:datapackages).
These provide interfaces to one or more spatial libraries or geoportals and aim to make data access even quicker from the command line.

<!--toDo:JN-->
<!-- update the table -->
\begin{table}

\caption[Selected R packages for geographic data retrieval.]{(\#tab:datapackages)Selected R packages for geographic data retrieval.}
\centering
\resizebox{\linewidth}{!}{
\begin{tabular}[t]{ll}
\toprule
Package & Description\\
\midrule
osmdata & Download and import small OpenStreetMap datasets.\\
osmextract & Download and import large OpenStreetMap datasets.\\
geodata & Download and import imports administrative, elevation, WorldClim data.\\
rnaturalearth & Access to Natural Earth vector and raster data.\\
rnoaa & Imports National Oceanic and Atmospheric Administration (NOAA) climate data.\\
\bottomrule
\end{tabular}}
\end{table}

<!--toDo:JN-->
<!-- add to the table: -->
<!-- - elevatr - https://github.com/jhollist/elevatr/issues/64 -->
<!-- https://github.com/ropensci/rsat -->
<!-- https://github.com/mikejohnson51/climateR/issues/44 -->
<!-- maybe: -->
<!-- - https://github.com/ErikKusch/KrigR -->
<!-- https://cran.r-project.org/web/packages/FedData/index.html -->
<!-- https://github.com/VeruGHub/easyclimate -->
<!-- mention: -->
<!-- - https://github.com/ropensci/MODIStsp -->

It should be emphasized that Table \@ref(tab:datapackages) represents only a small number of available geographic data packages.
For example, a large number of R packages exist to obtain various socio-demographic data, such as **tidycensus** and **tigris** (USA),  **cancensus** (Canada), **eurostat** and **giscoR** (European Union), or **idbr** (international databases) -- read [Analyzing US Census Data](https://walker-data.com/census-r) [@walker_analyzing_2022] to find some examples of how to analyse such data.
Similarly, several R packages exist giving access to spatial data for various regions and countries, such as **bcdata** (Province of British Columbia), **geobr** (Brazil), **RCzechia** (Czechia), or **rgugik** (Poland).
Other notable package is **GSODR**, which provides Global Summary Daily Weather Data in R (see the package's [README](https://github.com/ropensci/GSODR) for an overview of weather data sources).
<!--toDo:JN-->
<!-- ; and **hddtools**, which provides access to a range of hydrological datasets. --> 
<!-- not on CRAN anymore -->

Each data package has its own syntax for accessing data.
This diversity is demonstrated in the subsequent code chunks, which show how to get data using three packages from Table \@ref(tab:datapackages).^[More examples of data downloading using dedicated R packages can be found at https://rspatialdata.github.io/.]
Country borders are often useful and these can be accessed with the `ne_countries()` function from the **rnaturalearth** package as follows:


```r
library(rnaturalearth)
usa = ne_countries(country = "United States of America") # United States borders
class(usa)
#> [1] "SpatialPolygonsDataFrame"
#> attr(,"package")
#> [1] "sp"
# alternative way of accessing the data, with geodata
# geodata::gadm("USA", level = 0, path = tempdir())
```

By default **rnaturalearth** returns objects of class `Spatial*`.
The result can be converted into an `sf` objects with `st_as_sf()` as follows:


```r
usa_sf = st_as_sf(usa)
```

<!--toDo:JN-->
<!-- add info about other world-data packages -->
<!-- https://github.com/wmgeolab/rgeoboundaries/issues/11 -->
<!-- https://github.com/wmgeolab/rgeoboundaries -->
<!-- https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0231866 -->
<!-- https://www.geoboundaries.org/ -->

A second example downloads a series of rasters containing global monthly precipitation sums with spatial resolution of ten minutes (~18.5 km at the equator) using the **geodata** package.
The result is a multilayer object of class `SpatRaster`.


```r
library(geodata)
worldclim_prec = worldclim_global("prec", res = 10, path = tempdir())
class(worldclim_prec)
```

A third example uses the **osmdata** package [@R-osmdata] to find parks from the OpenStreetMap (OSM) database\index{OpenStreetMap}.
As illustrated in the code-chunk below, queries begin with the function `opq()` (short for OpenStreetMap query), the first argument of which is bounding box, or text string representing a bounding box (the city of Leeds in this case).
The result is passed to a function for selecting which OSM elements we're interested in (parks in this case), represented by *key-value pairs*.
Next, they are passed to the function `osmdata_sf()` which does the work of downloading the data and converting it into a list of `sf` objects (see `vignette('osmdata')` for further details):


```r
library(osmdata)
parks = opq(bbox = "leeds uk") |> 
  add_osm_feature(key = "leisure", value = "park") |> 
  osmdata_sf()
```

A limitation with the **osmdata** package is that it is *rate limited*, meaning that it cannot download large OSM datasets (e.g. all the OSM data for a large city).
To overcome this limitation, the **osmextract** package was developed, which can be used to download and import binary `.pbf` files containing compressed versions of the OSM database for pre-defined regions.
<!--todo: add proper citation-->

OpenStreetMap is a vast global database of crowd-sourced data, is growing daily, and has a wider ecosystem of tools enabling easy access to the data, from the [Overpass turbo](https://overpass-turbo.eu/) web service for rapid development and testing of OSM queries to [osm2pgsql](https://osm2pgsql.org/) for importing the data into a PostGIS database.
Although the quality of datasets derived from OSM varies, the data source and wider OSM ecosystems have many advantages: they provide datasets that are available globally, free of charge, and constantly improving thanks to an army of volunteers.
Using OSM encourages 'citizen science' and contributions back to the digital commons (you can start editing data representing a part of the world you know well at [www.openstreetmap.org](https://www.openstreetmap.org)).
Further examples of OSM data in action are provided in Chapters \@ref(gis), \@ref(transport) and \@ref(location).

Sometimes, packages come with built-in datasets.
These can be accessed in four ways: by attaching the package (if the package uses 'lazy loading' as **spData** does), with `data(dataset, package = mypackage)`, by referring to the dataset with `mypackage::dataset`, or with `system.file(filepath, package = mypackage)` to access raw data files.
The following code chunk illustrates the latter two options using the `world` dataset (already loaded by attaching its parent package with `library(spData)`):^[
For more information on data import with R packages, see Sections 5.5 and 5.6 of @gillespie_efficient_2016.
]


```r
world2 = spData::world
world3 = read_sf(system.file("shapes/world.gpkg", package = "spData"))
```

The last example, `system.file("shapes/world.gpkg", package = "spData")`, returns a path to the `world.gpkg` file, which is stored inside of the `"shapes/"` folder of the **spData** package.

\index{geocoding}
Another way to obtain spatial information is to perform geocoding -- transform a description of a location, usually an address, into its coordinates.
This is usually done by sending a query to an online service and getting the location as a result.
Many such services exist that differ in the used method of geocoding, usage limitations, costs, or API key requirements. 
R has several packages for geocoding; however, **tidygeocoder** seems to allow to connect to [the largest number of geocoding services](https://jessecambon.github.io/tidygeocoder/articles/geocoder_services.html) with a consistent interface.
The **tidygeocoder** main function is `geocode`, which takes a data frame with addresses and adds coordinates as `"lat"` and `"long"`.
This function also allows to select a geocoding service with the `method` argument and has many additional parameters.

The example below searches for John Snow blue plaque coordinates located on a building in the Soho district of London.


```r
library(tidygeocoder)
geo_df = data.frame(address = "54 Frith St, London W1D 4SJ, UK")
geo_df = geocode(geo_df, address, method = "osm")
geo_df
```

The resulting data frame can be converted into an `sf` object with `st_as_sf()`.


```r
geo_sf = st_as_sf(geo_df, coords = c("lat", "long"), crs = "EPSG:4326")
```

This package also allows performing the opposite process called reverse geocoding used to get a set of information (name, address, etc.) based on a pair of coordinates.
<!-- https://github.com/jessecambon/tidygeocoder -->

<!--toDo:jn-->
<!-- we should add a rgee section in the bridges chapter and add a reference here -->
<!-- consider data from rgee -->
<!-- rgee - see https://github.com/loreabad6/30DayMapChallenge/blob/main/scripts/day08_blue.R -->
<!-- Finally, there are some packages that allows to download spatial data among many other functions.  -->
<!-- Prominent example here is the **rgee** package  -->
<!-- ee_imagecollection_to_local -->

## Geographic web services

<!--toDo:RL-->
<!--revise and update the following section-->
<!--jn: Robin, I am leaving this section entirely to you -- I have zero knowledge about OWS-->
<!-- potentially useful package - https://github.com/eblondel/geosapi -->
<!-- rstac - https://gist.github.com/h-a-graham/420434c158c139180f5eb82859099082, -->

\index{geographic web services}
In an effort to standardize web APIs for accessing spatial data, the Open Geospatial Consortium (OGC) has created a number of specifications for web services (collectively known as OWS, which is short for OGC Web Services).
These specifications include the Web Feature Service (WFS)\index{geographic web services!WFS}, Web Map Service (WMS)\index{geographic web services!WMS}, Web Map Tile Service (WMTS)\index{geographic web services!WMTS}, the Web Coverage Service (WCS)\index{geographic web services!WCS} and even a Web Processing Service (WPS)\index{geographic web services!WPS}.
Map servers such as PostGIS have adopted these protocols, leading to standardization of queries.
Like other web APIs, OWS APIs use a 'base URL', an 'endpoint' and 'URL query arguments' following a `?` to request data (see the [`best-practices-api-packages`](https://httr.r-lib.org/articles/api-packages.html) vignette in the **httr** package).

There are many requests that can be made to a OWS service.
One of the most fundamental is `getCapabilities`, demonstrated with **httr** functions `GET()` and `modify_url()` below.
The code chunk demonstrates how API\index{API} queries can be constructed and dispatched, in this case to discover the capabilities of a service run by the Food and Agriculture Organization of the United Nations (FAO):


```r
library(httr)
base_url = "http://www.fao.org"
endpoint = "/figis/geoserver/wfs"
q = list(request = "GetCapabilities")
res = GET(url = modify_url(base_url, path = endpoint), query = q)
res$url
#> [1] "https://www.fao.org/figis/geoserver/wfs?request=GetCapabilities"
```

The above code chunk demonstrates how API\index{API} requests can be constructed programmatically with the `GET()` function, which takes a base URL and a list of query parameters which can easily be extended.
The result of the request is saved in `res`, an object of class `response` defined in the **httr** package, which is a list containing information of the request, including the URL.
As can be seen by executing `browseURL(res$url)`, the results can also be read directly in a browser.
One way of extracting the contents of the request is as follows:


```r
txt = content(res, "text")
xml = xml2::read_xml(txt)
```


```r
xml
#> {xml_document} ...
#> [1] <ows:ServiceIdentification>\n  <ows:Title>GeoServer WFS...
#> [2] <ows:ServiceProvider>\n  <ows:ProviderName>UN-FAO Fishe...
#> ...
```

Data can be downloaded from WFS services with the `GetFeature` request and a specific `typeName` (as illustrated in the code chunk below).



Available names differ depending on the accessed web feature service.
One can extract them programmatically using web technologies [@nolan_xml_2014] or scrolling manually through the contents of the `GetCapabilities` output in a browser.


```r
qf = list(request = "GetFeature", typeName = "area:FAO_AREAS")
file = tempfile(fileext = ".gml")
GET(url = base_url, path = endpoint, query = qf, write_disk(file))
fao_areas = read_sf(file)
```

Note the use of `write_disk()` to ensure that the results are written to disk rather than loaded into memory, allowing them to be imported with **sf**.
This example shows how to gain low-level access to web services using **httr**, which can be useful for understanding how web services work.
For many everyday tasks, however, a higher-level interface may be more appropriate, and a number of R packages, and tutorials, have been developed precisely for this purpose.
The package **ows4R** was developed for working with OWS services.

## File formats

\index{file formats}
Geographic datasets are usually stored as files or in spatial databases.
File formats can either store vector or raster data, while spatial databases such as [PostGIS](https://postgis.net/) can store both (see also Section \@ref(postgis)).
Today the variety of file formats may seem bewildering but there has been much consolidation and standardization since the beginnings of GIS software in the 1960s when the first widely distributed program ([SYMAP](https://news.harvard.edu/gazette/story/2011/10/the-invention-of-gis/)) for spatial analysis was created at Harvard University [@coppock_history_1991].

\index{GDAL}
GDAL (which should be pronounced "goo-dal", with the double "o" making a reference to object-orientation), the Geospatial Data Abstraction Library, has resolved many issues associated with incompatibility between geographic file formats since its release in 2000.
GDAL provides a unified and high-performance interface for reading and writing of many raster and vector data formats.^[As we mentioned in Chapter \@ref(geometric-operations), GDAL also contains a set of utility functions allowing for raster mosaicing, resampling, cropping, and reprojecting, etc.]
Many open and proprietary GIS programs, including GRASS, ArcGIS\index{ArcGIS} and QGIS\index{QGIS}, use GDAL\index{GDAL} behind their GUIs\index{graphical user interface} for doing the legwork of ingesting and spitting out geographic data in appropriate formats.

GDAL\index{GDAL} provides access to more than 200 vector and raster data formats.
Table \@ref(tab:formats) presents some basic information about selected and often used spatial file formats.

\begin{table}

\caption[Selected spatial file formats.]{(\#tab:formats)Selected spatial file formats.}
\centering
\begin{tabular}[t]{l>{\raggedright\arraybackslash}p{7em}>{\raggedright\arraybackslash}p{14em}l>{\raggedright\arraybackslash}p{7em}}
\toprule
Name & Extension & Info & Type & Model\\
\midrule
ESRI Shapefile & .shp (the main file) & Popular format consisting of at least three files. No support for: files > 2GB;  mixed types; names > 10 chars; cols > 255. & Vector & Partially open\\
GeoJSON & .geojson & Extends the JSON exchange format by including a subset of the simple feature representation; mostly used for storing coordinates in longitude and latitude; it is extended by the TopoJSON format & Vector & Open\\
KML & .kml & XML-based format for spatial visualization, developed for use with Google Earth. Zipped KML file forms the KMZ format. & Vector & Open\\
GPX & .gpx & XML schema created for exchange of GPS data. & Vector & Open\\
FlatGeobuf & .fgb & Single file format allowing for quick reading and writing of vector data. Has streaming capabilities. & Vector & Open\\
\addlinespace
GeoTIFF & .tif/.tiff & Popular raster format. A TIFF file containing additional spatial metadata. & Raster & Open\\
Arc ASCII & .asc & Text format where the first six lines represent the raster header, followed by the raster cell values arranged in rows and columns. & Raster & Open\\
SQLite/SpatiaLite & .sqlite & Standalone  relational database, SpatiaLite is the spatial extension of SQLite. & Vector and raster & Open\\
ESRI FileGDB & .gdb & Spatial and nonspatial objects created by ArcGIS. Allows: multiple feature classes; topology. Limited support from GDAL. & Vector and raster & Proprietary\\
GeoPackage & .gpkg & Lightweight database container based on SQLite allowing an easy and platform-independent exchange of geodata & Vector and (very limited) raster & Open\\
\bottomrule
\end{tabular}
\end{table}
<!-- additional suggestions from our readers: -->
<!-- - KEA - https://gdal.org/drivers/raster/kea.html -->
<!-- - sfarrow & geoparquet/pandas/GeoFeather -->
<!-- Zarr - long term time series raster cloud format -->

\index{Shapefile}
\index{GeoPackage}
An important development ensuring the standardization and open-sourcing of file formats was the founding of the Open Geospatial Consortium ([OGC](http://www.opengeospatial.org/)) in 1994.
Beyond defining the simple features data model (see Section \@ref(intro-sf)), the OGC also coordinates the development of open standards, for example as used in file formats such as KML\index{KML} and GeoPackage\index{GeoPackage}.
Open file formats of the kind endorsed by the OGC have several advantages over proprietary formats: the standards are published, ensure transparency and open up the possibility for users to further develop and adjust the file formats to their specific needs.

ESRI Shapefile\index{Shapefile} is the most popular vector data exchange format; however, it is not an open format (though its specification is open).
It was developed in the early 1990s and has a number of limitations.
First of all, it is a multi-file format, which consists of at least three files.
It only supports 255 columns, column names are restricted to ten characters and the file size limit is 2 GB.
Furthermore, ESRI Shapefile\index{Shapefile} does not support all possible geometry types, for example, it is unable to distinguish between a polygon and a multipolygon.^[To learn more about ESRI Shapefile limitations and possible alternative file formats, visit http://switchfromshapefile.org/.]
Despite these limitations, a viable alternative had been missing for a long time. 
In the meantime, [GeoPackage](https://www.geopackage.org/)\index{GeoPackage} emerged, and seems to be a more than suitable replacement candidate for ESRI Shapefile.
Geopackage is a format for exchanging geospatial information and an OGC standard. 
The GeoPackage standard describes the rules on how to store geospatial information in a tiny SQLite container.
Hence, GeoPackage is a lightweight spatial database container, which allows the storage of vector and raster data but also of non-spatial data and extensions.
Aside from GeoPackage, there are other geospatial data exchange formats worth checking out (Table \@ref(tab:formats)).

\index{GeoTIFF}
\index{COG}
The GeoTIFF format seems to be the most prominent raster data format.
It allows spatial information, such as CRS, to be embedded within a TIFF file. 
Similar to ESRI Shapefile, this format was firstly developed in the 1990s, but as an open format.
Additionally, GeoTIFF is still being expanded and improved.
One of the most significant recent addition to the GeoTIFF format is its variant called COG (*Cloud Optimized GeoTIFF*).
Raster objects saved as COGs can be hosted on HTTP servers, so other people can read only parts of the file without downloading the whole file (see Sections \@ref(raster-data-read) and \@ref(raster-data-write)).

There is also a plethora of other spatial data formats that we do not explain in detail or mention in Table \@ref(tab:formats) due to the book limits.
If you need to use other formats, we encourage you to read the GDAL documentation about [vector](https://gdal.org/drivers/vector/index.html) and [raster](https://gdal.org/drivers/raster/index.html) drivers.
Additionally, some spatial data formats can store other data models (types) than vector or raster.
It includes LAS and LAZ formats for storing lidar point clouds, and NetCDF and HDF for storing multidimensional arrays.
<!-- do we mention them anywhere in the book and can reference to? -->

Finally, spatial data is also often stored using tabular (non-spatial) text formats, including CSV files or Excel spreadsheets.
For example, this can be convenient to share spatial samples with people who do not use GIS tools or exchange data with other software that does not accept spatial data formats. 
However, this approach has several possible issues -- it is fairly challenging for storing geometries more complex than POINTs and does not directly store information about CRS.

## Data input (I) {#data-input}

Executing commands such as `sf::read_sf()` (the main function we use for loading vector data) or `terra::rast()` (the main function used for loading raster data) silently sets off a chain of events that reads data from files.
Moreover, there are many R packages containing a wide range of geographic data or providing simple access to different data sources.
All of them load the data into R or, more precisely, assign objects to your workspace, stored in RAM accessible from the [`.GlobalEnv`](http://adv-r.had.co.nz/Environments.html) of the R session.

### Vector data {#iovec}

\index{vector!data input}
Spatial vector data comes in a wide variety of file formats.
Most popular representations such as `.geojson` and `.gpkg` files can be imported directly into R with the **sf** function `read_sf()` (or the equivalent `st_read()`), which uses [GDAL's vector drivers](https://gdal.org/drivers/vector/index.html)\index{GDAL} behind the scenes.
`st_drivers()` returns a data frame containing `name` and `long_name` in the first two columns, and features of each driver available to GDAL (and therefore **sf**), including ability to write data and store raster data in the subsequent columns, as illustrated for key file formats in Table \@ref(tab:drivers).  
The following commands show the first three drivers reported the computer's GDAL installation (results can vary depending on the GDAL version installed) and a summary of the their features.
Note that the majority of drivers can write data (51 out of 87) while only 16 formats can efficiently represent raster data in addition to vector data (see `?st_drivers()` for details):


```r
sf_drivers = st_drivers()
head(sf_drivers, n = 3)
summary(sf_drivers[-c(1:2)])
```

\begin{table}

\caption[Sample of available vector drivers.]{(\#tab:drivers)Popular drivers/formats for reading/writing vector data.}
\centering
\begin{tabular}[t]{l>{\raggedright\arraybackslash}p{7em}lllll}
\toprule
name & long\_name & write & copy & is\_raster & is\_vector & vsi\\
\midrule
ESRI Shapefile & ESRI Shapefile & TRUE & FALSE & FALSE & TRUE & TRUE\\
GPX & GPX & TRUE & FALSE & FALSE & TRUE & TRUE\\
KML & Keyhole Markup Language (KML) & TRUE & FALSE & FALSE & TRUE & TRUE\\
GeoJSON & GeoJSON & TRUE & FALSE & FALSE & TRUE & TRUE\\
GPKG & GeoPackage & TRUE & TRUE & TRUE & TRUE & TRUE\\
\bottomrule
\end{tabular}
\end{table}

<!-- One of the major advantages of **sf** is that it is fast. -->
<!-- reference to the vignette -->
The first argument of `read_sf()` is `dsn`, which should be a text string or an object containing a single text string.
The content of a text string could vary between different drivers.
In most cases, as with the ESRI Shapefile\index{Shapefile} (`.shp`) or the `GeoPackage`\index{GeoPackage} format (`.gpkg`), the `dsn` would be a file name.
`read_sf()` guesses the driver based on the file extension, as illustrated for a `.gpkg` file below:


```r
f = system.file("shapes/world.gpkg", package = "spData")
world = read_sf(f, quiet = TRUE)
```

For some drivers, `dsn` could be provided as a folder name, access credentials for a database, or a GeoJSON string representation (see the examples of the `read_sf()` help page for more details).

Some vector driver formats can store multiple data layers.
By default, `read_sf()` automatically reads the first layer of the file specified in `dsn`; however, using the `layer` argument you can specify any other layer.

\index{OGR SQL}
The `read_sf()` function also allows for reading just parts of the file into RAM with two possible mechanisms.
The first one is related to the `query` argument, which allows specifying what part of the data to read with [the OGR SQL query text](https://gdal.org/user/ogr_sql_dialect.html).
An example below extracts data for Tanzania only (Figure \@ref(fig:readsfquery):A).
It is done by specifying that we want to get all columns (`SELECT *`) from the `"world"` layer for which the `name_long` equals to `"Tanzania"`:


```r
tanzania = read_sf(f, query = 'SELECT * FROM world WHERE name_long = "Tanzania"')
```

If you do not know the names of the available columns, a good approach is to just read one row of the data with `'SELECT * FROM world WHERE FID = 1'`.
`FID` represents a *feature ID* -- most often, it is a row number; however, its values depend on the used file format. 
For example, `FID` starts from 0 in ESRI Shapefile, from 1 in some other file formats, or can be even arbitrary.



The second mechanism uses the `wkt_filter` argument.
This argument expects a well-known text representing study area for which we want to extract the data.
Let's try it using a small example -- we want to read polygons from our file that intersect with the buffer of 50,000 meters of Tanzania's borders.
To do it, we need to prepare our "filter" by (a) creating the buffer (Section \@ref(buffers)), (b) converting the `sf` buffer object into an `sfc` geometry object with `st_geometry()`, and (c) translating geometries into their well-known text representation with `st_as_text()`:


```r
tanzania_buf = st_buffer(tanzania, 50000)
tanzania_buf_geom = st_geometry(tanzania_buf)
tanzania_buf_wkt = st_as_text(tanzania_buf_geom)
```

Now, we can apply this "filter" using the `wkt_filter` argument.


```r
tanzania_neigh = read_sf(f, wkt_filter = tanzania_buf_wkt)
```

Our result, shown in Figure \@ref(fig:readsfquery):B, contains Tanzania and every country within its 50 km buffer.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{08-read-write-plot_files/figure-latex/readsfquery-1} 

}

\caption{Reading a subset of the vector data using a query (A) and a wkt filter (B).}(\#fig:readsfquery)
\end{figure}

Naturally, some options are specific to certain drivers.^[
A list of supported vector formats and options can be found at http://gdal.org/ogr_formats.html.
]
For example, think of coordinates stored in a spreadsheet format (`.csv`).
To read in such files as spatial objects, we naturally have to specify the names of the columns (`X` and `Y` in our example below) representing the coordinates.
We can do this with the help of the `options` parameter.
To find out about possible options, please refer to the 'Open Options' section of the corresponding GDAL\index{GDAL} driver description.
For the comma-separated value (csv) format, visit http://www.gdal.org/drv_csv.html.


```r
cycle_hire_txt = system.file("misc/cycle_hire_xy.csv", package = "spData")
cycle_hire_xy = read_sf(cycle_hire_txt,
  options = c("X_POSSIBLE_NAMES=X", "Y_POSSIBLE_NAMES=Y"))
```

Instead of columns describing 'XY' coordinates, a single column can also contain the geometry information.
Well-known text (WKT)\index{well-known text}, well-known binary (WKB)\index{well-known binary}, and the GeoJSON formats are examples of this.
For instance, the `world_wkt.csv` file has a column named `WKT` representing polygons of the world's countries.
We will again use the `options` parameter to indicate this.


```r
world_txt = system.file("misc/world_wkt.csv", package = "spData")
world_wkt = read_sf(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT")
# the same as
world_wkt2 = st_read(world_txt, options = "GEOM_POSSIBLE_NAMES=WKT", 
                    quiet = TRUE, stringsAsFactors = FALSE, as_tibble = TRUE)
```



\BeginKnitrBlock{rmdnote}
Not all of the supported vector file formats store information about their coordinate reference system.
In these situations, it is possible to add the missing information using the `st_set_crs()` function.
Please refer also to Section \@ref(crs-intro) for more information.
\EndKnitrBlock{rmdnote}

\index{KML}
As a final example, we will show how `read_sf()` also reads KML files.
A KML file stores geographic information in XML format - a data format for the creation of web pages and the transfer of data in an application-independent way [@nolan_xml_2014].
Here, we access a KML file from the web.
This file contains more than one layer.
`st_layers()` lists all available layers.
We choose the first layer `Placemarks` and say so with the help of the `layer` parameter in `read_sf()`.


```r
u = "https://developers.google.com/kml/documentation/KML_Samples.kml"
download.file(u, "KML_Samples.kml")
st_layers("KML_Samples.kml")
#> Driver: LIBKML 
#> Available layers:
#>               layer_name geometry_type features fields crs_name
#> 1             Placemarks                      3     11   WGS 84
#> 2      Styles and Markup                      1     11   WGS 84
#> 3       Highlighted Icon                      1     11   WGS 84
#> 4        Ground Overlays                      1     11   WGS 84
#> 5        Screen Overlays                      0     11   WGS 84
#> 6                  Paths                      6     11   WGS 84
#> 7               Polygons                      0     11   WGS 84
#> 8          Google Campus                      4     11   WGS 84
#> 9       Extruded Polygon                      1     11   WGS 84
#> 10 Absolute and Relative                      4     11   WGS 84
kml = read_sf("KML_Samples.kml", layer = "Placemarks")
```

All the examples presented in this section so far have used the **sf** package for geographic data import.
It is fast and flexible but it may be worth looking at other packages for specific file formats.
An example is the **geojsonsf** package.
A [benchmark](https://github.com/ATFutures/geobench) suggests it is around 10 times faster than the **sf** package for reading `.geojson`.



### Raster data {#raster-data-read}

\index{raster!data input}
Similar to vector data, raster data comes in many file formats with some of them supporting multilayer files.
**terra**'s `rast()` command reads in a single layer when a file with just one layer is provided.


```r
raster_filepath = system.file("raster/srtm.tif", package = "spDataLarge")
single_layer = rast(raster_filepath)
```

It also works in case you want to read a multilayer file.


```r
multilayer_filepath = system.file("raster/landsat.tif", package = "spDataLarge")
multilayer_rast = rast(multilayer_filepath)
```

\index{vsicurl}
\index{GDAL}
\index{COG}
All of the previous examples read spatial information from files stored on your hard drive. 
However, GDAL also allows reading data directly from online resources, such as HTTP/HTTPS/FTP web resources.
The only thing we need to do is to add a `/vsicurl/` prefix before the path to the file.
Let's try it by connecting to the global monthly snow probability at 500 m resolution for the period 2000-2012 [@hengl_t_2021_5774954].
Snow probability for December is stored as a Cloud Optimized GeoTIFF (COG) file (see Section \@ref(file-formats)) at \url{https://zenodo.org/record/5774954/files/clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0.tif}.
To read an online file, we just need to provide its URL together with the `/vsicurl/` prefix.


```r
myurl = "/vsicurl/https://zenodo.org/record/5774954/files/clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0.tif"
snow = rast(myurl)
snow
#> class       : SpatRaster 
#> dimensions  : 35849, 86400, 1  (nrow, ncol, nlyr)
#> resolution  : 0.00417, 0.00417  (x, y)
#> extent      : -180, 180, -62, 87.4  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#> source      : clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0.tif 
#> name        : clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0
```

Due to the fact that the input data is COG, we are actually not reading this file to our RAM, but rather creating a connection to it without obtaining any values.
Its values will be read if we apply any value-based operation (e.g., `crop()` or `extract()`).
This allows us also to just read a tiny portion of the data without downloading the entire file.
For example, we can get the snow probability for December in Reykjavik (70%) by specifying its coordinates and applying the `extract()` function:


```r
rey = data.frame(lon = -21.94, lat = 64.15)
snow_rey = extract(snow, rey)
snow_rey
#>   ID clm_snow.prob_esacci.dec_p.90_500m_s0..0cm_2000..2012_v2.0
#> 1  1                                                         70
```

This way, we just downloaded a single value instead of the whole, large GeoTIFF file.

The above example just shows one simple (but useful) case, but there is more to explore.
The `/vsicurl/` prefix also works not only for raster but also for vector file formats.
It allows reading vectors directly from online storage with `read_sf()` just by adding the prefix before the vector file URL.

Importantly, `/vsicurl/` is not the only prefix provided by GDAL -- many more exist, such as `/vsizip/` to read spatial files from ZIP archives without decompressing them beforehand or `/vsis3/` for on-the-fly reading files available in AWS S3 buckets.
You can learn more about it at https://gdal.org/user/virtual_file_systems.html.

<!-- ### Databases -->

<!-- jn:toDo-->
<!-- postgis input example -->

## Data output (O) {#data-output}

Writing geographic data allows you to convert from one format to another and to save newly created objects.
Depending on the data type (vector or raster), object class (e.g., `sf` or `SpatRaster`), and type and amount of stored information (e.g., object size, range of values), it is important to know how to store spatial files in the most efficient way.
The next two sections will demonstrate how to do this.

### Vector data

\index{vector!data output}


The counterpart of `read_sf()` is `write_sf()`.
It allows you to write **sf** objects to a wide range of geographic vector file formats, including the most common such as `.geojson`, `.shp` and `.gpkg`.
Based on the file name, `write_sf()` decides automatically which driver to use. 
The speed of the writing process depends also on the driver.


```r
write_sf(obj = world, dsn = "world.gpkg")
```

**Note**: if you try to write to the same data source again, the function will overwrite the file:


```r
write_sf(obj = world, dsn = "world.gpkg")
```

Instead of overwriting the file, we could add a new layer to the file with `append = TRUE`, which is supported by several spatial formats, including GeoPackage.


```r
write_sf(obj = world, dsn = "world_many_layers.gpkg", append = TRUE)
```

Alternatively, you can use `st_write()` since it is equivalent to `write_sf()`.
However, it has different defaults -- it does not overwrite files (returns an error when you try to do it) and shows a short summary of the written file format and the object.


```r
st_write(obj = world, dsn = "world2.gpkg")
#> Writing layer `world2' to data source `world2.gpkg' using driver `GPKG'
#> Writing 177 features with 10 fields and geometry type Multi Polygon.
```

The `layer_options` argument could be also used for many different purposes.
One of them is to write spatial data to a text file.
This can be done by specifying `GEOMETRY` inside of `layer_options`. 
It could be either `AS_XY` for simple point datasets (it creates two new columns for coordinates) or `AS_WKT` for more complex spatial data (one new column is created which contains the well-known text representation of spatial objects).


```r
write_sf(cycle_hire_xy, "cycle_hire_xy.csv", layer_options = "GEOMETRY=AS_XY")
write_sf(world_wkt, "world_wkt.csv", layer_options = "GEOMETRY=AS_WKT")
```



### Raster data {#raster-data-write}

\index{raster!data output}
The `writeRaster()` function saves `SpatRaster` objects to files on disk. 
The function expects input regarding output data type and file format, but also accepts GDAL options specific to a selected file format (see `?writeRaster` for more details).

\index{raster!data types}
The **terra** package offers seven data types when saving a raster: INT1U, INT2S, INT2U, INT4S, INT4U, FLT4S, and FLT8S.^[
Using INT4U is not recommended as R does not support 32-bit unsigned integers.
]
The data type determines the bit representation of the raster object written to disk (Table \@ref(tab:datatypes)).
Which data type to use depends on the range of the values of your raster object.
The more values a data type can represent, the larger the file will get on disk.
Unsigned integers (INT1U, INT2U, INT4U) are suitable for categorical data, while float numbers (FLT4S and FLT8S) usually represent continuous data.
`writeRaster()` uses FLT4S as the default.
While this works in most cases, the size of the output file will be unnecessarily large if you save binary or categorical data.
Therefore, we would recommend to use the data type that needs the least storage space, but is still able to represent all values (check the range of values with the `summary()` function).

\begin{table}

\caption[Data types supported by the terra package.]{(\#tab:datatypes)Data types supported by the terra package.}
\centering
\begin{tabular}[t]{lll}
\toprule
Data type & Minimum value & Maximum value\\
\midrule
INT1U & 0 & 255\\
INT2S & -32,767 & 32,767\\
INT2U & 0 & 65,534\\
INT4S & -2,147,483,647 & 2,147,483,647\\
INT4U & 0 & 4,294,967,296\\
\addlinespace
FLT4S & -3.4e+38 & 3.4e+38\\
FLT8S & -1.7e+308 & 1.7e+308\\
\bottomrule
\end{tabular}
\end{table}

By default, the output file format is derived from the filename.
Naming a file `*.tif` will create a GeoTIFF file, as demonstrated below:


```r
writeRaster(single_layer, filename = "my_raster.tif", datatype = "INT2U")
```

Some raster file formats have additional options, that can be set by providing [GDAL parameters](http://www.gdal.org/formats_list.html) to the `options` argument of `writeRaster()`.
GeoTIFF files are written in **terra**, by default, with the LZW compression `gdal = c("COMPRESS=LZW")`.
To change or disable the compression, we need to modify this argument.


```r
writeRaster(x = single_layer, filename = "my_raster.tif",
            gdal = c("COMPRESS=NONE"), overwrite = TRUE)
```

Additionally, we can save our raster object as COG (*Cloud Optimized GeoTIFF*, Section \@ref(file-formats)) with the `filetype = "COG"` options.


```r
writeRaster(x = single_layer, filename = "my_raster.tif",
            filetype = "COG", overwrite = TRUE)
```


## Visual outputs

\index{map making!outputs}
R supports many different static and interactive graphics formats.
The most general method to save a static plot is to open a graphic device, create a plot, and close it, for example:


```r
png(filename = "lifeExp.png", width = 500, height = 350)
plot(world["lifeExp"])
dev.off()
```

Other available graphic devices include `pdf()`, `bmp()`, `jpeg()`, and `tiff()`. 
You can specify several properties of the output plot, including width, height and resolution.

\index{tmap (package)!saving maps}
Additionally, several graphic packages provide their own functions to save a graphical output.
For example, the **tmap** package has the `tmap_save()` function.
You can save a `tmap` object to different graphic formats or an HTML file by specifying the object name and a file path to a new file.


```r
library(tmap)
tmap_obj = tm_shape(world) + tm_polygons(col = "lifeExp")
tmap_save(tmap_obj, filename = "lifeExp_tmap.png")
```

On the other hand, you can save interactive maps created in the **mapview** package as an HTML file or image using the `mapshot()` function:


```r
library(mapview)
mapview_obj = mapview(world, zcol = "lifeExp", legend = TRUE)
mapshot(mapview_obj, file = "my_interactive_map.html")
```

## Exercises


E1. List and describe three types of vector, raster, and geodatabase formats.




E2. Name at least two differences between the **sf** functions `read_sf()` and `st_read()`.





E3. Read the `cycle_hire_xy.csv` file from the **spData** package as a spatial object (Hint: it is located in the `misc` folder).
What is a geometry type of the loaded object? 



E4. Download the borders of Germany using **rnaturalearth**, and create a new object called `germany_borders`.
Write this new object to a file of the GeoPackage format.



E5. Download the global monthly minimum temperature with a spatial resolution of five minutes using the **geodata** package.
Extract the June values, and save them to a file named `tmin_june.tif` file (hint: use `terra::subset()`).



E6. Create a static map of Germany's borders, and save it to a PNG file.



E7. Create an interactive map using data from the `cycle_hire_xy.csv` file. 
Export this map to a file called `cycle_hire.html`.

<!--chapter:end:08-read-write-plot.Rmd-->

# (PART) Extensions {-}

# Making maps with R {#adv-map}

## Prerequisites {-}

- This chapter requires the following packages that we have already been using:


```r
library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
```

- In addition, it uses the following visualization packages (also install shiny if you want to develop interactive mapping applications):


```r
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package
```

## Introduction

A satisfying and important aspect of geographic research is communicating the results.
Map making --- the art of cartography --- is an ancient skill that involves communication, intuition, and an element of creativity.
Static mapping in R is straightforward with the `plot()` function, as we saw in Section \@ref(basic-map).
It is possible to create advanced maps using base R methods [@murrell_r_2016].
The focus of this chapter, however, is cartography with dedicated map-making packages.
When learning a new skill, it makes sense to gain depth-of-knowledge in one area before branching out.
Map making is no exception, hence this chapter's coverage of one package (**tmap**) in depth rather than many superficially.

In addition to being fun and creative, cartography also has important practical applications.
A carefully crafted map can be the best way of communicating the results of your work, but poorly designed maps can leave a bad impression.
Common design issues include poor placement, size and readability of text and careless selection of colors, as outlined in the style [guide](https://www.tandf.co.uk//journals/authors/style/TJOM-suppmaterial-quick-guide.pdf) of the Journal of Maps.
Furthermore, poor map making can hinder the communication of results [@brewer_designing_2015]:

> Amateur-looking maps can undermine your audience’s ability to understand important information and weaken the presentation of a professional data investigation.

Maps have been used for several thousand years for a wide variety of purposes.
Historic examples include maps of buildings and land ownership in the Old Babylonian dynasty more than 3000 years ago and Ptolemy's world map in his masterpiece *Geography* nearly 2000 years ago [@talbert_ancient_2014].

Map making has historically been an activity undertaken only by, or on behalf of, the elite.
This has changed with the emergence of open source mapping software such as the R package **tmap** and the 'print composer' in QGIS\index{QGIS} which enable anyone to make high-quality maps, enabling 'citizen science'.
Maps are also often the best way to present the findings of geocomputational research in a way that is accessible.
Map making is therefore a critical part of geocomputation\index{geocomputation} and its emphasis not only on describing, but also *changing* the world.

This chapter shows how to make a wide range of maps.
The next section covers a range of static maps, including aesthetic considerations, facets and inset maps.
Sections \@ref(animated-maps) to \@ref(mapping-applications) cover animated and interactive maps (including web maps and mapping applications).
Finally, Section \@ref(other-mapping-packages) covers a range of alternative map-making packages including **ggplot2** and **cartogram**.

## Static maps

\index{map making!static maps}
Static maps are the most common type of visual output from geocomputation.
Standard formats include `.png` and `.pdf` for raster and vector outputs respectively.
Initially, static maps were the only type of maps that R could produce.
Things advanced with the release of **sp** [see @pebesma_classes_2005] and many techniques for map making have been developed since then.
However, despite the innovation of interactive mapping, static plotting was still the emphasis of geographic data visualisation in R a decade later [@cheshire_spatial_2015].

The generic `plot()` function is often the fastest way to create static maps from vector and raster spatial objects (see sections \@ref(basic-map) and \@ref(basic-map-raster)).
Sometimes, simplicity and speed are priorities, especially during the development phase of a project, and this is where `plot()` excels.
The base R approach is also extensible, with `plot()` offering dozens of arguments.
Another approach is the **grid** package which allows low level control of static maps, as illustrated in Chapter [14](https://www.stat.auckland.ac.nz/~paul/RG2e/chapter14.html) of @murrell_r_2016.
This section focuses on **tmap** and emphasizes the important aesthetic and layout options.

\index{tmap (package)}
**tmap** is a powerful and flexible map-making package with sensible defaults.
It has a concise syntax that allows for the creation of attractive maps with minimal code which will be familiar to **ggplot2** users.
It also has the unique capability to generate static and interactive maps using the same code via `tmap_mode()`.
Finally, it accepts a wider range of spatial classes (including `raster` objects) than alternatives such as **ggplot2** (see the vignettes [`tmap-getstarted`](https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html) and [`tmap-changes-v2`](https://cran.r-project.org/web/packages/tmap/vignettes/tmap-changes-v2.html), as well as @tennekes_tmap_2018, for further documentation).

### tmap basics

\index{tmap (package)!basics}
Like **ggplot2**, **tmap** is based on the idea of a 'grammar of graphics' [@wilkinson_grammar_2005].
This involves a separation between the input data and the aesthetics (how data are visualised): each input dataset can be 'mapped' in a range of different ways including location on the map (defined by data's `geometry`), color, and other visual variables.
The basic building block is `tm_shape()` (which defines input data, raster and vector objects), followed by one or more layer elements such as `tm_fill()` and `tm_dots()`.
This layering is demonstrated in the chunk below, which generates the maps presented in Figure \@ref(fig:tmshape):


```r
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

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/tmshape-1} 

}

\caption[New Zealand's shape plotted using tmap functions.]{New Zealand's shape plotted with fill (left), border (middle) and fill and border (right) layers added using tmap functions.}(\#fig:tmshape)
\end{figure}

The object passed to `tm_shape()` in this case is `nz`, an `sf` object representing the regions of New Zealand (see Section \@ref(intro-sf) for more on `sf` objects).
Layers are added to represent `nz` visually, with `tm_fill()` and `tm_borders()` creating shaded areas (left panel) and border outlines (middle panel) in Figure \@ref(fig:tmshape), respectively.

This is an intuitive approach to map making:
the common task of *adding* new layers is undertaken by the addition operator `+`, followed by `tm_*()`.
The asterisk (\*) refers to a wide range of layer types which have self-explanatory names including `fill`, `borders` (demonstrated above), `bubbles`, `text` and `raster` (see `help("tmap-element")` for a full list).
This layering is illustrated in the right panel of Figure \@ref(fig:tmshape), the result of adding a border *on top of* the fill layer.

\BeginKnitrBlock{rmdnote}
`qtm()` is a handy function to create **q**uick **t**hematic **m**aps (hence the snappy name).
It is concise and provides a good default visualization in many cases:
`qtm(nz)`, for example, is equivalent to `tm_shape(nz) + tm_fill() + tm_borders()`.
Further, layers can be added concisely using multiple `qtm()` calls, such as `qtm(nz) + qtm(nz_height)`.
The disadvantage is that it makes aesthetics of individual layers harder to control, explaining why we avoid teaching it in this chapter.
\EndKnitrBlock{rmdnote}

### Map objects {#map-obj}

A useful feature of **tmap** is its ability to store *objects* representing maps.
The code chunk below demonstrates this by saving the last plot in Figure \@ref(fig:tmshape) as an object of class `tmap` (note the use of `tm_polygons()` which condenses `tm_fill()  + tm_borders()` into a single function):


```r
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)
#> [1] "tmap"
```

`map_nz` can be plotted later, for example by adding additional layers (as shown below) or simply running `map_nz` in the console, which is equivalent to `print(map_nz)`.

New *shapes* can be added with `+ tm_shape(new_obj)`.
In this case `new_obj` represents a new spatial object to be plotted on top of preceding layers.
When a new shape is added in this way, all subsequent aesthetic functions refer to it, until another new shape is added.
This syntax allows the creation of maps with multiple shapes and layers, as illustrated in the next code chunk which uses the function `tm_raster()` to plot a raster layer (with `alpha` set to make the layer semi-transparent):


```r
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(alpha = 0.7)
```

Building on the previously created `map_nz` object, the preceding code creates a new map object `map_nz1` that contains another shape (`nz_elev`) representing average elevation across New Zealand (see Figure \@ref(fig:tmlayers), left).
More shapes and layers can be added, as illustrated in the code chunk below which creates `nz_water`, representing New Zealand's [territorial waters](https://en.wikipedia.org/wiki/Territorial_waters), and adds the resulting lines to an existing map object.


```r
nz_water = st_union(nz) |> st_buffer(22200) |> 
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()
```

There is no limit to the number of layers or shapes that can be added to `tmap` objects.
The same shape can even be used multiple times.
The final map illustrated in Figure \@ref(fig:tmlayers) is created by adding a layer representing high points (stored in the object `nz_height`) onto the previously created `map_nz2` object with `tm_dots()` (see `?tm_dots` and `?tm_bubbles` for details on **tmap**'s point plotting functions).
The resulting map, which has four layers, is illustrated in the right-hand panel of Figure \@ref(fig:tmlayers):


```r
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()
```

A useful and little known feature of **tmap** is that multiple map objects can be arranged in a single 'metaplot' with `tmap_arrange()`.
This is demonstrated in the code chunk below which plots `map_nz1` to `map_nz3`, resulting in Figure \@ref(fig:tmlayers).


```r
tmap_arrange(map_nz1, map_nz2, map_nz3)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/tmlayers-1} 

}

\caption[Additional layers added to the output of Figure 9.1.]{Maps with additional layers added to the final map of Figure 9.1.}(\#fig:tmlayers)
\end{figure}

More elements can also be added with the `+` operator.
Aesthetic settings, however, are controlled by arguments to layer functions.

### Aesthetics

\index{tmap (package)!aesthetics}
The plots in the previous section demonstrate **tmap**'s default aesthetic settings.
Gray shades are used for `tm_fill()` and  `tm_bubbles()` layers and a continuous black line is used to represent lines created with `tm_lines()`.
Of course, these default values and other aesthetics can be overridden.
The purpose of this section is to show how.

There are two main types of map aesthetics: those that change with the data and those that are constant.
Unlike **ggplot2**, which uses the helper function `aes()` to represent variable aesthetics, **tmap** accepts aesthetic arguments directly.
To map a variable to an aesthetic, pass its column name to the corresponding argument, and to set a fixed aesthetic, pass the desired value instead.^[
If there is a clash between a fixed value and a column name, the column name takes precedence. This can be verified by running the next code chunk after running `nz$red = 1:nrow(nz)`.
]
The most commonly used aesthetics for fill and border layers include color, transparency, line width and line type, set with `col`, `alpha`, `lwd`, and `lty` arguments, respectively.
The impact of setting these with fixed values is illustrated in Figure \@ref(fig:tmstatic).


```r
ma1 = tm_shape(nz) + tm_fill(col = "red")
ma2 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3)
ma3 = tm_shape(nz) + tm_borders(col = "blue")
ma4 = tm_shape(nz) + tm_borders(lwd = 3)
ma5 = tm_shape(nz) + tm_borders(lty = 2)
ma6 = tm_shape(nz) + tm_fill(col = "red", alpha = 0.3) +
  tm_borders(col = "blue", lwd = 3, lty = 2)
tmap_arrange(ma1, ma2, ma3, ma4, ma5, ma6)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/tmstatic-1} 

}

\caption[The impact of changing commonly used aesthetics.]{The impact of changing commonly used fill and border aesthetics to fixed values.}(\#fig:tmstatic)
\end{figure}



Like base R plots, arguments defining aesthetics can also receive values that vary.
Unlike the base R code below (which generates the left panel in Figure \@ref(fig:tmcol)), **tmap** aesthetic arguments will not accept a numeric vector:


```r
plot(st_geometry(nz), col = nz$Land_area)  # works
tm_shape(nz) + tm_fill(col = nz$Land_area) # fails
#> Error: Fill argument neither colors nor valid variable name(s)
```

Instead `col` (and other aesthetics that can vary such as `lwd` for line layers and `size` for point layers) requires a character string naming an attribute associated with the geometry to be plotted.
Thus, one would achieve the desired result as follows (plotted in the right-hand panel of Figure \@ref(fig:tmcol)):


```r
tm_shape(nz) + tm_fill(col = "Land_area")
```

\begin{figure}[t]

{\centering \includegraphics[width=0.45\linewidth]{09-mapping_files/figure-latex/tmcol-1} \includegraphics[width=0.45\linewidth]{09-mapping_files/figure-latex/tmcol-2} 

}

\caption[Comparison of base graphics and tmap]{Comparison of base (left) and tmap (right) handling of a numeric color field.}(\#fig:tmcol)
\end{figure}

An important argument in functions defining aesthetic layers such as `tm_fill()` is `title`, which sets the title of the associated legend.
The following code chunk demonstrates this functionality by providing a more attractive name than the variable name `Land_area` (note the use of `expression()` to create superscript text):


```r
legend_title = expression("Area (km"^2*")")
map_nza = tm_shape(nz) +
  tm_fill(col = "Land_area", title = legend_title) + tm_borders()
```

### Color settings

\index{tmap (package)!color breaks}
Color settings are an important part of map design.
They can have a major impact on how spatial variability is portrayed as illustrated in Figure \@ref(fig:tmpal).
This shows four ways of coloring regions in New Zealand depending on median income, from left to right (and demonstrated in the code chunk below):

- The default setting uses 'pretty' breaks, described in the next paragraph
- `breaks` allows you to manually set the breaks
- `n` sets the number of bins into which numeric variables are categorized
- `palette` defines the color scheme, for example `BuGn`


```r
tm_shape(nz) + tm_polygons(col = "Median_income")
breaks = c(0, 3, 4, 5) * 10000
tm_shape(nz) + tm_polygons(col = "Median_income", breaks = breaks)
tm_shape(nz) + tm_polygons(col = "Median_income", n = 10)
tm_shape(nz) + tm_polygons(col = "Median_income", palette = "BuGn")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/tmpal-1} 

}

\caption[Illustration of settings that affect color settings.]{Illustration of settings that affect color settings. The results show (from left to right): default settings, manual breaks, n breaks, and the impact of changing the palette.}(\#fig:tmpal)
\end{figure}

Another way to change color settings is by altering color break (or bin) settings.
In addition to manually setting `breaks` **tmap** allows users to specify algorithms to automatically create breaks with the `style` argument.
\index{tmap (package)!break styles}
Here are six of the most useful break styles:

- `style = "pretty"`, the default setting, rounds breaks into whole numbers where possible and spaces them evenly;
- `style = "equal"` divides input values into bins of equal range and is appropriate for variables with a uniform distribution (not recommended for variables with a skewed distribution as the resulting map may end-up having little color diversity);
- `style = "quantile"` ensures the same number of observations fall into each category (with the potential downside that bin ranges can vary widely);
- `style = "jenks"` identifies groups of similar values in the data and maximizes the differences between categories;
- `style = "cont"` (and `"order"`) present a large number of colors over continuous color fields and are particularly suited for continuous rasters (`"order"` can help visualize skewed distributions);
- `style = "cat"` was designed to represent categorical values and assures that each category receives a unique color.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/break-styles-1} 

}

\caption[Illustration of different binning methods using tmap.]{Illustration of different binning methods set using the style argument in tmap.}(\#fig:break-styles)
\end{figure}

\BeginKnitrBlock{rmdnote}
Although `style` is an argument of **tmap** functions, in fact it originates as an argument in `classInt::classIntervals()` --- see the help page of this function for details.
\EndKnitrBlock{rmdnote}

Palettes define the color ranges associated with the bins and  determined by the `breaks`, `n`, and `style` arguments described above.
The default color palette is specified in `tm_layout()` (see Section \@ref(layouts) to learn more); however, it could be quickly changed using the `palette` argument.
It expects a vector of colors or a new color palette name, which can be selected interactively with `tmaptools::palette_explorer()`.
You can add a `-` as prefix to reverse the palette order.

There are three main groups of color palettes\index{map making!color palettes}: categorical, sequential and diverging (Figure \@ref(fig:colpal)), and each of them serves a different purpose.
Categorical palettes consist of easily distinguishable colors and are most appropriate for categorical data without any particular order such as state names or land cover classes.
Colors should be intuitive: rivers should be blue, for example, and pastures green.
Avoid too many categories: maps with large legends and many colors can be uninterpretable.^[
`col = "MAP_COLORS"` can be used in maps with a large number of individual polygons (for example, a map of individual countries) to create unique colors for adjacent polygons.
] 

The second group is sequential palettes.
These follow a gradient, for example from light to dark colors (light colors tend to represent lower values), and are appropriate for continuous (numeric) variables.
Sequential palettes can be single (`Blues` go from light to dark blue, for example) or multi-color/hue (`YlOrBr` is gradient from light yellow to brown via orange, for example), as demonstrated in the code chunk below --- output not shown, run the code yourself to see the results!


```r
tm_shape(nz) + tm_polygons("Population", palette = "Blues")
tm_shape(nz) + tm_polygons("Population", palette = "YlOrBr")
```

The last group, diverging palettes, typically range between three distinct colors (purple-white-green in Figure \@ref(fig:colpal)) and are usually created by joining two single-color sequential palettes with the darker colors at each end.
Their main purpose is to visualize the difference from an important reference point, e.g., a certain temperature, the median household income or the mean probability for a drought event.
The reference point's value can be adjusted in **tmap** using the `midpoint` argument.

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{09-mapping_files/figure-latex/colpal-1} 

}

\caption{Examples of categorical, sequential and diverging palettes.}(\#fig:colpal)
\end{figure}

There are two important principles for consideration when working with colors: perceptibility and accessibility.
Firstly, colors on maps should match our perception. 
This means that certain colors are viewed through our experience and also cultural lenses.
For example, green colors usually represent vegetation or lowlands and blue is connected with water or cool.
Color palettes should also be easy to understand to effectively convey information.
It should be clear which values are lower and which are higher, and colors should change gradually.
This property is not preserved in the rainbow color palette; therefore, we suggest avoiding it in geographic data visualization [@borland_rainbow_2007].
Instead, [the viridis color palettes](https://cran.r-project.org/web/packages/viridis/), also available in **tmap**, can be used.
Secondly, changes in colors should be accessible to the largest number of people.
Therefore, it is important to use colorblind friendly palettes as often as possible.^[See the "Color blindness simulator" options in `tmaptools::palette_explorer()`.]

### Layouts

\index{tmap (package)!layouts}
The map layout refers to the combination of all map elements into a cohesive map.
Map elements include among others the objects to be mapped, the title, the scale bar, margins and aspect ratios, while the color settings covered in the previous section relate to the palette and break-points used to affect how the map looks.
Both may result in subtle changes that can have an equally large impact on the impression left by your maps.

Additional elements such as north arrows\index{tmap (package)!north arrows} and scale bars\index{tmap (package)!scale bars} have their own functions: `tm_compass()` and `tm_scale_bar()` (Figure \@ref(fig:na-sb)).


```r
map_nz + 
  tm_compass(type = "8star", position = c("left", "top")) +
  tm_scale_bar(breaks = c(0, 100, 200), text.size = 1)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{09-mapping_files/figure-latex/na-sb-1} 

}

\caption[Map with a north arrow and scale bar.]{Map with additional elements - a north arrow and scale bar.}(\#fig:na-sb)
\end{figure}

**tmap** also allows a wide variety of layout settings to be changed, some of which, produced using the following code (see `args(tm_layout)` or `?tm_layout` for a full list), are illustrated in Figure \@ref(fig:layout1):


```r
map_nz + tm_layout(title = "New Zealand")
map_nz + tm_layout(scale = 5)
map_nz + tm_layout(bg.color = "lightblue")
map_nz + tm_layout(frame = FALSE)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/layout1-1} 

}

\caption[Layout options specified by the tmap arguments.]{Layout options specified by (from left to right) title, scale, bg.color and frame arguments.}(\#fig:layout1)
\end{figure}

The other arguments in `tm_layout()` provide control over many more aspects of the map in relation to the canvas on which it is placed.
Here are some useful layout settings (some of which are illustrated in Figure \@ref(fig:layout2)):

- Frame width (`frame.lwd`) and an option to allow double lines (`frame.double.line`)
- Margin settings including `outer.margin` and `inner.margin`
- Font settings controlled by `fontface` and `fontfamily`
- Legend settings including binary options such as `legend.show` (whether or not to show the legend) `legend.only` (omit the map) and `legend.outside` (should the legend go outside the map?), as well as multiple choice settings such as `legend.position`
- Default colors of aesthetic layers (`aes.color`), map attributes such as the frame (`attr.color`)
- Color settings controlling `sepia.intensity` (how yellowy the map looks) and `saturation` (a color-grayscale)

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/layout2-1} 

}

\caption{Illustration of selected layout options.}(\#fig:layout2)
\end{figure}

The impact of changing the color settings listed above is illustrated in Figure \@ref(fig:layout3) (see `?tm_layout` for a full list).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/layout3-1} 

}

\caption{Illustration of selected color-related layout options.}(\#fig:layout3)
\end{figure}

\index{tmap (package)!styles}
Beyond the low-level control over layouts and colors, **tmap** also offers high-level styles, using the `tm_style()` function (representing the second meaning of 'style' in the package).
Some styles such as `tm_style("cobalt")` result in stylized maps, while others such as `tm_style("gray")` make more subtle changes, as illustrated in Figure \@ref(fig:tmstyles), created using the code below (see `08-tmstyles.R`):


```r
map_nza + tm_style("bw")
map_nza + tm_style("classic")
map_nza + tm_style("cobalt")
map_nza + tm_style("col_blind")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/tmstyles-1} 

}

\caption[Selected tmap styles.]{Selected tmap styles.}(\#fig:tmstyles)
\end{figure}

\BeginKnitrBlock{rmdnote}
A preview of predefined styles can be generated by executing `tmap_style_catalogue()`.
This creates a folder called `tmap_style_previews` containing nine images.
Each image, from `tm_style_albatross.png` to `tm_style_white.png`, shows a faceted map of the world in the corresponding style.
Note: `tmap_style_catalogue()` takes some time to run.
\EndKnitrBlock{rmdnote}

### Faceted maps

\index{map making!faceted maps}
\index{tmap (package)!faceted maps}
Faceted maps, also referred to as 'small multiples', are composed of many maps arranged side-by-side, and sometimes stacked vertically [@meulemans_small_2017].
Facets enable the visualization of how spatial relationships change with respect to another variable, such as time.
The changing populations of settlements, for example, can be represented in a faceted map with each panel representing the population at a particular moment in time.
The time dimension could be represented via another *aesthetic* such as color.
However, this risks cluttering the map because it will involve multiple overlapping points (cities do not tend to move over time!).

Typically all individual facets in a faceted map contain the same geometry data repeated multiple times, once for each column in the attribute data (this is the default plotting method for `sf` objects, see Chapter \@ref(spatial-class)).
However, facets can also represent shifting geometries such as the evolution of a point pattern over time.
This use case of faceted plot is illustrated in Figure \@ref(fig:urban-facet).


```r
urb_1970_2030 = urban_agglomerations |> 
  filter(year %in% c(1970, 1990, 2010, 2030))

tm_shape(world) +
  tm_polygons() +
  tm_shape(urb_1970_2030) +
  tm_symbols(col = "black", border.col = "white", size = "population_millions") +
  tm_facets(by = "year", nrow = 2, free.coords = FALSE)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/urban-facet-1} 

}

\caption[Faceted map showing urban agglomerations.]{Faceted map showing the top 30 largest urban agglomerations from 1970 to 2030 based on population projections by the United Nations.}(\#fig:urban-facet)
\end{figure}

The preceding code chunk demonstrates key features of faceted maps created with **tmap**:

- Shapes that do not have a facet variable are repeated (the countries in `world` in this case)
- The `by` argument which varies depending on a variable (`year` in this case).
- The `nrow`/`ncol` setting specifying the number of rows and columns that facets should be arranged into
- The `free.coords` parameter specifying if each map has its own bounding box

In addition to their utility for showing changing spatial relationships, faceted maps are also useful as the foundation for animated maps (see Section \@ref(animated-maps)).

### Inset maps

\index{map making!inset maps}
\index{tmap (package)!inset maps}
An inset map is a smaller map rendered within or next to the main map. 
It could serve many different purposes, including providing a context (Figure \@ref(fig:insetmap1)) or bringing some non-contiguous regions closer to ease their comparison (Figure \@ref(fig:insetmap2)).
They could be also used to focus on a smaller area in more detail or to cover the same area as the map, but representing a different topic.

In the example below, we create a map of the central part of New Zealand's Southern Alps.
Our inset map will show where the main map is in relation to the whole New Zealand.
The first step is to define the area of interest, which can be done by creating a new spatial object, `nz_region`.


```r
nz_region = st_bbox(c(xmin = 1340000, xmax = 1450000,
                      ymin = 5130000, ymax = 5210000),
                    crs = st_crs(nz_height)) |> 
  st_as_sfc()
```

In the second step, we create a base map showing the New Zealand's Southern Alps area. 
This is a place where the most important message is stated. 


```r
nz_height_map = tm_shape(nz_elev, bbox = nz_region) +
  tm_raster(style = "cont", palette = "YlGn", legend.show = TRUE) +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 1) +
  tm_scale_bar(position = c("left", "bottom"))
```

The third step consists of the inset map creation. 
It gives a context and helps to locate the area of interest. 
Importantly, this map needs to clearly indicate the location of the main map, for example by stating its borders.


```r
nz_map = tm_shape(nz) + tm_polygons() +
  tm_shape(nz_height) + tm_symbols(shape = 2, col = "red", size = 0.1) + 
  tm_shape(nz_region) + tm_borders(lwd = 3) 
```

Finally, we combine the two maps using the function `viewport()` from the **grid** package, the first arguments of which specify the center location (`x` and `y`) and a size (`width` and `height`) of the inset map.


```r
library(grid)
nz_height_map
print(nz_map, vp = viewport(0.8, 0.27, width = 0.5, height = 0.5))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/insetmap1-1} 

}

\caption[Inset map providing a context.]{Inset map providing a context - location of the central part of the Southern Alps in New Zealand.}(\#fig:insetmap1)
\end{figure}

Inset map can be saved to file either by using a graphic device (see Section \@ref(visual-outputs)) or the `tmap_save()` function and its arguments - `insets_tm` and `insets_vp`.

Inset maps are also used to create one map of non-contiguous areas.
Probably, the most often used example is a map of the United States, which consists of the contiguous United States, Hawaii and Alaska.
It is very important to find the best projection for each individual inset in these types of cases (see Chapter \@ref(reproj-geo-data) to learn more).
We can use US National Atlas Equal Area for the map of the contiguous United States by putting its EPSG code in the `projection` argument of `tm_shape()`.


```r
us_states_map = tm_shape(us_states, projection = 2163) + tm_polygons() + 
  tm_layout(frame = FALSE)
```

The rest of our objects, `hawaii` and `alaska`, already have proper projections; therefore, we just need to create two separate maps:


```r
hawaii_map = tm_shape(hawaii) + tm_polygons() + 
  tm_layout(title = "Hawaii", frame = FALSE, bg.color = NA, 
            title.position = c("LEFT", "BOTTOM"))
alaska_map = tm_shape(alaska) + tm_polygons() + 
  tm_layout(title = "Alaska", frame = FALSE, bg.color = NA)
```

The final map is created by combining and arranging these three maps:


```r
us_states_map
print(hawaii_map, vp = grid::viewport(0.35, 0.1, width = 0.2, height = 0.1))
print(alaska_map, vp = grid::viewport(0.15, 0.15, width = 0.3, height = 0.3))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/insetmap2-1} 

}

\caption{Map of the United States.}(\#fig:insetmap2)
\end{figure}

The code presented above is compact and can be used as the basis for other inset maps but the results, in Figure \@ref(fig:insetmap2), provide a poor representation of the locations of Hawaii and Alaska.
For a more in-depth approach, see the [`us-map`](https://geocompr.github.io/geocompkg/articles/us-map.html) vignette from the **geocompkg**.

## Animated maps

\index{map making!animated maps}
\index{tmap (package)!animated maps}
Faceted maps, described in Section \@ref(faceted-maps), can show how spatial distributions of variables change (e.g., over time), but the approach has disadvantages.
Facets become tiny when there are many of them.
Furthermore, the fact that each facet is physically separated on the screen or page means that subtle differences between facets can be hard to detect.

Animated maps solve these issues.
Although they depend on digital publication, this is becoming less of an issue as more and more content moves online.
Animated maps can still enhance paper reports: you can always link readers to a web-page containing an animated (or interactive) version of a printed map to help make it come alive.
There are several ways to generate animations in R, including with animation packages such as **gganimate**, which builds on **ggplot2** (see Section \@ref(other-mapping-packages)).
This section focusses on creating animated maps with **tmap** because its syntax will be familiar from previous sections and the flexibility of the approach.

Figure \@ref(fig:urban-animated) is a simple example of an animated map.
Unlike the faceted plot, it does not squeeze multiple maps into a single screen and allows the reader to see how the spatial distribution of the world's most populous agglomerations evolve over time (see the book's website for the animated version).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/urban-animated} 

}

\caption[Animated map showing the top 30 largest 'urban agglomerations'.]{Animated map showing the top 30 largest urban agglomerations from 1950 to 2030 based on population projects by the United Nations. Animated version available online at: geocompr.robinlovelace.net.}(\#fig:urban-animated)
\end{figure}



The animated map illustrated in Figure \@ref(fig:urban-animated) can be created using the same **tmap** techniques that generate faceted maps, demonstrated in Section \@ref(faceted-maps).
There are two differences, however, related to arguments in `tm_facets()`:

- `along = "year"` is used instead of `by = "year"`.
- `free.coords = FALSE`, which maintains the map extent for each map iteration.

These additional arguments are demonstrated in the subsequent code chunk:


```r
urb_anim = tm_shape(world) + tm_polygons() + 
  tm_shape(urban_agglomerations) + tm_dots(size = "population_millions") +
  tm_facets(along = "year", free.coords = FALSE)
```

The resulting `urb_anim` represents a set of separate maps for each year.
The final stage is to combine them and save the result as a `.gif` file with `tmap_animation()`.
The following command creates the animation illustrated in Figure \@ref(fig:urban-animated), with a few elements missing, that we will add in during the exercises:


```r
tmap_animation(urb_anim, filename = "urb_anim.gif", delay = 25)
```

Another illustration of the power of animated maps is provided in Figure \@ref(fig:animus).
This shows the development of states in the United States, which first formed in the east and then incrementally to the west and finally into the interior.
Code to reproduce this map can be found in the script `08-usboundaries.R`.



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/animus} 

}

\caption[Animated map showing boundary changes in the United States.]{Animated map showing population growth, state formation and boundary changes in the United States, 1790-2010. Animated version available online at geocompr.robinlovelace.net.}(\#fig:animus)
\end{figure}

## Interactive maps

\index{map making!interactive maps}
\index{tmap (package)!interactive maps}
While static and animated maps can enliven geographic datasets, interactive maps can take them to a new level.
Interactivity can take many forms, the most common and useful of which is the ability to pan around and zoom into any part of a geographic dataset overlaid on a 'web map' to show context.
Less advanced interactivity levels include popups which appear when you click on different features, a kind of interactive label.
More advanced levels of interactivity include the ability to tilt and rotate maps, as demonstrated in the **mapdeck** example below, and the provision of "dynamically linked" sub-plots which automatically update when the user pans and zooms [@pezanowski_senseplace3_2018].

The most important type of interactivity, however, is the display of geographic data on interactive or 'slippy' web maps.
The release of the **leaflet** package in 2015 revolutionized interactive web map creation from within R and a number of packages have built on these foundations adding new features (e.g., **leaflet.extras**) and making the creation of web maps as simple as creating static maps (e.g., **mapview** and **tmap**).
This section illustrates each approach in the opposite order.
We will explore how to make slippy maps with **tmap** (the syntax of which we have already learned), **mapview**\index{mapview (package)} and finally **leaflet**\index{leaflet (package)} (which provides low-level control over interactive maps).

A unique feature of **tmap** mentioned in Section \@ref(static-maps) is its ability to create static and interactive maps using the same code.
Maps can be viewed interactively at any point by switching to view mode, using the command `tmap_mode("view")`.
This is demonstrated in the code below, which creates an interactive map of New Zealand based on the `tmap` object `map_nz`, created in Section \@ref(map-obj), and illustrated in Figure \@ref(fig:tmview):


```r
tmap_mode("view")
map_nz
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/tmview-1} 

}

\caption[Interactive map of New Zealand.]{Interactive map of New Zealand created with tmap in view mode. Interactive version available online at: geocompr.robinlovelace.net.}(\#fig:tmview)
\end{figure}

Now that the interactive mode has been 'turned on', all maps produced with **tmap** will launch (another way to create interactive maps is with the `tmap_leaflet` function).
Notable features of this interactive mode include the ability to specify the basemap  with `tm_basemap()` (or `tmap_options()`) as demonstrated below (result not shown):


```r
map_nz + tm_basemap(server = "OpenTopoMap")
```

An impressive and little-known feature of **tmap**'s view mode is that it also works with faceted plots.
The argument `sync` in `tm_facets()` can be used in this case to produce multiple maps with synchronized zoom and pan settings, as illustrated in Figure \@ref(fig:sync), which was produced by the following code:


```r
world_coffee = left_join(world, coffee_data, by = "name_long")
facets = c("coffee_production_2016", "coffee_production_2017")
tm_shape(world_coffee) + tm_polygons(facets) + 
  tm_facets(nrow = 1, sync = TRUE)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/interactive-facets} 

}

\caption[Faceted interactive maps of global coffee production.]{Faceted interactive maps of global coffee production in 2016 and 2017 in sync, demonstrating tmap's view mode in action.}(\#fig:sync)
\end{figure}

Switch **tmap** back to plotting mode with the same function:


```r
tmap_mode("plot")
#> tmap mode set to plotting
```

If you are not proficient with **tmap**, the quickest way to create interactive maps may be with **mapview**\index{mapview (package)}.
The following 'one liner' is a reliable way to interactively explore a wide range of geographic data formats:


```r
mapview::mapview(nz)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/mapview} 

}

\caption{Illustration of mapview in action.}(\#fig:mapview)
\end{figure}

**mapview** has a concise syntax yet is powerful. By default, it provides some standard GIS functionality such as mouse position information, attribute queries (via pop-ups), scale bar, and zoom-to-layer buttons.
It offers advanced controls including the ability to 'burst' datasets into multiple layers and the addition of multiple layers with `+` followed by the name of a geographic object. 
Additionally, it provides automatic coloring of attributes (via argument `zcol`).
In essence, it can be considered a data-driven **leaflet** API\index{API} (see below for more information about **leaflet**). 
Given that **mapview** always expects a spatial object (`sf`, `Spatial*`, `Raster*`) as its first argument, it works well at the end of piped expressions. 
Consider the following example where **sf** is used to intersect lines and polygons and then is visualized with **mapview** (Figure \@ref(fig:mapview2)).


```r
trails |>
  st_transform(st_crs(franconia)) |>
  st_intersection(franconia[franconia$district == "Oberfranken", ]) |>
  st_collection_extract("LINE") |>
  mapview(color = "red", lwd = 3, layer.name = "trails") +
  mapview(franconia, zcol = "district", burst = TRUE) +
  breweries
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/mapview-example} 

}

\caption{Using mapview at the end of a sf-based pipe expression.}(\#fig:mapview2)
\end{figure}

<!--toDo:jn-->
<!-- add more info about mapview improved performance ("mapview can use all of them by setting e.g. `mapviewOptions(platform = "leafgl"/"mapdeck")` or `mapviewOptions(georaster = TRUE)`") -->

One important thing to keep in mind is that **mapview** layers are added via the `+` operator (similar to **ggplot2** or **tmap**). 
This is a frequent [gotcha](https://en.wikipedia.org/wiki/Gotcha_(programming)) in piped workflows where the main binding operator is `|>`.
For further information on **mapview**, see the package's website at: [r-spatial.github.io/mapview/](https://r-spatial.github.io/mapview/articles/).

There are other ways to create interactive maps with R.
The **googleway** package\index{googleway (package)}, for example, provides an interactive mapping interface that is flexible and extensible
(see the [`googleway-vignette`](https://cran.r-project.org/web/packages/googleway/vignettes/googleway-vignette.html) for details).
Another approach by the same author is **[mapdeck](https://github.com/SymbolixAU/mapdeck)**, which provides access to Uber's `Deck.gl` framework\index{mapdeck (package)}.
Its use of WebGL enables it to interactively visualize large datasets (up to millions of points).
The package uses Mapbox [access tokens](https://www.mapbox.com/help/how-access-tokens-work/), which you must register for before using the package.

\BeginKnitrBlock{rmdnote}
Note that the following block assumes the access token is stored in your R environment as `MAPBOX=your_unique_key`.
This can be added with `edit_r_environ()` from the **usethis** package.
\EndKnitrBlock{rmdnote}

A unique feature of **mapdeck** is its provision of interactive '2.5d' perspectives, illustrated in Figure \@ref(fig:mapdeck).
This means you can can pan, zoom and rotate around the maps, and view the data 'extruded' from the map.
Figure \@ref(fig:mapdeck), generated by the following code chunk, visualizes road traffic crashes in the UK, with bar height respresenting casualties per area.




```r
library(mapdeck)
set_token(Sys.getenv("MAPBOX"))
crash_data = read.csv("https://git.io/geocompr-mapdeck")
crash_data = na.omit(crash_data)
ms = mapdeck_style("dark")
mapdeck(style = ms, pitch = 45, location = c(0, 52), zoom = 4) |>
  add_grid(data = crash_data, lat = "lat", lon = "lng", cell_size = 1000,
         elevation_scale = 50, layer_id = "grid_layer",
         colour_range = viridisLite::plasma(6))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/mapdeck-mini} 

}

\caption[Map generated by mapdeck.]{Map generated by mapdeck, representing road traffic casualties across the UK. Height of 1 km cells represents number of crashes.}(\#fig:mapdeck)
\end{figure}

In the browser you can zoom and drag, in addition to rotating and tilting the map when pressing `Cmd`/`Ctrl`.
Multiple layers can be added with the `|>` operator, as demonstrated in the [`mapdeck` vignette](https://cran.r-project.org/web/packages/mapdeck/vignettes/mapdeck.html). 

Mapdeck also supports `sf` objects, as can be seen by replacing the `add_grid()` function call in the preceding code chunk with `add_polygon(data = lnd, layer_id = "polygon_layer")`, to add polygons representing London to an interactive tilted map.






Last but not least is **leaflet** which is the most mature and widely used interactive mapping package in R\index{leaflet (package)}.
**leaflet** provides a relatively low-level interface to the Leaflet JavaScript library and many of its arguments can be understood by reading the documentation of the original JavaScript library (see [leafletjs.com](https://leafletjs.com/)).

Leaflet maps are created with `leaflet()`, the result of which is a `leaflet` map object which can be piped to other **leaflet** functions.
This allows multiple map layers and control settings to be added interactively, as demonstrated in the code below which generates Figure \@ref(fig:leaflet) (see [rstudio.github.io/leaflet/](https://rstudio.github.io/leaflet/) for details).


```r
pal = colorNumeric("RdYlBu", domain = cycle_hire$nbikes)
leaflet(data = cycle_hire) |> 
  addProviderTiles(providers$CartoDB.Positron) |>
  addCircles(col = ~pal(nbikes), opacity = 0.9) |> 
  addPolygons(data = lnd, fill = FALSE) |> 
  addLegend(pal = pal, values = ~nbikes) |> 
  setView(lng = -0.1, 51.5, zoom = 12) |> 
  addMiniMap()
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/leaflet-1} 

}

\caption[The leaflet package in action.]{The leaflet package in action, showing cycle hire points in London. See interactive version [online](https://geocompr.github.io/img/leaflet.html).}(\#fig:leaflet)
\end{figure}

## Mapping applications

\index{map making!mapping applications}
The interactive web maps demonstrated in Section \@ref(interactive-maps) can go far.
Careful selection of layers to display, base-maps and pop-ups can be used to communicate the main results of many projects involving geocomputation.
But the web mapping approach to interactivity has limitations:

- Although the map is interactive in terms of panning, zooming and clicking, the code is static, meaning the user interface is fixed
- All map content is generally static in a web map, meaning that web maps cannot scale to handle large datasets easily
- Additional layers of interactivity, such a graphs showing relationships between variables and 'dashboards' are difficult to create using the web-mapping approach

Overcoming these limitations involves going beyond static web mapping and towards geospatial frameworks and map servers.
Products in this field include [GeoDjango](https://docs.djangoproject.com/en/2.0/ref/contrib/gis/)\index{GeoDjango} (which extends the Django web framework and is written in [Python](https://github.com/django/django))\index{Python}, [MapGuide](https://www.osgeo.org/projects/mapguide-open-source/)\index{MapGuide} (a framework for developing web applications, largely written in [C++](https://trac.osgeo.org/mapguide/wiki/MapGuideArchitecture))\index{C++} and [GeoServer](https://github.com/geoserver/geoserver) (a mature and powerful map server written in [Java](https://github.com/geoserver/geoserver)\index{Java}).
Each of these (particularly GeoServer) is scalable, enabling maps to be served to thousands of people daily --- assuming there is sufficient public interest in your maps!
The bad news is that such server-side solutions require much skilled developer time to set-up and maintain, often involving teams of people with roles such as a dedicated geospatial database administrator ([DBA](https://wiki.gis.com/wiki/index.php/Database_administrator)).

The good news is that web mapping applications can now be rapidly created using **shiny**\index{shiny (package)}, a package for converting R code into interactive web applications.
This is thanks to its support for interactive maps via functions such as `renderLeaflet()`, documented on the [Shiny integration](https://rstudio.github.io/leaflet/shiny.html) section of RStudio's **leaflet** website.
This section gives some context, teaches the basics of **shiny** from a web mapping perspective and culminates in a full-screen mapping application in less than 100 lines of code.

The way **shiny** works is well documented at [shiny.rstudio.com](https://shiny.rstudio.com/).
The two key elements of a **shiny** app reflect the duality common to most web application development: 'front end' (the bit the user sees) and 'back end' code.
In **shiny** apps, these elements are typically created in objects named `ui` and `server` within an R script named `app.R`, which lives in an 'app folder'.
This allows web mapping applications to be represented in a single file, such as the [`coffeeApp/app.R`](https://github.com/Robinlovelace/geocompr/blob/main/apps/coffeeApp/app.R) file in the book's GitHub repo.

\BeginKnitrBlock{rmdnote}
In **shiny** apps these are often split into `ui.R` (short for user interface) and `server.R` files, naming conventions used by `shiny-server`, a server-side Linux application for serving shiny apps on public-facing websites.
`shiny-server` also serves apps defined by a single `app.R` file in an 'app folder'.
Learn more at: https://github.com/rstudio/shiny-server.
\EndKnitrBlock{rmdnote}

Before considering large apps, it is worth seeing a minimal example, named 'lifeApp', in action.^[
The word 'app' in this context refers to 'web application' and should not be confused with smartphone apps, the more common meaning of the word.
]
The code below defines and launches --- with the command `shinyApp()` --- a lifeApp, which provides an interactive slider allowing users to make countries appear with progressively lower levels of life expectancy (see Figure \@ref(fig:lifeApp)):


```r
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

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/shiny-app} 

}

\caption[Minimal example of a web mapping application.]{Screenshot showing minimal example of a web mapping application created with shiny.}(\#fig:lifeApp)
\end{figure}

The **user interface** (`ui`) of lifeApp is created by `fluidPage()`.
This contains input and output 'widgets' --- in this case, a `sliderInput()` (many other `*Input()` functions are available) and a `leafletOutput()`.
These are arranged row-wise by default, explaining why the slider interface is placed directly above the map in Figure \@ref(fig:lifeApp) (see `?column` for adding content column-wise).

The **server side** (`server`) is a function with `input` and `output` arguments.
`output` is a list of objects containing elements generated by `render*()` function --- `renderLeaflet()` which in this example generates `output$map`.
Input elements such as `input$life` referred to in the server must relate to elements that exist in the `ui` --- defined by `inputId = "life"` in the code above.
The function `shinyApp()` combines both the `ui` and `server` elements and serves the results interactively via a new R process.
When you move the slider in the map shown in Figure \@ref(fig:lifeApp), you are actually causing R code to re-run, although this is hidden from view in the user interface.

Building on this basic example and knowing where to find help (see `?shiny`), the best way forward now may be to stop reading and start programming!
The recommended next step is to open the previously mentioned [`CycleHireApp/app.R`](https://github.com/Robinlovelace/geocompr/blob/main/apps/CycleHireApp/app.R) script in an IDE of choice, modify it and re-run it repeatedly.
The example contains some of the components of a web mapping application implemented in **shiny** and should 'shine' a light on how they behave.

The `CycleHireApp/app.R` script contains **shiny** functions that go beyond those demonstrated in the simple 'lifeApp' example.
These include `reactive()` and `observe()` (for creating outputs that respond to the user interface --- see `?reactive`) and `leafletProxy()` (for modifying a `leaflet` object that has already been created).
Such elements are critical to the creation of web mapping applications implemented in **shiny**.
A range of 'events' can be programmed including advanced functionality such as drawing new layers or subsetting data, as described in the shiny section of RStudio's **leaflet** [website.](https://rstudio.github.io/leaflet/shiny.html)

\BeginKnitrBlock{rmdnote}
There are a number of ways to run a **shiny** app.
For RStudio users, the simplest way is probably to click on the 'Run App' button located in the top right of the source pane when an `app.R`, `ui.R` or `server.R` script is open.
**shiny** apps can also be initiated by using `runApp()` with the first argument being the folder containing the app code and data: `runApp("CycleHireApp")` in this case (which assumes a folder named `CycleHireApp` containing the `app.R` script is in your working directory).
You can also launch apps from a Unix command line with the command `Rscript -e 'shiny::runApp("CycleHireApp")'`.
\EndKnitrBlock{rmdnote}

Experimenting with apps such as `CycleHireApp` will build not only your knowledge of web mapping applications in R, but also your practical skills.
Changing the contents of `setView()`, for example, will change the starting bounding box that the user sees when the app is initiated.
Such experimentation should not be done at random, but with reference to relevant documentation, starting with `?shiny`, and motivated by a desire to solve problems such as those posed in the exercises.

**shiny** used in this way can make prototyping mapping applications faster and more accessible than ever before (deploying **shiny** apps is a separate topic beyond the scope of this chapter).
Even if your applications are eventually deployed using different technologies, **shiny** undoubtedly allows web mapping applications to be developed in relatively few lines of code (76 in the case of CycleHireApp).
That does not stop shiny apps getting rather large.
The Propensity to Cycle Tool (PCT) hosted at [pct.bike](https://www.pct.bike/), for example, is a national mapping tool funded by the UK's Department for Transport.
The PCT is used by dozens of people each day and has multiple interactive elements based on more than 1000 lines of [code](https://github.com/npct/pct-shiny/blob/master/regions_www/m/server.R) [@lovelace_propensity_2017].

While such apps undoubtedly take time and effort to develop, **shiny** provides a framework for reproducible prototyping that should aid the development process.
One potential problem with the ease of developing prototypes with **shiny** is the temptation to start programming too early, before the purpose of the mapping application has been envisioned in detail.
For that reason, despite advocating **shiny**, we recommend starting with the longer established technology of a pen and paper as the first stage for interactive mapping projects.
This way your prototype web applications should be limited not by technical considerations, but by your motivations and imagination.



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/CycleHireApp-2} 

}

\caption[coffeeApp, a simple web mapping application.]{Hire a cycle App, a simple web mapping application for finding the closest cycle hiring station based on your location and requirement of cycles. Interactive version available online at geocompr.robinlovelace.net.}(\#fig:CycleHireApp-latex)
\end{figure}

## Other mapping packages

**tmap** provides a powerful interface for creating a wide range of static maps (Section \@ref(static-maps)) and also supports interactive maps (Section \@ref(interactive-maps)).
But there are many other options for creating maps in R.
The aim of this section is to provide a taster of some of these and pointers for additional resources: map making is a surprisingly active area of R package development, so there is more to learn than can be covered here.

The most mature option is to use `plot()` methods provided by core spatial packages **sf** and **raster**, covered in Sections \@ref(basic-map) and \@ref(basic-map-raster), respectively.
What we have not mentioned in those sections was that plot methods for raster and vector objects can be combined when the results draw onto the same plot area (elements such as keys in **sf** plots and multi-band rasters will interfere with this).
This behavior is illustrated in the subsequent code chunk which generates Figure \@ref(fig:nz-plot).
`plot()` has many other options which can be explored by following links in the `?plot` help page and the **sf** vignette [`sf5`](https://cran.r-project.org/web/packages/sf/vignettes/sf5.html).


```r
g = st_graticule(nz, lon = c(170, 175), lat = c(-45, -40, -35))
plot(nz_water, graticule = g, axes = TRUE, col = "blue")
raster::plot(nz_elev / 1000, add = TRUE)
plot(st_geometry(nz), add = TRUE)
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/nz-plot-1} 

}

\caption[Map of New Zealand created with plot().]{Map of New Zealand created with plot(). The legend to the right refers to elevation (1000 m above sea level).}(\#fig:nz-plot)
\end{figure}

Since version [2.3.0](https://www.tidyverse.org/articles/2018/05/ggplot2-2-3-0/), the **tidyverse**\index{tidyverse (package)} plotting package **ggplot2** has supported `sf` objects with `geom_sf()`\index{ggplot2 (package)}.
The syntax is similar to that used by **tmap**:
an initial `ggplot()` call is followed by one or more layers, that are added with `+ geom_*()`, where `*` represents a layer type such as `geom_sf()` (for `sf` objects) or `geom_points()` (for points).

**ggplot2** plots graticules by default.
The default settings for the graticules can be overridden using `scale_x_continuous()`, `scale_y_continuous()` or [`coord_sf(datum = NA)`](https://github.com/tidyverse/ggplot2/issues/2071).
Other notable features include the use of unquoted variable names encapsulated in `aes()` to indicate which aesthetics vary and switching data sources using the `data` argument, as demonstrated in the code chunk below which creates Figure \@ref(fig:nz-gg):


```r
library(ggplot2)
g1 = ggplot() + geom_sf(data = nz, aes(fill = Median_income)) +
  geom_sf(data = nz_height) +
  scale_x_continuous(breaks = c(170, 175))
g1
```

\begin{figure}[t]

{\centering \includegraphics[width=0.5\linewidth]{09-mapping_files/figure-latex/nz-gg-1} 

}

\caption{Map of New Zealand created with ggplot2.}(\#fig:nz-gg)
\end{figure}

An advantage of **ggplot2** is that it has a strong user-community and many add-on packages.
Good additional resources can be found in the open source [ggplot2 book](https://github.com/hadley/ggplot2-book) [@wickham_ggplot2_2016] and in the descriptions of the multitude of '**gg**packages' such as **ggrepel** and **tidygraph**.

Another benefit of maps based on **ggplot2** is that they can easily be given a level of interactivity when printed using the function `ggplotly()` from the **plotly** package\index{plotly (package)}.
Try `plotly::ggplotly(g1)`, for example, and compare the result with other **plotly** mapping functions described at: [blog.cpsievert.me](https://blog.cpsievert.me/2018/03/30/visualizing-geo-spatial-data-with-sf-and-plotly/).



At the same time, **ggplot2** has a few drawbacks.
The `geom_sf()` function is not always able to create a desired legend to use from the spatial [data](https://github.com/tidyverse/ggplot2/issues/2037).
Raster objects are also not natively supported in **ggplot2** and need to be converted into a data frame before plotting.

We have covered mapping with **sf**, **raster** and **ggplot2** packages first because these packages are highly flexible, allowing for the creation of a wide range of static maps.
Before we cover mapping packages for plotting a specific type of map (in the next paragraph), it is worth considering alternatives to the packages already covered for general-purpose mapping (Table \@ref(tab:map-gpkg)).

\begin{table}

\caption[Selected general-purpose mapping packages.]{(\#tab:map-gpkg)Selected general-purpose mapping packages.}
\centering
\begin{tabular}[t]{l>{\raggedright\arraybackslash}p{9cm}}
\toprule
Package & Title\\
\midrule
cartography & Thematic Cartography\\
ggplot2 & Create Elegant Data Visualisations Using the Grammar of Graphics\\
googleway & Accesses Google Maps APIs to Retrieve Data and Plot Maps\\
ggspatial & Spatial Data Framework for ggplot2\\
leaflet & Create Interactive Web Maps with Leaflet\\
\addlinespace
mapview & Interactive Viewing of Spatial Data in R\\
plotly & Create Interactive Web Graphics via 'plotly.js'\\
rasterVis & Visualization Methods for Raster Data\\
tmap & Thematic Maps\\
\bottomrule
\end{tabular}
\end{table}

Table \@ref(tab:map-gpkg) shows a range of mapping packages are available, and there are many others not listed in this table.
Of note is **cartography**, which can generate range of geographic visualizations including choropleth, 'proportional symbol' and 'flow' maps.
These are documented in the [`cartography`](https://cran.r-project.org/web/packages/cartography/vignettes/cartography.html)\index{cartography (package)} vignette.

Several packages focus on specific map types, as illustrated in Table \@ref(tab:map-spkg).
Such packages create cartograms that distort geographical space, create line maps, transform polygons into regular or hexagonal grids, and visualize complex data on grids representing geographic topologies.

\begin{table}

\caption[Selected specific-purpose mapping packages.]{(\#tab:map-spkg)Selected specific-purpose mapping packages, with associated metrics.}
\centering
\begin{tabular}[t]{ll}
\toprule
Package & Title\\
\midrule
cartogram & Create Cartograms with R\\
geogrid & Turn Geospatial Polygons into Regular or Hexagonal Grids\\
geofacet & 'ggplot2' Faceting Utilities for Geographical Data\\
globe & Plot 2D and 3D Views of the Earth, Including Major Coastline\\
linemap & Line Maps\\
\bottomrule
\end{tabular}
\end{table}

All of the aforementioned packages, however, have different approaches for data preparation and map creation.
In the next paragraph, we focus solely on the **cartogram** package\index{cartogram (package)}.
Therefore, we suggest to read the [linemap](https://github.com/rCarto/linemap)\index{linemap (package)}, [geogrid](https://github.com/jbaileyh/geogrid)\index{geogrid (package)} and [geofacet](https://github.com/hafen/geofacet)\index{geofacet (package)} documentations to learn more about them.

A cartogram is a map in which the geometry is proportionately distorted to represent a mapping variable. 
Creation of this type of map is possible in R with **cartogram**, which allows for creating continuous and non-contiguous area cartograms.
It is not a mapping package per se, but it allows for construction of distorted spatial objects that could be plotted using any generic mapping package.

The `cartogram_cont()` function creates continuous area cartograms.
It accepts an `sf` object and name of the variable (column) as inputs.
Additionally, it is possible to modify the `intermax` argument - maximum number of iterations for the cartogram transformation.
For example, we could represent median income in New Zeleand's regions as a continuous cartogram (the right-hand panel of Figure \@ref(fig:cartomap1)) as follows:


```r
library(cartogram)
nz_carto = cartogram_cont(nz, "Median_income", itermax = 5)
tm_shape(nz_carto) + tm_polygons("Median_income")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/cartomap1-1} 

}

\caption[Comparison of standard map and continuous area cartogram.]{Comparison of standard map (left) and continuous area cartogram (right).}(\#fig:cartomap1)
\end{figure}

**cartogram** also offers creation of non-contiguous area cartograms using  `cartogram_ncont()` and Dorling cartograms using `cartogram_dorling()`.
Non-contiguous area cartograms are created by scaling down each region based on the provided weighting variable.
Dorling cartograms consist of circles with their area proportional to the weighting variable.
The code chunk below demonstrates creation of non-contiguous area and Dorling cartograms of US states' population (Figure \@ref(fig:cartomap2)):


```r
us_states2163 = st_transform(us_states, 2163)
us_states2163_ncont = cartogram_ncont(us_states2163, "total_pop_15")
us_states2163_dorling = cartogram_dorling(us_states2163, "total_pop_15")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{09-mapping_files/figure-latex/cartomap2-1} 

}

\caption[Comparison of cartograms.]{Comparison of non-continuous area cartogram (left) and Dorling cartogram (right).}(\#fig:cartomap2)
\end{figure}

New mapping packages are emerging all the time.
In 2018 alone, a number of mapping packages have been released on CRAN\index{CRAN}, including **mapdeck**, **mapsapi**, and **rayshader**.
In terms of interactive mapping, **leaflet.extras** contains many functions for extending the functionality of **leaflet** (see the end of the [`point-pattern`](https://geocompr.github.io/geocompkg/articles/point-pattern.html) vignette in the **geocompkg** website for examples of heatmaps created by **leaflet.extras**).

<!--toDo:JN-->
<!-- add https://github.com/riatelab/fisheye -->

## Exercises

These exercises rely on a new object, `africa`.
Create it using the `world` and `worldbank_df` datasets from the **spData** package as follows (see Chapter \@ref(attr)):


```r
africa = world |> 
  filter(continent == "Africa", !is.na(iso_a2)) |> 
  left_join(worldbank_df, by = "iso_a2") |> 
  dplyr::select(name, subregion, gdpPercap, HDI, pop_growth) |> 
  st_transform("+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25")
```

We will also use `zion` and `nlcd` datasets from **spDataLarge**:


```r
zion = st_read((system.file("vector/zion.gpkg", package = "spDataLarge")))
data(nlcd, package = "spDataLarge")
```

1. Create a map showing the geographic distribution of the Human Development Index (`HDI`) across Africa with base **graphics** (hint: use `plot()`) and **tmap** packages (hint: use `tm_shape(africa) + ...`).
    - Name two advantages of each based on the experience.
    - Name three other mapping packages and an advantage of each.
    - Bonus: create three more maps of Africa using these three packages.
1. Extend the **tmap** created for the previous exercise so the legend has three bins: "High" (`HDI` above 0.7), "Medium" (`HDI` between 0.55 and 0.7) and "Low" (`HDI` below 0.55).
    - Bonus: improve the map aesthetics, for example by changing the legend title, class labels and color palette.
1. Represent `africa`'s subregions on the map. 
Change the default color palette and legend title.
Next, combine this map and the map created in the previous exercise into a single plot.
1. Create a land cover map of the Zion National Park.
    - Change the default colors to match your perception of the land cover categories
    - Add a scale bar and north arrow and change the position of both to improve the map's aesthetic appeal
    - Bonus: Add an inset map of Zion National Park's location in the context of the Utah state. (Hint: an object representing Utah can be subset from the `us_states` dataset.) 
1. Create facet maps of countries in Eastern Africa:
    - With one facet showing HDI and the other representing population growth (hint: using variables `HDI` and `pop_growth`, respectively)
    - With a 'small multiple' per country
<!--comment to the next q:  worldbank_df along the iso_a2 variable is pegging Kosovo and South Cyprus to Somaliland -->
1. Building on the previous facet map examples, create animated maps of East Africa:
    - Showing first the spatial distribution of HDI scores then population growth
    - Showing each country in order
1. Create an interactive map of Africa:
    - With **tmap**
    - With **mapview**
    - With **leaflet**
    - Bonus: For each approach, add a legend (if not automatically provided) and a scale bar
1. Sketch on paper ideas for a web mapping app that could be used to make transport or land-use policies more evidence based:
    - In the city you live, for a couple of users per day
    - In the country you live, for dozens of users per day
    - Worldwide for hundreds of users per day and large data serving requirements
1. Update the code in `coffeeApp/app.R` so that instead of centering on Brazil the user can select which country to focus on:
    - Using `textInput()`
    - Using `selectInput()`
1. Reproduce Figure \@ref(fig:tmshape) and the 1st and 6th panel of Figure \@ref(fig:break-styles) as closely as possible using the **ggplot2** package.
1. Join `us_states` and `us_states_df` together and calculate a poverty rate for each state using the new dataset.
Next, construct a continuous area cartogram based on total population. 
Finally, create and compare two maps of the poverty rate: (1) a standard choropleth map and (2) a map using the created cartogram boundaries.
What is the information provided by the first and the second map?
How do they differ from each other?
1. Visualize population growth in Africa. 
Next, compare it with the maps of a hexagonal and regular grid created using the **geogrid** package.

<!--chapter:end:09-mapping.Rmd-->

# Bridges to GIS software {#gis}

## Prerequisites {-}

- This chapter requires QGIS\index{QGIS}, SAGA\index{SAGA} and GRASS\index{GRASS} to be installed and the following packages to be attached:


```r
library(sf)
library(terra)
```


```r
# remotes::install_github("paleolimbot/qgisprocess")
library(qgisprocess)
library(Rsagacmd)
library(rgrass7)
library(rstac)
library(gdalcubes)
```

<!-- issue of rgrass -->
<!-- https://github.com/rsbivand/rgrass -->

## Introduction

A defining feature of R is the way you interact with it:
you type commands and hit `Enter` (or `Ctrl+Enter` if writing code in the source editor in RStudio\index{RStudio}) to execute them interactively.
This way of interacting with the computer is called a command-line interface (CLI)\index{command-line interface} (see definition in the note below).
CLIs are not unique to R.^[
Other 'command-lines' include terminals for interacting with the operating system and other interpreted languages such as Python.
Many GISs originated as a CLI:
it was only after the widespread uptake of computer mice and high-resolution screens in the 1990s that GUIs\index{graphical user interface} became common.
GRASS, one of the longest-standing GIS\index{GIS} programs, for example, relied primarily on command-line interaction before it gained a sophisticated GUI [@landa_new_2008].
]
In dedicated GIS\index{GIS} packages, by contrast, the emphasis tends to be on the graphical user interface (GUI)\index{graphical user interface}.
You *can* interact with GRASS\index{GRASS}, QGIS\index{QGIS}, SAGA\index{SAGA} and gvSIG from system terminals and embedded CLIs\index{command-line interface}, but 'pointing and clicking' is the norm.
This means many GIS\index{GIS} users miss out on the advantages of the command-line according to Gary Sherman, creator of QGIS\index{QGIS} [@sherman_desktop_2008]:

> With the advent of 'modern' GIS software, most people want to point and
click their way through life. That’s good, but there is a tremendous amount
of flexibility and power waiting for you with the command line. Many times
you can do something on the command line in a fraction of the time you
can do it with a GUI.

The 'CLI vs GUI'\index{graphical user interface} debate can be adversial but it does not have to be; both options can be used interchangeably, depending on the task at hand and the user's skillset.^[GRASS GIS and PostGIS are popular in academia and industry and can be seen as products which buck this trend as they are built around the command-line.]
The advantages of a good CLI\index{command-line interface} such as that provided by R (and enhanced by IDEs\index{IDE} such as RStudio\index{RStudio}) are numerous.
A good CLI:

- Facilitates the automation of repetitive tasks
- Enables transparency and reproducibility, the backbone of good scientific practice and data science
- Encourages software development by providing tools to modify existing functions and implement new ones
- Helps develop future-proof programming skills which are in high demand in many disciplines and industries
- Is user-friendly and fast, allowing an efficient workflow

On the other hand, GUI-based GIS\index{GIS} systems (particularly QGIS\index{QGIS}) are also advantageous.
A good GIS GUI:

- Has a 'shallow' learning curve meaning geographic data can be explored and visualized without hours of learning a new language
- Provides excellent support for 'digitizing' (creating new vector datasets), including trace, snap and topological tools^[
The **mapedit** package allows the quick editing of a few spatial features but not professional, large-scale cartographic digitizing.
]
- Enables georeferencing (matching raster images to existing maps) with ground control points and orthorectification
- Supports stereoscopic mapping (e.g., LiDAR and structure from motion)
- Provides access to spatial database management systems with object-oriented relational data models, topology and fast (spatial) querying

Another advantage of dedicated GISs is that they provide access to hundreds of 'geoalgorithms' (computational recipes to solve geographic problems --- see Chapter \@ref(algorithms)).
Many of these are unavailable from the R command line, except via 'GIS bridges', the topic of (and motivation for) this chapter.^[
An early use of the term 'bridge' referred to the coupling of R with GRASS\index{GRASS} [@neteler_open_2008].
]

\BeginKnitrBlock{rmdnote}
A command-line interface is a means of interacting with computer programs in which the user issues commands via successive lines of text (command lines).
`bash` in Linux and `PowerShell` in Windows are its common examples.
CLIs can be augmented with IDEs such as RStudio for R, which provides code auto-completion and other features to improve the user experience.
\EndKnitrBlock{rmdnote}

R originated as an interface language.
Its predecessor S provided access to statistical algorithms in other languages (particularly FORTRAN\index{FORTRAN}), but from an intuitive read-evaluate-print loop (REPL) [@chambers_extending_2016].
R continues this tradition with interfaces to numerous languages, notably C++\index{C++}, as described in Chapter \@ref(intro).
R was not designed as a GIS.
However, its ability to interface with dedicated GISs gives it astonishing geospatial capabilities.
R is well known as a statistical programming language, but many people are unaware of its ability to replicate GIS workflows, with the additional benefits of a (relatively) consistent CLI.
Furthermore, R outperforms GISs in some areas of geocomputation\index{geocomputation}, including interactive/animated map making (see Chapter \@ref(adv-map)) and spatial statistical modeling (see Chapter \@ref(spatial-cv)).
This chapter focuses on 'bridges' to three mature open source GIS products (see Table \@ref(tab:gis-comp)): QGIS\index{QGIS} (via the package **qgisprocess**\index{qgisprocess (package)}; Section \@ref(rqgis)), SAGA\index{SAGA} (via **Rsagacmd**\index{Rsagacmd (package)}; Section \@ref(saga)) and GRASS\index{GRASS} (via **rgrass7**\index{rgrass7 (package)}; Section \@ref(grass)).^[
<!--toDo:jn-->
<!-- Though not covered here, it is worth being aware of the interface to ArcGIS\index{ArcGIS}, a proprietary and very popular GIS software, via **RPyGeo**.^[By the way, it is also possible to use R from within Desktop GIS software packages.  -->
<!-- The so-called R-ArcGIS bridge (see https://github.com/R-ArcGIS/r-bridge) allows R to be used from within ArcGIS\index{ArcGIS}.  -->
<!--toDo:jn-->
<!-- rgee? -->
<!-- whitetoolbox? -->
One can also use R scripts from within QGIS\index{QGIS} (see https://docs.qgis.org/3.16/en/docs/training_manual/processing/r_intro.html).
Finally, it is also possible to use R from the GRASS GIS\index{GRASS} command line (see https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7).
]
To complement the R-GIS bridges, the chapter ends with a very brief introduction to interfaces to spatial libraries (Section \@ref(gdal)), spatial databases\index{spatial database} (Section \@ref(postgis)), and  cloud-based processing of Earth observation data (Section \@ref(cloud)).

\begin{table}

\caption[Comparison between three open-source GIS.]{(\#tab:gis-comp)Comparison between three open-source GIS. Hybrid refers to the support of vector and raster operations.}
\centering
\begin{tabular}[t]{llll}
\toprule
GIS & First release & No. functions & Support\\
\midrule
GRASS & 1984 & >500 & hybrid\\
QGIS & 2002 & >1000 & hybrid\\
SAGA & 2004 & >600 & hybrid\\
\bottomrule
\end{tabular}
\end{table}

## QGIS through **qgisprocess** {#rqgis}

<!--toDo:jn-->
<!-- how to mention/use the QGIS package (https://en.cahik.cz//2022/03/07/r-package-qgis/) here? -->

QGIS\index{QGIS} is one of the most popular open-source GIS [Table \@ref(tab:gis-comp); @graser_processing_2015]. 
Its main advantage lies in the fact that it provides a unified interface to several other open-source GIS.
This means that you have access to GDAL\index{GDAL}, GRASS\index{GRASS}, and SAGA\index{SAGA} through QGIS\index{QGIS} [@graser_processing_2015]. 
Since version 3.14, QGIS provides a command line API\index{API}, `qgis_process`, that allows to run all these geoalgorithms (frequently more than 1000, depending on your set-up) outside of the QGIS GUI.

The **qgisprocess** package \index{qgisprocess (package)} wraps this QGIS command-line utility, and thus makes it possible to call QGIS, GDAL, GRASS, and SAGA algorithms from the R session.
Before running **qgisprocess**\index{qgisprocess (package)}, make sure you have installed QGIS\index{QGIS} and all its (third-party) dependencies such as SAGA\index{SAGA} and GRASS\index{GRASS}.


```r
library(qgisprocess)
#> Using 'qgis_process' at 'qgis_process'.
#> QGIS version: 3.20.3-Odense
#> ...
```

This package automatically tries to detect a QGIS installation and complains if it cannot find it.^[You can see details of the detection process with `qgis_configure()`.]
There are a few possible solutions when the configuration fails: you can set `options(qgisprocess.path = "path/to/your_qgis_process")`, or set up the `R_QGISPROCESS_PATH` environment variable.
<!--toDo:jn-->
<!-- link to the vignette https://github.com/paleolimbot/qgisprocess/pull/31/files when it is online -->
The above approaches can also be used when you have more than one QGIS installation and want to decide which one to use.

Next, we can find which providers (meaning different software) are available on our computer.


```r
qgis_providers()
#> # A tibble: 6 × 2
#>   provider provider_title   
#>   <chr>    <chr>            
#> 1 3d       QGIS (3D)        
#> 2 gdal     GDAL             
#> 3 grass7   GRASS            
#> 4 native   QGIS (native c++)
#> 5 qgis     QGIS             
#> 6 saga     SAGA
```

The output table affirms that we can use QGIS geoalgorithms (`native`, `qgis`, `3d`) and external ones from the third-party providers GDAL, SAGA and GRASS through the QGIS interface.

We are now ready for some QGIS geocomputation from within R!
Let's try two example case studies.
The first one shows how to unite two polygonal datasets with different borders\index{union} (Section \@ref(qgis-vector)).
The second one focuses on deriving new information from a digital elevation model represented as a raster (Section \@ref(qgis-raster)).

### Vector data {#qgis-vector}

Consider a situation when you have two polygon objects with different spatial units (e.g., regions, administrative units).
Our goal is to merge these two objects into one, containing all of the boundary lines and related attributes.
We use again the incongruent polygons we have already encountered in Section \@ref(incongruent) (Figure \@ref(fig:uniondata)).
Both polygon datasets are available in the **spData** package, and for both we would like to use a geographic CRS\index{CRS!geographic} (see also Chapter \@ref(reproj-geo-data)).


```r
data("incongruent", "aggregating_zones", package = "spData")
incongr_wgs = st_transform(incongruent, "EPSG:4326")
aggzone_wgs = st_transform(aggregating_zones, "EPSG:4326")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{10-gis_files/figure-latex/uniondata-1} 

}

\caption{Illustration of two areal units: incongruent (black lines) and aggregating zones (red borders). }(\#fig:uniondata)
\end{figure}

To find an algorithm to do this work, we can search the output of the `qgis_algorithms()` function.
This function returns a data frame containing all of the available providers and the algorithms they contain.^[Therefore, if you cannot see an expected provider, it is probably because you still need to install some external GIS software.] 


```r
qgis_algo = qgis_algorithms()
```

The `qgis_algo` object has a lot of columns, but usually, we are only interested in the `algorithm` column that combines information about the provider and the algorithm name.
Assuming that the short description of the function contains the word "union"\index{union}, we can run the following code to find the algorithm of interest:


```r
grep("union", qgis_algo$algorithm, value = TRUE)
#> [1] "native:union"      "saga:fuzzyunionor" "saga:polygonunion"
```

One of the algorithms on the above list, `"native:union"`, sounds promising.
The next step is to find out what this algorithm does and how we can use it.
This is the role of the `qgis_show_help()`, which gives us a help information, including the description of the algorithm, its arguments, and outputs.^[We can also extract some of information independently with `qgis_description()`, `qgis_arguments()`, and `qgis_outputs()`.]


```r
alg = "native:union"
qgis_show_help(alg)
```

The description gives a few sentences summary of what the selected algorithm does. 
Next, a list of arguments gives us the possible arguments' names, for example, `INPUT`, `OVERLAY`, `OVERLAY_FIELDS_PREFIX`, and `OUTPUT` in this case, and their acceptable values.
Based on the help information, some of the above arguments seem to expect a "path to a vector layer".
However, the **qgisprocess** package also allows to provide `sf` object as well in these cases.^[Objects from the **terra** and **stars** package can be used when a path to a raster layer.]
The algorithm's outputs (it is possible to have more than one output) are listed at the end of the help list.

Finally, we can let QGIS\index{QGIS} do the work.
The main function of **qgisprocess** is `qgis_run_algorithm()`.
It accepts the used algorithm name and a set of named arguments shown in the help list, and performs expected calculations.
In our case, three arguments seem important - `INPUT`, `OVERLAY`, and `OUTPUT`.
The first one, `INPUT`, is our main vector object `incongr_wgs`, while the second one, `OVERLAY`, is `aggzone_wgs`.
The last argument, `OUTPUT`, expects a path to a new vector file; however, if we do not provide the path, **qgisprocess** will automatically create a temporary file.


```r
union = qgis_run_algorithm(alg, INPUT = incongr_wgs, OVERLAY = aggzone_wgs)
union
```

Running the above line of code will save our two input objects into temporary .gpkg files, run the selected algorithm on them, and return a temporary .gpkg file as the output.
The **qgisprocess** package stores the `qgis_run_algorithm()` result as a list containing, in this case, a path to the output file.
We can either read this file back into R with `read_sf()` (e.g., `union_sf = read_sf(union[[1]])`) or directly with `st_as_sf()`:


```r
union_sf = st_as_sf(union)
```

Note that the QGIS\index{QGIS} union\index{vector!union} operation merges the two input layers into one layer by using the intersection\index{vector!intersection} and the symmetrical difference of the two input layers (which, by the way, is also the default when doing a union operation in GRASS\index{GRASS} and SAGA\index{SAGA}).
This is **not** the same as `st_union(incongr_wgs, aggzone_wgs)` (see Exercises)!

Our result, `union_sf`, is a multipolygon with a larger number of features than two input objects .
Notice, however, that many of these polygons are small and do not represent real areas but are rather a result of our two datasets having a different level of detail.
These artifacts of error are called sliver polygons (see red-colored polygons in the left panel of Figure \@ref(fig:sliver))
One way to identify slivers is to find polygons with comparatively very small areas, here, e.g., 25000 m^2^, and next remove them.
Let's search for an appropriate algorithm.


```r
grep("clean", qgis_algo$algorithm, value = TRUE)
```

This time the found algorithm, `v.clean`, is not included in QGIS, but GRASS GIS.
GRASS GIS's `v.clean` is a powerful tool for cleaning topology of spatial vector data. 
Importantly, we can use it through **qgisprocess**.

Similarly to the previous step, we should start by looking at this algorithm's help.


```r
qgis_show_help("grass7:v.clean")
```

You may notice that the help text is quite long and contains a lot of arguments.^[Also note that these arguments, contrary to the QGIS's ones, are in lower case.]
This is because `v.clean` is a multi tool -- it can clean different types of geometries and solve different types of topological problems.
For this example, let's focus on just a few arguments, however, we encourage you to visit [this algorithm's documentation](https://grass.osgeo.org/grass78/manuals/v.clean.html) to learn more about `v.clean` capabilities.

The main argument for this algorithm is `input` -- our vector object.
Next, we need to select a tool -- a cleaning method. ^[It is also possible to select several tools, which will then be executed sequentially.]
About a dozen of tools exist in `v.clean` allowing to, for example, remove duplicate geometries, remove small angles between lines, or remove small areas.
In this case, we are interested in the latter tool, `rmarea`, which is identified by the number 10.
Several of the tools, `rmarea` included, expect an additional argument `threshold`, which behavior depends on the selected tool.
In our case, the `rmarea` tool removes all areas smaller or equal to `threshold`. 

Let's run this algorithm and convert its output into a new `sf` object `clean_sf`.


```r
clean = qgis_run_algorithm("grass7:v.clean", input = union_sf,
                           tool = 10, threshold = 25000)
clean_sf = st_as_sf(clean)
```

The result, the right panel of \@ref(fig:sliver), looks as expected -- sliver polygons are now removed.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/10-sliver} 

}

\caption{Sliver polygons colored in red (left panel). Cleaned polygons (right panel).}(\#fig:sliver)
\end{figure}

### Raster data {#qgis-raster}

Digital elevation models (DEMs) contain elevation information for each raster cell.
They are applied for many purposes, including satellite navigation, water flow models, surface analysis, or visualization.
Here, we are interested in deriving new information from a DEM raster that could be used as predictors in statistical learning.
Various terrain parameters, for example, can be helpful for the prediction of landslides (see Chapter \@ref(spatial-cv))

For this section, we will use `dem.tif` -- a digital elevation model\index{digital elevation model} of the Mongón study area <!--refs??-->.
It has a resolution of about 30 by 30 meters and uses a projected CRS.


```r
library(qgisprocess)
library(terra)
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
```

The **terra** package's `terrain()` allows calculation of several fundamental topographic characteristics such as slope, aspect, TPI (*Topographic Position Index*), TRI (*Topographic Ruggedness Index*), roughness, and flow directions.
This function allows choosing a terrain characteristic (`v`) and, in the case of `"slope"` and `"aspect"`, the output unit.


```r
dem_slope = terrain(dem, unit = "radians")
dem_aspect = terrain(dem, v = "aspect", unit = "radians")
```

It returns a new raster object with the same dimensions as the original one but with new values representing a selected terrain characteristic.

That being said -- many more terrain characteristics exist, some of which can be more suitable in certain contexts.
For example, the topographic wetness index (TWI) was found useful in studying hydrological and biological processes [@sorensen_calculation_2006].
Let's search the algorithm list for this index using a `"wetness"` keyword.


```r
qgis_algo = qgis_algorithms()
grep("wetness", qgis_algo$algorithm, value = TRUE)
```

An output of the above code suggests that the desired algorithm exists in the SAGA GIS software.^[TWI can be also calculated using the `r.topidx` GRASS GIS function.]
Though SAGA is a hybrid GIS, its main focus has been on raster processing, and here, particularly on digital elevation models\index{digital elevation model} (soil properties, terrain attributes, climate parameters). 
Hence, SAGA is especially good at the fast processing of large (high-resolution) raster\index{raster} datasets [@conrad_system_2015].

The `"saga:sagawetnessindex"` algorithm is actually a modified TWI, that results in a more realistic soil moisture potential for the cells located in valley floors [@bohner_spatial_2006].


```r
qgis_show_help("saga:sagawetnessindex")
```

This algorithm requires only one argument -- the input `DEM` and several additional arguments.^[The additional arguments of `"saga:sagawetnessindex"` are well-explained at https://gis.stackexchange.com/a/323454/20955.]
It returns not one but four rasters -- catchment area, catchment slope, modified catchment area, and topographic wetness index.


```r
dem_wetness = qgis_run_algorithm("saga:sagawetnessindex", DEM = dem)
```

The result, `dem_wetness`, is a list with file paths to the four outputs.
We can read a selected output by providing an output name in the `qgis_as_terra()` function.


```r
dem_wetness_twi = qgis_as_terra(dem_wetness$TWI)
```

You can see the output TWI map on the left panel of Figure \@ref(fig:qgis-raster-map).
The topographic wetness index is unitless.
Its low values represent areas that will not accumulate water, while higher values show areas that will accumulate water at increasing levels.

Information from digital elevation models can also be categorized, for example, to geomorphons -- the geomorphological phonotypes consisting of 10 classes that represent terrain forms, such as slopes, ridges, or valleys [@jasiewicz_geomorphons_2013].
These classes are used in many studies, including landslide susceptibility, ecosystem services, human mobility, and digital soil mapping. 
<!-- https://scholar.google.pl/scholar?cites=8284408958489255337&as_sdt=2005&sciodt=0,5&hl=en -->
<!-- https://www.nature.com/articles/s41597-020-0479-6.pdf -->

The original implementation of the geomorphons' algorithm was created in GRASS GIS, and we can find it in the **qgisprocess** list as `"grass7:r.geomorphon"`:


```r
grep("geomorphon", qgis_algo$algorithm, value = TRUE)
qgis_show_help("grass7:r.geomorphon")
```

Calculation of geomorphons requires an input DEM (`elevation`), and can be customized with a set of optional arguments.
It includes, `search` -- a length for which the line-of-sight is calculated, and ``-m`` -- a flag specifying that the search value will be provided in meters (and not the number of cells).
More information about additional arguments can be found in the original paper and the [GRASS GIS documentation](https://grass.osgeo.org/grass78/manuals/r.geomorphon.html).


```r
dem_geomorph = qgis_run_algorithm("grass7:r.geomorphon", elevation = dem, 
                                    `-m` = TRUE, search = 120)
```

Our output, `dem_geomorph$forms`, contains a raster file with 10 categories -- each one representing a terrain form.
We can read it into R with `qgis_as_terra()`, and then visualize it (the right panel of Figure \@ref(fig:qgis-raster-map)) or use it in our subsequent calculations.


```r
dem_geomorph_terra = qgis_as_terra(dem_geomorph$forms)
```

Interestingly, there are connections between some geomorphons and the TWI values, as shown in Figure \@ref(fig:qgis-raster-map).
The largest TWI values mostly occur in valleys and hollows, while the lowest values are seen, as expected, on ridges.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/10-qgis-raster-map} 

}

\caption{Topographic wetness index (TWI, left panel) and geomorphons (right panel) derived for the Mongón study area.}(\#fig:qgis-raster-map)
\end{figure}

## Other GIS bridges

### SAGA GIS {#saga}

The System for Automated Geoscientific Analyses (SAGA\index{SAGA}; Table \@ref(tab:gis-comp)) provides the possibility to execute SAGA modules via the command line interface\index{command-line interface} (`saga_cmd.exe` under Windows and just `saga_cmd` under Linux) (see the [SAGA wiki on modules](https://sourceforge.net/p/saga-gis/wiki/Executing%20Modules%20with%20SAGA%20CMD/)).
In addition, there is a Python interface (SAGA Python API\index{API}).
**Rsagacmd**\index{Rsagacmd (package)} uses the former to run SAGA\index{SAGA} from within R.


```r
library(Rsagacmd)
```

To start using this package, we need to run the `saga_gis()` function.
It serves two main purposes: 

- It dynamically^[This means that the available libraries will depend on the installed SAGA GIS version.] creates a new object that contains links to all valid SAGA-GIS libraries and tools
- It sets up general package options, such as `raster_backend` (R package to use for handling raster data), `vector_backend` (R package to use for handling vector data), and `cores` (a maximum number of CPU cores used for processing, default: all)


```r
saga = saga_gis(raster_backend = "terra", vector_backend = "sf")
```

<!-- add ref to the ndvi calculations section -->


```r
ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))
```

`tidy(sg)`



`ndvi_seeds$variance`
 `tidy(srg)`




`ndvi_srg$similarity`, `ndvi_srg$table`









<!-- explain saga$ -->

<!-- expain/mention other segmentation techinques -->
<!-- mention supercells -- exercises?? -->
<!-- https://github.com/joaofgoncalves/SegOptim ?? -->

<!-- add figure -->

<!-- mention many raster layers -->
<!-- how to find help? other resources -->

### GRASS GIS {#grass}

The U.S. Army - Construction Engineering Research Laboratory (USA-CERL) created the core of the Geographical Resources Analysis Support System (GRASS)\index{GRASS} [Table \@ref(tab:gis-comp); @neteler_open_2008] from 1982 to 1995. 
Academia continued this work since 1997.
Similar to SAGA\index{SAGA}, GRASS focused on raster processing in the beginning while only later, since GRASS 6.0, adding advanced vector functionality [@bivand_applied_2013].

Here, we introduce **rgrass**\index{rgrass (package)} with one of the most interesting problems in GIScience - the traveling salesman problem\index{traveling salesman}.
Suppose a traveling salesman would like to visit 24 customers.
Additionally, he would like to start and finish his journey at home which makes a total of 25 locations while covering the shortest distance possible.
There is a single best solution to this problem; however, to check all of the possible solutions it is (mostly) impossible for modern computers [@longley_geographic_2015].
In our case, the number of possible solutions correspond to `(25 - 1)! / 2`, i.e., the factorial of 24 divided by 2 (since we do not differentiate between forward or backward direction).
Even if one iteration can be done in a nanosecond, this still corresponds to 9837145 years.
Luckily, there are clever, almost optimal solutions which run in a tiny fraction of this inconceivable amount of time.
GRASS GIS\index{GRASS} provides one of these solutions (for more details, see [v.net.salesman](https://grass.osgeo.org/grass80/manuals/v.net.salesman.html)).
In our use case, we would like to find the shortest path\index{shortest route} between the first 25 bicycle stations (instead of customers) on London's streets (and we simply assume that the first bike station corresponds to the home of our traveling salesman\index{traveling salesman}).


```r
data("cycle_hire", package = "spData")
points = cycle_hire[1:25, ]
```

Aside from the cycle hire points data, we need a street network for this area.
We can download it with from OpenStreetMap\index{OpenStreetMap} with the help of the **osmdata** \index{osmdata (package)} package (see also Section \@ref(retrieving-data)).
To do this, we constrain the query of the street network (in OSM language called "highway") to the bounding box\index{bounding box} of `points`, and attach the corresponding data as an `sf`-object\index{sf}.
`osmdata_sf()` returns a list with several spatial objects (points, lines, polygons, etc.), but here, we only keep the line objects with their related ids.
<!-- OpenStreetMap\index{OpenStreetMap} objects come with a lot of columns, `streets` features almost 500. -->
<!-- In fact, we are only interested in the geometry column. -->
<!-- Nevertheless, we are keeping one attribute column; otherwise, we will run into trouble when trying to provide `writeVECT()` only with a geometry object (see further below and `?writeVECT` for more details). -->
<!-- Remember that the geometry column is sticky, hence, even though we are just selecting one attribute, the geometry column will be also returned (see Section \@ref(intro-sf)). -->


```r
library(osmdata)
b_box = st_bbox(points)
london_streets = opq(b_box) |>
  add_osm_feature(key = "highway") |>
  osmdata_sf() 
london_streets = london_streets[["osm_lines"]]
london_streets = dplyr::select(london_streets, osm_id)
```

As a convenience to the reader, one can attach `london_streets` to the global environment using `data("london_streets", package = "spDataLarge")`.

Now that we have the data, we can go on and initiate a GRASS\index{GRASS} session.
First of all, we need to find out if and where GRASS is installed on the computer.


```r
library(link2GI)
link = findGRASS()
```

GRASS GIS differs from many other GIS software in its approach for handling input data -- it puts all of the input data in a GRASS spatial database.
The GRASS geodatabase \index{spatial database} system is based on SQLite.
Consequently, different users can easily work on the same project, possibly with different read/write permissions.
However, one has to set up this spatial database\index{spatial database} (also from within R), and users might find this process a bit intimidating in the beginning.
First of all, the GRASS database requires its own directory, which, in turn, contains a location (see the [GRASS GIS Database](https://grass.osgeo.org/grass80/manuals/grass_database.html) help pages at [grass.osgeo.org](https://grass.osgeo.org/grass80/manuals/index.html) for further information).
The location stores the geodata for one project or one area.
Within one location, several mapsets can exist that typically refer to different users or different tasks.
Each location also has PERMANENT -- a mandatory mapset that is created automatically.
PERMANENT stores the projection, the spatial extent and the default resolution for raster data.
In order to share geographic data with all users of a project, the database owner can add spatial data to the PERMANENT mapset.
So, to sum it all up -- the GRASS geodatabase may contain many locations (all data in one location have the same CRS), and each location can store many mapsets (groups of datasets).
Please refer to @neteler_open_2008 and the [GRASS GIS quick start](https://grass.osgeo.org/grass80/manuals/helptext.html) for more information on the GRASS spatial database\index{spatial database} system.

Now, you have to set up a location and a mapset if you want to use GRASS\index{GRASS} from within R.

<!--toDo:jn-->
<!--improve the next code chunk-->




<!-- `link` is a `data.frame` which contains in its rows the GRASS 7 installations on your computer.  -->
<!-- Here, we will use a GRASS 7\index{GRASS} installation. -->
<!-- If you have not installed GRASS 7 on your computer, we recommend that you do so now. -->
<!-- Assuming that we have found a working installation on your computer, we use the corresponding path in `initGRASS`.  -->
<!-- Additionally, we specify where to store the spatial database\index{spatial database} (gisDbase), name the location `london`, and use the PERMANENT mapset. -->

<!-- ```{r 09-gis-28, eval=FALSE} -->
<!-- library(rgrass7) -->
<!-- # find a GRASS 7 installation, and use the first one -->
<!-- ind = grep("7", link$version)[1] -->
<!-- # next line of code only necessary if we want to use GRASS as installed by  -->
<!-- # OSGeo4W. Among others, this adds some paths to PATH, which are also needed -->
<!-- # for running GRASS. -->
<!-- link2GI::paramGRASSw(link[ind, ]) -->
<!-- grass_path =  -->
<!--   ifelse(test = !is.null(link$installation_type) &&  -->
<!--            link$installation_type[ind] == "osgeo4W", -->
<!--          yes = file.path(link$instDir[ind], "apps/grass", link$version[ind]), -->
<!--          no = link$instDir) -->
<!-- initGRASS(gisBase = grass_path, -->
<!--           # home parameter necessary under UNIX-based systems -->
<!--           home = tempdir(), -->
<!--           gisDbase = tempdir(), location = "london",  -->
<!--           mapset = "PERMANENT", override = TRUE) -->
<!-- ``` -->

<!-- Subsequently, we define the projection, the extent and the resolution. -->

<!-- ```{r 09-gis-29, eval=FALSE} -->
<!-- execGRASS("g.proj", flags = c("c", "quiet"),  -->
<!--           proj4 = st_crs(london_streets)$proj4string) -->
<!-- b_box = st_bbox(london_streets)  -->
<!-- execGRASS("g.region", flags = c("quiet"),  -->
<!--           n = as.character(b_box["ymax"]), s = as.character(b_box["ymin"]),  -->
<!--           e = as.character(b_box["xmax"]), w = as.character(b_box["xmin"]),  -->
<!--           res = "1") -->
<!-- ``` -->

<!-- Once you are familiar with how to set up the GRASS environment, it becomes tedious to do so over and over again. -->
<!-- Luckily, `linkGRASS7()` of the **link2GI** packages lets you do it with one line of code. -->
<!-- The only thing you need to provide is a spatial object which determines the projection and the extent of the spatial database.\index{spatial database}. -->
<!-- First, `linkGRASS7()` finds all GRASS\index{GRASS} installations on your computer. -->
<!-- Since we have set `ver_select` to `TRUE`, we can interactively choose one of the found GRASS-installations. -->
<!-- If there is just one installation, the `linkGRASS7()` automatically chooses this one. -->
<!-- Second, `linkGRASS7()` establishes a connection to GRASS 7. -->

<!-- ```{r 09-gis-30, eval=FALSE} -->
<!-- link2GI::linkGRASS7(london_streets, ver_select = TRUE) -->
<!-- ``` -->

<!-- Before we can use GRASS geoalgorithms\index{geoalgorithm}, we need to add data to GRASS's spatial database\index{spatial database}. -->
<!-- Luckily, the convenience function `writeVECT()` does this for us. -->
<!-- (Use `writeRAST()` in the case of raster data.) -->
<!-- In our case we add the street and cycle hire point data while using only the first attribute column, and name them also `london_streets` and `points`.  -->

<!-- To use **sf**-objects with **rgrass7**, we have to run `use_sf()` first (note: the code below assumes you are running **rgrass7** 0.2.1 or above). -->

<!-- ```{r 09-gis-31, eval=FALSE} -->
<!-- use_sf() -->
<!-- writeVECT(SDF = london_streets, vname = "london_streets") -->
<!-- writeVECT(SDF = points[, 1], vname = "points") -->
<!-- ``` -->

<!-- To perform our network\index{network} analysis, we need a topological clean street network. -->
<!-- GRASS's `v.clean` takes care of the removal of duplicates, small angles and dangles, among others.  -->
<!-- Here, we break lines at each intersection to ensure that the subsequent routing algorithm can actually turn right or left at an intersection, and save the output in a GRASS object named `streets_clean`. -->
<!-- It is likely that a few of our cycling station points will not lie exactly on a street segment. -->
<!-- However, to find the shortest route\index{shortest route} between them, we need to connect them to the nearest streets segment. -->
<!-- `v.net`'s connect-operator does exactly this.  -->
<!-- We save its output in `streets_points_con`. -->

<!-- ```{r 09-gis-32, eval=FALSE} -->
<!-- # clean street network -->
<!-- execGRASS(cmd = "v.clean", input = "london_streets", output = "streets_clean", -->
<!--           tool = "break", flags = "overwrite") -->
<!-- # connect points with street network -->
<!-- execGRASS(cmd = "v.net", input = "streets_clean", output = "streets_points_con",  -->
<!--           points = "points", operation = "connect", threshold = 0.001, -->
<!--           flags = c("overwrite", "c")) -->
<!-- ``` -->

<!-- The resulting clean dataset serves as input for the `v.net.salesman`-algorithm, which finally finds the shortest route between all cycle hire stations. -->
<!-- `center_cats` requires a numeric range as input. -->
<!-- This range represents the points for which a shortest route should be calculated.  -->
<!-- Since we would like to calculate the route for all cycle stations, we set it to `1-25`. -->
<!-- To access the GRASS help page of the traveling salesman\index{traveling salesman} algorithm\index{algorithm}, run `execGRASS("g.manual", entry = "v.net.salesman")`. -->

<!-- ```{r 09-gis-33, eval=FALSE} -->
<!-- execGRASS(cmd = "v.net.salesman", input = "streets_points_con", -->
<!--           output = "shortest_route", center_cats = paste0("1-", nrow(points)), -->
<!--           flags = c("overwrite")) -->
<!-- ``` -->

<!-- To visualize our result, we import the output layer into R, convert it into an sf-object keeping only the geometry, and visualize it with the help of the **mapview** package (Figure \@ref(fig:grass-mapview) and Section \@ref(interactive-maps)). -->

<!-- ```{r grass-mapview, fig.cap="Shortest route (blue line) between 24 cycle hire stations (blue dots) on the OSM street network of London.", fig.scap="Shortest route between 24 cycle hire stations.", echo=FALSE, out.width="80%"} -->
<!-- knitr::include_graphics("figures/09_shortest_route.png") -->
<!-- ``` -->

<!-- ```{r 09-gis-34, eval=FALSE} -->
<!-- route = readVECT("shortest_route") |> -->
<!--   st_as_sf() |> -->
<!--   st_geometry() -->
<!-- mapview::mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) + -->
<!--   points -->
<!-- ``` -->

<!-- ```{r 09-gis-35, eval=FALSE, echo=FALSE} -->
<!-- library("mapview") -->
<!-- m_1 = mapview(route, map.types = "OpenStreetMap.BlackAndWhite", lwd = 7) + -->
<!--   points -->
<!-- mapview::mapshot(m_1,  -->
<!--                  file = file.path(getwd(), "figures/09_shortest_route.png"), -->
<!--                  remove_controls = c("homeButton", "layersControl", -->
<!--                                      "zoomControl")) -->
<!-- ``` -->

<!-- There are a few important considerations to note in the process: -->

<!-- - We could have used GRASS's spatial database\index{spatial database} (based on SQLite) which allows faster processing.  -->
<!-- That means we have only exported geographic data at the beginning. -->
<!-- Then we created new objects but only imported the final result back into R. -->
<!-- To find out which datasets are currently available, run `execGRASS("g.list", type = "vector,raster", flags = "p")`. -->
<!-- - We could have also accessed an already existing GRASS spatial database from within R. -->
<!-- Prior to importing data into R, you might want to perform some (spatial) subsetting\index{vector!subsetting}. -->
<!-- Use `v.select` and `v.extract` for vector data.  -->
<!-- `db.select` lets you select subsets of the attribute table of a vector layer without returning the corresponding geometry. -->
<!-- - You can also start R from within a running GRASS\index{GRASS} session [for more information please refer to @bivand_applied_2013 and this [wiki](https://grasswiki.osgeo.org/wiki/R_statistics/rgrass7)]. -->
<!-- - Refer to the excellent [GRASS online help](https://grass.osgeo.org/grass77/manuals/) or `execGRASS("g.manual", flags = "i")` for more information on each available GRASS geoalgorithm\index{geoalgorithm}. -->
<!-- - If you would like to use GRASS 6 from within R, use the R package **spgrass6**. -->

### WhiteboxTools {#whitebox}

<!-- whitebox init -->

<!-- https://giswqs.github.io/whiteboxR/ -->

<!-- Pre-compiled binaries are only available for download for 64-bit Linux (Ubuntu 20.04), Windows and Mac OS (Intel) platforms. -->


```r
whitebox::install_whitebox()
```

<!-- source code (or docker) - https://github.com/jblindsay/whitebox-tools -->


```r
library(whitebox)
wbt_init()
```

<!-- `??whitebox` -->
<!-- ??wbt_ -->

<!-- For more information visit https://giswqs.github.io/whiteboxR/ -->
<!-- https://www.whiteboxgeo.com/manual/wbt_book/intro.html -->


## When to use what?

To recommend a single R-GIS interface is hard since the usage depends on personal preferences, the tasks at hand and your familiarity with different GIS\index{GIS} software packages which in turn probably depends on your field of study.
As mentioned previously, SAGA\index{SAGA} is especially good at the fast processing of large (high-resolution) raster\index{raster} datasets, and frequently used by hydrologists, climatologists and soil scientists [@conrad_system_2015].
GRASS GIS\index{GRASS}, on the other hand, is the only GIS presented here supporting a topologically based spatial database which is especially useful for network analyses but also simulation studies (see below).
QGIS is much more user-friendly compared to GRASS- and SAGA-GIS, especially for first-time GIS users, and probably the most popular open-source GIS.
Therefore, **RQGIS**\index{RQGIS (package)} is an appropriate choice for most use cases.
Its main advantages are:

- A unified access to several GIS, and therefore the provision of >1000 geoalgorithms (Table \@ref(tab:gis-comp)) including duplicated functionality, e.g., you can perform overlay-operations using QGIS-\index{QGIS}, SAGA-\index{SAGA} or GRASS-geoalgorithms\index{GRASS}
- Automatic data format conversions (SAGA uses `.sdat` grid files and GRASS uses its own database format but QGIS will handle the corresponding conversions)
- Its automatic passing of geographic R objects to QGIS geoalgorithms\index{geoalgorithm} and back into R
- Convenience functions to support the access of the online help, named arguments and automatic default value retrieval (**rgrass7**\index{rgrass7 (package)} inspired the latter two features)

By all means, there are use cases when you certainly should use one of the other R-GIS bridges.
Though QGIS is the only GIS providing a unified interface to several GIS\index{GIS} software packages, it only provides access to a subset of the corresponding third-party geoalgorithms (for more information please refer to @muenchow_rqgis:_2017).
Therefore, to use the complete set of SAGA and GRASS functions, stick with **RSAGA**\index{RSAGA (package)} and **rgrass7**. 
When doing so, take advantage of **RSAGA**'s numerous user-friendly functions.
Note also, that **RSAGA** offers native R functions for geocomputation such as `multi.local.function()`, `pick.from.points()` and many more.
**RSAGA** supports much more SAGA versions than (R)QGIS.
Finally, if you need topological correct data and/or spatial database management functionality such as multi-user access, we recommend the usage of GRASS. 
In addition, if you would like to run simulations with the help of a geodatabase\index{spatial database} [@krug_clearing_2010], use **rgrass7** directly since **RQGIS** always starts a new GRASS session for each call.

Please note that there are a number of further GIS software packages that have a scripting interface but for which there is no dedicated R package that accesses these: gvSig, OpenJump, Orfeo Toolbox and TauDEM.

## Other bridges

The focus of this chapter is on R interfaces to Desktop GIS\index{GIS} software.
We emphasize these bridges because dedicated GIS software is well-known and a common 'way in' to understanding geographic data.
They also provide access to many geoalgorithms\index{geoalgorithm}.

Other 'bridges' include interfaces to spatial libraries (Section \@ref(gdal) shows how to access the GDAL\index{GDAL} CLI\index{command-line interface} from R), spatial databases\index{spatial database} (see Section \@ref(postgis)) and web mapping services (see Chapter \@ref(adv-map)).
This section provides only a snippet of what is possible.
Thanks to R's\index{R} flexibility, with its ability to call other programs from the system and integration with other languages (notably via **Rcpp** and **reticulate**\index{reticulate (package)}), many other bridges are possible.
The aim is not to be comprehensive, but to demonstrate other ways of accessing the 'flexibility and power' in the quote by @sherman_desktop_2008 at the beginning of the chapter.

### Bridges to GDAL {#gdal}

As discussed in Chapter \@ref(read-write), GDAL\index{GDAL} is a low-level library that supports many geographic data formats.
GDAL is so effective that most GIS programs use GDAL\index{GDAL} in the background for importing and exporting geographic data, rather than re-inventing the wheel and using bespoke read-write code.
But GDAL\index{GDAL} offers more than data I/O.
It has [geoprocessing tools](https://gdal.org/programs/index.html) for vector and raster data, functionality to create [tiles](https://gdal.org/programs/gdal2tiles.html#gdal2tiles) for serving raster data online, and rapid [rasterization](https://gdal.org/programs/gdal_rasterize.html#gdal-rasterize) of vector data, all of which can be accessed via the system of R command line.

<!--toDo:jn-->
<!--expand a list of what is possible-->

The code chunk below demonstrates this functionality:
`linkGDAL()` searches the computer for a working GDAL\index{GDAL} installation and adds the location of the executable files to the PATH variable, allowing GDAL to be called.


```r
link2GI::linkGDAL()
```

<!--toDo:jn-->
<!--explain the syntax-->
Now we can use the `system()` function to call any of the GDAL tools.
For example, `ogrinfo()` provides metadata of a vector dataset.
Here we will call this tool with two additional flags: `-al` to list all features of all layers and `-so` to get a summary only (and not a complete geometry list):


```r
our_filepath = system.file("shapes/world.gpkg", package = "spData")
cmd = paste("ogrinfo -al -so", our_filepath)
system(cmd)
#> INFO: Open of `.../spData/shapes/world.gpkg'
#>       using driver `GPKG' successful.
#> 
#> Layer name: world
#> Geometry: Multi Polygon
#> Feature Count: 177
#> Extent: (-180.000000, -89.900000) - (179.999990, 83.645130)
#> Layer SRS WKT:
#> ...
```

The 'link' to GDAL provided by **link2GI** could be used as a foundation for doing more advanced GDAL work from the R or system CLI.
TauDEM (http://hydrology.usu.edu/taudem) and the Orfeo Toolbox (https://www.orfeo-toolbox.org/) are other spatial data processing libraries/programs offering a command line interface -- the above example shows how to access these libraries from the system command line via R.
This in turn could be the starting point for creating a proper interface to these libraries in the form of new R packages.

Before diving into a project to create a new bridge, however, it is important to be aware of the power of existing R packages and that `system()` calls may not be platform-independent (they may fail on some computers).
Furthermore, **sf** brings most of the power provided by GDAL\index{GDAL}, GEOS\index{GEOS} and PROJ\index{PROJ} to R via the R/C++\index{C++} interface provided by **Rcpp**, which avoids `system()` calls.

### Bridges to spatial databases {#postgis}

<!--toDo:jn-->
<!--consider referencing to 3rd edition-->

\index{spatial database}
Spatial database management systems (spatial DBMS) store spatial and non-spatial data in a structured way.
They can organize large collections of data into related tables (entities) via unique identifiers (primary and foreign keys) and implicitly via space (think for instance of a spatial join). 
This is useful because geographic datasets tend to become big and messy quite quickly.
Databases enable storing and querying large datasets efficiently based on spatial and non-spatial fields, and provide multi-user access and topology\index{topological relations} support.

The most important open source spatial database\index{spatial database} is PostGIS\index{PostGIS} [@obe_postgis_2015].^[
SQLite/SpatiaLite are certainly also important but implicitly we have already introduced this approach since GRASS\index{GRASS} is using SQLite in the background (see Section \@ref(grass)).
]
R bridges to spatial DBMSs such as PostGIS\index{PostGIS} are important, allowing access to huge data stores without loading several gigabytes of geographic data into RAM, and likely crashing the R session.
The remainder of this section shows how PostGIS can be called from R, based on "Hello real world" from *PostGIS in Action, Second Edition* [@obe_postgis_2015].^[
Thanks to Manning Publications, Regina Obe and Leo Hsu for permission to use this example.
]

The subsequent code requires a working internet connection, since we are accessing a PostgreSQL/PostGIS\index{PostGIS} database which is living in the QGIS Cloud (https://qgiscloud.com/).^[
QGIS\index{QGIS} Cloud lets you store geographic data and maps in the cloud. 
In the background, it uses QGIS Server and PostgreSQL/PostGIS.
This way, the reader can follow the PostGIS example without the need to have PostgreSQL/PostGIS installed on a local machine.
Thanks to the QGIS Cloud team for hosting this example.
]
Our first step here is to create a connection to a database by providing its name, host name, and user information.


```r
library(RPostgreSQL)
conn = dbConnect(drv = PostgreSQL(), 
                 dbname = "rtafdf_zljbqm", host = "db.qgiscloud.com",
                 port = "5432", user = "rtafdf_zljbqm", password = "d3290ead")
```

Our new object, `conn`, is just an established link between our R session and the database.
It does not store any data.

Often the first question is, 'which tables can be found in the database?'.
This can be answered with `dbListTables()` as follows:


```r
dbListTables(conn)
#> [1] "spatial_ref_sys" "topology"        "layer"           "restaurants"    
#> [5] "highways" 
```

The answer is five tables.
Here, we are only interested in the `restaurants` and the `highways` tables.
The former represents the locations of fast-food restaurants in the US, and the latter are principal US highways.
To find out about attributes available in a table, we can run `dbListFields`:


```r
dbListFields(conn, "highways")
#> [1] "qc_id"        "wkb_geometry" "gid"          "feature"     
#> [5] "name"         "state"   
```

Now, as we know the available datasets, we can perform some queries -- ask the database some questions.
The query needs to be provided in a language understandable by the database -- usually, it is SQL.
The first query will select `US Route 1` in the state of Maryland (`MD`) from the `highways` table.
Note that `read_sf()` allows us to read geographic data from a database if it is provided with an open connection to a database and a query.
Additionally, `read_sf()` needs to know which column represents the geometry (here: `wkb_geometry`).


```r
query = paste(
  "SELECT *",
  "FROM highways",
  "WHERE name = 'US Route 1' AND state = 'MD';")
us_route = read_sf(conn, query = query, geom = "wkb_geometry")
```

This results in an **sf**-object\index{sf} named `us_route` of type `MULTILINESTRING`.

As we mentioned before, it is also possible to not only ask non-spatial questions, but also query datasets based on their spatial properties.
To show this, the next example adds a 35-kilometer (35,000 m) buffer around the selected highway (Figure \@ref(fig:postgis)).


```r
query = paste(
  "SELECT ST_Union(ST_Buffer(wkb_geometry, 35000))::geometry",
  "FROM highways",
  "WHERE name = 'US Route 1' AND state = 'MD';")
buf = read_sf(conn, query = query)
```

Note that this was a spatial query using functions (`ST_Union()`\index{vector!union}, `ST_Buffer()`\index{vector!buffers}) you should be already familiar with.
You find them also in the **sf**-package, though here they are written in lowercase characters (`st_union()`, `st_buffer()`).
In fact, function names of the **sf** package largely follow the PostGIS\index{PostGIS} naming conventions.^[
The prefix `st` stands for space/time.
]

The last query will find all Hardee's restaurants (`HDE`) within the 35 km buffer zone (Figure \@ref(fig:postgis)).


```r
query = paste(
  "SELECT *",
  "FROM restaurants r",
  "WHERE EXISTS (",
  "SELECT gid",
  "FROM highways",
  "WHERE",
  "ST_DWithin(r.wkb_geometry, wkb_geometry, 35000) AND",
  "name = 'US Route 1' AND",
  "state = 'MD' AND",
  "r.franchise = 'HDE');"
)
hardees = read_sf(conn, query = query)
```

Please refer to @obe_postgis_2015 for a detailed explanation of the spatial SQL query.
Finally, it is good practice to close the database connection as follows:^[
It is important to close the connection here because QGIS Cloud (free version) allows only ten concurrent connections.
]


```r
RPostgreSQL::postgresqlCloseConnection(conn)
```



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{10-gis_files/figure-latex/postgis-1} 

}

\caption[Visualization of the output of previous PostGIS commands.]{Visualization of the output of previous PostGIS commands showing the highway (black line), a buffer (light yellow) and four restaurants (red points) within the buffer.}(\#fig:postgis)
\end{figure}

Unlike PostGIS, **sf** only supports spatial vector data. 
To query and manipulate raster data stored in a PostGIS database, use the **rpostgis** package [@bucklin_rpostgis_2018] and/or use command-line tools such as `rastertopgsql` which comes as part of the PostGIS\index{PostGIS} installation. 

This subsection is only a brief introduction to PostgreSQL/PostGIS.
Nevertheless, we would like to encourage the practice of storing geographic and non-geographic data in a spatial DBMS\index{spatial database} while only attaching those subsets to R's global environment which are needed for further (geo-)statistical analysis.
Please refer to @obe_postgis_2015 for a more detailed description of the SQL queries presented and a more comprehensive introduction to PostgreSQL/PostGIS in general.
PostgreSQL/PostGIS is a formidable choice as an open-source spatial database.
But the same is true for the lightweight SQLite/SpatiaLite database engine and GRASS\index{GRASS} which uses SQLite in the background (see Section \@ref(grass)).

As a final note, if your data is getting too big for PostgreSQL/PostGIS and you require massive spatial data management and query performance, then the next logical step is to use large-scale geographic querying on distributed computing systems, as for example, provided by GeoMesa (http://www.geomesa.org/) or Apache Sedona [https://sedona.apache.org/; formerly known as GeoSpark - @huang_geospark_2017].

## Bridges to cloud technologies and services {#cloud}

### STAC, COGs, and data cubes in the cloud

Major cloud computing providers (Amazon Web Services, Microsoft Azure / Planetary Computer, Google Cloud Platform, and others)\index{cloud computing} offer huge catalogs of open Earth observation data such as the complete Sentinel-2 archive on their platforms. 
We can use R and directly connect to and process data from these archives, ideally from a machine in the same cloud and region.

Three promising developments that make working with such image archives on cloud platforms _easier_ and _more efficient_ are the [SpatioTemporal Asset Catalog (STAC)](https://stacspec.org)\index{STAC}, the [cloud-optimized GeoTIFF (COG)](https://www.cogeo.org/)\index{COG} image file format, and the concept of data cubes\index{data cube}. 
Below, we introduce these individual developments and briefly describe how they can be used from R. 

The SpatioTemporal Asset Catalog (STAC)\index{STAC} is a general description format for spatiotemporal data that is used to describe a variety of datasets on cloud platforms including imagery, synthetic aperture radar (SAR) data, and point clouds. 
Besides simple static catalog descriptions, STAC-API presents a web service to query items (e.g. images) of catalogs by space, time, and other properties. 
In R, the **rstac** package [@simoes_rstac_2021] allows to connect to STAC-API endpoints and search for items. 
In the example below, we request all images from the [Sentinel-2 Cloud-Optimized GeoTIFF (COG) dataset on Amazon Web Services](https://registry.opendata.aws/sentinel-2-l2a-cogs)\index{COG} that intersect with a predefined area and time of interest. 
The result contains all found images and their metadata (e.g. cloud cover) and URLs pointing to actual files on AWS. 


```r
library(rstac)
# Connect to the STAC-API endpoint for Sentinel-2 data
# and search for images intersecting our AOI
s = stac("https://earth-search.aws.element84.com/v0")
items = s |>
  stac_search(collections = "sentinel-s2-l2a-cogs",
              bbox = c(7.1, 51.8, 7.2, 52.8), 
              datetime = "2020-01-01/2020-12-31") |>
  post_request() |> items_fetch()
```

Cloud storage differs from local hard disks and traditional image file formats do not perform well in cloud-based geoprocessing. 
Broadly speaking, the cloud-optimized GeoTIFF\index{COG} format is a specific type of GeoTIFF that makes it possible to efficiently read only parts of an image from cloud storage. 
As a result, reading rectangular subsets of an image or reading images at lower resolution becomes much more efficient. 
As an R user, you don't have to install anything to work with COGs because [GDAL](https://gdal.org)\index{GDAL} (and any package using it) can already work with COGs. However, keep in mind that the availability of COGs is a big plus while browsing through catalogs of data providers.

For larger areas of interest, requested images are still relatively difficult to work with: they may use different map projections, may spatially overlap, and the spatial resolution often depends on the spectral band. 
The **gdalcubes** package [@appel_gdalcubes_2019] can be used to abstract from individual images and to create and process image collections as four-dimensional data cubes\index{data cube}.

The code below shows a minimal example to create a lower resolution (250m) maximum NDVI composite from the Sentinel-2 images returned by the previous STAC-API search. 


```r
library(gdalcubes)
# Filter images from STAC response by cloud cover 
# and create an image collection object
collection = stac_image_collection(items$features, 
                  property_filter = function(x) {x[["eo:cloud_cover"]] < 10})
# Define extent, resolution (250m, daily) and CRS of the target data cube
v = cube_view(srs = "EPSG:3857", extent = collection, dx = 250, dy = 250,
              dt = "P1D") # "P1D" is an ISO 8601 duration string
# Create and process the data cube
cube = raster_cube(collection, v) |>
  select_bands(c("B04", "B08")) |>
  apply_pixel("(B08-B04)/(B08+B04)", "NDVI") |>
  reduce_time("max(NDVI)")
# gdalcubes_options(parallel = 8)
# plot(cube, zlim = c(0,1))
```

To filter images by cloud cover, we provide a property filter function that is applied on each STAC\index{STAC} result item while creating the image collection. 
The function receives available metadata of an image as input list and returns a single logical value such that only images for which the function yields TRUE will be considered. 
In this case, we ignore images with 10% or more cloud cover. 

The combination of STAC\index{STAC}, COGs\index{COG}, and data cubes\index{data cube} forms a cloud-native workflow to analyze (larger) collections of satellite imagery in the cloud\index{cloud computing}. 
For more details, please refer to this [tutorial presented at OpenGeoHub summer school 2021](https://appelmar.github.io/ogh2021/tutorial.html).

### openEO

Besides hosting large data archives, numerous cloud-based services\index{cloud computing} to process Earth observation data have been launched during the last years. 
OpenEO [@schramm_openeo_2021]\index{openEO} is an initiative to support interoperability among cloud services by defining a common language for processing the data. 
The initial idea has been described in an [r-spatial.org blog post](https://r-spatial.org/2016/11/29/openeo.html) and aims at making it possible for users to change between cloud services easily with as little code changes as possible. 
The [standardized processes](https://processes.openeo.org) use a multidimensional data cube model\index{data cube} as an interface to the data. 
Implementations are available for eight different backends (see https://hub.openeo.org) to which users can connect with R, Python, JavaScript, QGIS, or a web editor and define (and chain) processes on collections. 
Since the functionality and data availability differs among the backends, the **openeo** R package [@lahn_openeo_2021] dynamically loads available processes and collections from the connected backend. 
Afterwards, users can load image collections, apply and chain processes, submit jobs, and explore and plot results. 

The following code will connect to the [openEO platform backend](https://openeo.cloud/), request available datasets, processes, and output formats, define a process graph to compute a maximum NDVI image from Sentinel-2 data, and finally executes the graph after logging in to the backend. 
The openEO\index{openEO} platform backend includes a free tier and registration is possible from existing institutional or social platform accounts. 


```r
library(openeo)
con = connect(host = "https://openeo.cloud")
p = processes() # load available processes
collections = list_collections() # load available collections
formats = list_file_formats() # load available output formats
# Load Sentinel-2 collection
s2 = p$load_collection(id = "SENTINEL2_L2A",
                       spatial_extent = list(west = 7.5, east = 8.5,
                                             north = 51.1, south = 50.1),
                       temporal_extent = list("2021-01-01", "2021-01-31"),
                       bands = list("B04","B08")) 
# Compute NDVI vegetation index
compute_ndvi = p$reduce_dimension(data = s2, dimension = "bands",
                                  reducer = function(data, context) {
                                    (data[2] - data[1]) / (data[2] + data[1])
                                  })
# Compute maximum over time
reduce_max = p$reduce_dimension(data = compute_ndvi, dimension = "t",
                                reducer = function(x, y) {max(x)})
# Export as GeoTIFF
result = p$save_result(reduce_max, formats$output$GTiff)
# Login, see https://docs.openeo.cloud/getting-started/r/#authentication
login(login_type = "oidc",
      provider = "egi",
      config = list(
        client_id= "...",
        secret = "..."))
# Execute processes
compute_result(graph = result, output_file = tempfile(fileext = ".tif"))
```

## Exercises

1. Create two overlapping polygons (`poly_1` and `poly_2`) with the help of the **sf**-package (see Chapter \@ref(spatial-class)). 

1. Union `poly_1` and `poly_2` using `st_union()` and `qgis:union`.
What is the difference between the two union operations\index{vector!union}? 
How can we use the **sf**\index{sf} package to obtain the same result as QGIS\index{QGIS}?

1. Calculate the intersection\index{vector!intersection} of `poly_1` and `poly_2` using:

    - **RQGIS**, **RSAGA** and **rgrass7**
    - **sf**

1. Attach `data(dem, package = "spDataLarge")` and `data(random_points, package = "spDataLarge")`.
Select randomly a point from `random_points` and find all `dem` pixels that can be seen from this point (hint: viewshed\index{viewshed}).
Visualize your result.
For example, plot a hillshade\index{hillshade}, and on top of it the digital elevation model\index{digital elevation model}, your viewshed\index{viewshed} output and the point.
Additionally, give `mapview` a try.

1. Compute catchment area\index{catchment area} and catchment slope of `data("dem", package = "spDataLarge")` using **RSAGA** (see Section \@ref(saga)).

1. Use `gdalinfo` via a system call for a raster\index{raster} file stored on disk of your choice (see Section \@ref(gdal)).

1. Query all Californian highways from the PostgreSQL/PostGIS\index{PostGIS} database living in the QGIS\index{QGIS} Cloud introduced in this chapter (see Section \@ref(postgis)).


<!--chapter:end:10-gis.Rmd-->

# Scripts, algorithms and functions {#algorithms}

## Prerequisites {-}

This chapter primarily uses base R; the **sf**\index{sf} package is used to check the result of an algorithm we will develop.
It assumes you have an understanding of the geographic classes introduced in Chapter \@ref(spatial-class) and how they can be used to represent a wide range of input file formats (see Chapter \@ref(read-write)).

## Introduction {#intro-algorithms}

Chapter \@ref(intro) established that geocomputation is not only about using existing tools, but developing new ones, "in the form of shareable R scripts and functions".
This chapter teaches these building blocks of reproducible code.
It also introduces low-level geometric algorithms, of the type used in Chapter \@ref(gis).
Reading it should help you to understand how such algorithms work and to write code that can be used many times, by many people, on multiple datasets.
The chapter cannot, by itself, make you a skilled programmer.
Programming is hard and requires plenty of practice [@abelson_structure_1996]:

> To appreciate programming as an intellectual activity in its own right you must turn to computer programming; you must read and write computer programs --- many of them.

There are strong reasons for moving in that direction, however.^[
This chapter does not teach programming itself.
For more on programming, we recommend @wickham_advanced_2019, @gillespie_efficient_2016, and @xiao_gis_2016. 
]
The advantages of reproducibility\index{reproducibility} go beyond allowing others to replicate your work:
reproducible code is often better in every way than code written to be run only once, including in terms of computational efficiency, scalability and ease of adapting and maintaining it.

Scripts are the basis of reproducible R code, a topic covered in Section \@ref(scripts).
Algorithms are recipes for modifying inputs using a series of steps, resulting in an output, as described in Section \@ref(geometric-algorithms).
To ease sharing and reproducibility, algorithms can be placed into functions.
That is the topic of Section \@ref(functions).
The example of finding the centroid\index{centroid} of a polygon will be used to tie these concepts together.
Chapter \@ref(geometric-operations) already introduced a centroid\index{centroid} function `st_centroid()`, but this example highlights how seemingly simple operations are the result of comparatively complex code, affirming the following observation [@wise_gis_2001]:

> One of the most intriguing things about spatial data problems is that things which appear to be trivially easy to a human being can be surprisingly difficult on a computer.

The example also reflects a secondary aim of the chapter which, following @xiao_gis_2016, is "not to duplicate what is available out there, but to show how things out there work".

## Scripts

If functions distributed in packages are the building blocks of R code, scripts are the glue that holds them together, in a logical order, to create reproducible workflows.
To programming novices scripts may sound intimidating but they are simply plain text files, typically saved with an extension representing the language they contain.
R scripts are generally saved with a `.R` extension and named to reflect what they do.
An example is `11-hello.R`, a script file stored in the `code` folder of the book's repository, which contains the following two lines of code:

```r
# Aim: provide a minimal R script
print("Hello geocompr")
```

The lines of code may not be particularly exciting but they demonstrate the point: scripts do not need to be complicated.
Saved scripts can be called and executed in their entirety with `source()`, as demonstrated below which shows how the comment is ignored but the instruction is executed:


```r
source("code/11-hello.R")
#> [1] "Hello geocompr"
```

There are no strict rules on what can and cannot go into script files and nothing to prevent you from saving broken, non-reproducible code.^[
Lines of code that do not contain valid R should be commented out, by adding a `#` to the start of the line, to prevent errors.
See line 1 of the `11-hello.R` script.
]
There are, however, some conventions worth following:

- Write the script in order: just like the script of a film, scripts should have a clear order such as 'setup', 'data processing' and 'save results' (roughly equivalent to 'beginning', 'middle' and 'end' in a film).
- Add comments to the script so other people (and your future self) can understand it. At a minimum, a comment should state the purpose of the script (see Figure \@ref(fig:codecheck)) and (for long scripts) divide it into sections. This can be done in RStudio\index{RStudio}, for example, with the shortcut `Ctrl+Shift+R`, which creates 'foldable' code section headings.

- Above all, scripts should be reproducible: self-contained scripts that will work on any computer are more useful than scripts that only run on your computer, on a good day. This involves attaching required packages at the beginning, reading-in data from persistent sources (such as a reliable website) and ensuring that previous steps have been taken.^[
Prior steps can be referred to with a comment or with an if statement such as `if(!exists("x")) source("x.R")` (which would run the script file `x.R` if the object `x` is missing).
]

It is hard to enforce reproducibility in R scripts, but there are tools that can help.
By default, RStudio \index{RStudio} 'code-checks' R scripts and underlines faulty code with a red wavy line, as illustrated below:

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/codecheck} 

}

\caption[Illustration of 'code checking' in RStudio.]{Code checking in RStudio. This example, from the script 11-centroid-alg.R, highlights an unclosed curly bracket on line 19.}(\#fig:codecheck)
\end{figure}

\BeginKnitrBlock{rmdnote}
A useful tool for reproducibility is the **reprex** package.
Its main function `reprex()` tests lines of R code to check if they are reproducible, and provides markdown output to facilitate communication on sites such as GitHub.
See the web page reprex.tidyverse.org for details.
\EndKnitrBlock{rmdnote}

\index{reproducibility}

The contents of this section apply to any type of R script.
A particular consideration with scripts for geocomputation is that they tend to have external dependencies, such as the QGIS\index{QGIS} dependency to run code in Chapter \@ref(gis), and require input data in a specific format.
Such dependencies should be mentioned as comments in the script or elsewhere in the project of which it is a part, as illustrated in the script [`11-centroid-alg.R`](https://github.com/Robinlovelace/geocompr/blob/main/code/11-centroid-alg.R).
The work undertaken by this script is demonstrated in the reproducible example below, which works on a pre-requisite object named `poly_mat`, a square with sides 9 units in length (the meaning of this will become apparent in the next section):^[
This example shows that `source()` works with URLs (a shortened version is used here), assuming you have an internet connection.
If you do not, the same script can be called with `source("code/11-centroid-alg.R")`, assuming you are running R from the root directory of the `geocompr` folder, which can be downloaded from https://github.com/Robinlovelace/geocompr.
]


```r
poly_mat = cbind(
  x = c(0, 0, 9, 9, 0),
  y = c(0, 9, 9, 0, 0)
)
source("https://raw.githubusercontent.com/Robinlovelace/geocompr/master/code/11-centroid-alg.R")
```


```
#> [1] "The area is: 81"
#> [1] "The coordinates of the centroid are: 4.5, 4.5"
```

## Geometric algorithms

Algorithms\index{algorithm} can be understood as the computing equivalent of a cooking recipe.
They are a complete set of instructions which, when undertaken on the input (ingredients), result in useful (tasty) outputs.
Before diving into a concrete case study, a brief history will show how algorithms relate to scripts (covered in Section \@ref(scripts)) and functions (which can be used to generalize algorithms, as we'll see in Section \@ref(functions)).

The word "algorithm"\index{algorithm} originated in 9^th^ century Baghdad with the publication of *Hisab al-jabr w’al-muqabala*, an early math textbook.
The book was translated into Latin and became so popular that the author's last name, [al-Khwārizmī](https://en.wikipedia.org/wiki/Muhammad_ibn_Musa_al-Khwarizmi), "was immortalized as a scientific term: Al-Khwarizmi
became Alchoarismi, Algorismi and, eventually, algorithm" [@bellos_alex_2011].
In the computing age, algorithm\index{algorithm} refers to a series of steps that solves a problem, resulting in a pre-defined output.
Inputs must be formally defined in a suitable data structure [@wise_gis_2001].
Algorithms\index{algorithm} often start as flow charts or pseudocode\index{pseudocode} showing the aim of the process before being implemented in code.
To ease usability, common algorithms are often packaged inside functions, which may hide some or all of the steps taken (unless you look at the function's source code, see Section \@ref(functions)).

Geoalgorithms\index{geoalgorithm}, such as those we encountered in Chapter \@ref(gis), are algorithms that take geographic data in and, generally, return geographic results (alternative terms for the same thing include *GIS algorithms* and *geometric algorithms*).
That may sound simple but it is a deep subject with an entire academic field, *Computational Geometry*, dedicated to their study [@berg_computational_2008] and numerous books on the subject.
@orourke_computational_1998, for example, introduces the subject with a range of progressively harder geometric algorithms using reproducible and freely available C code.

An example of a geometric algorithm is one that finds the centroid\index{centroid} of a polygon.
There are many approaches to centroid\index{centroid} calculation, some of which work only on specific types of [spatial data](https://en.wikipedia.org/wiki/Centroid).
For the purposes of this section, we choose an approach that is easy to visualize: breaking the polygon into many triangles and finding the centroid\index{centroid} of each of these, an approach discussed by @kaiser_algorithms_1993 alongside other centroid algorithms [and mentioned briefly in @orourke_computational_1998].
It helps to further break down this approach into discrete tasks before writing any code (subsequently referred to as step 1 to step 4, these could also be presented as a schematic diagram or pseudocode\index{pseudocode}):

1. Divide the polygon into contiguous triangles.
2. Find the centroid\index{centroid} of each triangle.
3. Find the area of each triangle.
4. Find the area-weighted mean of triangle centroids\index{centroid}.

These steps may sound straightforward, but converting words into working code requires some work and plenty of trial-and-error, even when the inputs are constrained:
The algorithm will only work for *convex polygons*, which contain no internal angles greater than 180°, no star shapes allowed (packages **decido** and **sfdct** can triangulate non-convex polygons using external libraries, as shown in the [algorithm](https://geocompr.github.io/geocompkg/articles/algorithm.html) vignette at geocompr.github.io). 

The simplest data structure of a polygon is a matrix of x and y coordinates in which each row represents a vertex tracing the polygon's border in order where the first and last rows are identical [@wise_gis_2001].
In this case, we'll create a polygon with five vertices in base R, building on an example from *GIS Algorithms* [@xiao_gis_2016 see [github.com/gisalgs](https://github.com/gisalgs/geom) for Python code], as illustrated in Figure \@ref(fig:polymat):




```r
# generate a simple matrix representation of a polygon:
x_coords = c(10, 0, 0, 12, 20, 10)
y_coords = c(0, 0, 10, 20, 15, 0)
poly_mat = cbind(x_coords, y_coords)
```

Now that we have an example dataset, we are ready to undertake step 1 outlined above.
The code below shows how this can be done by creating a single triangle (`T1`), that demonstrates the method; it also demonstrates step 2 by calculating its centroid\index{centroid} based on the [formula](https://math.stackexchange.com/q/1702595/) $1/3(a + b + c)$ where $a$ to $c$ are coordinates representing the triangle's vertices:


```r
# create a point representing the origin:
Origin = poly_mat[1, ]
# create 'triangle matrix':
T1 = rbind(Origin, poly_mat[2:3, ], Origin) 
# find centroid (drop = FALSE preserves classes, resulting in a matrix):
C1 = (T1[1, , drop = FALSE] + T1[2, , drop = FALSE] + T1[3, , drop = FALSE]) / 3
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{11-algorithms_files/figure-latex/polymat-1} 

}

\caption{Illustration of polygon centroid calculation problem.}(\#fig:polymat)
\end{figure}

Step 3 is to find the area of each triangle, so a *weighted mean* accounting for the disproportionate impact of large triangles is accounted for. 
The formula to calculate the area of a triangle is as follows [@kaiser_algorithms_1993]:

$$
\frac{Ax ( B y − C y ) + B x ( C y − A y ) + C x ( A y − B y )}
{ 2 }
$$

Where $A$ to $C$ are the triangle's three points and $x$ and $y$ refer to the x and y dimensions.
A translation of this formula into R code that works with the data in the matrix representation of a triangle `T1` is as follows (the function `abs()` ensures a positive result):


```r
# calculate the area of the triangle represented by matrix T1:
abs(T1[1, 1] * (T1[2, 2] - T1[3, 2]) +
  T1[2, 1] * (T1[3, 2] - T1[1, 2]) +
  T1[3, 1] * (T1[1, 2] - T1[2, 2]) ) / 2
#> [1] 50
```

This code chunk outputs the correct result.^[
The result can be verified with the following formula (which assumes a horizontal base):
area is half of the base width times height, $A = B * H / 2$.
In this case $10 * 10 / 2 = 50$.
]
The problem is that code is clunky and must by re-typed if we want to run it on another triangle matrix.
To make the code more generalizable, we will see how it can be converted into a function in Section \@ref(functions).

Step 4 requires steps 2 and 3 to be undertaken not just on one triangle (as demonstrated above) but on all triangles.
This requires *iteration* to create all triangles representing the polygon, illustrated in Figure \@ref(fig:polycent).
`lapply()`\index{loop!lapply} and `vapply()`\index{loop!vapply} are used to iterate over each triangle here because they provide a concise solution in base R:^[
See `?lapply` for documentation and Chapter \@ref(location) for more on iteration.
]


```r
i = 2:(nrow(poly_mat) - 2)
T_all = lapply(i, function(x) {
  rbind(Origin, poly_mat[x:(x + 1), ], Origin)
})

C_list = lapply(T_all,  function(x) (x[1, ] + x[2, ] + x[3, ]) / 3)
C = do.call(rbind, C_list)

A = vapply(T_all, function(x) {
  abs(x[1, 1] * (x[2, 2] - x[3, 2]) +
        x[2, 1] * (x[3, 2] - x[1, 2]) +
        x[3, 1] * (x[1, 2] - x[2, 2]) ) / 2
  }, FUN.VALUE = double(1))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{11-algorithms_files/figure-latex/polycent-1} 

}

\caption[Illustration of iterative centroid algorithm with triangles.]{Illustration of iterative centroid algorithm with triangles. The X represents the area-weighted centroid in iterations 2 and 3.}(\#fig:polycent)
\end{figure}

We are now in a position to complete step 4 to calculate the total area with `sum(A)` and the centroid\index{centroid} coordinates of the polygon with `weighted.mean(C[, 1], A)` and `weighted.mean(C[, 2], A)` (exercise for alert readers: verify these commands work).
To demonstrate the link between algorithms\index{algorithm} and scripts, the contents of this section have been condensed into `11-centroid-alg.R`.
We saw at the end of Section \@ref(scripts) how this script can calculate the centroid\index{centroid} of a square.
The great thing about *scripting* the algorithm is that it works on the new `poly_mat` object (see exercises below to verify these results with reference to `st_centroid()`):


```r
source("code/11-centroid-alg.R")
#> [1] "The area is: 245"
#> [1] "The coordinates of the centroid are: 8.83, 9.22"
```

The example above shows that low-level geographic operations *can* be developed from first principles with base R.
It also shows that if a tried-and-tested solution already exists, it may not be worth re-inventing the wheel:
if we aimed only to find the centroid\index{centroid} of a polygon, it would have been quicker to represent `poly_mat` as an **sf** object and use the pre-existing `sf::st_centroid()` function instead.
However, the great benefit of writing algorithms from 1^st^ principles is that you will understand every step of the process, something that cannot be guaranteed when using other peoples' code.
A further consideration is performance: R is slow compared with low-level languages such as C++\index{C++} for number crunching (see Section \@ref(software-for-geocomputation)) and optimization is difficult.
If the aim is to develop new methods, computational efficiency should not be prioritized.
This is captured in the saying "premature optimization is the root of all evil (or at least most of it) in programming" [@knuth_computer_1974].

Algorithm\index{algorithm} development is hard.
This should be apparent from the amount of work that has gone into developing a centroid\index{centroid} algorithm\index{algorithm} in base R\index{R} that is just one, rather inefficient, approach to the problem with limited real-world applications (convex polygons are uncommon in practice).
The experience should lead to an appreciation of low-level geographic libraries such as GEOS\index{GEOS} (which underlies `sf::st_centroid()`) and CGAL\index{CGAL} (the Computational Geometry Algorithms Library) which not only run fast but work on a wide range of input geometry types.
A great advantage of the open source nature of such libraries is that their source code\index{source code} is readily available for study, comprehension and (for those with the skills and confidence) modification.^[
The CGAL\index{CGAL} function `CGAL::centroid()` is in fact composed of 7 sub-functions as described at https://doc.cgal.org/latest/Kernel_23/group__centroid__grp.html allowing it to work on a wide range of input data types, whereas the solution we created works only on a very specific input data type.
The source code underlying GEOS\index{GEOS} function `Centroid::getCentroid()` can be found at https://github.com/libgeos/geos/search?q=getCentroid.
]

## Functions

Like algorithms\index{algorithm}, functions take an input and return an output.
Functions\index{function}, however, refer to the implementation in a particular programming language, rather than the 'recipe' itself.
In R, functions\index{function} are objects in their own right, that can be created and joined together in a modular fashion.
We can, for example, create a function that undertakes step 2 of our centroid\index{centroid} generation algorithm\index{algorithm} as follows:


```r
t_centroid = function(x) {
  (x[1, ] + x[2, ] + x[3, ]) / 3
}
```

The above example demonstrates two key components of [functions](http://adv-r.had.co.nz/Functions.html):
1) the function *body*, the code inside the curly brackets that define what the function does with the inputs; and 2) the *formals*, the list of arguments the function works with --- `x` in this case (the third key component, the environment, is beyond the scope of this section).
By default, functions return the last object that has been calculated (the coordinates of the centroid\index{centroid} in the case of `t_centroid()`).^[
You can also explicitly set the output of a function by adding `return(output)` into the body of the function, where `output` is the result to be returned.
]



The function now works on any inputs you pass it, as illustrated in the below command which calculates the area of the 1^st^ triangle from the example polygon in the previous section (see Figure \@ref(fig:polycent)):


```r
t_centroid(T1)
#> x_coords y_coords 
#>     3.33     3.33
```

We can also create a function\index{function} to calculate a triangle's area, which we will name `t_area()`:


```r
t_area = function(x) {
  abs(
    x[1, 1] * (x[2, 2] - x[3, 2]) +
    x[2, 1] * (x[3, 2] - x[1, 2]) +
    x[3, 1] * (x[1, 2] - x[2, 2])
  ) / 2
}
```

Note that after the function's creation, a triangle's area can be calculated in a single line of code, avoiding duplication of verbose code:
functions are a mechanism for *generalizing* code.
The newly created function\index{function} `t_area()` takes any object `x`, assumed to have the same dimensions as the 'triangle matrix' data structure we've been using, and returns its area, as illustrated on `T1` as follows:


```r
t_area(T1)
#> [1] 50
```

We can test the generalizability of the function\index{function} by using it to find the area of a new triangle matrix, which has a height of 1 and a base of 3:


```r
t_new = cbind(x = c(0, 3, 3, 0),
              y = c(0, 0, 1, 0))
t_area(t_new)
#>   x 
#> 1.5
```

A useful feature of functions is that they are modular.
Provided that you know what the output will be, one function can be used as the building block of another.
Thus, the functions `t_centroid()` and `t_area()` can be used as sub-components of a larger function\index{function} to do the work of the script `11-centroid-alg.R`: calculate the area of any convex polygon.
The code chunk below creates the function `poly_centroid()` to mimic the behavior of `sf::st_centroid()` for convex polygons:^[
Note that the functions we created are called iteratively in `lapply()`\index{loop!lapply} and `vapply()`\index{loop!vapply} function calls.
]


```r
poly_centroid = function(poly_mat) {
  Origin = poly_mat[1, ] # create a point representing the origin
  i = 2:(nrow(poly_mat) - 2)
  T_all = lapply(i, function(x) {
    rbind(Origin, poly_mat[x:(x + 1), ], Origin)
  })
  C_list = lapply(T_all, t_centroid)
  C = do.call(rbind, C_list)
  A = vapply(T_all, t_area, FUN.VALUE = double(1))
  c(weighted.mean(C[, 1], A), weighted.mean(C[, 2], A))
}
```





```r
poly_centroid(poly_mat)
#> [1] 8.83 9.22
```

Functions\index{function} such as `poly_centroid()` can further be extended to provide different types of output.
To return the result as an object of class `sfg`, for example, a 'wrapper' function can be used to modify the output of `poly_centroid()` before returning the result:


```r
poly_centroid_sfg = function(x) {
  centroid_coords = poly_centroid(x)
  sf::st_point(centroid_coords)
}
```

We can verify that the output is the same as the output from `sf::st_centroid()` as follows:


```r
poly_sfc = sf::st_polygon(list(poly_mat))
identical(poly_centroid_sfg(poly_mat), sf::st_centroid(poly_sfc))
#> [1] TRUE
```

## Programming

In this chapter we have moved quickly, from scripts to functions via the tricky topic of algorithms\index{algorithm}.
Not only have we discussed them in the abstract, but we have also created working examples of each to solve a specific problem:

- The script `11-centroid-alg.R` was introduced and demonstrated on a 'polygon matrix'
- The individual steps that allowed this script to work were described as an algorithm\index{algorithm}, a computational recipe
- To generalize the algorithm\index{algorithm} we converted it into modular functions which were eventually combined to create the function `poly_centroid()` in the previous section

Taken on its own, each of these steps is straightforward.
But the skill of programming is combining scripts, algorithms and functions in a way that produces performant, robust and user-friendly tools that other people can use.
If you are new to programming, as we expect most people reading this book will be, being able to follow and reproduce the results in the preceding sections should be seen as a major achievement. 
Programming takes many hours of dedicated study and practice before you become proficient.

The challenge facing developers aiming to implement new algorithms\index{algorithm} in an efficient way is put in perspective by considering that we have only created a toy function.
In its current state, `poly_centroid()` fails on most (non-convex) polygons!
A question arising from this is: how would one generalize the function\index{function}?
Two options are (1) to find ways to triangulate non-convex polygons (a topic covered in the online [algorithm](https://geocompr.github.io/geocompkg/articles/algorithm.html) article that supports this chapter) and (2) to explore other centroid\index{centroid} algorithms\index{algorithm} that do not rely on triangular meshes.

A wider question is: is it worth programming a solution at all when high performance algorithms have already been implemented and packaged in functions such as `st_centroid()`?
The reductionist answer in this specific case is 'no'.
In the wider context, and considering the benefits of learning to program, the answer is 'it depends'.
With programming, it's easy to waste hours trying to implement a method, only to find that someone has already done the hard work.
So instead of seeing this chapter as your first stepping stone towards geometric algorithm programming wizardry, it may be more productive to use it as a lesson in when to try to program a generalized solution, and when to use existing higher-level solutions.
There will surely be occasions when writing new functions is the best way forward, but there will also be times when using functions that already exist is the best way forward.

We cannot guarantee that, having read this chapter, you will be able to rapidly create new functions\index{function} for your work.
But we are confident that its contents will help you decide when is an appropriate time to try (when no other existing functions solve the problem, when the programming task is within your capabilities and when the benefits of the solution are likely to outweigh the time costs of developing it).
First steps towards programming can be slow (the exercises below should not be rushed) but the long-term rewards can be large.

## Exercises {#ex-algorithms}

1. Read the script `11-centroid-alg.R` in the `code` folder of the book's GitHub repo.
    - Which of the best practices covered in Section \@ref(scripts) does it follow?
    - Create a version of the script on your computer in an IDE\index{IDE} such as RStudio\index{RStudio} (preferably by typing-out the script line-by-line, in your own coding style and with your own comments, rather than copy-pasting --- this will help you learn how to type scripts). Using the example of a square polygon (e.g., created with `poly_mat = cbind(x = c(0, 0, 9, 9, 0), y = c(0, 9, 9, 0, 0))`) execute the script line-by-line.
    - What changes could be made to the script to make it more reproducible?
    <!-- - Answer: The script could state that it needs an object called `poly_mat` to be present and, if none is present, create an example dataset at the outset for testing. -->
<!-- 1. Check-out the script `11-earthquakes.R` in the `code` folder of the book's GitHub [repo](https://github.com/Robinlovelace/geocompr/blob/main/code/11-earthquakes.R). -->
<!--     - Try to reproduce the results: how many significant earthquakes were there last month? -->
<!--     - Modify the script so that it provides a map with all earthquakes that happened in the past hour. -->
<!-- change line 10 to: -->
<!-- u = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_hour.geojson" -->
    - How could the documentation be improved?
  <!-- It could document the source of the data better - e.g. with `data from https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php` -->
1. In Section \@ref(geometric-algorithms) we calculated that the area and geographic centroid\index{centroid} of the polygon represented by `poly_mat` was 245 and 8.8, 9.2, respectively.
    - Reproduce the results on your own computer with reference to the script `11-centroid-alg.R`, an implementation of this algorithm (bonus: type out the commands - try to avoid copy-pasting).
    <!-- Todo: add link to that script file (RL) -->
    - Are the results correct? Verify them by converting `poly_mat` into an `sfc` object (named `poly_sfc`) with `st_polygon()` (hint: this function takes objects of class `list()`) and then using `st_area()` and `st_centroid()`.
<!-- We can verify the answer by converting `poly_mat` into a simple feature collection as follows, which shows the calculations match: -->

1. It was stated that the algorithm\index{algorithm} we created only works for *convex hulls*. Define convex hulls\index{convex hull} (see Chapter \@ref(geometric-operations)) and test the algorithm on a polygon that is *not* a convex hull.
     - Bonus 1: Think about why the method only works for convex hulls and note changes that would need to be made to the algorithm to make it work for other types of polygon.
<!-- The algorithm would need to be able to have negative as well as positive area values. -->
     - Bonus 2: Building on the contents of `11-centroid-alg.R`, write an algorithm\index{algorithm} only using base R functions that can find the total length of linestrings represented in matrix form.
<!-- Todo: add example of matrix representing a linestring, demonstrate code to verify the answer, suggest alternative functions to decompose as a bonus. -->
1. In Section \@ref(functions) we created different versions of the `poly_centroid()` function that generated outputs of class `sfg` (`poly_centroid_sfg()`) and type-stable `matrix` outputs (`poly_centroid_type_stable()`). Further extend the function by creating a version (e.g., called `poly_centroid_sf()`) that is type stable (only accepts inputs of class `sf`) *and* returns `sf` objects (hint: you may need to convert the object `x` into a matrix with the command `sf::st_coordinates(x)`).
    - Verify it works by running `poly_centroid_sf(sf::st_sf(sf::st_sfc(poly_sfc)))`
    - What error message do you get when you try to run `poly_centroid_sf(poly_mat)`?
    


<!--chapter:end:11-algorithms.Rmd-->

# Statistical learning {#spatial-cv}

## Prerequisites {-}

This chapter assumes proficiency with geographic data analysis\index{geographic data analysis}, for example gained by studying the contents and working-through the exercises in Chapters \@ref(spatial-class) to \@ref(reproj-geo-data).
A familiarity with generalized linear models (GLM)\index{GLM} and machine learning\index{machine learning} is highly recommended [for example from @zuur_mixed_2009;@james_introduction_2013].

The chapter uses the following packages:^[
Packages **GGally**, **lgr**, **kernlab**, **ml3measures**, **paradox**, **pROC**, **progressr** and **spDataLarge** must also be installed although these do not need to be attached.
]


```r
library(dplyr)
library(future)
library(lgr)
library(mlr3)
library(mlr3learners)
library(mlr3extralearners)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(mlr3viz)
library(progressr)
library(sf)
library(terra)
```

Required data will be attached in due course.

## Introduction {#intro-cv1}

Statistical learning\index{statistical learning} is concerned with the use of statistical and computational models for identifying patterns in data and predicting from these patterns.
Due to its origins, statistical learning\index{statistical learning} is one of R's\index{R} great strengths (see Section \@ref(software-for-geocomputation)).^[
Applying statistical techniques to geographic data has been an active topic of research for many decades in the fields of geostatistics, spatial statistics and point pattern analysis [@diggle_modelbased_2007; @gelfand_handbook_2010; @baddeley_spatial_2015].
]
Statistical learning\index{statistical learning} combines methods from statistics\index{statistics} and machine learning\index{machine learning} and can be categorized into supervised and unsupervised techniques.
Both are increasingly used in disciplines ranging from physics, biology and ecology to geography and economics [@james_introduction_2013].

This chapter focuses on supervised techniques in which there is a training dataset, as opposed to unsupervised techniques such as clustering\index{clustering}.
Response variables can be binary (such as landslide occurrence), categorical (land use), integer (species richness count) or numeric (soil acidity measured in pH).
Supervised techniques model the relationship between such responses --- which are known for a sample of observations --- and one or more predictors.

<!-- For this we can use techniques from the field of statistics or from the field of machine learning.
Which to use depends on the primary aim: statistical inference or prediction.
Statistical regression techniques are especially useful if the aim is statistical inference.
These techniques also allow predictions of unseen data points but this is usually only of secondary interest to statisticians.
Statistical inference, on the other hand, refers among others to a predictor's significance, its importance for a specific model, its relationship with the response and the uncertainties associated with the estimated coefficients.
To trust the p-values and standard errors of such models we need to perform a thorough model validation testing if one or several of the underlying model assumptions (heterogeneity, independence, etc.) have been violated [@zuur_mixed_2009].
By contrast, statistical inference is impossible with machine learning [@james_introduction_2013].
-->
<!-- The primary aim of machine learning is to make good predictions, whereas the field of statistics is more focussed on the underlying theory [e.g. @zuur_mixed_2009] -->

The primary aim of much machine learning\index{machine learning} research is to make good predictions, as opposed to statistical/Bayesian inference, which is good at helping to understand underlying mechanisms and uncertainties in the data [see @krainski_advanced_2018].
Machine learning thrives in the age of 'big data'\index{big data} because its methods make few assumptions about input variables and can handle huge datasets.
Machine learning is conducive to tasks such as the prediction of future customer behavior, recommendation services (music, movies, what to buy next), face recognition, autonomous driving, text classification and predictive maintenance (infrastructure, industry).

<!-- ^[In this case we do not have too worry too much about possible model misspecifications since we explicitly do not want to do statistical inference.] -->

This chapter is based on a case study: the (spatial) prediction of landslides.
This application links to the applied nature of geocomputation, defined in Chapter \@ref(intro), and illustrates how machine learning\index{machine learning} borrows from the field of statistics\index{statistics} when the sole aim is prediction.
Therefore, this chapter first introduces modeling and cross-validation\index{cross-validation} concepts with the help of a Generalized Linear Model \index{GLM} [@zuur_mixed_2009].
Building on this, the chapter implements a more typical machine learning\index{machine learning} algorithm\index{algorithm}, namely a Support Vector Machine (SVM)\index{SVM}.
The models' **predictive performance** will be assessed using spatial cross-validation (CV)\index{cross-validation!spatial CV}, which accounts for the fact that geographic data is special.

CV\index{cross-validation} determines a model's ability to generalize to new data, by splitting a dataset (repeatedly) into training and test sets.
It uses the training data to fit the model, and checks its performance when predicting against the test data.
CV helps to detect overfitting\index{overfitting} since models that predict the training data too closely (noise) will tend to perform poorly on the test data.

Randomly splitting spatial data can lead to training points that are neighbors in space with test points.
Due to spatial autocorrelation\index{autocorrelation!spatial}, test and training datasets would not be independent in this scenario, with the consequence that CV\index{cross-validation} fails to detect a possible overfitting\index{overfitting}.
Spatial CV\index{cross-validation!spatial CV} alleviates this problem and is the **central** theme in this chapter.

## Case study: Landslide susceptibility {#case-landslide}

This case study is based on a dataset of landslide locations in Southern Ecuador, illustrated in Figure \@ref(fig:lsl-map) and described in detail in @muenchow_geomorphic_2012.
A subset of the dataset used in that paper is provided in the **spDataLarge**\index{spDataLarge (package)} package, which can be loaded as follows:


```r
data("lsl", "study_mask", package = "spDataLarge")
ta = terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))
```

The above code loads three objects: a `data.frame` named `lsl`, an `sf` object named `study_mask` and a `SpatRaster` (see Section \@ref(raster-classes)) named `ta` containing terrain attribute rasters.
`lsl` contains a factor column `lslpts` where `TRUE` corresponds to an observed landslide 'initiation point', with the coordinates stored in columns `x` and `y`.^[
The landslide initiation point is located in the scarp of a landslide polygon. See @muenchow_geomorphic_2012 for further details.
]
There are 175 landslide and 175 non-landslide points, as shown by `summary(lsl$lslpts)`.
The 175 non-landslide points were sampled randomly from the study area, with the restriction that they must fall outside a small buffer around the landslide polygons.

\begin{figure}[t]

{\centering \includegraphics[width=0.7\linewidth]{figures/lsl-map-1} 

}

\caption[Landslide initiation points.]{Landslide initiation points (red) and points unaffected by landsliding (blue) in Southern Ecuador.}(\#fig:lsl-map)
\end{figure}
\index{hillshade}

The first three rows of `lsl`, rounded to two significant digits, can be found in Table \@ref(tab:lslsummary).

\begin{table}

\caption[`lsl` dataset.]{(\#tab:lslsummary)Structure of the lsl dataset.}
\centering
\resizebox{\linewidth}{!}{
\begin{tabular}[t]{lrrlrrrrr}
\toprule
  & x & y & lslpts & slope & cplan & cprof & elev & log10\_carea\\
\midrule
1 & 713888 & 9558537 & FALSE & 34 & 0.023 & 0.003 & 2400 & 2.8\\
2 & 712788 & 9558917 & FALSE & 39 & -0.039 & -0.017 & 2100 & 4.1\\
350 & 713826 & 9559078 & TRUE & 35 & 0.020 & -0.003 & 2400 & 3.2\\
\bottomrule
\end{tabular}}
\end{table}

To model landslide susceptibility, we need some predictors.
Since terrain attributes are frequently associated with landsliding [@muenchow_geomorphic_2012], we have already extracted following terrain attributes from `ta` to `lsl`:

- `slope`:  slope angle (°)
- `cplan`: plan curvature (rad m^−1^) expressing the convergence or divergence of a slope and thus water flow
- `cprof`: profile curvature (rad m^-1^) as a measure of flow acceleration, also known as downslope change in slope angle
- `elev`: elevation (m a.s.l.) as the representation of different altitudinal zones of vegetation and precipitation in the study area
- `log10_carea`: the decadic logarithm of the catchment area (log10 m^2^) representing the amount of water flowing towards a location

It might be a worthwhile exercise to compute the terrain attributes with the help of R-GIS bridges (see Chapter \@ref(gis)) and extract them to the landslide points (see Exercise section at the end of this Chapter).

## Conventional modeling approach in R {#conventional-model}

Before introducing the **mlr3**\index{mlr3 (package)} package, an umbrella-package providing a unified interface to dozens of learning algorithms (Section \@ref(spatial-cv-with-mlr3)), it is worth taking a look at the conventional modeling interface in R\index{R}.
This introduction to supervised statistical learning\index{statistical learning} provides the basis for doing spatial CV\index{cross-validation!spatial CV}, and contributes to a better grasp on the **mlr3**\index{mlr3 (package)} approach presented subsequently.

Supervised learning involves predicting a response variable as a function of predictors (Section \@ref(intro-cv)). 
In R\index{R}, modeling functions are usually specified using formulas (see `?formula` and the detailed [Formulas in R Tutorial](https://www.datacamp.com/community/tutorials/r-formula-tutorial) for details of R formulas).
The following command specifies and runs a generalized linear model\index{GLM}:


```r
fit = glm(lslpts ~ slope + cplan + cprof + elev + log10_carea,
          family = binomial(),
          data = lsl)
```

It is worth understanding each of the three input arguments:

- A formula, which specifies landslide occurrence (`lslpts`) as a function of the predictors
- A family, which specifies the type of model, in this case `binomial` because the response is binary (see `?family`)
- The data frame which contains the response and the predictors (as columns)

The results of this model can be printed as follows (`summary(fit)` provides a more detailed account of the results):


```r
class(fit)
#> [1] "glm" "lm"
fit
#> 
#> Call:  glm(formula = lslpts ~ slope + cplan + cprof + elev + log10_carea, 
#>     family = binomial(), data = lsl)
#> 
#> Coefficients:
#> (Intercept)        slope        cplan        cprof         elev  log10_carea  
#>    2.51e+00     7.90e-02    -2.89e+01    -1.76e+01     1.79e-04    -2.27e+00  
#> 
#> Degrees of Freedom: 349 Total (i.e. Null);  344 Residual
#> Null Deviance:	    485 
#> Residual Deviance: 373 	AIC: 385
```

The model object `fit`, of class `glm`, contains the coefficients defining the fitted relationship between response and predictors.
It can also be used for prediction.
This is done with the generic `predict()` method, which in this case calls the function `predict.glm()`.
Setting `type` to `response` returns the predicted probabilities (of landslide occurrence) for each observation in `lsl`, as illustrated below (see `?predict.glm`):


```r
pred_glm = predict(object = fit, type = "response")
head(pred_glm)
#>      1      2      3      4      5      6 
#> 0.1901 0.1172 0.0952 0.2503 0.3382 0.1575
```

Spatial predictions can be made by applying the coefficients to the predictor rasters. 
This can be done manually or with `terra::predict()`.
In addition to a model object (`fit`), this function also expects a `SpatRaster` with the predictors (raster layers) named as in the model's input data frame (Figure \@ref(fig:lsl-susc)).


```r
# making the prediction
pred = terra::predict(ta, model = fit, type = "response")
```

\begin{figure}[t]

{\centering \includegraphics[width=0.7\linewidth]{figures/lsl-susc-1} 

}

\caption[Spatial prediction of landslide susceptibility.]{Spatial prediction of landslide susceptibility using a GLM.}(\#fig:lsl-susc)
\end{figure}

Here, when making predictions we neglect spatial autocorrelation\index{autocorrelation!spatial} since we assume that on average the predictive accuracy remains the same with or without spatial autocorrelation structures.
However, it is possible to include spatial autocorrelation\index{autocorrelation!spatial} structures into models [@zuur_mixed_2009;@blangiardo_spatial_2015;@zuur_beginners_2017] as well as into predictions [kriging approaches, see, e.g., @goovaerts_geostatistics_1997;@hengl_practical_2007;@bivand_applied_2013].
This is, however, beyond the scope of this book.
<!--
Nevertheless, we give the interested reader some pointers where to look it up:

1. The predictions of regression kriging combines the predictions of a regression with the kriging of the regression's residuals [@bivand_applied_2013]. 
2. One can also add a spatial correlation (dependency) structure to a generalized least squares model  [`nlme::gls()`; @zuur_mixed_2009; @zuur_beginners_2017].  
3. Finally, there are mixed-effect modeling approaches.
Basically, a random effect imposes a dependency structure on the response variable which in turn allows for observations of one class to be more similar to each other than to those of another class [@zuur_mixed_2009]. 
Classes can be, for example, bee hives, owl nests, vegetation transects or an altitudinal stratification.
This mixed modeling approach assumes normal and independent distributed random intercepts.^[Note that for spatial predictions one would usually use the population intercept.]
This can even be extended by using a random intercept that is normal and spatially dependent.
For this, however, you will have to resort most likely to Bayesian modeling approaches since frequentist software tools are rather limited in this respect especially for more complex models [@blangiardo_spatial_2015; @zuur_beginners_2017]. 
-->

Spatial prediction maps are one very important outcome of a model.
Even more important is how good the underlying model is at making them since a prediction map is useless if the model's predictive performance is bad.
The most popular measure to assess the predictive performance of a binomial model is the Area Under the Receiver Operator Characteristic Curve (AUROC)\index{AUROC}.
This is a value between 0.5 and 1.0, with 0.5 indicating a model that is no better than random and 1.0 indicating perfect prediction of the two classes. 
Thus, the higher the AUROC\index{AUROC}, the better the model's predictive power.
The following code chunk computes the AUROC\index{AUROC} value of the model with `roc()`, which takes the response and the predicted values as inputs. 
`auc()` returns the area under the curve.


```r
pROC::auc(pROC::roc(lsl$lslpts, fitted(fit)))
#> Area under the curve: 0.8216
```

An AUROC\index{AUROC} value of
<!--  -->
0.82 represents a good fit.
However, this is an overoptimistic estimation since we have computed it on the complete dataset. 
To derive a biased-reduced assessment, we have to use cross-validation\index{cross-validation} and in the case of spatial data should make use of spatial CV\index{cross-validation!spatial CV}.

## Introduction to (spatial) cross-validation {#intro-cv} 

Cross-validation\index{cross-validation} belongs to the family of resampling methods\index{resampling} [@james_introduction_2013].
The basic idea is to split (repeatedly) a dataset into training and test sets whereby the training data is used to fit a model which then is applied to the test set.
Comparing the predicted values with the known response values from the test set (using a performance measure such as the AUROC\index{AUROC} in the binomial case) gives a bias-reduced assessment of the model's capability to generalize the learned relationship to independent data.
For example, a 100-repeated 5-fold cross-validation means to randomly split the data into five partitions (folds) with each fold being used once as a test set (see upper row of Figure \@ref(fig:partitioning)). 
This guarantees that each observation is used once in one of the test sets, and requires the fitting of five models.
Subsequently, this procedure is repeated 100 times.
Of course, the data splitting will differ in each repetition.
<!--if the error is calc. on the fold-level. most often its calc. on the repetition level. maybe worth noting.
talk about this in person
-->
Overall, this sums up to 500 models, whereas the mean performance measure (AUROC\index{AUROC}) of all models is the model's overall predictive power.

However, geographic data is special.
As we will see in Chapter \@ref(transport), the 'first law' of geography states that points close to each other are, generally, more similar than points further away [@miller_tobler_2004].
This means these points are not statistically independent because training and test points in conventional CV\index{cross-validation} are often too close to each other (see first row of Figure \@ref(fig:partitioning)).
'Training' observations near the 'test' observations can provide a kind of 'sneak preview':
information that should be unavailable to the training dataset.
<!-- "folds" only for the repetition split, "partitions" or "subsets" for splitting within a fold
talk about this in person
-->
To alleviate this problem 'spatial partitioning' is used to split the observations into spatially disjointed subsets (using the observations' coordinates in a *k*-means clustering\index{clustering!kmeans}; @brenning_spatial_2012; second row of Figure \@ref(fig:partitioning)).
This partitioning strategy is the **only** difference between spatial and conventional CV.
As a result, spatial CV leads to a bias-reduced assessment of a model's predictive performance, and hence helps to avoid overfitting\index{overfitting}.
<!-- Alex suggested to remove this: 
It is important to note that spatial CV reduces the bias introduced by spatial autocorrelation but does not completely remove it. 
This is because there are still a few points in the test and training data which are still neighbors (@brenning_spatial_2012; see second row of \@ref(fig:partitioning)).
-->

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/13_partitioning} 

}

\caption[Spatial visualization of selected test and training observations.]{Spatial visualization of selected test and training observations for cross-validation of one repetition. Random (upper row) and spatial partitioning (lower row).}(\#fig:partitioning)
\end{figure}

## Spatial CV with **mlr3**
\index{mlr3 (package)}
There are dozens of packages for statistical learning\index{statistical learning}, as described for example in the [CRAN machine learning task view](https://CRAN.R-project.org/view=MachineLearning).
Getting acquainted with each of these packages, including how to undertake cross-validation and hyperparameter\index{hyperparameter} tuning, can be a time-consuming process.
Comparing model results from different packages can be even more laborious.
The **mlr3** package and ecosystem was developed to address these issues.
It acts as a 'meta-package', providing a unified interface to popular supervised and unsupervised statistical learning techniques including classification, regression\index{regression}, survival analysis and clustering\index{clustering} [@lang_mlr3_2019; @becker_mlr3_2022].
The standardized **mlr3** interface is based on eight 'building blocks'.
As illustrated in Figure \@ref(fig:building-blocks), these have a clear order.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/13_ml_abstraction_crop} 

}

\caption[Basic building blocks of the mlr3 package.]{Basic building blocks of the mlr3 package. Source: Becker(2022). (Permission to reuse this figure was kindly granted.)}(\#fig:building-blocks)
\end{figure}

The **mlr3** modeling process consists of three main stages.
First, a **task** specifies the data (including response and predictor variables) and the model type (such as regression\index{regression} or classification\index{classification}).
Second, a **learner** defines the specific learning algorithm that is applied to the created task.
Third, the **resampling** approach assesses the predictive performance of the model, i.e., its ability to generalize to new data (see also Section \@ref(intro-cv)).

### Generalized linear model {#glm}

To implement a GLM\index{GLM} in **mlr3**\index{mlr3 (package)}, we must create a **task** containing the landslide data.
Since the response is binary (two-category variable) and has a spatial dimension, we create a classification\index{classification} task with `TaskClassifST$new()` of the **mlr3spatiotempcv** package [@schratz_mlr3spatiotempcv_2021, for non-spatial tasks, use `mlr3::TaskClassif$new()` or `mlr3::TaskRegr$new()` for regression\index{regression} tasks, see `?Task` for other task types].^[The **mlr3** ecosystem makes heavily use of **data.table** and **R6** classes. And though you might use **mlr3** without knowing the specifics of **data.table** or **R6**, it might be rather helpful. To learn more about **data.table**, please refer to https://rdatatable.gitlab.io/data.table/index.html. To learn more about **R6**, we recommend [Chapter 14](https://adv-r.hadley.nz/fp.html) of the Advanced R book [@wickham_advanced_2019].]
The first essential argument of these `Task*$new()` functions is `backend`.
`backend` expects that the input data includes the response and predictor variables.
The `target` argument indicates the name of a response variable (in our case this is `lslpts`) and `positive` determines which of the two factor levels of the response variable indicate the landslide initiation point (in our case this is `TRUE`).
All other variables of the `lsl` dataset will serve as predictors.
For spatial CV, we need to provide a few extra arguments (`extra_args`).
The `coordinate_names` argument expects the names of the coordinate columns (see Section \@ref(intro-cv) and Figure \@ref(fig:partitioning)).
Additionally, we should indicate the used CRS (`crs`) and decide if we want to use the coordinates as predictors in the modeling (`coords_as_features`).


```r
# create task
task = mlr3spatiotempcv::TaskClassifST$new(
  id = "ecuador_lsl",
  backend = mlr3::as_data_backend(lsl), 
  target = "lslpts", 
  positive = "TRUE",
  coordinate_names = c("x", "y"),
  crs = "EPSG:32717",
  coords_as_features = FALSE,
  extra_args = list()
  )
```

Note that `TaskClassifST$new()` also accepts an `sf`-object as input for the `backend` parameter.
In this case, you might only want to specify the `coords_as_features` argument of the `extra_args` list.
We did not convert `lsl` into an `sf`-object because `TaskClassifST$new()` would just turn it back into a non-spatial `data.table` object in the background.
For a short data exploration, the `autoplot()` function of the **mlr3viz** package might come in handy since it plots the response against all predictors and all predictors against all predictors (not shown).


```r
# plot response against each predictor
mlr3viz::autoplot(task, type = "duo")
# plot all variables against each other
mlr3viz::autoplot(task, type = "pairs")
```

Having created a task, we need to choose a **learner** that determines the statistical learning\index{statistical learning} method to use.
All classification\index{classification} **learners** start with `classif.` and all regression\index{regression} learners with `regr.` (see `?Learner` for details). 
`mlr3extralearners::list_mlr3learners()` lists all available learners and from which package **mlr3** imports them (Table \@ref(tab:lrns)). 
To find out about learners that are able to model a binary response variable, we can run:


```r
mlr3extralearners::list_mlr3learners(
  filter = list(class = "classif", properties = "twoclass"), 
  select = c("id", "mlr3_package", "required_packages")) |>
  head()
```

\begin{table}

\caption[Sample of available learners.]{(\#tab:lrns)Sample of available learners for binomial tasks in the mlr3 package.}
\centering
\begin{tabular}[t]{lll}
\toprule
id & mlr3\_package & required\_packages\\
\midrule
classif.AdaBoostM1 & mlr3extralearners & mlr3             , mlr3extralearners, RWeka\\
classif.bart & mlr3extralearners & mlr3             , mlr3extralearners, dbarts\\
classif.C50 & mlr3extralearners & mlr3             , mlr3extralearners, C50\\
classif.catboost & mlr3extralearners & mlr3             , mlr3extralearners, catboost\\
classif.cforest & mlr3extralearners & mlr3             , mlr3extralearners, partykit         , sandwich         , coin\\
\addlinespace
classif.ctree & mlr3extralearners & mlr3             , mlr3extralearners, partykit         , sandwich         , coin\\
\bottomrule
\end{tabular}
\end{table}

This yields all learners able to model two-class problems (landslide yes or no).
We opt for the binomial classification\index{classification} method used in Section \@ref(conventional-model) and implemented as `classif.log_reg` in **mlr3learners**.
Additionally, we need to specify the `predict.type` which determines the type of the prediction with `prob` resulting in the predicted probability for landslide occurrence between 0 and 1 (this corresponds to `type = response` in `predict.glm`).


```r
learner = mlr3::lrn("classif.log_reg", predict_type = "prob")
```

To access the help page of the learner and find out from which package it was taken, we can run:


```r
learner$help()
```

<!--
Having specified a learner and a task, we can train our model which basically executes the `glm()` command in the background for our task. 


```r
learner$train(task)
learner$model
```




```r
fit = glm(lslpts ~ ., family = binomial(link = "logit"), 
          data = dplyr::select(lsl, -x, -y))
identical(fit$coefficients, learner$model$coefficients)
```
-->

The set-up steps for modeling with **mlr3**\index{mlr3 (package)} may seem tedious. 
But remember, this single interface provides access to the 130+ learners shown by `mlr3extralearners::list_mlr3learners()`; it would be far more tedious to learn the interface for each learner!
Further advantages are simple parallelization of resampling techniques and the ability to tune machine learning hyperparameters\index{hyperparameter} (see Section \@ref(svm)).
Most importantly, (spatial) resampling in **mlr3spatiotempcv** [@schratz_mlr3spatiotempcv_2021] is straightforward, requiring only two more steps: specifying a resampling method and running it.
We will use a 100-repeated 5-fold spatial CV\index{cross-validation!spatial CV}: five partitions will be chosen based on the provided coordinates in our `task` and the partitioning will be repeated 100 times:[^13]

[^13]: 

    Note that package **sperrorest** initially implemented spatial cross-validation in R [@brenning_spatial_2012].
    In the meantime, its functionality was integrated into the **mlr3** ecosystem which is the reason why we are using **mlr3** [@schratz_hyperparameter_2019]. The **tidymodels** framework is another umbrella-package for streamlined modeling in R; however, it only recently integrated support for spatial cross validation via **spatialsample** which so far only supports one spatial resampling method.



```r
resampling = mlr3::rsmp("repeated_spcv_coords", folds = 5, repeats = 100)
```

To execute the spatial resampling, we run `resample()` using the previously specified task, learner, and resampling strategy.
This takes some time (around 15 seconds on a modern laptop) because it computes 500 resampling partitions and 500 models. 
As performance measure, we again choose the AUROC.
To retrieve it, we use the `score()` method of the resampling result output object (`score_spcv_glm`).
This returns a `data.table` object with 500 rows -- one for each model.

<!--toDo:jn-->
<!--fix pipes-->


```r
# reduce verbosity
lgr::get_logger("mlr3")$set_threshold("warn")
# run spatial cross-validation and save it to resample result glm (rr_glm)
rr_spcv_glm = mlr3::resample(task = task,
                             learner = learner,
                             resampling = resampling)
# compute the AUROC as a data.table
score_spcv_glm = rr_spcv_glm$score(measure = mlr3::msr("classif.auc")) %>%
  # keep only the columns you need
  .[, .(task_id, learner_id, resampling_id, classif.auc)]
```

The output of the preceding code chunk is a bias-reduced assessment of the model's predictive performance.
We have saved it as `extdata/12-bmr_score.rds` in the book's GitHub repo.
If required, you can read it in as follows:


```r
score = readRDS("extdata/12-bmr_score.rds")
score_spcv_glm = score[learner_id == "classif.log_reg" & 
                         resampling_id == "repeated_spcv_coords"]
```

To compute the mean AUROC over all 500 models, we run:


```r
mean(score_spcv_glm$classif.auc) |>
  round(2)
#> [1] 0.77
```

To put these results in perspective, let us compare them with AUROC\index{AUROC} values from a 100-repeated 5-fold non-spatial cross-validation (Figure \@ref(fig:boxplot-cv); the code for the non-spatial cross-validation\index{cross-validation} is not shown here but will be explored in the exercise section).
<!--JN: why "as expected"? I think it would be great to explain this expectation in a few sentences here...-->
As expected, the spatially cross-validated result yields lower AUROC values on average than the conventional cross-validation approach, underlining the over-optimistic predictive performance due to spatial autocorrelation\index{autocorrelation!spatial} of the latter.


```
#> 
#> Attaching package: 'ggplot2'
#> The following object is masked from 'package:lgr':
#> 
#>     Layout
```

\begin{figure}[t]

{\centering \includegraphics[width=0.75\linewidth]{12-spatial-cv_files/figure-latex/boxplot-cv-1} 

}

\caption[Boxplot showing AUROC values.]{Boxplot showing the difference in GLM AUROC values on spatial and conventional 100-repeated 5-fold cross-validation.}(\#fig:boxplot-cv)
\end{figure}

### Spatial tuning of machine-learning hyperparameters {#svm}

Section \@ref(intro-cv) introduced machine learning\index{machine learning} as part of statistical learning\index{statistical learning}.
To recap, we adhere to the following definition of machine learning by [Jason Brownlee](https://machinelearningmastery.com/linear-regression-for-machine-learning/):

> Machine learning, more specifically the field of predictive modeling, is primarily concerned with minimizing the error of a model or making the most accurate predictions possible, at the expense of explainability.
In applied machine learning we will borrow, reuse and steal algorithms from many different fields, including statistics and use them towards these ends.

In Section \@ref(glm) a GLM was used to predict landslide susceptibility.
This section introduces support vector machines (SVM)\index{SVM} for the same purpose.
Random forest\index{random forest} models might be more popular than SVMs; however, the positive effect of tuning hyperparameters\index{hyperparameter} on model performance is much more pronounced in the case of SVMs [@probst_hyperparameters_2018].
Since (spatial) hyperparameter tuning is the major aim of this section, we will use an SVM.
For those wishing to apply a random forest model, we recommend to read this chapter, and then proceed to Chapter \@ref(eco) in which we will apply the currently covered concepts and techniques to make spatial predictions based on a random forest model.

SVMs\index{SVM} search for the best possible 'hyperplanes' to separate classes (in a classification\index{classification} case) and estimate 'kernels' with specific hyperparameters to create non-linear boundaries between classes [@james_introduction_2013].
Hyperparameters\index{hyperparameter} should not be confused with coefficients of parametric models, which are sometimes also referred to as parameters.^[
For a detailed description of the difference between coefficients and hyperparameters, see the 'machine mastery' blog post on the subject.
<!-- For a more detailed description of the difference between coefficients and hyperparameters, see the [machine mastery blog](https://machinelearningmastery.com/difference-between-a-parameter-and-a-hyperparameter/). -->
]
Coefficients can be estimated from the data, while hyperparameters are set before the learning begins.
Optimal hyperparameters are usually determined within a defined range with the help of cross-validation methods.
This is called hyperparameter tuning.

Some SVM implementations such as that provided by **kernlab** allow hyperparameters to be tuned automatically, usually based on random sampling (see upper row of Figure \@ref(fig:partitioning)).
This works for non-spatial data but is of less use for spatial data where 'spatial tuning' should be undertaken.

Before defining spatial tuning, we will set up the **mlr3**\index{mlr3 (package)} building blocks, introduced in Section \@ref(glm), for the SVM.
The classification\index{classification} task remains the same, hence we can simply reuse the `task` object created in Section \@ref(glm).
Learners implementing SVM can be found using `listLearners()` as follows:


```r
mlr3_learners = list_mlr3learners()
mlr3_learners[class == "classif" & grepl("svm", id),
              .(id, class, mlr3_package, required_packages)]
#>               id   class      mlr3_package              required_packages
#> 1:  classif.ksvm classif mlr3extralearners mlr3,mlr3extralearners,kernlab
#> 2: classif.lssvm classif mlr3extralearners mlr3,mlr3extralearners,kernlab
#> 3:   classif.svm classif      mlr3learners        mlr3,mlr3learners,e1071
```

Of the options illustrated above, we will use `ksvm()` from the **kernlab** package [@karatzoglou_kernlab_2004].
To allow for non-linear relationships, we use the popular radial basis function (or Gaussian) kernel which is also the default of `ksvm()`.
To make sure that the tuning does not stop because of one failing model, we additionally define a fallback learner (for more information please refer to https://mlr3book.mlr-org.com/technical.html#fallback-learners).


```r
lrn_ksvm = mlr3::lrn("classif.ksvm", predict_type = "prob", kernel = "rbfdot")
#> Warning: Package 'kernlab' required but not installed for Learner 'classif.ksvm'
lrn_ksvm$fallback = lrn("classif.featureless", predict_type = "prob")
```

The next stage is to specify a resampling strategy.
Again we will use a 100-repeated 5-fold spatial CV\index{cross-validation!spatial CV}.

<!-- Instead of saying "outer resampling" we concluded to use "performance estimation level" and "tuning level" (inner) in our paper
# this is also what is shown in the nested CV figure so it would be more consistent -->


```r
# performance estimation level
perf_level = mlr3::rsmp("repeated_spcv_coords", folds = 5, repeats = 100)
```

Note that this is the exact same code as used for the resampling for the GLM\index{GLM} in Section \@ref(glm); we have simply repeated it here as a reminder.

So far, the process has been identical to that described in Section \@ref(glm).
The next step is new, however: to tune the hyperparameters\index{hyperparameter}.
Using the same data for the performance assessment and the tuning would potentially lead to overoptimistic results [@cawley_overfitting_2010].
This can be avoided using nested spatial CV\index{cross-validation!spatial CV}.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/13_cv} 

}

\caption[Schematic of hyperparameter tuning.]{Schematic of hyperparameter tuning and performance estimation levels in CV. (Figure was taken from Schratz et al. (2019). Permission to reuse it was kindly granted.)}(\#fig:inner-outer)
\end{figure}

This means that we split each fold again into five spatially disjoint subfolds which are used to determine the optimal hyperparameters\index{hyperparameter} (`tune_level` object in the code chunk below; see Figure \@ref(fig:inner-outer) for a visual representation).
To find the optimal hyperparameter combination, we fit 50 models (`terminator` object in the code chunk below) in each of these subfolds with randomly selected values for the hyperparameters C and Sigma.
The random selection of values C and Sigma is additionally restricted to a predefined tuning space (`search_space` object).
The range of the tuning space was chosen with values recommended in the literature [@schratz_hyperparameter_2019].

<!--
Questions Pat:
- why not using e1071 svm -> inner hyperparameter tuning also possible I guess...
## Because kernlab has more kernel options. Other than that there is no argument
- explanation correct?
## If you mean the paragraph above, yes
- trafo-function?
## is just a different approach of writing the limits. You could also directly write 2^{-15}. Makes it easier to see the limits at the first glance. Personal preference though
- 125,000 models
-->

<!--
talk in person (see also exercises):
- can I compare the mean AUROC of the GLM and the SVM when using the same seed? Or is seeding not strictly necessary? I mean, ok, the partitions vary a bit but overall...
-->


```r
# five spatially disjoint partitions
tune_level = mlr3::rsmp("spcv_coords", folds = 5)
# use 50 randomly selected hyperparameters
terminator = mlr3tuning::trm("evals", n_evals = 50)
tuner = mlr3tuning::tnr("random_search")
# define the outer limits of the randomly selected hyperparameters
search_space = paradox::ps(
  C = paradox::p_dbl(lower = -12, upper = 15, trafo = function(x) 2^x),
  sigma = paradox::p_dbl(lower = -15, upper = 6, trafo = function(x) 2^x)
)
```

The next stage is to modify the learner `lrn_ksvm` in accordance with all the characteristics defining the hyperparameter tuning with `AutoTuner$new()`.


```r
at_ksvm = mlr3tuning::AutoTuner$new(
  learner = lrn_ksvm,
  resampling = tune_level,
  measure = mlr3::msr("classif.auc"),
  search_space = search_space,
  terminator = terminator,
  tuner = tuner
)
```

The tuning is now set-up to fit 250 models to determine optimal hyperparameters for one fold.
Repeating this for each fold, we end up with 1,250 (250 \* 5) models for each repetition.
Repeated 100 times means fitting a total of 125,000 models to identify optimal hyperparameters (Figure \@ref(fig:partitioning)).
These are used in the performance estimation, which requires the fitting of another 500 models (5 folds \* 100 repetitions; see Figure \@ref(fig:partitioning)). 
To make the performance estimation processing chain even clearer, let us write down the commands we have given to the computer:

1. Performance level (upper left part of Figure \@ref(fig:inner-outer)) - split the dataset into five spatially disjoint (outer) subfolds
1. Tuning level (lower left part of Figure \@ref(fig:inner-outer)) - use the first fold of the performance level and split it again spatially into five (inner) subfolds for the hyperparameter tuning. 
Use the 50 randomly selected hyperparameters\index{hyperparameter} in each of these inner subfolds, i.e., fit 250 models
1. Performance estimation - Use the best hyperparameter combination from the previous step (tuning level) and apply it to the first outer fold in the performance level to estimate the performance (AUROC\index{AUROC})
1. Repeat steps 2 and 3 for the remaining four outer folds
1. Repeat steps 2 to 4, 100 times

The process of hyperparameter tuning and performance estimation is computationally intensive.
To decrease model runtime, **mlr3** offers the possibility to use parallelization\index{parallelization} with the help of the **future** package.
Since we are about to run a nested cross-validation, we can decide if we would like to parallelize the inner or the outer loop (see lower left part of Figure \@ref(fig:inner-outer)).
Since the former will run 125,000 models, whereas the latter only runs 500, it is quite obvious that we should parallelize the inner loop.
To set up the parallelization of the inner loop, we run:


```r
library(future)
# execute the outer loop sequentially and parallelize the inner loop
future::plan(list("sequential", "multisession"), 
             workers = floor(availableCores() / 2))
```

Additionally, we instructed **future** to only use half instead of all available cores (default), a setting that allows possible other users to work on the same high performance computing cluster in case one is used.

Now we are set up for computing the nested spatial CV.
Specifying the `resample()` parameters follows the exact same procedure as presented when using a GLM\index{GLM}, the only difference being the `store_models` and `encapsulate` arguments.
Setting the former to `TRUE` would allow the extraction of the hyperparameter\index{hyperparameter} tuning results which is important if we plan follow-up analyses on the tuning.
The latter ensures that the processing continues even if one of the models throws an error.
This avoids the process stopping just because of one failed model, which is desirable on large model runs.
Once the processing is completed, one can have a look at the failed models.
After the processing, it is good practice to explicitly stop the parallelization\index{parallelization} with `future:::ClusterRegistry("stop")`.
Finally, we save the output object (`result`) to disk in case we would like to use it in another R session.
Before running the subsequent code, be aware that it is time-consuming since it will run the spatial cross-validation with 125,500 models.
Note that runtime depends on many aspects: CPU speed, the selected algorithm, the selected number of cores and the dataset.

<!--toDo:jn-->
<!--fix pipes-->


```r
progressr::with_progress(expr = {
  rr_spcv_svm = mlr3::resample(task = task,
                               learner = at_ksvm, 
                               # outer resampling (performance level)
                               resampling = perf_level,
                               store_models = FALSE,
                               encapsulate = "evaluate")
})

# stop parallelization
future:::ClusterRegistry("stop")
# compute the AUROC values
score_spcv_svm = rr_spcv_svm$score(measure = mlr3::msr("classif.auc")) %>%
  # keep only the columns you need
  .[, .(task_id, learner_id, resampling_id, classif.auc)]
```

In case you do not want to run the code locally, we have saved [score_svm](https://github.com/Robinlovelace/geocompr/blob/main/extdata/12-bmr_score.rds) in the book's GitHub repo.
They can be loaded as follows:


```r
score = readRDS("extdata/12-bmr_score.rds")
score_spcv_svm = score[learner_id == "classif.ksvm.tuned" & 
                         resampling_id == "repeated_spcv_coords"]
```

Let us have a look at the final AUROC\index{AUROC}: the model's ability to discriminate the two classes. 


```r
# final mean AUROC
round(mean(score_spcv_svm$classif.auc), 2)
#> [1] 0.74
```

It appears that the GLM\index{GLM} (aggregated AUROC\index{AUROC} was 0.77) is slightly better than the SVM\index{SVM} in this specific case.
To guarantee an absolute fair comparison, one should also make sure that the two models use the exact same partitions -- something we have not shown here but have silently used in the background (see `code/12_cv.R` in the book's github repo for more information).
To do so, **mlr3** offers the functions `benchmark_grid()` and `benchmark()` [see also https://mlr3book.mlr-org.com/perf-eval-cmp.html#benchmarking, @becker_mlr3_2022]. 
We will explore these functions in more detail in the Exercises.
Please note also that using more than 50 iterations in the random search of the SVM would probably yield hyperparameters\index{hyperparameter} that result in models with a better AUROC [@schratz_hyperparameter_2019].
On the other hand, increasing the number of random search iterations would also increase the total number of models and thus runtime.

So far spatial CV\index{cross-validation!spatial CV} has been used to assess the ability of learning algorithms to generalize to unseen data.
For spatial predictions, one would tune the hyperparameters\index{hyperparameter} on the complete dataset.
This will be covered in Chapter \@ref(eco).

## Conclusions

Resampling methods are an important part of a data scientist's toolbox [@james_introduction_2013]. 
This chapter used cross-validation\index{cross-validation} to assess predictive performance of various models.
As described in Section \@ref(intro-cv), observations with spatial coordinates may not be statistically independent due to spatial autocorrelation\index{autocorrelation!spatial}, violating a fundamental assumption of cross-validation.
Spatial CV\index{cross-validation!spatial CV} addresses this issue by reducing bias introduced by spatial autocorrelation\index{autocorrelation!spatial}. 

The **mlr3**\index{mlr3 (package)} package facilitates (spatial) resampling\index{resampling} techniques in combination with the most popular statistical learning\index{statistical learning} techniques including linear regression\index{regression!linear}, semi-parametric models such as generalized additive models\index{generalized additive model} and machine learning\index{machine learning} techniques such as random forests\index{random forest}, SVMs\index{SVM}, and boosted regression trees [@bischl_mlr:_2016;@schratz_hyperparameter_2019].
Machine learning algorithms often require hyperparameter\index{hyperparameter} inputs, the optimal 'tuning' of which can require thousands of model runs which require large computational resources, consuming much time, RAM and/or cores.
**mlr3** tackles this issue by enabling parallelization\index{parallelization}.

Machine learning overall, and its use to understand spatial data, is a large field and this chapter has provided the basics, but there is more to learn.
We recommend the following resources in this direction:

- The **mlr3 book** [@becker_mlr3_2022; https://mlr-org.github.io/mlr-tutorial/release/html/] and especially the [chapter on the handling of spatio-temporal data](https://mlr3book.mlr-org.com/spatiotemporal.html)
- An academic paper on hyperparameter\index{hyperparameter} tuning [@schratz_hyperparameter_2019]
- An academic paper on how to use **mlr3spatiotempcv** [@schratz_mlr3spatiotempcv_2021]
- In case of spatio-temporal data, one should account for spatial\index{autocorrelation!spatial} and temporal\index{autocorrelation!temporal} autocorrelation when doing CV\index{cross-validation} [@meyer_improving_2018]

## Exercises


E1. Compute the following terrain attributes from the `elev` dataset loaded with `terra::rast(system.file("raster/ta.tif", package = "spDataLarge"))$elev` with the help of R-GIS bridges (see this [Chapter](https://geocompr.robinlovelace.net/gis.html#gis)):

    - Slope
    - Plan curvature
    - Profile curvature
    - Catchment area
    


E2. Extract the values from the corresponding output rasters to the `lsl` data frame (`data("lsl", package = "spDataLarge"`) by adding new variables called `slope`, `cplan`, `cprof`, `elev` and `log_carea` (see this [section](https://geocompr.robinlovelace.net/spatial-cv.html#case-landslide) for details).



E3. Use the derived terrain attribute rasters in combination with a GLM to make a spatial prediction map similar to that shown in this [Figure](https://geocompr.robinlovelace.net/spatial-cv.html#fig:lsl-susc).
Running `data("study_mask", package = "spDataLarge")` attaches a mask of the study area.



E4. Compute a 100-repeated 5-fold non-spatial cross-validation and spatial CV based on the GLM learner and compare the AUROC values from both resampling strategies with the help of boxplots (see this [Figure](https://geocompr.robinlovelace.net/spatial-cv.html#fig:boxplot-cv)).

Hint: You need to specify a non-spatial resampling strategy.

Another hint: You might want to solve Excercises 4 to 6 in one go with the help of `mlr3::benchmark()` and `mlr3::benchmark_grid()` (for more information, please refer to https://mlr3book.mlr-org.com/perf-eval-cmp.html#benchmarking).
When doing so, keep in mind that the computation can take very long, probably several days.
This, of course, depends on your system.
Computation time will be shorter the more RAM and cores you have at your disposal.



E5. Model landslide susceptibility using a quadratic discriminant analysis (QDA).
Assess the predictive performance of the QDA. 
What is the a difference between the spatially cross-validated mean AUROC value of the QDA and the GLM?



E6. Run the SVM without tuning the hyperparameters.
Use the `rbfdot` kernel with $\sigma$ = 1 and *C* = 1. 
Leaving the hyperparameters unspecified in **kernlab**'s `ksvm()` would otherwise initialize an automatic non-spatial hyperparameter tuning.

<!--chapter:end:12-spatial-cv.Rmd-->

# (PART) Applications {-}

# Transportation {#transport}

## Prerequisites {-}

- This chapter uses the following packages:^[
The **nabor** package must also be installed, although it does not need to be attached.
]


```r
library(sf)
library(tidyverse)
library(spDataLarge)
library(stplanr)      # geographic transport data package
library(tmap)         # visualization package (see Chapter 9)
remotes::install_cran("sfnetworks")
library(sfnetworks)
```

## Introduction

In few other sectors is geographic space more tangible than transport.
The effort of moving (overcoming distance) is central to the 'first law' of geography, defined by Waldo Tobler in 1970 as follows [@miller_tobler_2004]: 

> Everything is related to everything else, but near things are more related than distant things.

This 'law' is the basis for spatial autocorrelation\index{autocorrelation!spatial} and other key geographic concepts.
It applies to phenomena as diverse as friendship networks and ecological diversity and can be explained by the costs of transport --- in terms of time, energy and money --- which constitute the 'friction of distance'.
From this perspective, transport technologies are disruptive, changing spatial relationships between geographic entities including mobile humans and goods: "the purpose of transportation is to overcome space" [@rodrigue_geography_2013].

Transport is an inherently geospatial activity.
It involves traversing continuous geographic space between A and B, and infinite localities in between.
It is therefore unsurprising that transport researchers have long turned to geocomputational methods to understand movement patterns and that transport problems are a motivator of geocomputational methods.

This chapter introduces the geographic analysis of transport systems at different geographic levels, including:

- **Areal units**: transport patterns can be understood with reference to zonal aggregates, such as the main mode of travel (by car, bike or foot, for example), and average distance of trips made by people living in a particular zone, covered in Section \@ref(transport-zones)
- **Desire lines**\index{desire lines}: straight lines that represent 'origin-destination' data that records how many people travel (or could travel) between places (points or zones) in geographic space, the topic of Section \@ref(desire-lines)
- **Routes**: these are lines representing a path along the route network along the desire lines defined in the previous bullet point.
We will see how to create them in Section \@ref(routes)
- **Nodes**\index{node}: these are points in the transport system that can represent common origins and destinations and public transport stations such as bus stops and rail stations, the topic of Section \@ref(nodes)
- **Route networks**\index{network}: these represent the system of roads, paths and other linear features in an area and are covered in Section \@ref(route-networks). 
They can be represented as geographic features (representing route segments) or structured as an interconnected graph, with the level of traffic on different segments referred to as 'flow' by transport modelers [@hollander_transport_2016]

Another key level is **agents**, mobile entities like you and me.
These can be represented computationally thanks to software such as [MATSim](http://www.matsim.org/), which captures the dynamics of transport systems using an agent-based modeling (ABM)\index{agent-based modeling} approach at high spatial and temporal resolution [@horni_multi-agent_2016].
ABM is a powerful approach to transport research with great potential for integration with R's spatial classes [@thiele_r_2014; @lovelace_spatial_2016], but is outside the scope of this chapter.
Beyond geographic levels and agents, the basic unit of analysis in most transport models is the **trip**, a single purpose journey from an origin 'A' to a destination 'B' [@hollander_transport_2016].
Trips join-up the different levels of transport systems: they are usually represented as *desire lines*\index{desire lines} connecting *zone* centroids\index{centroid} (*nodes*\index{node}), they can be allocated onto the *route network*\index{network} as *routes*, and are made by people who can be represented as *agents*\index{agent-based modeling}.

Transport systems are dynamic systems adding additional complexity.
The purpose of geographic transport modeling can be interpreted as simplifying this complexity in a way that captures the essence of transport problems.
Selecting an appropriate level of geographic analysis can help simplify this complexity, to capture the essence of a transport system without losing its most important features and variables [@hollander_transport_2016].

Typically, models are designed to solve a particular problem.
For this reason, this chapter is based around a policy scenario, introduced in the next section, that asks:
how to increase cycling in the city of Bristol?
Chapter \@ref(location) demonstrates another application of geocomputation:
prioritizing the location of new bike shops.
There is a link between the chapters because bike shops may benefit from new cycling infrastructure, demonstrating an important feature of transport systems: they are closely linked to broader social, economic and land-use patterns.

## A case study of Bristol {#bris-case}

The case study used for this chapter is located in Bristol, a city in the west of England, around 30 km east of the Welsh capital Cardiff.
An overview of the region's transport network is illustrated in Figure \@ref(fig:bristol), which shows a diversity of transport infrastructure, for cycling, public transport, and private motor vehicles.



\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/13_bristol} 

}

\caption[Bristol's transport network.]{Bristol's transport network represented by colored lines for active (green), public (railways, black) and private motor (red) modes of travel. Blue border lines represent the inner city boundary and the larger Travel To Work Area (TTWA).}(\#fig:bristol)
\end{figure}

Bristol is the 10^th^ largest city council in England, with a population of half a million people, although its travel catchment area\index{catchment area} is larger (see Section \@ref(transport-zones)).
It has a vibrant economy with aerospace, media, financial service and tourism companies, alongside two major universities.
Bristol shows a high average income per capita but also contains areas of severe deprivation [@bristol_city_council_deprivation_2015].

In terms of transport, Bristol is well served by rail and road links, and has a relatively high level of active travel.
19% of its citizens cycle and 88% walk at least once per month according to the [Active People Survey](https://www.gov.uk/government/statistical-data-sets/how-often-and-time-spent-walking-and-cycling-at-local-authority-level-cw010#table-cw0103) (the national average is 15% and 81%, respectively).
8% of the population said they cycled to work in the 2011 census, compared with only 3% nationwide.



Despite impressive walking and cycling statistics\index{statistics}, the city has a major congestion problem.
Part of the solution is to continue to increase the proportion of trips made by cycling.
Cycling has a greater potential to replace car trips than walking, with typical [speeds](https://en.wikipedia.org/wiki/Bicycle_performance) of 15-20 km/h vs 4-6 km/h for walking.
Furthermore many local transport plans, including Bristol's [Transport Strategy](https://www.bristol.gov.uk/documents/20182/3641895/Bristol+Transport+Strategy+-+adopted+2019.pdf/383a996e-2219-dbbb-dc75-3a270bfce26c), have ambitious plans for cycling.

In this policy context, the aim of this chapter, beyond demonstrating how geocomputation with R can be used to support sustainable transport planning, is to provide evidence for decision-makers in Bristol how best to increase the share of walking and cycling in particular in the city.
This high-level aim will be met via the following objectives:

- Describe the geographical pattern of transport behavior in the city
- Identify key public transport nodes\index{node} and routes along which cycling to rail stations could be encouraged, as the first stage in multi-model trips
- Analyze travel 'desire lines'\index{desire lines} to find where many people drive short distances
- Identify cycle route locations that will encourage less car driving and more cycling

To get the wheels rolling on the practical aspects of this chapter, we begin by loading zonal data on travel patterns.
These zone-level data are small but often vital for gaining a basic understanding of a settlement's overall transport system.

## Transport zones

Although transport systems are primarily based on linear features and nodes\index{node} --- including pathways and stations --- it often makes sense to start with areal data, to break continuous space into tangible units [@hollander_transport_2016].
In addition to the boundary defining the study area (Bristol in this case), two zone types are of particular interest to transport researchers: origin and destination zones.
Often, the same geographic units are used for origins and destinations.
However, different zoning systems, such as '[Workplace Zones](https://data.gov.uk/dataset/workplace-zones-a-new-geography-for-workplace-statistics3)', may be appropriate to represent the increased density of trip destinations in areas with many 'trip attractors' such as schools and shops [@office_for_national_statistics_workplace_2014].

The simplest way to define a study area is often the first matching boundary returned by OpenStreetMap\index{OpenStreetMap}.
This can be done with a command such as `osmdata::getbb("Bristol", format_out = "sf_polygon",  limit = 1)`.
This returns an `sf` object (or a list of `sf` objects if `limit = 1` is not specified) representing the bounds of the largest matching city region, either a rectangular polygon of the bounding box or a detailed polygonal boundary.^[
In cases where the first match does not provide the right name, the country or region should be specified, for example `Bristol Tennessee` for a Bristol located in America.
]
For Bristol, a detailed polygon is returned, as represented by the `bristol_region` object in the **spDataLarge** package.
See the inner blue boundary in Figure \@ref(fig:bristol): there are a couple of issues with this approach:

- The first OSM boundary returned by OSM may not be the official boundary used by local authorities
- Even if OSM returns the official boundary, this may be inappropriate for transport research because they bear little relation to where people travel

Travel to Work Areas (TTWAs) address these issues by creating a zoning system analogous to hydrological watersheds.
TTWAs were first defined as contiguous zones within which 75% of the population travels to work [@coombes_efficient_1986], and this is the definition used in this chapter.
Because Bristol is a major employer attracting travel from surrounding towns, its TTWA is substantially larger than the city bounds (see Figure \@ref(fig:bristol)).
The polygon representing this transport-orientated boundary is stored in the object `bristol_ttwa`, provided by the **spDataLarge** package loaded at the beginning of this chapter.

The origin and destination zones used in this chapter are the same: officially defined zones of intermediate geographic resolution (their [official](https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/annualsmallareapopulationestimates/2014-10-23) name is Middle layer Super Output Areas or MSOAs).
Each houses around 8,000 people.
Such administrative zones can provide vital context to transport analysis, such as the type of people who might benefit most from particular interventions [e.g., @moreno-monroy_public_2017].

The geographic resolution of these zones is important: small zones with high geographic resolution are usually preferable but their high number in large regions can have consequences for processing (especially for origin-destination analysis in which the number of possibilities increases as a non-linear function of the number of zones) [@hollander_transport_2016].

\begin{rmdnote}
Another issue with small zones is related to anonymity rules. To make it
impossible to infer the identity of individuals in zones, detailed
socio-demographic variables are often only available at a low geographic
resolution. Breakdowns of travel mode by age and sex, for example, are
available at the Local Authority level in the UK, but not at the much
higher Output Area level, each of which contains around 100 households.
For further details, see www.ons.gov.uk/methodology/geography.
\end{rmdnote}

The 102 zones used in this chapter are stored in `bristol_zones`, as illustrated in Figure \@ref(fig:zones).
Note the zones get smaller in densely populated areas: each houses a similar number of people.
`bristol_zones` contains no attribute data on transport, however, only the name and code of each zone:


```r
names(bristol_zones)
#> [1] "geo_code" "name"     "geometry"
```

To add travel data, we will perform an *attribute join*\index{attribute!join}, a common task described in Section \@ref(vector-attribute-joining).
We will use travel data from the UK's 2011 census question on travel to work, data stored in `bristol_od`, which was provided by the [ons.gov.uk](https://www.ons.gov.uk/help/localstatistics) data portal.
`bristol_od` is an origin-destination (OD) dataset on travel to work between zones from the UK's 2011 Census (see Section \@ref(desire-lines)).
The first column is the ID of the zone of origin and the second column is the zone of destination.
`bristol_od` has more rows than `bristol_zones`, representing travel *between* zones rather than the zones themselves:


```r
nrow(bristol_od)
#> [1] 2910
nrow(bristol_zones)
#> [1] 102
```

The results of the previous code chunk shows that there are more than 10 OD pairs for every zone, meaning we will need to aggregate the origin-destination data before it is joined with `bristol_zones`, as illustrated below (origin-destination data is described in Section \@ref(desire-lines)):


```r
zones_attr = bristol_od |> 
  group_by(o) |> 
  summarize(across(where(is.numeric), sum)) |> 
  dplyr::rename(geo_code = o)
```

The preceding chunk:

- Grouped the data by zone of origin (contained in the column `o`)
- Aggregated the variables in the `bristol_od` dataset *if* they were numeric, to find the total number of people living in each zone by mode of transport^[
The `_if` affix requires a `TRUE`/`FALSE` question to be asked of the variables, in this case 'is it numeric?' and only variables returning true are summarized.
]
- Renamed the grouping variable `o` so it matches the ID column `geo_code` in the `bristol_zones` object

The resulting object `zones_attr` is a data frame with rows representing zones and an ID variable.
We can verify that the IDs match those in the `zones` dataset using the `%in%` operator as follows:


```r
summary(zones_attr$geo_code %in% bristol_zones$geo_code)
#>    Mode    TRUE 
#> logical     102
```

The results show that all 102 zones are present in the new object and that `zone_attr` is in a form that can be joined onto the zones.^[
It would also be important to check that IDs match in the opposite direction on real data.
This could be done by changing the order of the IDs in the `summary()` command --- `summary(bristol_zones$geo_code %in% zones_attr$geo_code)` --- or by using `setdiff()` as follows: `setdiff(bristol_zones$geo_code, zones_attr$geo_code)`.
]
This is done using the joining function `left_join()` (note that `inner_join()` would produce here the same result):
\index{join!inner}
\index{join!left}


```r
zones_joined = left_join(bristol_zones, zones_attr, by = "geo_code")
sum(zones_joined$all)
#> [1] 238805
names(zones_joined)
#> [1] "geo_code"   "name"       "all"        "bicycle"    "foot"      
#> [6] "car_driver" "train"      "geometry"
```

The result is `zones_joined`, which contains new columns representing the total number of trips originating in each zone in the study area (almost 1/4 of a million) and their mode of travel (by bicycle, foot, car and train).
The geographic distribution of trip origins is illustrated in the left-hand map in Figure \@ref(fig:zones).
This shows that most zones have between 0 and 4,000 trips originating from them in the study area.
More trips are made by people living near the center of Bristol and fewer on the outskirts.
Why is this? Remember that we are only dealing with trips within the study region:
low trip numbers in the outskirts of the region can be explained by the fact that many people in these peripheral zones will travel to other regions outside of the study area.
Trips outside the study region can be included in regional model by a special destination ID covering any trips that go to a zone not represented in the model [@hollander_transport_2016].
The data in `bristol_od`, however, simply ignores such trips: it is an 'intra-zonal' model.

In the same way that OD datasets can be aggregated to the zone of origin, they can also be aggregated to provide information about destination zones.
People tend to gravitate towards central places.
This explains why the spatial distribution represented in the right panel in Figure \@ref(fig:zones) is relatively uneven, with the most common destination zones concentrated in Bristol city center.
The result is `zones_od`, which contains a new column reporting the number of trip destinations by any mode, is created as follows:


```r
zones_od = bristol_od |> 
  group_by(d) |> 
  summarize(across(where(is.numeric), sum)) |> 
  dplyr::select(geo_code = d, all_dest = all) |> 
  inner_join(zones_joined, ., by = "geo_code") |> 
  st_as_sf()
```

A simplified version of Figure \@ref(fig:zones) is created with the code below (see `12-zones.R` in the [`code`](https://github.com/Robinlovelace/geocompr/tree/main/code) folder of the book's GitHub repo to reproduce the figure and Section \@ref(faceted-maps) for details on faceted maps with **tmap**\index{tmap (package)}):


```r
qtm(zones_od, c("all", "all_dest")) +
  tm_layout(panel.labels = c("Origin", "Destination"))
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{13-transport_files/figure-latex/zones-1} 

}

\caption[Number of trips (commuters) living and working in the region.]{Number of trips (commuters) living and working in the region. The left map shows zone of origin of commute trips; the right map shows zone of destination (generated by the script 13-zones.R).}(\#fig:zones)
\end{figure}

## Desire lines

Desire lines\index{desire lines} connect origins and destinations, representing where people *desire* to go, typically between zones.
They represent the quickest 'bee line' or 'crow flies' route between A and B that would be taken, if it were not for obstacles such as buildings and windy roads getting in the way (we will see how to convert desire lines into routes in the next section).
Typically, desire lines are represented geographically as starting and ending in the geographic (or population weighted) centroid of each zone.
This is the type of desire line that we will create and use in this section, although it is worth being aware of 'jittering' techniques that enable multiple start and end points to increase the spatial coverage and accuracy of analyses building on OD data [@lovelace_jittering_2022b].

We have already loaded data representing desire lines\index{desire lines} in the dataset `bristol_od`.
This origin-destination (OD) data frame object represents the number of people traveling between the zone represented in `o` and `d`, as illustrated in Table \@ref(tab:od).
To arrange the OD data by all trips and then filter-out only the top 5, type (please refer to Chapter \@ref(attr) for a detailed description of non-spatial attribute operations):


```r
od_top5 = bristol_od |> 
  arrange(desc(all)) |> 
  top_n(5, wt = all)
```

\begin{table}

\caption[Sample of the origin-destination data.]{(\#tab:od)Sample of the top 5 origin-destination pairs in the Bristol OD data frame, representing travel desire lines between zones in the study area.}
\centering
\begin{tabular}[t]{llrrrrr}
\toprule
o & d & all & bicycle & foot & car\_driver & train\\
\midrule
E02003043 & E02003043 & 1493 & 66 & 1296 & 64 & 8\\
E02003047 & E02003043 & 1300 & 287 & 751 & 148 & 8\\
E02003031 & E02003043 & 1221 & 305 & 600 & 176 & 7\\
E02003037 & E02003043 & 1186 & 88 & 908 & 110 & 3\\
E02003034 & E02003043 & 1177 & 281 & 711 & 100 & 7\\
\bottomrule
\end{tabular}
\end{table}

The resulting table provides a snapshot of Bristolian travel patterns in terms of commuting (travel to work).
It demonstrates that walking is the most popular mode of transport among the top 5 origin-destination pairs, that zone `E02003043` is a popular destination (Bristol city center, the destination of all the top 5 OD pairs), and that the *intrazonal* trips, from one part of zone `E02003043` to another (first row of Table \@ref(tab:od)), constitute the most traveled OD pair in the dataset.
But from a policy perspective, the raw data presented in Table \@ref(tab:od) is of limited use:
aside from the fact that it contains only a tiny portion of the 2,910 OD pairs, it tells us little about *where* policy measures are needed, or *what proportion* of trips are made by walking and cycling.
The following command calculates the percentage of each desire line that is made by these active modes:


```r
bristol_od$Active = (bristol_od$bicycle + bristol_od$foot) /
  bristol_od$all * 100
```

There are two main types of OD pair:
*interzonal* and *intrazonal*.
Interzonal OD pairs represent travel between zones in which the destination is different from the origin.
Intrazonal OD pairs represent travel within the same zone (see the top row of Table \@ref(tab:od)).
The following code chunk splits `od_bristol` into these two types:


```r
od_intra = filter(bristol_od, o == d)
od_inter = filter(bristol_od, o != d)
```

The next step is to convert the interzonal OD pairs into an `sf` object representing desire lines that can be plotted on a map with the **stplanr**\index{stplanr (package)} function `od2line()`.^[
`od2line()` works by matching the IDs in the first two columns of the `bristol_od` object to the `zone_code` ID column in the geographic `zones_od` object.
Note that the operation emits a warning because `od2line()` works by allocating the start and end points of each origin-destination pair to the *centroid*\index{centroid} of its zone of origin and destination.
For real-world use one would use centroid values generated from projected data or, preferably, use *population-weighted* centroids [@lovelace_propensity_2017].
]


```r
desire_lines = od2line(od_inter, zones_od)
#> Creating centroids representing desire line start and end points.
```

An illustration of the results is presented in Figure \@ref(fig:desire), a simplified version of which is created with the following command (see the code in `13-desire.R` to reproduce the figure exactly and Chapter \@ref(adv-map) for details on visualization with **tmap**\index{tmap (package)}):


```r
qtm(desire_lines, lines.lwd = "all")
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{13-transport_files/figure-latex/desire-1} 

}

\caption[Desire lines representing trip patterns in Bristol.]{Desire lines representing trip patterns in Bristol, with width representing number of trips and color representing the percentage of trips made by active modes (walking and cycling). The four black lines represent the interzonal OD pairs in Table 7.1.}(\#fig:desire)
\end{figure}

The map shows that the city center dominates transport patterns in the region, suggesting policies should be prioritized there, although a number of peripheral sub-centers can also be seen.
Next it would be interesting to have a look at the distribution of interzonal modes, e.g., between which zones is cycling the least or the most common means of transport.

## Routes and routing engines

From a geographical perspective, routes are desire lines\index{desire lines} that are no longer straight:
the origin and destination points are the same as in the desire line representation of travel, but the pathway to get from A to B is more complex.
The geometries of routes are typically (but not always) determined by the transport network.

While desire lines\index{desire lines} contain only two vertices (their beginning and end points), routes can contain any number of vertices, representing points between A and B joined by straight lines: the definition of a linestring geometry.
Routes covering large distances or following intricate network can have many hundreds of vertices; routes on grid-based or simplified road networks tend to have fewer.
Routes are generated from desire lines\index{desire lines} --- or more commonly matrices containing coordinate pairs representing desire lines --- using routing services.
There are three main ways to compute routes from OD data:

- In-memory routing using R packages that enable route calculation
- Locally hosted routing engines external to R that can be called from R
- Remotely hosted routing engines by external entities that provide a web API that can be called from R

**In-memory** options include [**sfnetworks**](https://luukvdmeer.github.io/sfnetworks/)\index{sfnetworks (package)}, [**dodgr**](https://atfutures.github.io/dodgr/) and [**cppRouting**](https://github.com/vlarmet/cppRouting) packages.
While fast and flexible, in-memory options may be harder to set-up than dedicated routing engines: routing is a hard problem and many hundreds of hours have been put into open source routing engines that can be downloaded and hosted locally.

**Locally hosted** routing engines include OpenTripPlanner, OSRM and R5, and associated R packages **opentripplanner**, [**osrm**](https://github.com/riatelab/osrm) and **r5r** [@morgan_opentripplanner_2019; @pereira_r5r_2021].
Locally hosted routing engines run on the user's computer but in a process separate from R.
They benefit from speed of execution and control over the weighting profile for different modes of transport.
Disadvantages include the difficulty of representing complex networks locally; temporal dynamics (primarily due to traffic); and the need for specialized software.
A key feature of some advanced routing engines (both locally hosted and remotely hosted) such as R5, OpenTripPlanner and [Valhalla](https://github.com/valhalla/valhalla) (which at the time of writing does not have an R interface to the best of our knowledge) is the provision of *multi-modal* routes: allowing a single journey from A to B to be made by more than one mode of transport, such as cycling from home to a bus stop, catching a bus to the city center, and then walking to the destination.

**Remotely hosted**\index{routing} routing engines, by contrast, use a web API\index{API} to send queries about origins and destinations and return results generated on a powerful server running dedicated software.
Routing services based on open source routing engines, such as OSRM's publicly available service, work exactly the same when called from R as locally hosted instances, simply requiring arguments specifying 'base URLs' to be updated.
However, the fact that external routing services are hosted on a dedicated machine (usually funded by commercial company with incentives to generate accurate routes)\index{routing} can give them advantages, including:

- Provision of routing services worldwide (or usually at least over a large region)
- Established routing services available are usually update regularly and can often respond to traffic levels
- Routing services usually run on dedicated hardware and software including systems such as load balancers to ensure consistent performance

Disadvantages of remote routing\index{routing} services include speed when batch jobs are not possible (they often rely on data transfer over the internet on a route-by-route basis), price (the Google routing API, for example, limits the number of free queries) and licensing issues.
[**googleway**](http://symbolixau.github.io/googleway/) and [**mapbox**](https://walker-data.com/mapboxapi/articles/navigation.html) packages demonstrate this approach by providing access to routing services from Google and Mapbox, respectively\index{API}.
Free (but rate limited) routing service include [OSRM](http://project-osrm.org/) and [openrouteservice.org](https://openrouteservice.org/) which can be accessed from R with the [**osrm**](https://rgeomatic.hypotheses.org/category/osrm) and [**openrouteservice**](https://github.com/GIScience/openrouteservice-r) packages, the latter of which is not on CRAN.
There are also more specific routing services such as that provided by [CycleStreets.net](https://www.cyclestreets.net/), a cycle journey planner and not-for-profit transport technology company "for cyclists, by cyclists".
While R users can access CycleStreets routes via the package [**cyclestreets**](https://rpackage.cyclestreets.net/), many routing services lack R interfaces, representing a substantial opportunity for package development: building an R package to provide an interface to a web API can be a rewarding experience.

The wide range of R packages for computing and importing data representing routes on transport networks is a strength, meaning that the language has been increasingly used for transport research over the last few years.
However, a minor disadvantage of this proliferation of package and approaches is that there are many package and function names to remember. 
The package **stplanr** tackles this problem by providing a unified interface for generating routes with the `route()` function.
The function takes a wide range of inputs, including geographic desire lines (with the `l = ` argument), coordinates and even text strings representing unique addresses, and returns route data as consistent `sf` objects.
<!-- TODO: at some point I hope to create a dedicated router package, mention that if it gets created (RL 2022-07) -->

Regardless of the routing engine used, there are two broad types of output: route level and segment level.
Route level outputs contain a single feature (typically a multilinestring and associated row in the data frame representation) per origin-destination pair, meaning a single row of data per trip.
Most routing engines return route level by default, although multi-modal engines generally provide outputs at the 'leg' level (one feature per continuous movement by a single mode of transport).
Segment level data, by contrast, provides information about routes at the street segment.
The **cyclestreets** package, for example, provides segment level data by default, including street names and level of 'quietness', a proxy for cycle-friendliness.

Segment level results are less common partly because they have the disadvantage of complexity (with many rows of data returned for a single OD pair).
Such complexity may be advantageous, however, when the characteristics of individual ways on the network are important; it is hard to discern the most dangerous part of trip with route level data, for example.
When working with segment or leg-level data, route-level statistics can be returned by grouping by columns representing trip start and end points and summarizing/aggregating columns containing segment-level data.

Instead of routing\index{routing} *all* desire lines generated in the previous section, we will focus on the desire lines\index{desire lines} of policy interest.
Doing routing on a subset of the data before trying to compute routes for a large number of OD pairs is often sensible: routing can be time and memory-consuming: route datasets are usually substantially larger than desire line datasets because they have more detailed geometries and often have more attributes such as road name.

We will filter-out a subset of the desire lines with a focus on estimating cycling potential based on the observation that the benefits of cycling trips are greatest when they replace car trips and that relatively short trips are more likely to be cycled than long trips [@lovelace_propensity_2017].
Clearly, not all car trips can realistically be replaced by cycling.
Trips between 2.5 and 5 km Euclidean distance (or around 3 km, below which trips are can be made by walking or scooter, to 6-8 km of route distance) have a relatively high probability of being cycled, and the maximum distance increases when trips are made by [electric bike](https://www.sciencedirect.com/science/article/pii/S0967070X21003401).
Considering this, and the utility of a small route dataset for testing, we will compute routes for the subset of desire lines\index{desire lines} along which a high (100+) number of car trips take place that are 2.5 to 5 km in length:


```r
desire_lines$distance_km = as.numeric(st_length(desire_lines)) / 1000
desire_lines_short = desire_lines |> 
  filter(car_driver >= 100, distance_km <= 5, distance_km >= 2.5)
```

In the code above `st_length()` calculated the length of each desire line, as described in Section \@ref(distance-relations).
The `filter()` function from **dplyr** filtered the `desire_lines` dataset based on the criteria outlined above\index{filter operation|see{attribute!subsetting}}, as described in Section \@ref(vector-attribute-subsetting).
The next stage is to convert these desire lines into routes.
This is done using the publicly available OSRM service \index{routing} with the **stplanr** functions `route()` and `route_osrm()`\index{stplanr (package)} in the code chunk below:


```r
routes_short = route(l = desire_lines_short, route_fun = route_osrm,
                     osrm.profile = "bike")
```





The output is `routes_short`, an `sf` object representing routes on the transport network\index{network} that are suitable for cycling (according to the OSRM routing engine at least), one for each desire line.
Note: calls to external routing engines such as in the command above only work with an internet connection (and sometimes an API key stored in an environment variable, although not in this case).
In addition to the columns contained in the `desire_lines` object, the new route dataset contains `distance` (referring to route distance this time) and `duration` columns (in seconds), which provide potentially useful extra information on the nature of each route.
We will plot desire lines\index{desire lines} along which many short car journeys take place alongside cycling routes.
Making the width of the routes proportional to the number of car journeys that could potentially be replaced provides an effective way to prioritize interventions on the road network [@lovelace_propensity_2017].
The code chunk below plots the desire lines and routes, resulting in Figure \@ref(fig:routes) which shows routes along which people drive short distances:^[
Note that the red routes and black desire lines do not start at exactly the same points.
This is because zone centroids rarely lie on the route network: instead the route originate from the transport network node nearest the centroid.
Note also that routes are assumed to originate in the zone centroids, a simplifying assumption which is used in transport models to reduce the computational resources needed to calculate the shortest path between all combinations of possible origins and destinations [@hollander_transport_2016].
]


```r
tm_shape(desire_lines_short) + tm_lines() +
  tm_shape(routes_short) + tm_lines(col = "red") 
```

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{13-transport_files/figure-latex/routes-1} 

}

\caption[Routes along which many car journeys are made.]{Routes along which many (100+) short (<5km Euclidean distance) car journeys are made (red) overlaying desire lines representing the same trips (black) and zone centroids (dots).}(\#fig:routes)
\end{figure}

\index{routes}

Plotting the results on an interactive map, with `mapview::mapview(st_geometry(routes_short))` for example, shows that many short car trips take place in and around Bradley Stoke.
It is easy to find explanations for the area's high level of car dependency: according to  [Wikipedia](https://en.wikipedia.org/wiki/Bradley_Stoke), Bradley Stoke is "Europe's largest new town built with private investment", suggesting limited public transport provision.
Furthermore, the town is surrounded by large (cycling unfriendly) road structures, "such as junctions on both the M4 and M5 motorways" [@tallon_bristol_2007].

There are many benefits of converting travel desire lines\index{desire lines} into routes.
It is important to remember that we cannot be sure what proportion of trips will follow the routes calculated by routing engines.
However, route and street/way/segment level results can be highly policy relevant.
Route segment results can enable the prioritization of investment in cycleways where they are most needed according to available data [@lovelace_propensity_2017], for example.
Another common intervention in transport systems is the addition of new public transport nodes\index{node} to the network\index{network}.
Such nodes\index{node} are described in the next section.

## Nodes

Nodes\index{node} in geographic transport data are zero-dimensional features (points) among the predominantly one-dimensional features (lines) that comprise the network\index{network}.
There are two types of transport nodes:

1. Nodes\index{node} not directly on the network\index{network} such as zone centroids\index{centroid}  --- covered in the next section --- or individual origins and destinations such as houses and workplaces
2. Nodes\index{node} that are a part of transport networks\index{network}, representing individual pathways, intersections between pathways (junctions) and points for entering or exiting a transport network\index{network} such as bus stops and train stations

Transport networks\index{network} can be represented as graphs\index{graph}, in which each segment is connected (via edges representing geographic lines) to one or more other edges\index{edge} in the network.
Nodes outside the network\index{network} can be added with "centroid connectors"\index{centroid}, new route segments to nearby nodes\index{node} on the network\index{network} [@hollander_transport_2016].^[
The location of these connectors should be chosen carefully because they can lead to over-estimates of traffic volumes in their immediate surroundings [@jafari_investigation_2015].
]
Every node\index{node} in the network\index{network} is then connected by one or more 'edges'\index{edge} that represent individual segments on the network\index{network}.
We will see how transport networks\index{network} can be represented as graphs\index{graph} in Section \@ref(route-networks).

Public transport stops are particularly important nodes\index{node} that can be represented as either type of node: a bus stop that is part of a road, or a large rail station that is represented by its pedestrian entry point hundreds of meters from railway tracks.
We will use railway stations to illustrate public transport nodes\index{node}, in relation to the research question of increasing cycling in Bristol.
These stations are provided by **spDataLarge** in `bristol_stations`.

A common barrier preventing people from switching away from cars for commuting to work is that the distance from home to work is too far to walk or cycle.
Public transport can reduce this barrier by providing a fast and high-volume option for common routes into cities.
From an active travel perspective, public transport 'legs' of longer journeys divide trips into three: 

- The origin leg, typically from residential areas to public transport stations
- The public transport leg, which typically goes from the station nearest a trip's origin to the station nearest its destination
- The destination leg, from the station of alighting to the destination

Building on the analysis conducted in Section \@ref(desire-lines), public transport nodes\index{node} can be used to construct three-part desire lines\index{desire lines} for trips that can be taken by bus and (the mode used in this example) rail.
The first stage is to identify the desire lines\index{desire lines} with most public transport travel, which in our case is easy because our previously created dataset `desire_lines` already contains a variable describing the number of trips by train (the public transport potential could also be estimated using public transport routing\index{routing} services such as [OpenTripPlanner](http://www.opentripplanner.org/)).
To make the approach easier to follow, we will select only the top three desire lines\index{desire lines} in terms of rails use:


```r
desire_rail = top_n(desire_lines, n = 3, wt = train)
```

The challenge now is to 'break-up' each of these lines into three pieces, representing travel via public transport nodes\index{node}.
This can be done by converting a desire line into a multilinestring object consisting of three line geometries representing origin, public transport and destination legs of the trip.
This operation can be divided into three stages: matrix creation (of origins, destinations and the 'via' points representing rail stations), identification of nearest neighbors\index{nearest neighbor} and conversion to multilinestrings\index{multilinestrings}.
These are undertaken by `line_via()`.
This **stplanr**\index{stplanr (package)} function takes input lines and points and returns a copy of the desire lines\index{desire lines} --- see the [`?line_via()`](https://docs.ropensci.org/stplanr/reference/line_via.html) for details on how this works.
The output is the same as the input line, except it has new geometry columns representing the journey via public transport nodes\index{node}, as demonstrated below:


```r
ncol(desire_rail)
#> [1] 10
desire_rail = line_via(desire_rail, bristol_stations)
ncol(desire_rail)
#> [1] 13
```

As illustrated in Figure \@ref(fig:stations), the initial `desire_rail` lines now have three additional geometry list columns\index{list column} representing travel from home to the origin station, from there to the destination, and finally from the destination station to the destination.
In this case, the destination leg is very short (walking distance) but the origin legs may be sufficiently far to justify investment in cycling infrastructure to encourage people to cycle to the stations on the outward leg of peoples' journey to work in the residential areas surrounding the three origin stations in Figure \@ref(fig:stations).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{13-transport_files/figure-latex/stations-1} 

}

\caption[Station nodes.]{Station nodes (red dots) used as intermediary points that convert straight desire lines with high rail usage (black) into three legs: to the origin station (red) via public transport (gray) and to the destination (a very short blue line).}(\#fig:stations)
\end{figure}

## Route networks

While routes generally contain data at same level as desire lines (or at the level of segments with potentially overlapping segments), route network datasets represent a more-or-less complete representation of a transport network.
Each segment (roughly corresponding to a continuous section of street between junctions) in a route network is present once and only once.

Sometimes route networks are the input into a transport data analysis project; sometimes they are an output; and sometimes route networks are both an input and an output.
To be specific: any routing engines requires some kind of route network input, so any transport research of routes must invariably involve route network data in the internal or external routing engines (in the latter case the route network data is not necessarily imported into R).
However, route networks are also important outputs in many transport research projects: summarizing data such as the potential number of trips made on particular segments and represented as a route network, can help prioritize investment where it is most needed.
\index{network}

To demonstrate how to create route networks as an output derived from route level data, imagine a simple scenario of mode shift.
Imagine that 50% of car trips between 0 to 3 km in route distance are replaced by cycling, a percentage that drops by 10 percentage points for every additional km of route distance so that 20% of car trips of 6 km are replaced by cycling and no car trips that are 8 km or longer are replaced by cycling.
This is of course an unrealistic scenario [@lovelace_propensity_2017], but is a useful starting point.
In this case, we can model mode shift from cars to bikes as follows:


```r
uptake = function(x) {
  case_when(
    x <= 3 ~ 0.5,
    x >= 8 ~ 0,
    TRUE ~ (8 - x) / (8 - 3) * 0.5
  )
}
routes_short_scenario = routes_short |> 
  mutate(uptake = uptake(distance / 1000)) |> 
  mutate(bicycle = bicycle + car_driver * uptake,
         car_driver = car_driver * uptake)
sum(routes_short_scenario$bicycle) - sum(routes_short$bicycle)
#> [1] 4003
```

Having created a scenario in which approximately 4000 trips have switched from driving to cycling, we can now model where this updated modeled cycling activity will take place with the function `overline()` from the **stplanr** package.
The package take route level data, breaks linestrings at junctions (were two or more linestring geometries meet), and calculates aggregate statistics for each unique route segment [see @morgan_travel_2020 for further details], taking attributes to summarize as the second argument:


```r
route_network_scenario = overline(routes_short_scenario, attrib = "bicycle")
```

The outputs of the two preceding code chunks are summarized in Figure \@ref(fig:rnetvis) below.

\begin{figure}[t]

{\centering \includegraphics[width=0.49\linewidth]{13-transport_files/figure-latex/rnetvis-1} \includegraphics[width=0.49\linewidth]{13-transport_files/figure-latex/rnetvis-2} 

}

\caption{Illustration of the % of car trips switching to cycling as a function of distance (left) and route network level results of this function (right).}(\#fig:rnetvis)
\end{figure}

Another, more common, type of route network dataset is road network datasets.
This type of route network dataset is available for every city worldwide from OpenStreetMap.
The input dataset used to illustrate this type of route network downloaded using **osmdata**\index{osmdata (package)}.
To avoid having to request the data from OSM\index{OpenStreetMap} repeatedly, we will use the `bristol_ways` object from the **spDataLarge** package, which contains point and line data for the case study area (see `?bristol_ways`):


```r
summary(bristol_ways)
#>      highway        maxspeed         ref                geometry   
#>  cycleway:1317   30 mph : 925   A38    : 214   LINESTRING   :4915  
#>  rail    : 832   20 mph : 556   A432   : 146   epsg:4326    :   0  
#>  road    :2766   40 mph : 397   M5     : 144   +proj=long...:   0  
#>                  70 mph : 328   A4018  : 124                       
#>                  50 mph : 158   A420   : 115                       
#>                  (Other): 490   (Other):1877                       
#>                  NA's   :2061   NA's   :2295
```

The above code chunk summarized a simple feature\index{sf} object representing around 5,000 segments on the transport network\index{network}.
This an easily manageable dataset size (transport datasets can be large, but it's best to start small).

As mentioned, route networks\index{network} can usefully be represented as mathematical graphs\index{graph}, with nodes\index{node} on the network\index{network} connected by edges\index{edge}.
A number of R packages have been developed for dealing with such graphs\index{graph}, notably **igraph**\index{igraph (package)}.
You can manually convert a route network into an `igraph` object, but the geographic attributes will be lost.
To overcome this issue functionality was developed in the **stplanr**\index{stplanr (package)} and subsequently **sfnetworks**\index{sfnetworks (package)} packages to represent route networks simultaneously as graphs *and* a set of geographic lines.
We will demonstrate **sfnetworks** functionality on the `bristol_ways` object.


```r
bristol_ways$lengths = st_length(bristol_ways)
ways_sfn = as_sfnetwork(bristol_ways)
class(ways_sfn)
#> [1] "sfnetwork" "tbl_graph" "igraph"
ways_sfn
#> # A sfnetwork with 5728 nodes and 4915 edges
#> #
#> # CRS:  EPSG:4326 
#> #
#> # A directed multigraph with 1013 components with spatially explicit edges
#> #
#> # Node Data:     5,728 x 1 (active)
#> # Geometry type: POINT
#> # Dimension:     XY
#> # Bounding box:  xmin: -2.84 ymin: 51.3 xmax: -2.26 ymax: 51.7
#>       geometry
#>    <POINT [°]>
#> 1 (-2.61 51.4)
#> 2 (-2.61 51.4)
#> 3 (-2.62 51.4)
#> 4 (-2.62 51.4)
#> 5 (-2.34 51.5)
#> 6 (-2.28 51.5)
#> # ... with 5,722 more rows
#> #
#> # Edge Data:     4,915 x 7
#> # Geometry type: LINESTRING
#> # Dimension:     XY
#> # Bounding box:  xmin: -2.84 ymin: 51.3 xmax: -2.26 ymax: 51.7
#>    from    to highway maxspeed ref                              geometry lengths
#>   <int> <int> <fct>   <fct>    <fct>                    <LINESTRING [°]>     [m]
#> 1     1     2 road    <NA>     B3130 (-2.61 51.4, -2.61 51.4, -2.61 51.~    218.
#> 2     3     4 road    20 mph   B3130 (-2.62 51.4, -2.62 51.4, -2.62 51.~    135.
#> 3     5     6 road    70 mph   M4    (-2.34 51.5, -2.34 51.5, -2.34 51.~   4517.
#> # ... with 4,912 more rows
```

The output of the previous code chunk shows that `ways_sfn` is a composite object, containing both nodes and edges in graph and spatial form.
`ways_sfn` is of class `sfnetwork`, which builds on the `igraph` class from the **igraph** package.
In the example below, the 'edge betweenness'\index{edge}, meaning the number of shortest paths\index{shortest route} passing through each edge, is calculated (see `?igraph::betweenness` for further details).
The result of calculating edge betweenness for this dataset are shown Figure \@ref(fig:wayssln), which has the cycle route network dataset calculated with the `overline()` function as an overlay for comparison.
The results demonstrate that each graph\index{graph} edge represents a segment: the segments near the center of the road network\index{network} have the highest betweenness values, whereas segments closer to central Bristol have higher cycling potential, based on these simplistic datasets.


```r
ways_centrality = ways_sfn |> 
  activate("edges") |>  
  mutate(betweenness = tidygraph::centrality_edge_betweenness(lengths)) 
tm_shape(ways_centrality |> st_as_sf()) +
  tm_lines(lwd = "betweenness", scale = 9, title.lwd = "Betweenness") +
  tm_shape(route_network_scenario) +
  tm_lines(lwd = "bicycle", scale = 9, title.lwd = "N0. bike trips (modeled, one direction)", col = "green")
#> Warning in CPL_transform(x, crs, aoi, pipeline, reverse, desired_accuracy, :
#> GDAL Error 1: PROJ: proj_as_wkt: DatumEnsemble can only be exported to WKT2:2019
#> Legend labels were too wide. Therefore, legend.text.size has been set to 0.42. Increase legend.width (argument of tm_layout) to make the legend wider and therefore the labels larger.
```

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{13-transport_files/figure-latex/wayssln-1} 

}

\caption[Illustration of a small route network.]{Illustration of a small route network, with segment thickness proportional to its betweenness, generated using the igraph package and described in the text.}(\#fig:wayssln)
\end{figure}



One can also find the shortest route\index{shortest route} between origins and destinations using this graph\index{graph} representation of the route network\index{network} with the **sfnetworks** package.
<!-- TODO: make an exercise based on this if time allows (RL 2022-07) -->
While the methods presented in this section are relatively simple compared with what is possible with spatial network generation (e.g., with `overline()`) and analysis techniques (e.g., with **sfnetworks**), they should provide a strong starting point for further exploration and research into the area.

## Prioritizing new infrastructure

This chapter's final practical section demonstrates the policy-relevance of geocomputation for transport applications by identifying locations where new transport infrastructure may be needed.
Clearly, the types of analysis presented here would need to be extended and complemented by other methods to be used in real-world applications, as discussed in Section \@ref(future-directions-of-travel).
However, each stage could be useful on its own, and feed into wider analyses.
To summarize, these were: identifying short but car-dependent commuting routes (generated from desire lines) in Section \@ref(routes); creating desire lines\index{desire lines} representing trips to rail stations in Section \@ref(nodes); and analysis of transport systems at the route network\index{network} using graph\index{graph} theory in Section \@ref(route-networks).

The final code chunk of this chapter combines these strands of analysis.
It adds the car-dependent routes in `routes_short` with a newly created object, `route_rail` and creates a new column representing the amount of travel along the centroid-to-centroid\index{centroid} desire lines they represent:


```r
route_rail = desire_rail |>
  st_set_geometry("leg_orig") |> 
  route(l = _, route_fun = route_osrm) |> 
  select(names(routes_short))
```






```r
route_cycleway = rbind(route_rail, routes_short)
route_cycleway$all = c(desire_rail$all, desire_lines_short$all)
```



The results of the preceding code are visualized in Figure \@ref(fig:cycleways), which shows routes with high levels of car dependency and highlights opportunities for cycling rail stations (the subsequent code chunk creates a simple version of the figure --- see `code/13-cycleways.R` to reproduce the figure exactly).
The method has some limitations: in reality, people do not travel to zone centroids or always use the shortest route\index{shortest route} algorithm for a particular mode.
However, the results demonstrate routes along which cycle paths could be prioritized from car dependency and public transport perspectives.


```r
qtm(route_cycleway, lines.lwd = "all")
```

\begin{figure}[t]

{\centering \includegraphics[width=0.7\linewidth]{figures/13_highway} 

}

\caption[Routes along which to prioritise cycle infrastructure.]{Potential routes along which to prioritise cycle infrastructure in Bristol, based on access key rail stations (red dots) and routes with many short car journeys (north of Bristol surrounding Stoke Bradley). Line thickness is proportional to number of trips.}(\#fig:cycleways)
\end{figure}

The results may look more attractive in an interactive map, but what do they mean?
The routes highlighted in Figure \@ref(fig:cycleways) suggest that transport systems are intimately linked to the wider economic and social context.
The example of Stoke Bradley is a case in point:
its location, lack of public transport services and active travel infrastructure help explain why it is so highly car-dependent.
The wider point is that car dependency has a spatial distribution which has implications for sustainable transport policies [@hickman_transitions_2011].

## Future directions of travel

This chapter provides a taste of the possibilities of using geocomputation for transport research.
It has explored some key geographic elements that make-up a city's transport system using open data and reproducible code.
The results could help plan where investment is needed.

Transport systems operate at multiple interacting levels, meaning that geocomputational methods have great potential to generate insights into how they work.
There is much more that could be done in this area: it would be possible to build on the foundations presented in this chapter in many directions.
Transport is the fastest growing source of greenhouse gas emissions in many countries, and is set to become "the largest GHG emitting sector, especially in developed countries" (see  [EURACTIV.com](https://www.euractiv.com/section/agriculture-food/opinion/transport-needs-to-do-a-lot-more-to-fight-climate-change/)).
Because of the highly unequal distribution of transport-related emissions across society, and the fact that transport (unlike food and heating) is not essential for well-being, there is great potential for the sector to rapidly decarbonize through demand reduction, electrification of the vehicle fleet and the uptake of active travel modes such as walking and cycling.
Further exploration of such 'transport futures' at the local level represents promising direction of travel for transport-related geocomputational research.

Methodologically, the foundations presented in this chapter could be extended by including more variables in the analysis.
Characteristics of the route such as speed limits, busyness and the provision of protected cycling and walking paths could be linked to 'mode-split' (the proportion of trips made by different modes of transport).
By aggregating OpenStreetMap\index{OpenStreetMap} data using buffers and geographic data methods presented in Chapters \@ref(attr) and \@ref(spatial-operations), for example, it would be possible to detect the presence of green space in close proximity to transport routes.
Using R's\index{R} statistical modeling capabilities, this could then be used to predict current and future levels of cycling, for example.

This type of analysis underlies the Propensity to Cycle Tool (PCT), a publicly accessible (see [www.pct.bike](http://www.pct.bike/)) mapping tool developed in R\index{R} that is being used to prioritize investment in cycling across England [@lovelace_propensity_2017].
Similar tools could be used to encourage evidence-based transport policies related to other topics such as air pollution and public transport access around the world.

## Exercises {#ex-transport}


E1. What is the total distance of cycleways that would be constructed if all the routes presented in Figure \@ref(fig:cycleways) were to be constructed?
    - Bonus: find two ways of arriving at the same answer.



E2. What proportion of trips represented in the `desire_lines` are accounted for in the `route_cycleway` object?
    - Bonus: what proportion of trips cross the proposed routes?
    - Advanced: write code that would increase this proportion.



E3. The analysis presented in this chapter is designed for teaching how geocomputation methods can be applied to transport research. If you were to do this 'for real' for local government or a transport consultancy, what top 3 things would you do differently?
<!-- Higher level of geographic resolution. -->
<!-- Use cycle-specific routing services. -->
<!-- Identify key walking routes. -->
<!-- Include a higher proportion of trips in the analysis -->
E4. Clearly, the routes identified in Figure \@ref(fig:cycleways) only provide part of the picture. How would you extend the analysis to incorporate more trips that could potentially be cycled?
E5. Imagine that you want to extend the scenario by creating key *areas* (not routes) for investment in place-based cycling policies such as car-free zones, cycle parking points and reduced car parking strategy. How could raster\index{raster} data assist with this work? 
    - Bonus: develop a raster layer that divides the Bristol region into 100 cells (10 by 10) and provide a metric related to transport policy, such as number of people trips that pass through each cell by walking or the average speed limit of roads, from the `bristol_ways` dataset (the approach taken in Chapter \@ref(location)).

<!--chapter:end:13-transport.Rmd-->

# Geomarketing {#location}

## Prerequisites {-}

- This chapter requires the following packages (**revgeo** must also be installed):


```r
library(sf)
library(dplyr)
library(purrr)
library(raster)
library(osmdata)
library(spDataLarge)
```

- Required data, that will be downloaded in due course

As a convenience to the reader and to ensure easy reproducibility, we have made available the downloaded data in the **spDataLarge** package.

## Introduction

This chapter demonstrates how the skills learned in Parts I and II can be applied to a particular domain: geomarketing\index{geomarketing} (sometimes also referred to as location analysis\index{location analysis} or location intelligence).
This is a broad field of research and commercial application.
A typical example is where to locate a new shop.
The aim here is to attract most visitors and, ultimately, make the most profit.
There are also many non-commercial applications that can use the technique for public benefit, for example where to locate new health services [@tomintz_geography_2008].

People are fundamental to location analysis\index{location analysis}, in particular where they are likely to spend their time and other resources.
Interestingly, ecological concepts and models are quite similar to those used for store location analysis.
Animals and plants can best meet their needs in certain 'optimal' locations, based on variables that change over space (@muenchow_review_2018; see also chapter \@ref(eco)).
This is one of the great strengths of geocomputation and GIScience in general.
Concepts and methods are transferable to other fields.
Polar bears, for example, prefer northern latitudes where temperatures are lower and food (seals and sea lions) is plentiful.
Similarly, humans tend to congregate in certain places, creating economic niches (and high land prices) analogous to the ecological niche of the Arctic.
The main task of location analysis is to find out where such 'optimal locations' are for specific services, based on available data.
Typical research questions include:

- Where do target groups live and which areas do they frequent?
- Where are competing stores or services located?
- How many people can easily reach specific stores?
- Do existing services over- or under-exploit the market potential?
- What is the market share of a company in a specific area?

This chapter demonstrates how geocomputation can answer such questions based on a hypothetical case study based on real data.

## Case study: bike shops in Germany {#case-study}

Imagine you are starting a chain of bike shops in Germany.
The stores should be placed in urban areas with as many potential customers as possible.
Additionally, a hypothetical survey (invented for this chapter, not for commercial use!) suggests that single young males (aged 20 to 40) are most likely to buy your products: this is the *target audience*.
You are in the lucky position to have sufficient capital to open a number of shops.
But where should they be placed?
Consulting companies (employing geomarketing\index{geomarketing} analysts) would happily charge high rates to answer such questions.
Luckily, we can do so ourselves with the help of open data\index{open data} and open source software\index{open source software}.
The following sections will demonstrate how the techniques learned during the first chapters of the book can be applied to undertake common steps in service location analysis:

- Tidy the input data from the German census (Section \@ref(tidy-the-input-data))
- Convert the tabulated census data into raster\index{raster} objects (Section \@ref(create-census-rasters))
- Identify metropolitan areas with high population densities (Section \@ref(define-metropolitan-areas))
- Download detailed geographic data (from OpenStreetMap\index{OpenStreetMap}, with **osmdata**\index{osmdata (package)}) for these areas (Section \@ref(points-of-interest))
- Create rasters\index{raster} for scoring the relative desirability of different locations using map algebra\index{map algebra} (Section \@ref(identifying-suitable-locations))

Although we have applied these steps to a specific case study, they could be generalized to many scenarios of store location or public service provision.

## Tidy the input data

The German government provides gridded census data at either 1 km or 100 m resolution.
The following code chunk downloads, unzips and reads in the 1 km data.
Please note that `census_de` is also available from the **spDataLarge** package (`data("census_de", package = "spDataLarge"`).


```r
download.file("https://tinyurl.com/ybtpkwxz", 
              destfile = "census.zip", mode = "wb")
unzip("census.zip") # unzip the files
census_de = readr::read_csv2(list.files(pattern = "Gitter.csv"))
```

The `census_de` object is a data frame containing 13 variables for more than 300,000 grid cells across Germany.
For our work, we only need a subset of these: Easting (`x`) and Northing (`y`), number of inhabitants (population; `pop`), mean average age (`mean_age`), proportion of women (`women`) and average household size (`hh_size`).
These variables are selected and renamed from German into English in the code chunk below and summarized in Table \@ref(tab:census-desc). 
Further, `mutate_all()` is used to convert values -1 and -9 (meaning unknown) to `NA`.


```r
# pop = population, hh_size = household size
input = dplyr::select(census_de, x = x_mp_1km, y = y_mp_1km, pop = Einwohner,
                      women = Frauen_A, mean_age = Alter_D,
                      hh_size = HHGroesse_D)
# set -1 and -9 to NA
input_tidy = mutate_all(input, list(~ifelse(. %in% c(-1, -9), NA, .)))
```


\begin{table}

\caption[Categories for each variable in census data.]{(\#tab:census-desc)Categories for each variable in census data from Datensatzbeschreibung...xlsx located in the downloaded file census.zip (see Figure 13.1 for their spatial distribution).}
\centering
\begin{tabular}[t]{ccccc}
\toprule
class & Population & \% female & Mean age & Household size\\
\midrule
1 & 3-250 & 0-40 & 0-40 & 1-2\\
2 & 250-500 & 40-47 & 40-42 & 2-2.5\\
3 & 500-2000 & 47-53 & 42-44 & 2.5-3\\
4 & 2000-4000 & 53-60 & 44-47 & 3-3.5\\
5 & 4000-8000 & >60 & >47 & >3.5\\
\addlinespace
6 & >8000 &  &  & \\
\bottomrule
\end{tabular}
\end{table}

## Create census rasters
 
After the preprocessing, the data can be converted into a raster stack\index{raster!stack} or brick\index{raster!brick} (see Sections \@ref(raster-classes) and \@ref(raster-subsetting)).
`rasterFromXYZ()` makes this really easy.
It requires an input data frame where the first two columns represent coordinates on a regular grid.
All the remaining columns (here: `pop`, `women`, `mean_age`, `hh_size`) will serve as input for the raster brick layers (Figure \@ref(fig:census-stack); see also `code/14-location-jm.R` in our github repository).


```r
input_ras = rasterFromXYZ(input_tidy, crs = st_crs(3035)$proj4string)
```


```r
input_ras
#> class : RasterBrick
#> dimensions : 868, 642, 557256, 4 (nrow, ncol, ncell, nlayers)
#> resolution : 1000, 1000 (x, y)
#> extent : 4031000, 4673000, 2684000, 3552000 (xmin, xmax, ymin, ymax)
#> coord. ref. : +proj=laea +lat_0=52 +lon_0=10
#> names       :  pop, women, mean_age, hh_size 
#> min values  :    1,     1,        1,       1 
#> max values  :    6,     5,        5,       5
```

\BeginKnitrBlock{rmdnote}
Note that we are using an equal-area projection (EPSG:3035; Lambert Equal Area Europe), i.e., a projected CRS\index{CRS!projected} where each grid cell has the same area, here 1000 x 1000 square meters. 
Since we are using mainly densities such as the number of inhabitants or the portion of women per grid cell, it is of utmost importance that the area of each grid cell is the same to avoid 'comparing apples and oranges'.
Be careful with geographic CRS\index{CRS!geographic} where grid cell areas constantly decrease in poleward directions (see also Section \@ref(crs-intro) and Chapter \@ref(reproj-geo-data)). 
\EndKnitrBlock{rmdnote}

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/08_census_stack} 

}

\caption[Gridded German census data.]{Gridded German census data of 2011 (see Table 13.1 for a description of the classes).}(\#fig:census-stack)
\end{figure}

The next stage is to reclassify the values of the rasters stored in `input_ras` in accordance with the survey mentioned in Section \@ref(case-study), using the **raster** function `reclassify()`, which was introduced in Section \@ref(local-operations)\index{map algebra!local operations}.
In the case of the population data, we convert the classes into a numeric data type using class means. 
Raster cells are assumed to have a population of 127 if they have a value of 1 (cells in 'class 1' contain between 3 and 250 inhabitants) and 375 if they have a value of 2 (containing 250 to 500 inhabitants), and so on (see Table \@ref(tab:census-desc)).
A cell value of 8000 inhabitants was chosen for 'class 6' because these cells contain more than 8000 people.
Of course, these are approximations of the true population, not precise values.^[
The potential error introduced during this reclassification stage will be explored in the exercises.
]
However, the level of detail is sufficient to delineate metropolitan areas (see next section).

In contrast to the `pop` variable, representing absolute estimates of the total population, the remaining variables were re-classified as weights corresponding with weights used in the survey.
Class 1 in the variable `women`, for instance, represents areas in which 0 to 40% of the population is female;
these are reclassified with a comparatively high weight of 3 because the target demographic is predominantly male.
Similarly, the classes containing the youngest people and highest proportion of single households are reclassified to have high weights.


```r
rcl_pop = matrix(c(1, 1, 127, 2, 2, 375, 3, 3, 1250, 
                   4, 4, 3000, 5, 5, 6000, 6, 6, 8000), 
                 ncol = 3, byrow = TRUE)
rcl_women = matrix(c(1, 1, 3, 2, 2, 2, 3, 3, 1, 4, 5, 0), 
                   ncol = 3, byrow = TRUE)
rcl_age = matrix(c(1, 1, 3, 2, 2, 0, 3, 5, 0),
                 ncol = 3, byrow = TRUE)
rcl_hh = rcl_women
rcl = list(rcl_pop, rcl_women, rcl_age, rcl_hh)
```

Note that we have made sure that the order of the reclassification matrices in the list is the same as for the elements of `input_ras`.
For instance, the first element corresponds in both cases to the population.
Subsequently, the `for`-loop\index{loop!for} applies the reclassification matrix to the corresponding raster layer.
Finally, the code chunk below ensures the `reclass` layers have the same name as the layers of `input_ras`.


```r
reclass = input_ras
for (i in seq_len(nlayers(reclass))) {
  reclass[[i]] = reclassify(x = reclass[[i]], rcl = rcl[[i]], right = NA)
}
names(reclass) = names(input_ras)
```


```r
reclass
#> ... (full output not shown)
#> names       :  pop, women, mean_age, hh_size 
#> min values  :  127,     0,        0,       0 
#> max values  : 8000,     3,        3,       3
```


## Define metropolitan areas

We define metropolitan areas as pixels of 20 km^2^ inhabited by more than 500,000 people.
Pixels at this coarse resolution can rapidly be created using `aggregate()`\index{aggregation}, as introduced in Section \@ref(aggregation-and-disaggregation).
The command below uses the argument `fact = 20` to reduce the resolution of the result twenty-fold (recall the original raster resolution was 1 km^2^):


```r
pop_agg = aggregate(reclass$pop, fact = 20, fun = sum)
```

The next stage is to keep only cells with more than half a million people.


```r
summary(pop_agg)
#>             pop
#> Min.        127
#> 1st Qu.   39886
#> Median    66008
#> 3rd Qu.  105696
#> Max.    1204870
#> NA's        447
pop_agg = pop_agg[pop_agg > 500000, drop = FALSE] 
```

Plotting this reveals eight metropolitan regions (Figure \@ref(fig:metro-areas)).
Each region consists of one or more raster cells.
It would be nice if we could join all cells belonging to one region.
**raster**'s\index{raster} `clump()` command does exactly that.
Subsequently, `rasterToPolygons()` converts the raster object into spatial polygons, and `st_as_sf()` converts it into an `sf`-object.


```r
polys = pop_agg %>% 
  clump() %>%
  rasterToPolygons() %>%
  st_as_sf()
```

`polys` now features a column named `clumps` which indicates to which metropolitan region each polygon belongs and which we will use to dissolve\index{dissolve} the polygons into coherent single regions (see also Section \@ref(geometry-unions)):


```r
metros = polys %>%
  group_by(clumps) %>%
  summarize()
```

Given no other column as input, `summarize()` only dissolves the geometry.

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/08_metro_areas} 

}

\caption[The aggregated population raster.]{The aggregated population raster (resolution: 20 km) with the identified metropolitan areas (golden polygons) and the corresponding names.}(\#fig:metro-areas)
\end{figure}

The resulting eight metropolitan areas suitable for bike shops (Figure \@ref(fig:metro-areas); see also `code/14-location-jm.R` for creating the figure) are still missing a name.
A reverse geocoding\index{geocoding} approach can settle this problem.
Given a coordinate, reverse geocoding finds the corresponding address.
Consequently, extracting the centroid\index{centroid} coordinate of each metropolitan area can serve as an input for a reverse geocoding API\index{API}.
The **revgeo** package provides access to the open source Photon geocoder for OpenStreetMap\index{OpenStreetMap}, Google Maps and Bing. 
By default, it uses the Photon API\index{API}.
`revgeo::revgeo()` only accepts geographical coordinates (latitude/longitude); therefore, the first requirement is to bring the metropolitan polygons into an appropriate coordinate reference system\index{CRS} (Chapter \@ref(reproj-geo-data)).


```r
metros_wgs = st_transform(metros, 4326)
coords = st_centroid(metros_wgs) %>%
  st_coordinates() %>%
  round(4)
```

Choosing `frame` as `revgeocode()`'s `output` option will give back a `data.frame` with several columns referring to the location including the street name, house number and city.


```r
library(revgeo)
metro_names = revgeo(longitude = coords[, 1], latitude = coords[, 2], 
                     output = "frame")
```

To make sure that the reader uses the exact same results, we have put them into **spDataLarge** as the object `metro_names`.

\begin{table}

\caption[Result of the reverse geocoding.]{(\#tab:metro-names)Result of the reverse geocoding.}
\centering
\begin{tabular}[t]{ll}
\toprule
city & state\\
\midrule
Hamburg & Hamburg\\
Berlin & Berlin\\
Wülfrath & North Rhine-Westphalia\\
Leipzig & Saxony\\
Frankfurt am Main & Hesse\\
\addlinespace
Nuremberg & Bavaria\\
Stuttgart & Baden-Württemberg\\
Munich & Bavaria\\
\bottomrule
\end{tabular}
\end{table}

Overall, we are satisfied with the `city` column serving as metropolitan names (Table \@ref(tab:metro-names)) apart from one exception, namely Wülfrath which belongs to the greater region of Düsseldorf.
Hence, we replace Wülfrath with Düsseldorf (Figure \@ref(fig:metro-areas)).
Umlauts like `ü` might lead to trouble further on, for example when determining the bounding box of a metropolitan area with `opq()` (see further below), which is why we avoid them.


```r
metro_names = dplyr::pull(metro_names, city) %>% 
  as.character() %>% 
  ifelse(. == "Wülfrath", "Duesseldorf", .)
```

## Points of interest

\index{point of interest}
The **osmdata**\index{osmdata (package)} package provides easy-to-use access to OSM\index{OpenStreetMap} data (see also Section \@ref(retrieving-data)).
Instead of downloading shops for the whole of Germany, we restrict the query to the defined metropolitan areas, reducing computational load and providing shop locations only in areas of interest.
The subsequent code chunk does this using a number of functions including:

- `map()`\index{loop!map} (the **tidyverse** equivalent of `lapply()`\index{loop!lapply}), which iterates through all eight metropolitan names which subsequently define the bounding box\index{bounding box} in the OSM\index{OpenStreetMap} query function `opq()` (see Section \@ref(retrieving-data)).
- `add_osm_feature()` to specify OSM\index{OpenStreetMap} elements with a key value of `shop` (see [wiki.openstreetmap.org](http://wiki.openstreetmap.org/wiki/Map_Features) for a list of common key:value pairs).
- `osmdata_sf()`, which converts the OSM\index{OpenStreetMap} data into spatial objects (of class `sf`).
- `while()`\index{loop!while}, which tries repeatedly (three times in this case) to download the data if it fails the first time.^[The OSM-download will sometimes fail at the first attempt.
]
Before running this code: please consider it will download almost 2GB of data.
To save time and resources, we have put the output named `shops` into **spDataLarge**.
To make it available in your environment ensure that the **spDataLarge** package is loaded, or run `data("shops", package = "spDataLarge")`.


```r
shops = map(metro_names, function(x) {
  message("Downloading shops of: ", x, "\n")
  # give the server a bit time
  Sys.sleep(sample(seq(5, 10, 0.1), 1))
  query = opq(x) %>%
    add_osm_feature(key = "shop")
  points = osmdata_sf(query)
  # request the same data again if nothing has been downloaded
  iter = 2
  while (nrow(points$osm_points) == 0 & iter > 0) {
    points = osmdata_sf(query)
    iter = iter - 1
  }
  points = st_set_crs(points$osm_points, 4326)
})
```

It is highly unlikely that there are no shops in any of our defined metropolitan areas.
The following `if` condition simply checks if there is at least one shop for each region.
If not, we recommend to try to download the shops again for this/these specific region/s.


```r
# checking if we have downloaded shops for each metropolitan area
ind = map(shops, nrow) == 0
if (any(ind)) {
  message("There are/is still (a) metropolitan area/s without any features:\n",
          paste(metro_names[ind], collapse = ", "), "\nPlease fix it!")
}
```

To make sure that each list element (an `sf`\index{sf} data frame) comes with the same columns, we only keep the `osm_id` and the `shop` columns with the help of another `map` loop.
This is not a given since OSM contributors are not equally meticulous when collecting data.
Finally, we `rbind` all shops into one large `sf`\index{sf} object.


```r
# select only specific columns
shops = map(shops, dplyr::select, osm_id, shop)
# putting all list elements into a single data frame
shops = do.call(rbind, shops)
```

It would have been easier to simply use `map_dfr()`\index{loop!map\_dfr}. 
Unfortunately, so far it does not work in harmony with `sf` objects.
Note: `shops` is provided in the `spDataLarge` package.

The only thing left to do is to convert the spatial point object into a raster (see Section \@ref(rasterization)).
The `sf` object, `shops`, is converted into a raster\index{raster} having the same parameters (dimensions, resolution, CRS\index{CRS}) as the `reclass` object.
Importantly, the `count()` function is used here to calculate the number of shops in each cell.

\BeginKnitrBlock{rmdnote}
If the `shop` column were used instead of the `osm_id` column, we would have retrieved fewer shops per grid cell. 
This is because the `shop` column contains `NA` values, which the `count()` function omits when rasterizing vector objects.
\EndKnitrBlock{rmdnote}

The result of the subsequent code chunk is therefore an estimate of shop density (shops/km^2^).
`st_transform()`\index{sf!st\_transform} is used before `rasterize()`\index{raster!rasterize} to ensure the CRS\index{CRS} of both inputs match.


```r
shops = st_transform(shops, proj4string(reclass))
# create poi raster
poi = rasterize(x = shops, y = reclass, field = "osm_id", fun = "count")
```

As with the other raster layers (population, women, mean age, household size) the `poi` raster is reclassified into four classes (see Section \@ref(create-census-rasters)). 
Defining class intervals is an arbitrary undertaking to a certain degree.
One can use equal breaks, quantile breaks, fixed values or others.
Here, we choose the Fisher-Jenks natural breaks approach which minimizes within-class variance, the result of which provides an input for the reclassification matrix.


```r
# construct reclassification matrix
int = classInt::classIntervals(values(poi), n = 4, style = "fisher")
int = round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)  
# reclassify
poi = reclassify(poi, rcl = rcl_poi, right = NA) 
names(poi) = "poi"
```

## Identifying suitable locations

The only steps that remain before combining all the layers are to add `poi` to the `reclass` raster stack and remove the population layer from it.
The reasoning for the latter is twofold.
First of all, we have already delineated metropolitan areas, that is areas where the population density is above average compared to the rest of Germany.
Second, though it is advantageous to have many potential customers within a specific catchment area\index{catchment area}, the sheer number alone might not actually represent the desired target group.
For instance, residential tower blocks are areas with a high population density but not necessarily with a high purchasing power for expensive cycle components.
This is achieved with the complementary functions `addLayer()` and `dropLayer()`:


```r
# add poi raster
reclass = addLayer(reclass, poi)
# delete population raster
reclass = dropLayer(reclass, "pop")
```

In common with other data science projects, data retrieval and 'tidying' have consumed much of the overall workload so far.
With clean data, the final step --- calculating a final score by summing all raster\index{raster} layers --- can be accomplished in a single line of code.


```r
# calculate the total score
result = sum(reclass)
```

For instance, a score greater than 9 might be a suitable threshold indicating raster cells where a bike shop could be placed (Figure \@ref(fig:bikeshop-berlin); see also `code/14-location-jm.R`).

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/bikeshop-berlin-1} 

}

\caption[Suitable areas for bike stores.]{Suitable areas (i.e., raster cells with a score > 9) in accordance with our hypothetical survey for bike stores in Berlin.}(\#fig:bikeshop-berlin)
\end{figure}

## Discussion and next steps

The presented approach is a typical example of the normative usage of a GIS\index{GIS} [@longley_geographic_2015].
We combined survey data with expert-based knowledge and assumptions (definition of metropolitan areas, defining class intervals, definition of a final score threshold).
This approach is less suitable for scientific research than applied analysis that provides an evidence based indication of areas suitable for bike shops that should be compared with other sources of information.
A number of changes to the approach could improve the analysis:

- We used equal weights when calculating the final scores but other factors, such as the household size, could be as important as the portion of women or the mean age
- We used all points of interest\index{point of interest} but only those related to bike shops, such as do-it-yourself, hardware, bicycle, fishing, hunting, motorcycles, outdoor and sports shops (see the range of shop values available on the  [OSM Wiki](http://wiki.openstreetmap.org/wiki/Map_Features#Shop)) may have yielded more refined results
- Data at a higher resolution may improve the output (see exercises)
- We have used only a limited set of variables and data from other sources, such as the [INSPIRE geoportal](http://inspire-geoportal.ec.europa.eu/discovery/) or data on cycle paths from OpenStreetMap, may enrich the analysis (see also Section \@ref(retrieving-data))
- Interactions remained unconsidered, such as a possible relationships between the portion of men and single households

In short, the analysis could be extended in multiple directions.
Nevertheless, it should have given you a first impression and understanding of how to obtain and deal with spatial data in R\index{R} within a geomarketing\index{geomarketing} context.

Finally, we have to point out that the presented analysis would be merely the first step of finding suitable locations.
So far we have identified areas, 1 by 1 km in size, representing potentially suitable locations for a bike shop in accordance with our survey.
Subsequent steps in the analysis could be taken:

- Find an optimal location based on number of inhabitants within a specific catchment area\index{catchment area}.
For example, the shop should be reachable for as many people as possible within 15 minutes of traveling bike distance (catchment area\index{catchment area} routing\index{routing}).
Thereby, we should account for the fact that the further away the people are from the shop, the more unlikely it becomes that they actually visit it (distance decay function).
- Also it would be a good idea to take into account competitors. 
That is, if there already is a bike shop in the vicinity of the chosen location, possible customers (or sales potential) should be distributed between the competitors [@huff_probabilistic_1963; @wieland_market_2017].
- We need to find suitable and affordable real estate, e.g., in terms of accessibility, availability of parking spots, desired frequency of passers-by, having big windows, etc.

## Exercises

1. We have used `raster::rasterFromXYZ()` to convert a `input_tidy` into a raster brick\index{raster!brick}.
Try to achieve the same with the help of the `sp::gridded()` function.
<!--
input = st_as_sf(input, coords = c("x", "y"))
# use the correct projection (see data description)
input = st_set_crs(input, 3035)
# convert into an sp-object
input = as(input, "Spatial")
gridded(input) = TRUE
# convert into a raster stack
input = stack(input)
-->

1. Download the csv file containing inhabitant information for a 100-m cell resolution (https://www.zensus2011.de/SharedDocs/Downloads/DE/Pressemitteilung/DemografischeGrunddaten/csv_Bevoelkerung_100m_Gitter.zip?__blob=publicationFile&v=3).
Please note that the unzipped file has a size of 1.23 GB.
To read it into R\index{R}, you can use `readr::read_csv`.
This takes 30 seconds on my machine (16 GB RAM)
`data.table::fread()` might be even faster, and returns an object of class `data.table()`.
Use `as.tibble()` to convert it into a tibble\index{tibble}.
Build an inhabitant raster\index{raster}, aggregate\index{aggregation!spatial} it to a cell resolution of 1 km, and compare the difference with the inhabitant raster (`inh`) we have created using class mean values.

1. Suppose our bike shop predominantly sold electric bikes to older people. 
Change the age raster\index{raster} accordingly, repeat the remaining analyses and compare the changes with our original result.

<!--chapter:end:14-location.Rmd-->

# Ecology {#eco}

## Prerequisites {-}

This chapter assumes you have a strong grasp of geographic data analysis\index{geographic data analysis} and processing, covered in Chapters \@ref(spatial-class) to \@ref(geometric-operations).
In it you will also make use of R's\index{R} interfaces to dedicated GIS\index{GIS} software, and spatial cross-validation\index{cross-validation!spatial CV}, topics covered in Chapters \@ref(gis) and \@ref(spatial-cv), respectively.

The chapter uses the following packages:


```r
library(data.table)
library(dplyr)
library(mlr3)
library(mlr3spatiotempcv)
library(mlr3tuning)
library(mlr3learners)
library(qgisprocess)
library(paradox)
library(ranger)
library(tree)
library(sf)
library(terra)
library(tree)
library(vegan)
```

## Introduction

In this chapter we will model the floristic gradient of fog oases to reveal distinctive vegetation belts that are clearly controlled by water availability.
To do so, we will bring together concepts presented in previous chapters and even extend them (Chapters \@ref(spatial-class) to \@ref(geometric-operations) and  Chapters \@ref(gis) and \@ref(spatial-cv)).

Fog oases are one of the most fascinating vegetation formations we have ever encountered.
These formations, locally termed *lomas*, develop on mountains along the coastal deserts of Peru and Chile.^[Similar vegetation formations develop also in other parts of the world, e.g., in Namibia and along the coasts of Yemen and Oman [@galletti_land_2016].]
The deserts' extreme conditions and remoteness provide the habitat for a unique ecosystem, including species endemic to the fog oases.
Despite the arid conditions and low levels of precipitation of around 30-50 mm per year on average, fog deposition increases the amount of water available to plants during winter.
This results in green southern-facing mountain slopes along the coastal strip of Peru (Figure \@ref(fig:study-area-mongon)). 
The fog, which develops below the temperature inversion caused by the cold Humboldt current in austral winter, provides the name for this habitat.
Every few years, the El Niño phenomenon brings torrential rainfall to this sun-baked environment [@dillon_lomas_2003].
This causes the desert to bloom, and provides tree seedlings a chance to develop roots long enough to survive the following arid conditions.

Unfortunately, fog oases are heavily endangered, primarily due to human activity (agriculture and climate change).
To effectively protect the last remnants of this unique vegetation ecosystem, evidence is needed on the composition and spatial distribution of the native flora [@muenchow_predictive_2013; @muenchow_soil_2013].
*Lomas* mountains also have economic value as a tourist destination, and can contribute to the well-being of local people via recreation.
For example, most Peruvians live in the coastal desert, and *lomas* mountains are frequently the closest "green" destination.

In this chapter we will demonstrate ecological applications of some of the techniques learned in the previous chapters.
This case study will involve analyzing the composition and the spatial distribution of the vascular plants on the southern slope of Mt. Mongón, a *lomas* mountain near Casma on the central northern coast of Peru (Figure \@ref(fig:study-area-mongon)).

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{figures/15_study_area_mongon} 

}

\caption[The Mt. Mongón study area.]{The Mt. Mongón study area, from Muenchow, Schratz, and Brenning (2017).}(\#fig:study-area-mongon)
\end{figure}

During a field study to Mt. Mongón, we recorded all vascular plants living in 100 randomly sampled 4x4 m^2^ plots in the austral winter of 2011 [@muenchow_predictive_2013].
The sampling coincided with a strong La Niña event that year (see ENSO monitoring of the [NOASS Climate Prediction Center](http://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_v5.php)).
This led to even higher levels of aridity than usual in the coastal desert.
On the other hand, it also increased fog activity on the southern slopes of Peruvian *lomas* mountains.

<!--
The first hypothesis is that four plant belts will be found along the altitudinal gradient: a low-elevation *Tillandsia* belt, a herbaceous belt, a bromeliad belt, and an uppermost succulent belt [@muenchow_soil_2013].
-->

Ordinations\index{ordination} are dimension-reducing techniques that allow the extraction of the main gradients from a (noisy) dataset, in our case the floristic gradient developing along the southern mountain slope (see next section).
In this chapter, we will model the first ordination axis, i.e., the floristic gradient, as a function of environmental predictors such as altitude, slope, catchment area\index{catchment area} and NDVI\index{NDVI}.
For this, we will make use of a random forest model\index{random forest} - a very popular machine learning\index{machine learning} algorithm [@breiman_random_2001].
The model will allow us to make spatial predictions of the floristic composition anywhere in the study area.
To guarantee an optimal prediction, it is advisable to tune beforehand the hyperparameters\index{hyperparameter} with the help of spatial cross-validation\index{cross-validation!spatial CV} (see Section \@ref(svm)).

## Data and data preparation

All the data needed for the subsequent analyses is available via the **spDataLarge** package.


```r
data("study_area", "random_points", "comm", package = "spDataLarge")
dem = rast(system.file("raster/dem.tif", package = "spDataLarge"))
ndvi = rast(system.file("raster/ndvi.tif", package = "spDataLarge"))
```

`study_area` is a polygon representing the outline of the study area, and `random_points` is an `sf` object containing the 100 randomly chosen sites.
`comm` is a community matrix of the wide data format [@wickham_tidy_2014] where the rows represent the visited sites in the field and the columns the observed species.^[In statistics, this is also called a contingency table or cross-table.]


```r
# sites 35 to 40 and corresponding occurrences of the first five species in the
# community matrix
comm[35:40, 1:5]
#>    Alon_meri Alst_line Alte_hali Alte_porr Anth_eccr
#> 35         0         0         0       0.0     1.000
#> 36         0         0         1       0.0     0.500
#> 37         0         0         0       0.0     0.125
#> 38         0         0         0       0.0     3.000
#> 39         0         0         0       0.0     2.000
#> 40         0         0         0       0.2     0.125
```

The values represent species cover per site, and were recorded as the area covered by a species in proportion to the site area (%; please note that one site can have >100% due to overlapping cover between individual plants).
The rownames of `comm` correspond to the `id` column of `random_points`.
`dem` is the digital elevation model\index{digital elevation model} (DEM) for the study area, and `ndvi` is the Normalized Difference Vegetation Index (NDVI) computed from the red and near-infrared channels of a Landsat scene (see Section \@ref(local-operations) and `?spDataLarge::ndvi.tif`).
Visualizing the data helps to get more familiar with it, as shown in Figure \@ref(fig:sa-mongon) where the `dem` is overplotted by the `random_points` and the `study_area`.

\index{hillshade}

\begin{figure}[t]

{\centering \includegraphics[width=1\linewidth]{figures/15_sa_mongon_sampling} 

}

\caption[Study mask, location of the sampling sites.]{Study mask (polygon), location of the sampling sites (black points) and DEM in the background.}(\#fig:sa-mongon)
\end{figure}

The next step is to compute variables which are not only needed for the modeling and predictive mapping (see Section \@ref(predictive-mapping)) but also for aligning the Non-metric multidimensional scaling (NMDS)\index{NMDS} axes with the main gradient in the study area, altitude and humidity, respectively (see Section \@ref(nmds)).

Specifically, we compute catchment slope and catchment area\index{catchment area} from a digital elevation model\index{digital elevation model} using R-GIS bridges (see Chapter \@ref(gis)).
Curvatures might also represent valuable predictors, and in the Exercise section you can find out how they would impact the modeling result.

To compute catchment area\index{catchment area} and catchment slope, we can make use of the `saga:sagawetnessindex` function.^[Admittedly, it is a bit unsatisfying that the only way of knowing that `sagawetnessindex` computes the desired terrain attributes is to be familiar with SAGA\index{SAGA}.]
`qgis_show_help()` returns all function\index{function} parameters and default values of a specific geoalgorithm\index{geoalgorithm}.
Here, we present only a selection of the complete output.


```r
qgisprocess::qgis_show_help("saga:sagawetnessindex")
#> Saga wetness index (saga:sagawetnessindex)
#> ...
#> ----------------
#> Arguments
#> ----------------
#> 
#> DEM: Elevation
#> 	Argument type:	raster
#> 	Acceptable values:
#> 		- Path to a raster layer
#> ...
#> SLOPE_TYPE: Type of Slope
#> 	Argument type:	enum
#> 	Available values:
#> 		- 0: [0] local slope
#> 		- 1: [1] catchment slope
#> ...
#> AREA: Catchment area
#> 	Argument type:	rasterDestination
#> 	Acceptable values:
#> 		- Path for new raster layer
#>... 
#> ----------------
#> Outputs
#> ----------------
#> 
#> AREA: <outputRaster>
#> 	Catchment area
#> SLOPE: <outputRaster>
#> 	Catchment slope
#> ...
```

Subsequently, we can specify the needed parameters using R named arguments (see Section \@ref(rqgis)).
Remember that we can use a `SpatRaster` living in R's\index{R} global environment to specify the input raster `DEM` (see Section \@ref(rqgis)).
Specifying 1 as the `SLOPE_TYPE` makes sure that the algorithm will return the catchment slope.
The resulting rasters\index{raster} are saved to temporary files with an `.sdat` extension which is a SAGA\index{SAGA} raster format.


```r
# environmental predictors: catchment slope and catchment area
ep = qgisprocess::qgis_run_algorithm(
  alg = "saga:sagawetnessindex",
  DEM = dem,
  SLOPE_TYPE = 1, 
  SLOPE = tempfile(fileext = ".sdat"),
  AREA = tempfile(fileext = ".sdat"),
  .quiet = TRUE)
```

This returns a list named `ep` containing the paths to the computed output rasters.
Let's read in catchment area as well as catchment slope into a multilayer `SpatRaster` object (see Section \@ref(raster-classes)).
Additionally, we will add two more raster objects to it, namely `dem` and `ndvi`.


```r
# read in catchment area and catchment slope
ep = ep[c("AREA", "SLOPE")] |>
  unlist() |>
  terra::rast()
names(ep) = c("carea", "cslope") # assign proper names 
terra::origin(ep) = terra::origin(dem) # make sure rasters have the same origin
ep = c(dem, ndvi, ep) # add dem and ndvi to the multilayer SpatRaster object
```

Additionally, the catchment area\index{catchment area} values are highly skewed to the right (`hist(ep$carea)`).
A log10-transformation makes the distribution more normal.


```r
ep$carea = log10(ep$carea)
```

As a convenience to the reader, we have added `ep` to **spDataLarge**:


```r
ep = terra::rast(system.file("raster/ep.tif", package = "spDataLarge"))
```

Finally, we can extract the terrain attributes to our field observations (see also Section \@ref(raster-extraction)).


```r
# terra::extract adds automatically a for our purposes unnecessary ID column
ep_rp = terra::extract(ep, terra::vect(random_points)) |>
  dplyr::select(-ID)
random_points = cbind(random_points, ep_rp)
```

## Reducing dimensionality {#nmds}

Ordinations\index{ordination} are a popular tool in vegetation science to extract the main information, frequently corresponding to ecological gradients, from large species-plot matrices mostly filled with 0s. 
However, they are also used in remote sensing\index{remote sensing}, the soil sciences, geomarketing\index{geomarketing} and many other fields.
If you are unfamiliar with ordination\index{ordination} techniques or in need of a refresher, have a look at Michael W. Palmer's [web page](http://ordination.okstate.edu/overview.htm) for a short introduction to popular ordination techniques in ecology and at @borcard_numerical_2011 for a deeper look on how to apply these techniques in R. 
**vegan**'s\index{vegan (package)} package documentation is also a very helpful resource (`vignette(package = "vegan")`).

Principal component analysis (PCA\index{PCA}) is probably the most famous ordination\index{ordination} technique. 
It is a great tool to reduce dimensionality if one can expect linear relationships between variables, and if the joint absence of a variable in two plots (observations) can be considered a similarity.
This is barely the case with vegetation data.

For one, relationships are usually non-linear along environmental gradients.
That means the presence of a plant usually follows a unimodal relationship along a gradient (e.g., humidity, temperature or salinity) with a peak at the most favorable conditions and declining ends towards the unfavorable conditions. 

Secondly, the joint absence of a species in two plots is hardly an indication for similarity.
Suppose a plant species is absent from the driest (e.g., an extreme desert) and the most moistest locations (e.g., a tree savanna) of our sampling.
Then we really should refrain from counting this as a similarity because it is very likely that the only thing these two completely different environmental settings have in common in terms of floristic composition is the shared absence of species (except for rare ubiquitous species). 

Non-metric multidimensional scaling (NMDS\index{NMDS}) is one popular dimension-reducing technique used in ecology [@vonwehrden_pluralism_2009].
NMDS\index{NMDS} reduces the rank-based differences between the distances between objects in the original matrix and distances between the ordinated objects. 
The difference is expressed as stress. 
The lower the stress value, the better the ordination, i.e., the low-dimensional representation of the original matrix.
Stress values lower than 10 represent an excellent fit, stress values of around 15 are still good, and values greater than 20 represent a poor fit [@mccune_analysis_2002].
In R, `metaMDS()` of the **vegan**\index{vegan (package)} package can execute a NMDS.
As input, it expects a community matrix with the sites as rows and the species as columns.
Often ordinations\index{ordination} using presence-absence data yield better results (in terms of explained variance) though the prize is, of course, a less informative input matrix (see also Exercises).
`decostand()` converts numerical observations into presences and absences with 1 indicating the occurrence of a species and 0 the absence of a species.
Ordination techniques such as NMDS\index{NMDS} require at least one observation per site.
Hence, we need to dismiss all sites in which no species were found.


```r
# presence-absence matrix
pa = vegan::decostand(comm, "pa")  # 100 rows (sites), 69 columns (species)
# keep only sites in which at least one species was found
pa = pa[rowSums(pa) != 0, ]  # 84 rows, 69 columns
```

The resulting matrix serves as input for the NMDS\index{NMDS}.
`k` specifies the number of output axes, here, set to 4.^[One way of choosing `k` is to try `k` values between 1 and 6 and then using the result which yields the best stress value [@mccune_analysis_2002].]
NMDS\index{NMDS} is an iterative procedure trying to make the ordinated space more similar to the input matrix in each step.
To make sure that the algorithm converges, we set the number of steps to 500 (`try` parameter).


```r
set.seed(25072018)
nmds = vegan::metaMDS(comm = pa, k = 4, try = 500)
nmds$stress
#> ...
#> Run 498 stress 0.08834745 
#> ... Procrustes: rmse 0.004100446  max resid 0.03041186 
#> Run 499 stress 0.08874805 
#> ... Procrustes: rmse 0.01822361  max resid 0.08054538 
#> Run 500 stress 0.08863627 
#> ... Procrustes: rmse 0.01421176  max resid 0.04985418 
#> *** Solution reached
#> 0.08831395
```





A stress value of 9 represents a very good result, which means that the reduced ordination space represents the large majority of the variance of the input matrix.
Overall, NMDS\index{NMDS} puts objects that are more similar (in terms of species composition) closer together in ordination space.
However, as opposed to most other ordination\index{ordination} techniques, the axes are arbitrary and not necessarily ordered by importance [@borcard_numerical_2011].
However, we already know that humidity represents the main gradient in the study area [@muenchow_predictive_2013;@muenchow_rqgis:_2017].
Since humidity is highly correlated with elevation, we rotate the NMDS axes\index{NMDS} in accordance with elevation (see also `?MDSrotate` for more details on rotating NMDS axes).
Plotting the result reveals that the first axis is, as intended, clearly associated with altitude (Figure \@ref(fig:xy-nmds)).


```r
elev = dplyr::filter(random_points, id %in% rownames(pa)) |> 
  dplyr::pull(dem)
# rotating NMDS in accordance with altitude (proxy for humidity)
rotnmds = vegan::MDSrotate(nmds, elev)
# extracting the first two axes
sc = vegan::scores(rotnmds, choices = 1:2)
# plotting the first axis against altitude
plot(y = sc[, 1], x = elev, xlab = "elevation in m", 
     ylab = "First NMDS axis", cex.lab = 0.8, cex.axis = 0.8)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{figures/15_xy_nmds} 

}

\caption[First NMDS axis against altitude plot.]{Plotting the first NMDS axis against altitude.}(\#fig:xy-nmds)
\end{figure}



The scores of the first NMDS\index{NMDS} axis represent the different vegetation formations, i.e., the floristic gradient, appearing along the slope of Mt. Mongón.
To spatially visualize them, we can model the NMDS\index{NMDS} scores with the previously created predictors (Section \@ref(data-and-data-preparation)), and use the resulting model for predictive mapping (see next section).

## Modeling the floristic gradient

To predict the floristic gradient spatially, we use a random forest\index{random forest} model [@hengl_random_2018].
Random forest\index{random forest} models are frequently applied in environmental and ecological modeling, and often provide the best results in terms of predictive performance [@schratz_hyperparameter_2019]. 
Here, we shortly introduce decision trees and bagging, since they form the basis of random forests\index{random forest}.
We refer the reader to @james_introduction_2013 for a more detailed description of random forests\index{random forest} and related techniques.

To introduce decision trees by example, we first construct a response-predictor matrix by joining the rotated NMDS\index{NMDS} scores to the field observations (`random_points`).
We will also use the resulting data frame for the **mlr3**\index{mlr3 (package)} modeling later on.
<!-- JM: build process stops telling us that sc[, 1] causes the problem though I really don't know why... -->

```r
# construct response-predictor matrix
# id- and response variable
rp = data.frame(id = as.numeric(rownames(sc)), sc = sc[, 1])
# join the predictors (dem, ndvi and terrain attributes)
rp = inner_join(random_points, rp, by = "id")
```



Decision trees split the predictor space into a number of regions.
To illustrate this, we apply a decision tree to our data using the scores of the first NMDS\index{NMDS} axis as the response (`sc`) and altitude (`dem`) as the only predictor.


```r
tree_mo = tree::tree(sc ~ dem, data = rp)
plot(tree_mo)
text(tree_mo, pretty = 0)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{figures/15_tree} 

}

\caption[Simple example of a decision tree.]{Simple example of a decision tree with three internal nodes and four terminal nodes.}(\#fig:tree)
\end{figure}

The resulting tree consists of three internal nodes and four terminal nodes (Figure \@ref(fig:tree)).
The first internal node at the top of the tree assigns all observations which are below
<!---->
328.5 m to the left and all other observations to the right branch.
The observations falling into the left branch have a mean NMDS\index{NMDS} score of
<!---->-1.198.
Overall, we can interpret the tree as follows: the higher the elevation, the higher the NMDS\index{NMDS} score becomes.
Decision trees have a tendency to overfit\index{overfitting}, that is they mirror too closely the input data including its noise which in turn leads to bad predictive performances [Section \@ref(intro-cv); @james_introduction_2013].
Bootstrap aggregation (bagging) is an ensemble technique that can help to overcome this problem.
Ensemble techniques simply combine the predictions of multiple models.
Thus, bagging takes repeated samples from the same input data and averages the predictions.
This reduces the variance and overfitting\index{overfitting} with the result of a much better predictive accuracy compared to decision trees.
Finally, random forests\index{random forest} extend and improve bagging by decorrelating trees which is desirable since averaging the predictions of highly correlated trees shows a higher variance and thus lower reliability than averaging predictions of decorrelated trees [@james_introduction_2013].
To achieve this, random forests\index{random forest} use bagging, but in contrast to the traditional bagging where each tree is allowed to use all available predictors, random forests only use a random sample of all available predictors.

<!--
Recall that bagging is simply a special case of a random forest with m = p. Therefore, the randomForest() function can be used to perform both random forests and bagging. 
The argument mtry=13 indicates that all 13 predictors should be considered
for each split of the tree—in other words, that bagging should be done.
@james_introduction_2013
-->

### **mlr3** building blocks

The code in this section largely follows the steps we have introduced in Section \@ref(svm).
The only differences are the following:

1. The response variable is numeric, hence a regression\index{regression} task will replace the classification\index{classification} task of Section \@ref(svm)
1. Instead of the AUROC\index{AUROC} which can only be used for categorical response variables, we will use the root mean squared error (RMSE\index{RMSE}) as performance measure
1. We use a random forest\index{random forest} model instead of a support vector machine\index{SVM} which naturally goes along with different hyperparameters\index{hyperparameter}
1. We are leaving the assessment of a bias-reduced performance measure as an exercise to the reader (see Exercises).
Instead we show how to tune hyperparameters\index{hyperparameter} for (spatial) predictions

Remember that 125,500 models were necessary to retrieve bias-reduced performance estimates when using 100-repeated 5-fold spatial cross-validation\index{cross-validation!spatial CV} and a random search of 50 iterations (see Section \@ref(svm)).
In the hyperparameter\index{hyperparameter} tuning level, we found the best hyperparameter combination which in turn was used in the outer performance level for predicting the test data of a specific spatial partition (see also Figure \@ref(fig:inner-outer)). 
This was done for five spatial partitions, and repeated a 100 times yielding in total 500 optimal hyperparameter combinations.
Which one should we use for making spatial predictions?
The answer is simple: none at all. 
Remember, the tuning was done to retrieve a bias-reduced performance estimate, not to do the best possible spatial prediction.
For the latter, one estimates the best hyperparameter\index{hyperparameter} combination from the complete dataset.
This means, the inner hyperparameter\index{hyperparameter} tuning level is no longer needed which makes perfect sense since we are applying our model to new data (unvisited field observations) for which the true outcomes are unavailable, hence testing is impossible in any case. 
Therefore, we tune the hyperparameters\index{hyperparameter} for a good spatial prediction on the complete dataset via a 5-fold spatial CV\index{cross-validation!spatial CV} with one repetition.
<!-- If we used more than one repetition (say 2) we would retrieve multiple optimal tuned hyperparameter combinations (say 2) -->

Having already constructed the input variables (`rp`), we are all set for specifying the **mlr3**\index{mlr3 (package)} building blocks (task, learner, and resampling).
For specifying a spatial task, we use again the **mlr3spatiotempcv** package [@schratz_mlr3spatiotempcv_2021 & Section \@ref(spatial-cv-with-mlr3)], and since our response (`sc`) is numeric, we use a regression\index{regression} task.


```r
knitr::opts_chunk$set(eval = FALSE)
```



```r
# create task
task = mlr3spatiotempcv::as_task_regr_st(dplyr::select(rp, -id, -spri),
  id = "mongon", target = "sc")
```

Using an `sf` object as the backend automatically provides the geometry information needed for the spatial partitioning later on.
Additionally, we got rid of the columns `id` and `spri` since these variables should not be used as predictors in the modeling.
Next, we go on to construct the a random forest\index{random forest} learner from the **ranger** package.


```r
lrn_rf = lrn("regr.ranger", predict_type = "response")
```

As opposed to, for example, support vector machines\index{SVM} (see Section \@ref(svm)), random forests often already show good performances when used with the default values of their hyperparameters (which may be one reason for their popularity).
Still, tuning often moderately improves model results, and thus is worth the effort [@probst_hyperparameters_2018].
In random forests\index{random forest}, the hyperparameters\index{hyperparameter} `mtry`, `min.node.size` and `sample.fraction` determine the degree of randomness, and should be tuned [@probst_hyperparameters_2018].
`mtry` indicates how many predictor variables should be used in each tree. 
If all predictors are used, then this corresponds in fact to bagging (see beginning of Section \@ref(modeling-the-floristic-gradient)).
The `sample.fraction` parameter specifies the fraction of observations to be used in each tree.
Smaller fractions lead to greater diversity, and thus less correlated trees which often is desirable (see above).
The `min.node.size` parameter indicates the number of observations a terminal node should at least have (see also Figure \@ref(fig:tree)).
Naturally, as trees and computing time become larger, the lower the `min.node.size`.

Hyperparameter\index{hyperparameter} combinations will be selected randomly but should fall inside specific tuning limits (created with `paradox::ps()`).
`mtry` should range between 1 and the number of predictors (7) <!-- (4)-->, `sample.fraction` should range between 0.2 and 0.9 and `min.node.size` should range between 1 and 10.


```r
# specifying the search space
search_space = paradox::ps(
  mtry = paradox::p_int(lower = 1, upper = ncol(task$data()) - 1),
  sample.fraction = paradox::p_dbl(lower = 0.2, upper = 0.9),
  min.node.size = paradox::p_int(lower = 1, upper = 10)
)
```

Having defined the search space, we are all set for specifying our tuning via the `AutoTuner()` function.
Since we deal with geographic data, we will again make use of spatial cross-validation to tune the hyperparameters\index{hyperparameter} (see Sections \@ref(intro-cv) and \@ref(spatial-cv-with-mlr3)).
Specifically, we will use a five-fold spatial partitioning with only one repetition (`rsmp()`). 
In each of these spatial partitions, we run 50 models (`trm()`) while using randomly selected hyperparameter configurations (`tnr()`) within predefined limits (`seach_space`) to find the optimal hyperparameter\index{hyperparameter} combination [see also Section \@ref(svm) and https://mlr3book.mlr-org.com/optimization.html#autotuner, @becker_mlr3_2022].
The performance measure is the root mean squared error (RMSE\index{RMSE}).


```r
autotuner_rf = mlr3tuning::AutoTuner$new(
  learner = lrn_rf,
  resampling = mlr3::rsmp("spcv_coords", folds = 5), # spatial partitioning
  measure = mlr3::msr("regr.rmse"), # performance measure
  terminator = mlr3tuning::trm("evals", n_evals = 50), # specify 50 iterations
  search_space = search_space, # predefined hyperparameter search space
  tuner = mlr3tuning::tnr("random_search") # specify random search
)
```

Calling the `train()`-method of the `AutoTuner`-object finally runs the hyperparameter\index{hyperparameter} tuning, and will find the optimal hyperparameter\index{hyperparameter} combination for the specified parameters.


```r
# hyperparameter tuning
set.seed(0412022)
autotuner_rf$train(task)
```






```r
autotuner_rf$tuning_result
#>    mtry sample.fraction min.node.size learner_param_vals  x_domain regr.rmse
#> 1:    4             0.9             7          <list[4]> <list[3]>     0.375
```

<!--
An `mtry` of , a `sample.fraction` of , and a `min.node.size` of  represent the best hyperparameter\index{hyperparameter} combination.
An RMSE\index{RMSE} of 
is relatively good when considering the range of the response variable which is  (`diff(range(rp$sc))`).
-->
### Predictive mapping

The tuned hyperparameters\index{hyperparameter} can now be used for the prediction.
To do so, we only need to run the `predict` method of our fitted `AutoTuner` object.


```r
# predicting using the best hyperparameter combination
autotuner_rf$predict(task)
#> Warning: Detected version mismatch: Learner 'regr.ranger.tuned' has been trained
#> with mlr3 version '0.13.3', not matching currently installed version '0.13.4'
#> Warning: Detected version mismatch: Learner 'regr.ranger' has been trained with
#> mlr3 version '0.13.3', not matching currently installed version '0.13.4'
#> <PredictionRegr> for 84 observations:
#>     row_ids  truth response
#>           1 -1.084   -1.073
#>           2 -0.975   -1.050
#>           3 -0.912   -1.012
#> ---                        
#>          82  0.814    0.646
#>          83  0.814    0.790
#>          84  0.808    0.845
```

The `predict` method will apply the model to all observations used in the modeling.
Given a multilayer `SpatRaster` containing rasters named as the predictors used in the modeling, `terra::predict()` will also make spatial predictions, i.e., predict to new data.


```r
pred = terra::predict(ep, model = autotuner_rf, fun = predict)
```

\begin{figure}[t]

{\centering \includegraphics[width=0.6\linewidth]{figures/15_rf_pred} 

}

\caption[Predictive mapping of the floristic gradient.]{Predictive mapping of the floristic gradient clearly revealing distinct vegetation belts.}(\#fig:rf-pred)
\end{figure}

In case, `terra::predict()` does not support a model algorithm, you can still make the predictions manually.


```r
newdata = as.data.frame(as.matrix(ep))
colSums(is.na(newdata))  # 0 NAs
# but assuming there were 0s results in a more generic approach
ind = rowSums(is.na(newdata)) == 0
tmp = autotuner_rf$predict_newdata(newdata = newdata[ind, ], task = task)
newdata[ind, "pred"] = data.table::as.data.table(tmp)[["response"]]
pred_2 = ep$dem
# now fill the raster with the predicted values
pred_2[] = newdata$pred
# check if terra and our manual prediction is the same
all(values(pred - pred_2) == 0)
```

The predictive mapping clearly reveals distinct vegetation belts (Figure \@ref(fig:rf-pred)).
Please refer to @muenchow_soil_2013 for a detailed description of vegetation belts on **lomas** mountains.
The blue color tones represent the so-called *Tillandsia*-belt.
*Tillandsia* is a highly adapted genus especially found in high quantities at the sandy and quite desertic foot of *lomas* mountains.
The yellow color tones refer to a herbaceous vegetation belt with a much higher plant cover compared to the *Tillandsia*-belt.
The orange colors represent the bromeliad belt, which features the highest species richness and plant cover.
It can be found directly beneath the temperature inversion (ca. 750-850 m asl) where humidity due to fog is highest.
Water availability naturally decreases above the temperature inversion, and the landscape becomes desertic again with only a few succulent species (succulent belt; red colors).
Interestingly, the spatial prediction clearly reveals that the bromeliad belt is interrupted which is a very interesting finding we would have not detected without the predictive mapping.

## Conclusions

In this chapter we have ordinated\index{ordination} the community matrix of the **lomas** Mt. Mongón with the help of a NMDS\index{NMDS} (Section \@ref(nmds)).
The first axis, representing the main floristic gradient in the study area, was modeled as a function of environmental predictors which partly were derived through R-GIS\index{GIS} bridges (Section \@ref(data-and-data-preparation)).
The **mlr3**\index{mlr3 (package)} package provided the building blocks to spatially tune the hyperparameters\index{hyperparameter} `mtry`, `sample.fraction` and `min.node.size` (Section \@ref(mlr3-building-blocks)).
The tuned hyperparameters\index{hyperparameter} served as input for the final model which in turn was applied to the environmental predictors for a spatial representation of the floristic gradient (Section \@ref(predictive-mapping)).
The result demonstrates spatially the astounding biodiversity in the middle of the desert.
Since **lomas** mountains are heavily endangered, the prediction map can serve as basis for informed decision-making on delineating protection zones, and making the local population aware of the uniqueness found in their immediate neighborhood.

In terms of methodology, a few additional points could be addressed:

- It would be interesting to also model the second ordination\index{ordination} axis, and to subsequently find an innovative way of visualizing jointly the modeled scores of the two axes in one prediction map
- If we were interested in interpreting the model in an ecologically meaningful way, we should probably use (semi-)parametric models [@muenchow_predictive_2013;@zuur_mixed_2009;@zuur_beginners_2017]
However, there are at least approaches that help to interpret machine learning models such as random forests\index{random forest} (see, e.g., [https://mlr-org.github.io/interpretable-machine-learning-iml-and-mlr/](https://mlr-org.github.io/interpretable-machine-learning-iml-and-mlr/))
- A sequential model-based optimization (SMBO) might be preferable to the random search for hyperparameter\index{hyperparameter} optimization used in this chapter [@probst_hyperparameters_2018]

Finally, please note that random forest\index{random forest} and other machine learning\index{machine learning} models are frequently used in a setting with lots of observations and many predictors, much more than used in this chapter, and where it is unclear which variables and variable interactions contribute to explaining the response.
Additionally, the relationships might be highly non-linear.
In our use case, the relationship between response and predictors are pretty clear, there is only a slight amount of non-linearity and the number of observations and predictors is low.
Hence, it might be worth trying a linear model\index{regression!linear}.
A linear model is much easier to explain and understand than a random forest\index{random forest} model, and therefore to be preferred (law of parsimony), additionally it is computationally less demanding (see Exercises).
If the linear model cannot cope with the degree of non-linearity present in the data, one could also try a generalized additive model\index{generalized additive model} (GAM).
The point here is that the toolbox of a data scientist consists of more than one tool, and it is your responsibility to select the tool best suited for the task or purpose at hand.
Here, we wanted to introduce the reader to random forest\index{random forest} modeling and how to use the corresponding results for spatial predictions.
For this purpose, a well-studied dataset with known relationships between response and predictors, is appropriate.
However, this does not imply that the random forest\index{random forest} model has returned the best result in terms of predictive performance (see Exercises).

## Exercises


The solutions assume the following packages are attached (other packages will be attached when needed):



E1. Run a NMDS\index{NMDS} using the percentage data of the community matrix. 
Report the stress value and compare it to the stress value as retrieved from the NMDS using presence-absence data.
What might explain the observed difference?





E2. Compute all the predictor rasters\index{raster} we have used in the chapter (catchment slope, catchment area), and put them into a `SpatRaster`-object.
Add `dem` and `ndvi` to it.
Next, compute profile and tangential curvature and add them as additional predictor rasters (hint: `grass7:r.slope.aspect`).
Finally, construct a response-predictor matrix. 
The scores of the first NMDS\index{NMDS} axis (which were the result when using the presence-absence community matrix) rotated in accordance with elevation represent the response variable, and should be joined to `random_points` (use an inner join).
To complete the response-predictor matrix, extract the values of the environmental predictor raster object to `random_points`.



E3. Retrieve the bias-reduced RMSE of a random forest\index{random forest} and a linear model using spatial cross-validation\index{cross-validation!spatial CV}.
The random forest modeling should include the estimation of optimal hyperparameter\index{hyperparameter} combinations (random search with 50 iterations) in an inner tuning loop (see Section \@ref(svm)).
Parallelize\index{parallelization} the tuning level (see Section \@ref(svm)).
Report the mean RMSE\index{RMSE} and use a boxplot to visualize all retrieved RMSEs.
Please not that this exercise is best solved using the mlr3 functions `benchmark_grid()` and `benchmark()` (see https://mlr3book.mlr-org.com/perf-eval-cmp.html#benchmarking for more information).

<!--chapter:end:15-eco.Rmd-->

# Conclusion {#conclusion}

## Prerequisites {-}

Like the introduction, this concluding chapter contains few code chunks.
But its prerequisites are demanding.
It assumes that you have:

- read through and attempted the exercises in all the chapters of Part I (Foundations);
- considered how you can use geocomputation\index{geocomputation} to solve real-world problems, at work and beyond, after engaging with Part III (Applications).

## Introduction

The aim of this chapter is to synthesize the contents, with reference to recurring themes/concepts, and to inspire future directions of application and development.
Section \@ref(package-choice) discusses the wide range of options for handling geographic data in R.
Choice is a key feature of open source software; the section provides guidance on choosing between the various options.
Section \@ref(gaps) describes gaps in the book's contents and explains why some areas of research were deliberately omitted, while others were emphasized.
This discussion leads to the question (which is answered in Section \@ref(next)): having read this book, where to go next?
Section \@ref(benefit) returns to the wider issues raised in Chapter \@ref(intro).
In it we consider geocomputation as part of a wider 'open source approach' that ensures methods are publicly accessible, reproducible\index{reproducibility} and supported by collaborative communities.
This final section of the book also provides some pointers on how to get involved.

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
nz_name2 = nz |> select(Name)          # tidyverse approach
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
As of mid-2022, there are about 200 packages mentioned in the Spatial [Task View](https://cran.r-project.org/web/views/);
more packages and countless functions for geographic data are developed each year, making it impractical to cover them all in a single book.



The rate of evolution in R's spatial ecosystem may seem overwhelming, but there are strategies to deal with the wide range of options.
Our advice is to start by learning one approach *in depth* but to have a general understand of the *breadth* of options available.
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

On the other hand, we have omitted topics that are less commonly used, or which are covered in-depth elsewhere.
Statistical topics including point pattern analysis, spatial interpolation (kriging) and spatial epidemiology, for example, are only mentioned with reference to other topics such as the machine learning\index{machine learning} techniques covered in Chapter \@ref(spatial-cv) (if at all).
There is already excellent material on these methods, including statistically orientated chapters in @bivand_applied_2013 and a book on point pattern analysis by @baddeley_spatial_2015.
Other topics which received limited attention were remote sensing and using R alongside (rather than as a bridge to) dedicated GIS\index{GIS} software.
There are many resources on these topics, including @wegmann_remote_2016 and the GIS-related teaching materials available from [Marburg University](https://moc.online.uni-marburg.de/doku.php).

Instead of covering spatial statistical modeling and inference techniques, we focussed on machine learning\index{machine learning} (see Chapters \@ref(spatial-cv) and \@ref(eco)).
Again, the reason was that there are already excellent resources on these topics, especially with ecological use cases, including @zuur_mixed_2009, @zuur_beginners_2017 and freely available teaching material and code on *Geostatistics & Open-source Statistical Computing* by David Rossiter, hosted at [css.cornell.edu/faculty/dgr2](http://www.css.cornell.edu/faculty/dgr2/teach/) and the [*granolarr*](https://sdesabbata.github.io/granolarr/) project by [Stefano De Sabbata](https://stefanodesabbata.com/) [at the University of Leicester](https://www2.le.ac.uk/departments/geography/people/stefano-de-sabbata) for an introduction to R\index{R} for geographic data science\index{data science}.
There are also excellent resources on spatial statistics\index{spatial!statistics} using Bayesian modeling, a powerful framework for modeling and uncertainty estimation [@blangiardo_spatial_2015;@krainski_advanced_2018].

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

## Getting help? {#questions}
<!-- Now wondering if this should be an appendix, or even a new chapter?? -->

<!-- Chapter \@ref(intro) states that the approach advocated in this book "can help remove constraints on your creativity imposed by software". -->
<!-- We have covered many techniques that should enable you to put many of your ideas into reproducible and scalable code for research and applied geocomputation. -->
<!-- However, creativity involves thinking coming up with *new* ideas that have not yet been implemented, raising the question: what happens when software *does* impose a constraint because you are not sure how to implement your creative ideas? -->

<!-- In Chapter \@ref(intro) we set out our aim of providing strong foundations on which a wide range of data analysis, research and methodological and software development projects can build. -->
<!-- Geocomputation is about not only using existing techniques but developing new tools which, by definition, involves generating new knowledge. -->

Geocomputation is a large field and it is highly likely that you will encounter challenges preventing you from achieving an outcome that you are aiming towards.
In many cases you may just 'get stuck' at a particular point in data analysis workflows, with a cryptic error message or an unexpected result providing little clues as to what is going on.
This section provides pointers to help you overcome such problems, by clearly defining the problem, searching for existing knowledge on solutions and, if those approaches to not solve the problem, through the art of asking good questions.
<!-- generating new open knowledge by engaging with the community. -->

When you get stuck at a particular point, it is worth first taking a step back and working out which approach is most likely to solve the issue.
Trying each of the following steps, in order (or skipping steps if you have already tried them), provides a structured approach to problem solving:

1. Define exactly what you are trying to achieve, starting from first principles (and often a sketch, as outlined below)
2. Diagnose exactly where in your code the unexpected results arise, by running and exploring the outputs of individual lines of code and their individual components (you can can run individual parts of a complex command by selecting them with a cursor and pressing Ctrl+Enter in RStudio, for example)
3. Read the documentation of the function that has been diagnosed as the 'point of failure' in the previous step. Simply understanding the required inputs to functions, and running the examples that are often provided at the bottom of help pages, can help solve a surprisingly large proportion of issues (run the command `?terra::rast` and scroll down to the examples that are worth reproducing when getting started with the function, for example)
4. If reading R's inbuilt documentation, as outlined in the previous step, does not help solve the problem, it is probably time to do a broader search online to see if others have written about the issue you're seeing. See a list of places to search for help below for places to search
5. If all the previous steps above fail, and you cannot find a solution from your online searches, it may be time to compose a question with a reproducible example and post it in an appropriate place

Steps 1 to 3 outlined above are fairly self-explanatory but, due to the vastness of the internet and multitude of search options, it is worth considering effective search strategies before deciding to compose a question.

### Searching for solutions online

A logical place to start for many issues is search engines.
'Googling it' can in some cases result in the discovery of blog posts, forum messages and other online content about the precise issue you're having.
Simply typing in a clear description of the problem/question is a valid approach here but it is important to be specific (e.g. with reference to function and package names and input dataset sources if the problem is dataset specific).
You can also make online searches more effective by including additional detail:
<!-- To provide a concrete example, imagine you want to know how to use custom symbols in an interactive map. -->

- Use quote marks to maximise the chances that 'hits' relate to the exact issue you're having by reducing the number of results returned
<!-- todo: add example -->
- Set [time restraints](https://uk.pcmag.com/software-services/138320/21-google-search-tips-youll-want-to-learn), for example only returning content created within the last year can be useful when searching for help on an evolving package.
- Make use of additional [search engine features](https://www.makeuseof.com/tag/6-ways-to-search-by-date-on-google/), for example restricting searches to content hosted on CRAN with site:r-project.org

### Places to search for (and ask) for help {#help}

<!-- toDo:rl-->
<!-- Todo: provide pros and cons and maybe how to search each:  -->
- R's Special Interest Group on Geographic data email list ([R-SIG-GEO](https://stat.ethz.ch/mailman/listinfo/r-sig-geo))
- The GIS Stackexchange website at [gis.stackexchange.com](https://gis.stackexchange.com/)
- The large and general purposes programming Q&A site [stackoverflow.com](https://stackoverflow.com/)
- Online forums associated with a particular entity, such as the [RStudio Community](https://community.rstudio.com/), the [rOpenSci Discuss](https://discuss.ropensci.org/) web forum and forums associated with particular software tools such as the [Stan](https://discourse.mc-stan.org/) forum
- Software development platforms such as GitHub, which hosts issue trackers for the majority of R-spatial packages and also, increasingly, inbuilt discussion pages such as that created to encourage discussion (not just bug reporting) around the **sfnetworks** package (see [luukvdmeer/sfnetworks/discussions](https://github.com/luukvdmeer/sfnetworks/discussions/))

### How to ask a good question with a reproducible example {#reprex}

In terms asking a good question, a clearly stated questions supported by an accessible and fully reproducible example is key.
It is also helpful, after showing the code that 'did not work' from the user's perspective, to explain what you would like to see.
A very useful tool for creating reproducible examples is the **reprex** package.
<!-- Todo: show how reprex works. -->



<!-- A strength of open source and collaborative approaches to geocomputation is that they generate a vast and ever evolving body on knowledge, of which this book is a part. -->
<!-- Thousands of exchanges have taken place in publicly accessible fora, demonstrating the importance of knowing how to search for answers and, perhaps more importantly, show how beginners can support open source software communities by asking good questions. -->
<!-- This section covers these interrelated topics, with a focus on common places to search for answers and ask questions and how to ask good questions. -->
<!-- Should we divide these topics in 2? RL 2022-02 -->

<!-- Key fora for discussing methods and code for working with geographic data in R include: -->
<!-- I was thinking of saying "in descening order of ease of use" or something but not sure that's a good idea (RL 2022-02) -->

### Defining and sketching the problem

The best starting point when developing a new geocomputational methodology or approach is often a pen and paper (or equivalent digital sketching tools such as [Excalidraw](https://excalidraw.com/) and [tldraw](https://www.tldraw.com/) which allow collaborative sketching and rapid sharing of ideas): during the most creative early stages of methodological development work software *of any kind* can slow down your thoughts and direct your thinking away from important abstract thoughts.
Framing the question with mathematics is also highly recommended, with reference to a minimal example that you can sketch 'before and after' versions of numerically.
If you have the skills and if the problem warrants it, describing the approach algebraically can in some cases help develop effective implementations.

## Where to go next? {#next}

As indicated in Section \@ref(gaps), the book has covered only a fraction of the R's geographic ecosystem, and there is much more to discover.
We have progressed quickly, from geographic data models in Chapter \@ref(spatial-class), to advanced applications in Chapter \@ref(eco).
Consolidation of skills learned, discovery of new packages and approaches for handling geographic data, and application of the methods to new datasets and domains are suggested future directions.
This section expands on this general advice by suggesting specific 'next steps', highlighted in **bold** below.

In addition to learning about further geographic methods and applications with R\index{R}, for example with reference to the work cited in the previous section, deepening your understanding of **R itself** is a logical next step.
R's fundamental classes such as `data.frame` and `matrix` are the foundation of `sf` and `raster` classes, so studying them will improve your understanding of geographic data.
This can be done with reference to documents that are part of R, and which can be found with the command `help.start()` and additional resources on the subject such as those by @wickham_advanced_2019 and @chambers_extending_2016.

Another software-related direction for future learning is **discovering geocomputation with other languages**.
There are good reasons for learning R as a language for geocomputation, as described in Chapter \@ref(intro), but it is not the only option.^[
R's strengths relevant to our definition of geocomputation include its emphasis on scientific reproducibility\index{reproducibility}, widespread use in academic research and unparalleled support for statistical modeling of geographic data.
Furthermore, we advocate learning one language (R) for geocomputation\index{geocomputation} in depth before delving into other languages/frameworks because of the costs associated with context switching.
It is preferable to have expertise in one language than basic knowledge of many.
]
It would be possible to study *Geocomputation with: Python*\index{Python}, *C++*\index{C++}, *JavaScript*\index{JavaScript}, *Scala*\index{Scala} or *Rust*\index{Rust} in equal depth.
Each has evolving geospatial capabilities.
[**rasterio**](https://github.com/mapbox/rasterio), for example, is a Python package
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

## The open source approach {#benefit}

This is a technical book so it makes sense for the next steps, outlined in the previous section, to also be technical.
However, there are wider issues worth considering in this final section, which returns to our definition of geocomputation\index{geocomputation}.
One of the elements of the term introduced in Chapter \@ref(intro) was that geographic methods should have a positive impact.
Of course, how to define and measure 'positive' is a subjective, philosophical question, beyond the scope of this book.
Regardless of your worldview, consideration of the impacts of geocomputational work is a useful exercise:
the potential for positive impacts can provide a powerful motivation for future learning and, conversely, new methods can open-up many possible fields of application.
These considerations lead to the conclusion that geocomputation is part of a wider 'open source approach'.

Section \@ref(what-is-geocomputation) presented other terms that mean roughly the same thing as geocomputation, including geographic data science\index{data science} (GDS) and 'GIScience'.
Both capture the essence of working with geographic data, but geocomputation has advantages: it concisely captures the 'computational' way of working with geographic data advocated in this book --- implemented in code and therefore encouraging reproducibility --- and builds on desirable ingredients of its early definition [@openshaw_geocomputation_2000]:

- The *creative* use of geographic data
- Application to *real-world problems*
- Building 'scientific' tools
- Reproducibility\index{reproducibility}

We added the final ingredient: reproducibility was barely mentioned in early work on geocomputation, yet a strong case can be made for it being a vital component of the first two ingredients.
Reproducibility\index{reproducibility}

- encourages *creativity* by shifting the focus away from the basics (which are readily available through shared code) and towards applications;
- discourages people from 'reinventing the wheel': there is no need to re-do what others have done if their methods can be used by others; and
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

It is instructive to watch the incessant development activity happen in public fora such as GitHub, but it is even more rewarding to become an active participant.
This is one of the greatest features of the open source approach: it encourages people to get involved.
This book itself is a result of the open source approach:
it was motivated by the amazing developments in R's geographic capabilities over the last two decades, but made practically possible by dialogue and code sharing on platforms for collaboration.
We hope that in addition to disseminating useful methods for working with geographic data, this book inspires you to take a more open source approach.
Whether it's raising a constructive issue alerting developers to problems in their package; making the work done by you and the organizations you work for open; or simply helping other people by passing on the knowledge you've learned, getting involved can be a rewarding experience.


<!--chapter:end:16-synthesis.Rmd-->



<!--chapter:end:references.Rmd-->

