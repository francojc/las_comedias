
# FUNCTIONS --------------------------------------------------------------------

get_works_content <- function(html_file, data_dir = "data/derived/", regexp = ".*") {
  # Function: takes a specified local html file and reads
  #           and formats the relevant content to a tabular csv format

  html <- read_html(html_file) # parse html file as XML nodeset

  work_name <-
    html_file %>% # file name
    str_remove_all(pattern = "data/original/|\\.html") # remove directory/ extension

  work_meta <-
    work_name %>% # author, title, comedia information
    to_title_case(sep_in = "_") %>% # clean
    str_split("-") %>% # split
    unlist() # create character vector

  author <- work_meta[1] # pull author name
  title <- work_meta[2] # pull work name
  comedia <- work_meta[3] # pull comedia name

  tables <-
    html %>% # parsed html
    html_elements("td table") %>% # isolate content
    html_table() # create data frame from the content

  collapse_tables <- function(table) {
    # Helper function: collapse data frame rows into single row
    table %>% summarise(lines = paste(X1, collapse = " "))
  }

  content <-
    tables %>% # raw content tables
    map_dfr(collapse_tables) %>% # collapse tables into single rows
    filter(str_detect(lines, "^[A-Z]{3,}\\s")) %>% # remove redundant lines
    extract(col = lines, into = c("speaker", "dialogue"), regex = "(^[A-Z]+)\\s(.+$)") %>% # extract
    mutate(author = author, title = title, comedia = comedia, speaker = str_to_title(speaker)) # compile

  file_path <- paste0(data_dir, work_name, ".csv") # prepare file path
  write_csv(x = content, file = file_path) # write csv file to disk
}

