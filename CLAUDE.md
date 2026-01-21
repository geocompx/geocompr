# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is "Geocomputation with R" (2nd edition) - an open-source educational book built with R Bookdown. The book teaches geographic data science using R packages **sf** (vector), **terra** (raster), and **tmap** (mapping).

Published at: https://r.geocompx.org

## Build Commands

```r
# Render full book (outputs to _book/)
bookdown::render_book("index.Rmd")

# Live preview with hot-reload during development
bookdown::serve_book(".")

# Install all dependencies via meta-package
install.packages("geocompkg", repos = c("https://geocompx.r-universe.dev", "https://cloud.r-project.org"), dependencies = TRUE)
```

## Architecture

**Chapter structure**: 16 R Markdown files (`01-introduction.Rmd` through `16-synthesis.Rmd`) that are interdependent - code in later chapters assumes packages/objects from earlier ones.

**Key files**:
- `_bookdown.yml` - chapter order and book metadata
- `_output.yml` - theme, styling, CSS configuration
- `code/before_script.R` - sourced at start of each chapter
- `code/*.R` - support scripts for figures and data processing
- `_XX-ex.Rmd` - exercise solutions (rendered separately)

**Rendering**: Each chapter runs in a new R session (`new_session: true` in `_bookdown.yml`). Full render takes 10+ minutes due to spatial operations.

**CI/CD**: GitHub Actions renders using Docker container `ghcr.io/geocompx/suggests:latest` and deploys to gh-pages branch.

## Code Style

- Assignment: use `=` (not `<-`)
- Spaces around operators: `x = 1`, not `x=1`
- Strings: double quotes `"text"`
- Indentation: 2 spaces
- Pipes: `x %>% fun()` not `fun(x) %>% ...`
- File names: lowercase with hyphens (`file-name.rds`)

## Text Style

- One sentence per line (git diff friendly)
- Format references: **package**, `class`, `function()`
- Spelling: en-US
- Captions: no markdown characters or references

## References

Use Zotero group library, not direct .bib editing. Citation key format: `[auth:lower]_[veryshorttitle:lower]_[year]` via Better Bibtex plugin.

## Important Context

- This is pedagogical code meant to teach, not production code
- Chapter code is sequential - don't reorder without checking dependencies
- Changes to chapters may require updates to corresponding `_XX-ex.Rmd` exercise files
- System dependencies required: GDAL, GEOS, PROJ (handled by Docker in CI)
