html:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::bs4_book", clean = TRUE)'
	cp -fvr style/style.css _book/
	# cp -fvr images _book/
	cp -fvr _main* _book/

html2:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)'
	cp -fvr style/style.css _book/
	# cp -fvr images _book/
	cp -fvr _main* _book/

build: ## Make Build
	make html
	Rscript -e 'browseURL("_book/index.html")'

pdf: ## Render book in pdf
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'

md: ## Generate Markdown
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book", clean = FALSE)'

install: ## Perform install
	Rscript -e 'remotes::install_github("Robinlovelace/geocompr")'

deploy: ## Perform deployment
	Rscript -e 'bookdown::publish_book(render = "local", account = "robinlovelace")'

clean:
	Rscript -e "bookdown::clean_book(TRUE)"
	rm -fvr *.log Rplots.pdf _bookdown_files land.sqlite3

cleaner:
	make clean && rm -fvr rsconnect
	rm -frv *.aux *.out  *.toc # Latex output
	rm -fvr *.html # rogue html files
	rm -fvr *utf8.md # rogue md files

.PHONY: help
help: SHELL := /bin/sh
help: ## List available commands and their usage
	@awk 'BEGIN {FS = ":.*?##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } ' $(MAKEFILE_LIST)