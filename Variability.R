library(raster)
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs
library(viridis)

setwd("C:/lab/") # Windows

sen <- brick("sentinel.png") # image import

plotRGB(sen, 1, 2, 3, stretch="lin") # plot the image by the ggRGB function
plotTGB(sen, 2, 1, 3, stretch="lin")

# standard deviation on NIR band
nir <- sen[[1]] # assegnazione della prima banda di sen a nir
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # standard deviation with function focal

# creazione di un data frame per poter utilizzare il pacchetto ggplot2. Forziamo la trasformazione del raster in un data frame
sd3d <- as.data.frame(sd3, xy=TRUE)
sd3d

# utilizzo del pacchetto ggplot2 per mettere in risalto le riflettanze
ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
ggtitle("Standard Deviation moving window 3x3") +
scale_fill_viridis()


ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
ggtitle("Standard Deviation moving window 3x3") +
scale_fill_viridis(option="cividis")

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
ggtitle("Standard Deviation moving window 3x3") +
scale_fill_viridis(option="magma")



# patchwork
p1 <- ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
ggtitle("Standard Deviation moving window 3x3") +
scale_fill_viridis(option="cividis")

p2 <- ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) +
ggtitle("Standard Deviation moving window 3x3") +
scale_fill_viridis(option="magma")

p1 + p2
