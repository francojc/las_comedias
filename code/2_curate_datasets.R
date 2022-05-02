# ABOUT -------------------------------------------------------------------

# Description: Curate the raw html files acquired and written to disk
# Usage: ...
# Author: Jerid Francom
# Date: 2022-04-29

# SETUP -------------------------------------------------------------------

# Packages
pacman::p_load(tidyverse, rvest, snakecase)

# Functions
source("functions/curate_functions.R") # functions to parse HTML and create .csv files
source("functions/general.R") # data_dic_starter() function

# RUN --------------------------------------------------------------------------

# Read HTML files from data/original directory and parse into tables
fs::dir_ls(path = "data/original/", glob = "*.html") %>% # list html files
  walk(get_works_content) # get works content and write to disk in csv format

# Create a data dictionary scaffold
# -- to be edited with spreadsheet software after initial template creation

data_dic_file <- "data/derived/data_dictionary_curated.csv"

if(fs::file_exists(path = data_dic_file)) {
  message("Existing data dictionary file. Edit with spreadsheet software.")
} else {
  files <- fs::dir_ls(path = "data/derived/", glob = "*.csv") # check for .csv files
  if(length(files) != 0) { # if there is a .csv file
    template_file <- read_csv(file = files[1]) # read example file
    data_dic_starter(data = template_file, file_path = data_dic_file) # write template file
    message("Data dictionary file created. Edit with spreadsheet software.")
  } else {
    message("No data files.")
  }
}

# CLEANUP ----------------------------------------------------------------------

rm(list = ls()) # remove workspace variables

