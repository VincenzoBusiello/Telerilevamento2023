library(raster)
# install.packages("RStoolbox")
# library(RStoolbox)

setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# data import
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist") #Viene in bianco e nero, meglio utilizzare la funzione precedente

#Dato che c'è troppa variabilità tra i pc bisogna eseguire le cose a step. 
#1) Trasformare l'immagine in una serie di valori continui (un tabulato di colori)
singlenr <- getValues(so) #getValues prende i dati di una immagine (pixels) e li trasforma in un formato tabellare che servierà poi per la funzione kmeans
singlenr #apre la tabella

#2) Definizione del numero di classi
kcluster <- kmeans(singlenr, centers = 3) #raggruppa i pixel basandosi su delle classi. Means significa medie. K-means significa un tot di medie. ciò serve a definire il centroide di ogni nuvola per determinare la distanza di un pixel ignoto dalle nuvole di pixel conosciuti. 
kcluster

#3) Riconversione dei dati numerici estrapolati dall'immagine.
soclass <- setValues(so[[1]], kcluster$cluster) # setta i valori corrispondenti spazialmente all'immagine so primo elemento mettendoci dentro le classi
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)
# classe 3 (rosso): livello energetico più alto
# classe 2 (nero): livello energetico medio
# classe 1 (giallo): livello energetio più basso

#funzione per calcolare la frequenza delle classi
frequencies <- freq(soclass)
tot = 2221440
percentages = frequencies * 100 / tot
percentages
#classe3: 21.21993 %
#classe2: 41.44658 %
#classe1: 37.33349 %

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#_________________________________________________________________________________________

# Grand Canyon Excercise

#_________________________________________________________________________________________


library(raster)

setwd("C:/lab/")
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

plotRGB(gc, 1,2,3, stretch="lin")
gcc <- crop(gc, drawExtent())# La funzione crop() serve per ritagliare l'immagine.
plotRGB(gcc, 1,2,3, stretch="lin")
ncell(gcc)# Da come risultato il numero di celle per banda della nuova immagine
singlenr <- getValues(gcc)# Cattura dei valori dei pixel dell'immagine
singlenr
kcluster <- kmeans(singlenr, centers = 3)#raggruppa i pixel basandosi su delle classi. Means significa medie. K-means significa un tot di medie. ciò serve a definire il centroide di ogni nuvola per determinare la distanza di un pixel ignoto dalle nuvole di pixel conosciuti.
kcluster
gccclass <- setValues(gcc[[1]], kcluster$cluster)# Riconversione dei dati numerici estrapolati dall'immagine.
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)
# class1: conglomerates
# class2: sandstones
# class3: volcanic rocks
frequencies <- freq(gccclass)# calcolo della frequenza delle classi
total <- ncell(gccclass) #calcolo del totale di pixels
percentages = frequencies * 100 /  total
percentages
