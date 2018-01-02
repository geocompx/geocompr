# Code

Code lives in the `code` directory in files named according to the chapter they are in, e.g. `01-venn.R`.
The code does not have to be self-standing: it can depend on code run previously in the chapter.
        
- `library(package)` - library without quotes
- `=` - assignment operator (open for debate)
- ` = ` , ` > `, etc. - spaces around operators
- `"text"` - double quotes for character values
- `for(i in 1:9) {print(i)}` - use space separation for curly brackets
- When indenting your code, use two spaces (tab in RStudio)

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

# Figures

Names of the figures should contain a chapter number, e.g. `04-world-map.png` or `11-population-animation.gif`.

# File names

- Minimize capitalization: use `file-name.rds` not `file-name.Rds`
- `-` not `_`: use `file-name.rds` not `file_name.rds`
