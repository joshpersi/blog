download_data <- function(url) {
  fs::dir_create("data")

  file_name <- fs::path_rel(
    url,
    start = "https://www150.statcan.gc.ca/n1/pub/71-607-x/2021004/zip/"
  )

  curl::curl_download(
    url,
    destfile = fs::path("data", "data_zipped", file_name)
  )

  return(invisible())
}
