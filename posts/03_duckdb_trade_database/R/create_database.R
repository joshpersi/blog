create_database <- function(...) {
  db_path <- fs::path("data", "can_trade.duckdb")

  if (fs::file_exists(db_path)) {
    fs::file_delete(db_path)
  }

  duckdb::duckdb(dbdir = db_path)

  scripts <- fs::dir_ls("R", regexp = "^_")

  purrr::walk(scripts, source)

  create_ref_countries()
  create_ref_hs2_codes()
  create_ref_hs6_codes()
  create_ref_hs8_codes()
  create_ref_hs10_codes()
  create_ref_provinces()
  create_ref_states()
  create_ref_units_of_measurement()
  create_fct_imports()
  create_fct_domestic_exports()
  create_fct_total_exports()

  return(invisible())
}
