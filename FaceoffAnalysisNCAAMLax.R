library(tidyverse)

# Load data
player_fo_data <- read.csv("IndividualFOMensLacrosseData.csv")
team_data <- read.csv("TeamMensLacrosseData.csv")

# View tables
View(player_fo_data)
View(team_data)

# Estimation for possessions
team_data <- team_data |>
  mutate(
    est_poss = Shots + TO,
    goals_per_poss = Goals / est_poss,
    Wins = round(Win.Pct * Games, 0)
  )

# League average goals per possesion
league_avg_gpp <- mean(team_data$goals_per_poss)

# Extra possessions an >50 faceoff percentage player added
player_fo_data <- player_fo_data |>
  mutate(
    extra_poss_season = FOS.WON - (FOS.TAKEN * 0.5),
    xGA_season = extra_poss_season * league_avg_gpp,
  )

# Regression of extra goals added per season vs. faceoff percentage
ind_fo_model <- lm(xGA_season ~ PCT., data = player_fo_data)
summary(ind_fo_model)

# Plot of above regression
ggplot(player_fo_data, aes(x = PCT., y = xGA_season)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    title = "Faceoff Win Rate vs. Expected Goals Added Per Season",
    x = "Faceoff Win Percentage",
    y = "xGA Per Season"
  )

# A team's overall extra goals added
team_fo <- player_fo_data |>
  group_by(TEAM) |>
  summarise(team_xGA = sum(xGA_season)) |> 
  left_join(team_data, by = "TEAM")

# Regression of wins vs. extra goals added
team_model <- lm(Wins ~ team_xGA, data = team_fo)
summary(team_model)

# Plot of above regression
ggplot(team_fo, aes(x = team_xGA, y = Wins)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(
    title = "Expected Goals Added Per Season vs. Wins",
    x = "xGA Per Season",
    y = "Wins"
  )
