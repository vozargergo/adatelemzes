library(data.table)
library(ggplot2)
library(rbin)

spotify <- fread("data/spotify.csv")

ggplot(spotify, aes(x = speechiness, y = popularity)) +
  geom_bin2d()

spotify[, dance_cat := dplyr::case_when(
  danceability < 0.25 ~ 1,
  danceability < 0.5 ~ 2,
  danceability < 0.75 ~ 3,
  TRUE ~ 4
)]

spotify[, tempo_cat := dplyr::case_when(
  tempo < 100 ~ 1,
  tempo < 150 ~ 2,
  tempo < 200 ~ 3,
  TRUE ~ 4
)]

ggplot(spotify, aes(x = dance_cat, y = tempo_cat, fill = popularity)) +
  geom_tile()


spotify[, dance_cat := dplyr::case_when(
  danceability < 0.25 ~ 1,
  danceability < 0.5 ~ 2,
  danceability < 0.75 ~ 3,
  TRUE ~ 4
)]

spotify[, tempo_cat := dplyr::case_when(
  tempo < 100 ~ 1,
  tempo < 150 ~ 2,
  tempo < 200 ~ 3,
  TRUE ~ 4
)]

ggplot(spotify, aes(x = dance_cat, y = tempo_cat, fill = popularity)) +
  geom_tile()