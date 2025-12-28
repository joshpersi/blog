create_ref_states <- function() {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "CREATE TABLE IF NOT EXISTS ref_states (
         iso_2_alpha VARCHAR(2) PRIMARY KEY, 
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
    regexp = "(?i)ODPF_7_StateDesc.txt"
  )

  ref_states <- purrr::map(files, \(x) {
    readr::read_fwf(x, show_col_types = FALSE)
  })

  ref_states <- purrr::set_names(ref_states, files)

  ref_states <- purrr::list_rbind(ref_states, names_to = "file")

  ref_states <- dplyr::mutate(
    ref_states,
    file_year = stringr::str_extract(file, "(\\d{4})", group = 1),
    .before = tidyselect::everything(),
    .keep = "unused"
  )

  ref_states <- dplyr::select(
    ref_states,
    file_year,
    iso_2_alpha = X1,
    year_start = X2,
    year_end = X3,
    name_en = X4,
    name_fr = X5
  )

  ref_states <- dplyr::distinct(
    ref_states,
    dplyr::pick(!file_year),
    .keep_all = TRUE
  )

  ref_states <- ref_states |>
    dplyr::slice_max(year_start, n = 1, by = iso_2_alpha)

  ref_states <- dplyr::select(
    ref_states,
    iso_2_alpha,
    year_start,
    year_end,
    name_en,
    name_fr
  )

  ref_states <- dplyr::mutate(
    ref_states,
    dplyr::across(
      tidyselect::where(base::is.character),
      \(x) base::iconv(x, from = "latin1", to = "UTF-8")
    )
  )

  DBI::dbWriteTable(
    con,
    "ref_states",
    ref_states,
    append = TRUE
  )

  return(invisible())
}
