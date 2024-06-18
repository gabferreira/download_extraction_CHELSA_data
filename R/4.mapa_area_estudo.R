### Construindo mapa de area de estudo
## Gabriela Alves-Ferreira (gabriela-alves77@hotmail.com)
## Data: 30/05/2024
## R version 4.3.2

## Instala pacotes
install.packages("terra")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("tmap")

## Carrega os pacotes
library(terra)
library(rnaturalearth)
library(rnaturalearthdata)
library(tmap)

## Defina seu diretorio onde estao os dados latlong
# LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
setwd("E:/Doutorado_UESC/Estagio_gestao/scripts_CENAP/data")

## Carregue seus dados com coordenadas geograficas e transforme em objeto espacial

list.files()
pontosdf <- read.csv("occs_sites_exemplo.csv", head = T, sep = ",")
head(pontosdf)

## Converter para objeto espacial SpatVector
# o nome das colunas no argumento geom = c("longitude", "latitude")
# deve ser exatamente igual ao nome no seu data.frame
names(pontosdf) # confira os nomes
pontos <- vect(pontosdf, geom = c("longitude", "latitude"), 
               crs = "+proj=longlat +datum=WGS84")
plot(pontos)
class(pontos)

## Carregue o raster que voce quer colocar como fundo
rast_exemplo <- rast("E:/shapes_rasters/rasters/uso_da_terra_2030/uso_da_terra_2030_WGS.tif")
plot(rast_exemplo)

## Baixar o shapefile do Brasil
brasil <- ne_countries(scale = "medium", country = "Brazil", returnclass = "sv")
plot(brasil)

## Voce tambem pode carregar um shapefile diretamente do seu computador
# brasil <- vect("E:/shapes_rasters/shapes/UFs_Brasil/estados_brasileiros_2010.shp")
# plot(brasil)

## Carregue o shapefile de seu interesse, nesse caso o do novo mundo
nw <- vect("E:/shapes_rasters/shapes/newworld/NWCountries.shp")
plot(nw)

## Mudando a escala de cores do raster
breaks <- seq(0, 40, by = 0.01)
colors <- colorRampPalette(c("pink","yellow","darkgreen"))(length(breaks-1))

## Faca o mapa da area de estudo
plot(rast_exemplo, 
     col = c(colors), # cores pra plotar no mapa
     range = c(0, 40), # definindo range
     axes = T, # adicionar coordenadas 
     plg = list( # parametros para desenhar a legenda
       # title = "b)", # titulo da legenda
       # title.cex = 2, # tamanho do titulo da legenda
       cex = 1), # tamanho do texto da legenda
     pax = list( # parametro para desenhar os eixos
       cex.axis = 0.8), # tamanho do texto do eixo
     cex.main = 2) # titulo dos eixos

north(xy = c(-75, 3), type = 2, cex = 0.8) # norte

sbar(700, c(-41, -32), type = "bar", below = "km", cex = 0.9, divs = 3) # barra de escala

lines(brasil, alpha = 0.3) # adiciona o shape do brasil

points(pontos, col = "black", cex=0.7, pch=16) # adiciona os pontos

b <- ext(pontos)+0.02 # fazer uma caixa pra plotar dentro do mapa pequeno com a extencao dos pontos
inset(nw, col = "lightgrey", loc = "bottomleft",  # plotar um mapa pequeno no canto
      border = "grey50", perimeter=TRUE, 
      box = b, pbox=list(col="darkgreen", lwd=2))

## Salve o mapa no seu laptop
tiff("mapa_area_estudo_Elildo.tiff", # nome da figura no laptop   
     width = 12, height = 10, unit = "in", # tamanho da figura
     res = 300) # resolucao em dpi

plot(rast_exemplo, 
     col = c(colors), # cores pra plotar no mapa
     range = c(0, 40), # definindo range
     axes = T, # adicionar coordenadas 
     plg = list( # parametros para desenhar a legenda
       # title = "b)", # titulo da legenda
       # title.cex = 2, # tamanho do titulo da legenda
       cex = 2), # tamanho do texto da legenda
     pax = list( # parametro para desenhar os eixos
       cex.axis = 1.5), # tamanho do texto do eixo
     cex.main = 2) # titulo dos eixos
north(xy = c(-75, 3), type = 2, cex = 1.2) # norte
sbar(700, c(-41, -32), type = "bar", below = "km", cex = 1.2, divs = 3) # barra de escala
lines(brasil, alpha = 0.3) # adiciona o shape do brasil
points(pontos, col = "black", cex=0.7, pch=16) # adiciona os pontos
b <- ext(pontos)+0.02 # fazer uma caixa pra plotar dentro do mapa pequeno com a extencao dos pontos
inset(nw, col = "lightgrey", loc = "bottomleft",  # plotar um mapa pequeno no canto
      border = "grey50", perimeter=TRUE, 
      box = b, pbox=list(col="darkgreen", lwd=2))

dev.off() # finalize a plotagem e salve
