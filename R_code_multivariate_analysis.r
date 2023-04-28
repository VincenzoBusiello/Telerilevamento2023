library(raster)
library(ggplot2)

setwd("C:/lab/") 
sen <- brick("sentinel.png")
sen
plot(sen)

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]]) # stack of the bands of sen. Elimination of the fourth band.

plot(sen2) 

pairs(sen2) # view of correlation between the bands of sen2

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained
summary(pca)

# correlation with original bands
pca

# pc map
pci <- predict(sen2, pca, index=c(1:2))

plot(pci[[1]])

# ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()

#focal sd
focal <- focal(pci[[1]], matrix(1/9, 3, 3), fun=sd)


# speeding up analyses
# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# then repeat the PCA analysis









