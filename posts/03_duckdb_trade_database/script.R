con <- DBI::dbConnect(
  drv = duckdb::duckdb(),
  fs::path("data", "can_trade.duckdb")
)

DBI::dbExecute(
  con,
  "
  CREATE VIEW IF NOT EXISTS test_view AS
  SELECT
      domestic_exports.hs8,
      country,
      sum(value) AS total_value
  FROM domestic_exports LEFT JOIN hs_codes_ref ON domestic_exports.hs8
  WHERE year IN (
    SELECT DISTINCT year
    FROM domestic_exports
    ORDER BY year DESC
    LIMIT 5
  ) AND domestic_exports.hs8 = '62102000'
  GROUP BY domestic_exports.hs8, country;
  "
)

DBI::dbGetQuery(
  con,
  "SELECT
    fct_domestic_exports.hs8,
    ref_hs8_codes.description_en,
    sum(fct_domestic_exports.value) AS total_value
FROM fct_domestic_exports LEFT JOIN ref_hs8_codes USING (hs8)
WHERE year = 2025
GROUP BY fct_domestic_exports.hs8, ref_hs8_codes.description_en
ORDER BY total_value DESC
LIMIT 6;"
)
