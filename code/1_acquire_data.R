# ABOUT -------------------------------------------------------------------

# Description: Acquire raw html files from the https://www.cervantesvirtual.com/
#              website. The following script takes urls for any title on the
#              https://www.cervantesvirtual.com/portales/teatro_clasico_espanol/canon_60_titulos/
#              index page.
# Usage: ...
# Author: Jerid Francom
# Date: 2022-04-29

# SETUP -------------------------------------------------------------------

# Packages
pacman::p_load(tidyverse, rvest, snakecase)

# Functions
source("functions/acquire_functions.R")

# RUN --------------------------------------------------------------------------

works_urls <- c("https://www.cervantesvirtual.com/portales/teatro_clasico_espanol/obra/la-bizarrias-de-elisa/",
                "https://www.cervantesvirtual.com/portales/teatro_clasico_espanol/obra/el-burlador-de-sevilla-0/")

works_urls %>% # pass url(s) to acquire all associated works
  walk(get_works_html) # locate, read, and write each work to disk in html format


