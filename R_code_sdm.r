# R_code for Species Distribution Modelling

install.packages("sdm") #installation of package Species Distribution Modelling
install.packages("rgdal") #installation of package 

# call the libraries
library(sdm)
library(rgdal) # species
library(raster) # predictors

file <- system.file("external/species.shp", package="sdm") #serve per prendere il file spicies all'interno del pacchetto sdm
file #serve per sapere qual è il percorso in cui è posto species.shp

species <- shapefile(file)
species

plot(species, pch=19)

presences <- species[species$Occurrence == 1, ] # presenze delle specie che sono presenti in species
precences
plot(presences, pch=19)

absences <- species[species$Occurrence == 0, ]
absences
plot(abscences, pch=19)

#plot together 
plot(presences, pch=19, col="blue")
points(absences, pch=19, col="red")#aggiunge un altra plotting

#predictors: variabili ambientali
path <- system.file("external", package="sdm")
path

#list the predictors
lst <- list.files(path=path, pattern="asc$", full.names = T)
lst

#stack
preds <- stack(lst)
plot(preds)

cl <- colorRampPalette(c("blue", "orange", "red", "yellow")) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(presences, pch=19)

plot(preds$temperature, col=cl)
points(presences, pch=19)

plot(preds$precipitation, col=cl)
points(presences, pch=19)

plot(preds$vegetation, col=cl)
points(presences, pch=19)

#model
# spiegare al sistema quali sono i dati che utilizzeremo
datasdm <- sdmData(train=species, predictors=preds) # sdmData crea un oggetto con i dati di train(dati a terra) e predittori
m1 <- sdm(Occurrence ~ temperature + elevation + precipitation + vegetation, data=datasdm, methods="gdm")

p1 <- predict(m1, newdata=preds)
points(presences, pch=19)

#stack 
s1 <- stack(preds, p1)
plot(s1, col=cl)
# cambio nome degli elementi dello stack
names(s1) <- c("quota", "precipitazione", "temperatura", "vegetazione", "modello di distribuzione")
plot(s1, col=cl)
