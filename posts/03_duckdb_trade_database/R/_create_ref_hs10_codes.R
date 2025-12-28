create_ref_hs10_codes <- function(...) {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_hs10_codes (
         hs10 VARCHAR(10) PRIMARY KEY,
         unit VARCHAR(3) NOT NULL,
         description_en VARCHAR NOT NULL,
         description_fr VARCHAR NOT NULL
     );"
  )

  files <- fs::dir_ls(
    path = fs::path("data", "data_unzipped"),
    recurse = TRUE,
    type = "file",
    regexp = "(?i)ODPF_1_HS10Desc.txt"
  )

  ref_hs10_codes <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE)
  })

  ref_hs10_codes <- purrr::set_names(ref_hs10_codes, files)

  ref_hs10_codes <- purrr::list_rbind(ref_hs10_codes, names_to = "file")

  ref_hs10_codes <- dplyr::mutate(
    ref_hs10_codes,
    file_year = stringr::str_extract(
      file,
      "CIMT-CICM_Imp_(\\d{4})",
      group = 1
    ),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_hs10_codes <- dplyr::select(
    ref_hs10_codes,
    file_year,
    hs10 = X1,
    year_start = X2,
    year_end = X3,
    unit = X4,
    description_en = X5,
    description_fr = X6
  )

  ref_hs10_codes <- dplyr::distinct(
    ref_hs10_codes,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_hs10_codes <- ref_hs10_codes |>
    dplyr::slice_max(year_start, n = 1, by = hs10) |>
    dplyr::slice_max(file_year, n = 1, by = hs10)

  ref_hs10_codes <- dplyr::select(
    ref_hs10_codes,
    hs10,
    unit,
    description_en,
    description_fr
  )

  ref_hs10_codes <- dplyr::mutate(
    ref_hs10_codes,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  DBI::dbWriteTable(
    con,
    "ref_hs10_codes",
    ref_hs10_codes,
    append = TRUE
  )

  return(invisible())
}
