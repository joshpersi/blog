create_fct_imports <- function(...) {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "
  CREATE SEQUENCE IF NOT EXISTS imports_id INCREMENT BY 1 MINVALUE 1;

  CREATE TABLE IF NOT EXISTS fct_imports (
      id INTEGER PRIMARY KEY DEFAULT(nextval('imports_id')),
      year INTEGER,
      month INTEGER,
      hs10  VARCHAR(10) NOT NULL REFERENCES ref_hs10_codes(hs10),
      country VARCHAR(2) NOT NULL,
      province VARCHAR(2) NOT NULL,
      state VARCHAR(2),
      value BIGINT NOT NULL,
      quantity BIGINT NOT NULL,
      unit VARCHAR(3) NOT NULL
  );
  "
  )

  DBI::dbExecute(
    con,
    'INSERT INTO fct_imports (
        year, 
        month,
        hs10,
        country,
        province,
        state,
        value,
        quantity,
        unit
  ) 
  SELECT 
      ("YearMonth/AnnéeMois" / 100)::INTEGER AS year,   
      ("YearMonth/AnnéeMois" % 100)::INTEGER AS month,
      hs10,
      "Country/Pays",
      Province,
      "State/État",
      "Value/Valeur",
      "Quantity/Quantité",
      "Unit of Measure/Unité de Mesure"
  FROM 
      read_csv("data/data_unzipped/CIMT-CICM_Imp_*/ODPFN014_*.csv")'
  )

  return(invisible())
}
