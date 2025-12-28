create_ref_countries <- function() {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_countries (
         iso_2_alpha VARCHAR(2) PRIMARY KEY, 
         iso_3_numeric INTEGER NOT NULL,
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
    regexp = "(?i)ODPF_6_CtyDesc.txt"
  )

  ref_countries <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE, na = c(""))
  })

  ref_countries <- purrr::set_names(ref_countries, files)

  ref_countries <- purrr::list_rbind(ref_countries, names_to = "file")

  ref_countries <- dplyr::mutate(
    ref_countries,
    file_year = stringr::str_extract(file, "(\\d{4})", group = 1),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_countries <- dplyr::select(
    ref_countries,
    file_year,
    iso_2_alpha = X1,
    iso_3_numeric = X2,
    year_start = X3,
    year_end = X4,
    name_en = X5,
    name_fr = X6
  )

  ref_countries <- dplyr::distinct(
    ref_countries,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_countries <- ref_countries |>
    dplyr::slice_max(year_start, n = 1, by = iso_2_alpha) |>
    dplyr::slice_max(file_year, n = 1, by = iso_2_alpha)

  ref_countries <- dplyr::select(
    ref_countries,
    iso_2_alpha,
    iso_3_numeric,
    year_start,
    year_end,
    name_en,
    name_fr
  )

  ref_countries <- dplyr::mutate(
    ref_countries,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  DBI::dbWriteTable(
    con,
    "ref_countries",
    ref_countries,
    append = TRUE
  )

  return(invisible())
}
