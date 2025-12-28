create_fct_domestic_exports <- function(...) {
  con <- withr::local_db_connection(
    DBI::dbConnect(
      drv = duckdb::duckdb(),
      fs::path("data", "can_trade.duckdb")
    )
  )

  DBI::dbExecute(
    con,
    "
  CREATE SEQUENCE IF NOT EXISTS domestic_exports_id INCREMENT BY 1 MINVALUE 1;

  CREATE TABLE IF NOT EXISTS fct_domestic_exports (
      id INTEGER PRIMARY KEY DEFAULT(nextval('domestic_exports_id')),
      year INTEGER,
      month INTEGER,
      hs8  VARCHAR(8) NOT NULL REFERENCES ref_hs8_codes(hs8),
      country VARCHAR(2) NOT NULL REFERENCES ref_countries(iso_2_alpha),
      province VARCHAR(2) NOT NULL REFERENCES ref_provinces(iso_2_alpha),
      state VARCHAR(2) REFERENCES ref_states(iso_2_alpha),
      value BIGINT NOT NULL,
      quantity BIGINT NOT NULL,
      unit VARCHAR(3) NOT NULL REFERENCES ref_units_of_measurement(unit)
  );
  "
  )

  DBI::dbExecute(
    con,
    'INSERT INTO fct_domestic_exports (
        year, 
        month,
        hs8,
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
      HS8,
      "Country/Pays",
      CASE
          WHEN Province = \'NF\' THEN \'NL\'
          ELSE Province
      END AS Province,
      "State/État",
      "Value/Valeur",
      "Quantity/Quantité",
      "Unit of Measure/Unité de Mesure"
  FROM 
      read_csv("data/data_unzipped/CIMT-CICM_Dom_Exp_*/ODPFN016_*.csv")'
  )

  return(invisible())
}
