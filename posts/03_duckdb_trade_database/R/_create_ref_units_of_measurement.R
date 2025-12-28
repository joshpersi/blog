create_ref_units_of_measurement <- function() {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_units_of_measurement (
         unit VARCHAR(3) PRIMARY KEY, 
         year_start INTEGER NOT NULL,
         year_end INTEGER NOT NULL,
         description_en VARCHAR NOT NULL,
         description_fr VARCHAR NOT NULL
     );"
  )

  files <- fs::dir_ls(
    path = fs::path("data", "data_unzipped"),
    recurse = TRUE,
    type = "file",
    regexp = "(?i)ODPF_9_UOMDesc.txt"
  )

  ref_units_of_measurement <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE)
  })

  ref_units_of_measurement <- purrr::set_names(ref_units_of_measurement, files)

  ref_units_of_measurement <- purrr::list_rbind(
    ref_units_of_measurement,
    names_to = "file"
  )

  ref_units_of_measurement <- dplyr::mutate(
    ref_units_of_measurement,
    file_year = stringr::str_extract(file, "(\\d{4})", group = 1),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_units_of_measurement <- dplyr::select(
    ref_units_of_measurement,
    file_year,
    unit = X1,
    year_start = X2,
    year_end = X3,
    description_en = X4,
    description_fr = X5
  )

  ref_units_of_measurement <- dplyr::distinct(
    ref_units_of_measurement,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_units_of_measurement <- ref_units_of_measurement |>
    dplyr::slice_max(year_start, n = 1, by = unit)

  ref_units_of_measurement <- dplyr::select(
    ref_units_of_measurement,
    unit,
    year_start,
    year_end,
    description_en,
    description_fr
  )

  ref_units_of_measurement <- dplyr::mutate(
    ref_units_of_measurement,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  DBI::dbWriteTable(
    con,
    "ref_units_of_measurement",
    ref_units_of_measurement,
    append = TRUE
  )

  return(invisible())
}
