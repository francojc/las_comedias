
# FUNCTIONS --------------------------------------------------------------------

read_write_html <- function(url, work_author, work_title, data_dir) {
  # Function: takes a works url and reads and writes
  #           the original html to disk

  html <- read_html(url) # parse html from url

  author <- work_author %>% to_any_case() # snakecase the work author
  title <- work_title %>% to_any_case() # snakecase the work title

  comedia <-
    html %>% # parsed html
    html_element("h2:not(.sr-only)") %>% # get work comedia name
    html_text() %>% # extract text
    to_any_case() # convert to snakecase

  work_name <- paste0(author, "-", title, "-", comedia) # compile work name information

  html_chr <- html %>% as("character") # convert xml to plain text
  file_path <- paste0(data_dir, work_name, ".html") # create file path
  write_file(html_chr, file = file_path) # write html to disk
}

get_works_html <- function(works_url, data_dir = "data/original/") {
  # Function: takes a works url and finds, reads, and writes
  #           raw html to disk in a specified directory

  s <- session(works_url) # index page session

  work_meta <-
    s %>% # session
    html_element("span.col1 + a") %>% # get meta information
    html_text() # extract text

  work_author <-
    work_meta %>% # meta information
    str_extract("\\/\\s.+;") %>% # extract author name
    str_remove_all("(\\/\\s|;)") # clean

  work_title <-
    work_meta %>% # meta information
    str_extract("^.+\\/") %>% # extract work title
    str_remove("\\/") # clean

  works_links_page <- # works links session
    s %>% # session
    session_follow_link(css = "span.col1 + a") # pages with link to works

  works_urls <-
    works_links_page %>% # link page
    html_elements(css = 'li[style="display:inline;list-style-type:none;"] p a') %>% # works links
    html_attr("href") %>% # works relative href addresses
    url_absolute(base = works_links_page$url) # compose absolute url addresses

  works_urls %>%
    walk(read_write_html, work_author, work_title, data_dir) # apply function to read and write html to disk
}

