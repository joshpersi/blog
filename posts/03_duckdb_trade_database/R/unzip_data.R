unzip_data <- function() {
  zip_files <- fs::dir_ls(fs::path("data", "data_zipped"))

  purrr::walk(
    zip_files,
    \(x) {
      dir_name <- x |>
        fs::path_file() |>
        fs::path_ext_remove()

      utils::unzip(
        x,
        overwrite = TRUE,
        junkpaths = TRUE,
        exdir = fs::path("data", "data_unzipped", dir_name)
      )
    }
  )

  return(invisible())
}
