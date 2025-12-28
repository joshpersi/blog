create_fct_total_exports <- function(...) {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "
  CREATE SEQUENCE IF NOT EXISTS total_exports_id INCREMENT BY 1 MINVALUE 1;

  CREATE TABLE IF NOT EXISTS fct_total_exports (
      id INTEGER PRIMARY KEY DEFAULT(nextval('total_exports_id')),
      year INTEGER,
      month INTEGER,
      hs8  VARCHAR(8) NOT NULL REFERENCES ref_hs8_codes(hs8),
      country VARCHAR(2) NOT NULL,
      state VARCHAR(2),
      value BIGINT NOT NULL,
      quantity BIGINT NOT NULL,
      unit VARCHAR(3) NOT NULL
  );
  "
  )

  DBI::dbExecute(
    con,
    'INSERT INTO fct_total_exports (
        year, 
        month,
        hs8,
        country,
        state,
        value,
        quantity,
        unit
  ) 
  SELECT 
      ("YearMonth/AnnéeMois" / 100)::INTEGER AS year,   
      ("YearMonth/AnnéeMois" % 100)::INTEGER AS month,
      HS8,
      "Country/Pays",
      "State/État",
      "Value/Valeur",
      "Quantity/Quantité",
      "Unit of Measure/Unité de Mesure"
  FROM 
      read_csv("data/data_unzipped/CIMT-CICM_Tot_Exp_*/ODPFN017_*.csv")'
  )

  return(invisible())
}
