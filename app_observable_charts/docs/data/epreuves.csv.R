library(dplyr) 
library(lubridate)
library(tidyr)
library(purrr)
library(readr)
setwd("/workspaces/observablEcharts/app_observable_charts/docs/")
paris_2024 <- read.csv("data/paris_2024.csv")
names(paris_2024)

epreuves_2024_init <- paris_2024 %>%
  select("Discipline", "Épreuve", "Phase", "Genre", "Début", "Fin") %>%
  mutate(date_debut = ymd_hms(gsub("T|Z", " ", Début), tz = "UTC"),
          date_fin = ymd_hms(gsub("T|Z", " ", Fin), tz = "UTC"))


head(epreuves_2024_init, 10)

generer_heures <- function(debut, fin) {

  if (format(debut, "%H:%M:%S") == "00:00:00") {
    debut <- debut + 0
  } else {
    debut <- floor_date(debut, "hour")
  }

  if (format(fin, "%H:%M:%S") == "00:00:00") {
    fin <- fin + 24 * 60 * 60 - 1
  } else {
    fin <- ceiling_date(fin, "hour")
  }
  heures <- seq.POSIXt(floor_date(debut, "hour"),
                      ceiling_date(fin, "hour"),
                      by = "1 hour")

  return(data.frame(Heure = format(heures, "%Y-%m-%d %H:%M")))
}


epreuves_2024 <- epreuves_2024_init %>%
  mutate(Heures = map2(date_debut, date_fin, generer_heures)) %>%
  unnest(Heures)

write_csv(epreuves_2024, "epreuves.csv")
