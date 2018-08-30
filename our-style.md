# Code

Code lives in the `code` directory in files named according to the chapter they are in, e.g. `01-venn.R`.
The code does not have to be self-standing: it can depend on code run previously in the chapter.
        
- `library(package)` - library without quotes
- `=` - assignment operator (instead of `<-`)
- ` = ` , ` > `, etc. - spaces around operators
- `"text"` - double quotes for character values
- `for(i in 1:9) {print(i)}` - use space separation for curly brackets
- When indenting your code, use two spaces (tab in RStudio)
- When using pipes, pipe the first object (`x %>% fun() %>% ...` not `fun(x) %>% ...`)
- Scripts should (see example below): 
  - state their aim and (if appropriate) a date and a table of contents
  - be sectioned with the help of `---`, `===`, and `###` e.g. as acheived by pressing `Ctl-Shift-R`

```
# Filename: filename.R (2018-02-06)
# Aim: What should the script achieve
#
# Author(s): Robin Lovelace, Jakub Nowosad, Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. DATA EXPLORATION
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library(sf)
# attach data
nc = st_read(system.file("shape/nc.shp", package = "sf"))

#**********************************************************
# 2 DATA EXPLORATION---------------------------------------
#**********************************************************
```

# Comments

Comment your code unless obvious because the aim is teaching.
Use capital first letter for full-line comment.

```r
# Create object x
x = 1:9
```

Do not capitalise comment for end-of-line comment

```r
y = x^2 # square of x
```

# Text

- Use one line per sentence during development for ease of tracking changes.
- Leave a single empty line space before and after each code chunk.
- Format content as follows: 
    - **package_name**
    - `class_of_object`
    - `function_name()`

- Spelling: use `en-us`

# Captions

Captions should not contain any markdown characters, e.g. `*` or `*`. 
References in captions also should be avoided.

# Figures

Names of the figures should contain a chapter number, e.g. `04-world-map.png` or `11-population-animation.gif`.

# File names

- Minimize capitalization: use `file-name.rds` not `file-name.Rds`
- `-` not `_`: use `file-name.rds` not `file_name.rds`

# References

References are added using the markdown syntax [@refname] from the .bib files in this repo.
The package **citr** can be used to automate citation search and entry.
Use Zotero to add references to the geocompr at [zotero.org](https://www.zotero.org/groups/418217/energy-and-transport/items/collectionKey/9K6FRP6N/) rather than changing .bib files directly.
The citation key format used is `[auth:lower]_[veryshorttitle:lower]_[year]` using [zotero-better-bibtex](https://github.com/retorquere/zotero-better-bibtex).
