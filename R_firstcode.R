# My first code in Git Hub
# Let's install the raster package


#Installa il pacchetto raster. 
#Si usano le virgolette tra cui inserire il nome del pacchetto ("nomepacchetto") perché R sta dialogando con qualcosa di esterno ai propri server. 
install.packages("raster")


# Funzione per utilizzare la libreria.
library(raster) 


# La funzione setwd serve per impostare la cartella di lavoro. Per windows è meglio creare la cartella direttamente in C:/nomecartella/ 
#così da non inserire un percorso troppo lungo. Quando si usa direttamente R e non R_Studio bisogna cambiare gli slash del percorso perché altrimenti implode(?).
setwd("C:/lab/")


# assegno brick("p224r63_2011_masked.grd") a l2011 così da non richiamare ogni volta la funzione.
l2011 <- brick("p224r63_2011_masked.grd") 


# si crea una serie di grafici che caricano le varie bande in cui è divisa l'immagine. Viene data una leggenda di default. 
#B1: oggetti che assorbono il blu in un determinato colore. B2: verde. B3: rosso. B4: infrarosso vicino B5: infrarosso medio B6 infrarosso termico B7 infrarosso termico.
plot(l2011) 

#Per cambiare il colore dei grafici si può utilizzare la funzione seguente in cui si inserisce il vettori di colori che si vogliono utilizzare. 
#Fuori dalla funzione si inserisce il numero delle sfumature, in questo caso 100.
#Si assegna il tutto all'oggetto "cl".
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)


#per ricolorare le bande di l2011 bisogna rifare il plot ed impostare la gamma di colori contenuta in "cl" tramite l'argomento "col".
plot(l2011, col=cl)


#si può generare un plot anche scegliendo solamente un solo elemento (quindi una sola banda). Per utilizzare solo un elemento bisogna metterlo tra due parentesi quadre
#si usano due parentesi quadre perché il plot è bidimensionale. [[4]] è l'elemento numero 4 ovvero la banda del vicino infrarosso.
plot(l2011[[4]], col=cl)
#si può fare anche utilizzando il nome della banda (che si ottiene inviando solamente l'oggetto) che si collega con $
plot(l2011$B4_sre, col=cl)

#associa l'intera banda ad un oggetto
nir <- l2011[[4]]
#oppure
nir <- l2011$B4_sre
