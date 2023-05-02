library(pacman)

p_load(
  broom,
  ggplot2,
  palmerpenguins,
  purrr,
  tidymodels
  )

ggplot(penguins, aes(x = body_mass_g)) + 
  geom_density(, alpha = 0.5)

samples <- permutations(penguins, permute = body_mass_g, times = 10000)

ggplot(samples$splits[[2]] |> analysis(), aes(x = body_mass_g)) +
  geom_density(aes(fill = species), alpha = 0.5)

data <- samples |> 
  mutate(data = map(splits, analysis)) |> 
  unnest(data)

data |> 
  filter(species == "Adelie") |> 
  ggplot(aes(x = body_mass_g)) + 
  geom_density(aes(colour = id)) + 
  theme(legend.position = "none")


map_df(samples$splits, \(x) analysis(x))
