create_ref_provinces <- function() {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_provinces (
         iso_2_alpha VARCHAR(2) PRIMARY KEY, 
         iso_2_numeric INTEGER NOT NULL,
         year_start INTEGER NOT NULL,
         year_end INTEGER NOT NULL,
         name_en VARCHAR NOT NULL,
         name_fr VARCHAR NOT NULL
     );"
  )

  files <- fs::dir_ls(
    path = fs::path("data", "data_unzipped"),
    recurse = TRUE,
    type = "file",
    regexp = "(?i)ODPF_8_ProvDesc.txt"
  )

  ref_provinces <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE)
  })

  ref_provinces <- purrr::set_names(ref_provinces, files)

  ref_provinces <- purrr::list_rbind(ref_provinces, names_to = "file")

  ref_provinces <- dplyr::mutate(
    ref_provinces,
    file_year = stringr::str_extract(file, "(\\d{4})", group = 1),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_provinces <- dplyr::select(
    ref_provinces,
    file_year,
    iso_2_alpha = X2,
    iso_2_numeric = X1,
    year_start = X3,
    year_end = X4,
    name_en = X5,
    name_fr = X6
  )

  ref_provinces <- dplyr::distinct(
    ref_provinces,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_provinces <- ref_provinces |>
    dplyr::slice_max(year_start, n = 1, by = iso_2_numeric)

  ref_provinces <- dplyr::select(
    ref_provinces,
    iso_2_alpha,
    iso_2_numeric,
    year_start,
    year_end,
    name_en,
    name_fr
  )

  ref_provinces <- dplyr::mutate(
    ref_provinces,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  DBI::dbWriteTable(
    con,
    "ref_provinces",
    ref_provinces,
    append = TRUE
  )

  return(invisible())
}
