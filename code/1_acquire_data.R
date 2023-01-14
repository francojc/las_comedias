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

# Add data sources to the `data/original/data_sources.csv` file.
# The source URL only is testedd on works from the following index page:
# https://www.cervantesvirtual.com/portales/teatro_clasico_espanol/canon_60_titulos/
# This is done manually using spreadsheet software. The file must be
# saved in .csv format.

# Read data sources
data_sources <- read_csv(file = "data/original/data_sources.csv") # read data sources

# Get the URLs for each data source
works_urls <-
  data_sources %>% # data sources
  pull(work_url) # pull the work_url for each source

# Acquire HTML for each of the works under the work_url and write to disk
works_urls %>% # pass url(s) to acquire all associated works
  walk(get_works_html) # acquire html for each work

# CLEANUP ----------------------------------------------------------------------

rm(list = ls()) # remove workspace variables
