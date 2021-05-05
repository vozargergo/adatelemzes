library(ggplot2)
library(dplyr)
library(tidyverse)
library(readr)
library(colorspace)
library(corrplot)

spotify <- read.csv("data/spotify.csv", head=TRUE, sep=",")


#1. dataset, amiben csak numerikus adatok vannak
amikell = select(spotify, -c('id','name','artists','acousticness','year',"popularity",'release_date'))
  
#2. dataset, amiben már csak 0-1 közötti szám adatok vannak
amikell2 =select(amikell, -c('tempo','loudness','key','duration_ms','instrumentalness'))

#átlagolom a 0-1 számadatokat
vektorom = sapply(amikell2,mean)

names(vektorom)=colnames(amikell2)
barplot(vektorom)

#az átlagok pontos értéke
amikell2 %>% summarise_all(mean)
amikell %>% summarise_all(mean)

#táncolhatóság
ggplot(data=amikell2, aes(x=danceability)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()
#energikusság
ggplot(data=amikell2, aes(x=energy)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#hangerõ
ggplot(data=amikell, aes(x=loudness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#beszédesség
ggplot(data=amikell2, aes(x=speechiness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#akusztikusság
ggplot(data=spotify, aes(x=acousticness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#hangszeresség
ggplot(data=amikell, aes(x=instrumentalness)) +geom_density() +geom_histogram(aes(y=..density..), alpha=0.5) + theme_minimal()

#0-11-ig hozzárendelni az értékeket egy Hanghoz, majd kiiratni
vektorom2 =table(amikell$key)
names(vektorom2)=c('C','C#','D','D#','E','F','F#','G','G#','A','A#','B')
barplot(vektorom2)

#korreláció az összes 0-1 érték között
corrplot(cor(amikell))

