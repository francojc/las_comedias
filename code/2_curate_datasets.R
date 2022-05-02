# ABOUT -------------------------------------------------------------------

# Description: Curate the raw html files acquired and written to disk
# Usage: ...
# Author: Jerid Francom
# Date: 2022-04-29

# SETUP -------------------------------------------------------------------

# Packages
pacman::p_load(tidyverse, rvest, snakecase)

# Functions
source("functions/curate_functions.R")

# RUN --------------------------------------------------------------------------

fs::dir_ls(path = "data/original/") %>% # list html files
  walk(get_works_content) # get works content and write to disk in csv format



