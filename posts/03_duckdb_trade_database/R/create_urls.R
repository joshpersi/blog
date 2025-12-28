create_urls <- function() {
  years <- 1988:2025

  trade_types <- base::c("Imp", "Tot_Exp", "Dom_Exp")

  df <- tidyr::expand_grid(trade_types, years)

  df <- dplyr::mutate(
    df,
    url = glue::glue(
      "https://www150.statcan.gc.ca/n1/pub/71-607-x/2021004/zip/CIMT-CICM_{trade_types}_{years}.zip"
    )
  )

  urls <- dplyr::pull(df, url)

  return(urls)
}
