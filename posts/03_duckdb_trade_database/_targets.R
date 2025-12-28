targets::tar_option_set(
  controller = crew::crew_controller_local(workers = 20)
)

targets::tar_source()

# Replace the target list below with your own:
base::list(
  targets::tar_target(
    name = urls,
    command = create_urls()
  ),
  targets::tar_target(
    name = data_zipped,
    command = download_data(urls),
    pattern = map(urls)
  ),
  targets::tar_target(
    name = data_unzipped,
    command = unzip_data()
  ),
  targets::tar_target(
    name = database_created,
    command = create_database(),
    cue = targets::tar_cue(mode = "always")
  )
)
