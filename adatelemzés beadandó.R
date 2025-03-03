library(ggplot2)
library(dplyr)
library(tidyverse)
library(readr)
library(colorspace)
library(corrplot)
library(rbin)
library(data.table)

spotify <- read.csv("data/spotify.csv", head=TRUE, sep=",")


#1. dataset, amiben csak numerikus adatok vannak
amikell = select(spotify, -c('id','name','artists','acousticness','year',"popularity",'release_date'))
  
#2. dataset, amiben m�r csak 0-1 k�z�tti sz�m adatok vannak
amikell2 =select(amikell, -c('tempo','loudness','key','duration_ms','instrumentalness'))

#�tlagolom a 0-1 sz�madatokat
vektorom = sapply(amikell2,mean)

names(vektorom)=colnames(amikell2)
barplot(vektorom)

#az �tlagok pontos �rt�ke
amikell2 %>% summarise_all(mean)
amikell %>% summarise_all(mean)

#n�pszer�s�g adott v�ltoz�nk�nt
ggplot(spotify, aes(x = speechiness, y = popularity)) +
  geom_bin2d()

ggplot(spotify, aes(x = danceability, y = popularity)) +
  geom_bin2d()

ggplot(spotify, aes(x = energy, y = popularity)) +
  geom_bin2d()

ggplot(spotify, aes(x = loudness, y = popularity)) +
  geom_bin2d()

ggplot(spotify, aes(x = acousticness, y = popularity)) +
  geom_bin2d()

ggplot(spotify, aes(x = instrumentalness, y = popularity)) +
  geom_bin2d()
###############################################################

#t�ncolhat�s�g density
ggplot(data=amikell2, aes(x=danceability)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#energikuss�g density
ggplot(data=amikell2, aes(x=energy)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#hanger� density
ggplot(data=amikell, aes(x=loudness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#besz�dess�g density
ggplot(data=amikell2, aes(x=speechiness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#akusztikuss�g density
ggplot(data=spotify, aes(x=acousticness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()
 
#hangszeress�g density
ggplot(data=amikell, aes(x=instrumentalness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#0-11-ig hozz�rendelni az �rt�keket egy Hanghoz, majd kiiratni
vektorom2 =table(amikell$key)
names(vektorom2)=c('C','C#','D','D#','E','F','F#','G','G#','A','A#','B')
barplot(vektorom2)

#korrel�ci� az �sszes 0-1 �rt�k k�z�tt
corrplot(cor(amikell))

