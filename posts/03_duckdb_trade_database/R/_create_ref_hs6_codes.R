create_ref_hs6_codes <- function(...) {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_hs6_codes (
         hs6 VARCHAR(6) PRIMARY KEY,
         description_en VARCHAR NOT NULL,
         description_fr VARCHAR NOT NULL
     );"
  )

  files <- fs::dir_ls(
    path = fs::path("data", "data_unzipped"),
    recurse = TRUE,
    type = "file",
    regexp = "(?i)ODPF_(3|4)_HS6(M|X)Desc.txt"
  )

  ref_hs6_codes <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE)
  })

  ref_hs6_codes <- purrr::set_names(ref_hs6_codes, files)

  ref_hs6_codes <- purrr::list_rbind(ref_hs6_codes, names_to = "file")

  ref_hs6_codes <- dplyr::mutate(
    ref_hs6_codes,
    file_year = stringr::str_extract(
      file,
      "(\\d{4})",
      group = 1
    ),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_hs6_codes <- dplyr::select(
    ref_hs6_codes,
    file_year,
    hs6 = X1,
    year_start = X2,
    year_end = X3,
    description_en = X5,
    description_fr = X6
  )

  ref_hs6_codes <- dplyr::distinct(
    ref_hs6_codes,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_hs6_codes <- ref_hs6_codes |>
    dplyr::slice_max(year_start, n = 1, by = hs6) |>
    dplyr::slice_max(file_year, n = 1, by = hs6, with_ties = FALSE)

  ref_hs6_codes <- dplyr::select(
    ref_hs6_codes,
    hs6,
    description_en,
    description_fr
  )

  ref_hs6_codes <- dplyr::mutate(
    ref_hs6_codes,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  ref_hs6_codes <- dplyr::distinct(ref_hs6_codes)

  DBI::dbWriteTable(
    con,
    "ref_hs6_codes",
    ref_hs6_codes,
    append = TRUE
  )

  return(invisible())
}
