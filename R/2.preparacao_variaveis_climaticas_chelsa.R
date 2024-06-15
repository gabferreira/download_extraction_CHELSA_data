## Preparacao de rasters de temperatura e precipitacao do CHELSA
## Recorte dos mapas globais apenas para Brasil e conversao dos dados para Celsius (temp) e milimetros (prec)
## Gabriela Alves-Ferreira (gabriela-alves77@hotmail.com)
## Data: 30/05/2024
## R version 4.3.2

## Instala pacotes
install.packages("terra")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("parallel")

## Carrega os pacotes
library(terra)
library(rnaturalearth)
library(rnaturalearthdata)
library(parallel)

# Dados disponiveis entre 1979 e 2019 (todos os meses) para temperatura (med, min, max) e 
# entre 1979 e 2019 (janeiro a junho apenas) para precipitacao 
# https://chelsa-climate.org/timeseries/

# Dados CHELSA: https://chelsa-climate.org/timeseries/
# prec 	= precipitation [kg m-2 month1/100] 
# temp	= mean temperature [k/10]
# tmax	= maximum temperature [k/10]
# tmin	= minimum temperature [k/10]
# Metadados: https://chelsa-climate.org/wp-admin/download-page/CHELSA_tech_specification_V2.pdf
# Metadados: https://chelsa-climate.org/timeseries/ 

## Lista os arquivos que vc baixou no script 1 (1.download_variaveis_climaticas_chelsa.R) para carregar todos de uma vez no R

  
  # Lembre-se de mudar o nome para o seu diretorio de trabalho
  list_tas <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas", 
                  pattern = "tas_")
  list_tas # confira se pegou o que deveria pegar
  
  list_tasmin <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min", 
                     pattern = "tasmin_")
  list_tasmin # confira se pegou o que deveria pegar
  
  list_tasmax <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max", 
                     pattern = "tasmax")
  list_tasmax # confira se pegou o que deveria pegar
  
  list_pr <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr", 
                 pattern = "pr")
  list_pr # confira se pegou o que deveria pegar
  
  
  
  ## Carrega os rasters
  tas <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas/", 
                     list_tas))
  plot(tas[[1:2]])
  
  tasmin <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min/", 
                        list_tasmin))
  plot(tasmin[[1:2]])
  
  tasmax <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max/",
                        list_tasmax))
  plot(tasmax[[1:2]])
  
  pr <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr/", 
                    list_pr))
  plot(pr[[1:2]])
  


## Cortando pelo shapefile do Brasil e convertendo as variaveis

  # Como os rasters sao muito grandes, vamos cortar tudo pelo Brazil antes de converter
  
  # Baixar o shapefile do Brasil
  brasil <- ne_countries(scale = "medium", country = "Brazil", returnclass = "sv")
  plot(brasil)
  
  tas_crop <- crop(tas, brasil, mask = T)
  plot(tas_crop)
  
  tasmin_crop <- crop(tasmin, brasil, mask = T)

  plot(tasmin_crop)
  
  tasmax_crop <- crop(tasmax, brasil, mask = T)
  plot(tasmax_crop)
  
  pr_crop <- crop(pr, brasil, mask = T)
  plot(pr_crop)
  


## Converter para Celsius (temp) e para milimetros (prec)

  parallel::detectCores() # ver quantos nucleos tem em seu pc para usar mais de um e dimunuir o tempo de processamento
  # uma dica eh nunca usar todos os cores disponiveis, use metade dos disponiveis para que seu computador nao trave totalmente
  
  tas_crop_c <- terra::app(tas_crop, function(x) (x / 10) - 273.15, 
                           cores = 3) #conversao kelvin para celsius
  plot(tas_crop_c[[1]])
  
  tasmin_crop_c <- terra::app(tasmin_crop, function(x) (x / 10) - 273.15, 
                              cores = 3) #conversao kelvin para celsius
  plot(tasmin_crop_c[[1]])
  
  tasmax_crop_c <- terra::app(tasmax_crop, function(x) (x / 10) - 273.15, 
                              cores = 3) #conversao kelvin para celsius
  plot(tasmax_crop_c[[1]])
  
  pr_crop_mm <- terra::app(pr_crop, function(x) x / 100, 
                           cores = 3) # conversao para milimetros
  plot(pr_crop_mm[[1]])


## Salvando os rasters mensais recortados para o Brasil e convertidos

  
  ## temperatura media mensal
  CHELSA_tas_brasil <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_brasil"
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas_brasil)) {
    dir.create(CHELSA_tas_brasil, recursive = TRUE)
  }
  # Salvar os rasters mensais
  writeRaster(tas_crop_c, paste0(CHELSA_tas_brasil, "/","CHELSA_brasil_temp_mean_mensal_2013_2019_V.2.1.tif"), 
              overwrite = TRUE)
  
  
  ## temperatura minima
  CHELSA_tasmin_brasil <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min_brasil"
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas_min_brasil)) {
    dir.create(CHELSA_tas_min_brasil, recursive = TRUE)
  }
  # Salvar os rasters mensais
  writeRaster(tasmin_crop_c, paste0(CHELSA_tas_min_brasil, "/", "CHELSA_brasil_temp_min_mensal_2013_2019_V.2.1.tif"), 
                                    overwrite = TRUE)
  
  
  
  ## temperatura maxima
  CHELSA_tasmax_brasil <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max_brasil"
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas_max_brasil)) {
    dir.create(CHELSA_tas_max_brasil, recursive = TRUE)
  }
  # Salvar os rasters mensais
  writeRaster(tasmax_crop_c, paste0(CHELSA_tas_max_brasil, "/", "CHELSA_brasil_temp_max_mensal_2013_2019_V.2.1.tif"),
              overwrite = TRUE)
  
  
  
  ## precipitacao
  CHELSA_pr_brasil <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr_brasil"
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_pr_brasil)) {
    dir.create(CHELSA_pr_brasil, recursive = TRUE)
  }
  # Salvar os rasters mensais
  writeRaster(pr_crop_mm, paste0(CHELSA_pr_brasil, "/", "CHELSA_brasil_pr_mensal_2013_2018_V.2.1.tif"),
                                 overwrite = TRUE)
  


## Media anual para cada variavel

  names(tas_crop_c)[[1]]
  
  # Funcao para extrair o ano do nome da camada
  extract_year <- function(x) {
    parts <- strsplit(x, "_")[[1]] # divide o os elementos de um vetor em subdivisoes 
    year <- as.numeric(parts[[4]]) # pega a quarta divisao que eh o ano
    return(year)
  }
  
  
  ## Temperatura Media
  
    # Aplicar a funcao para obter os anos que calcularei a media
    years <- sapply(names(tas_crop_c), extract_year) # pega os anos para todas as camadas
    # obter um vetor com os sete anos de interesse (2013-2019 em nosso caso)
    unique_years <- as.character(unique(years))
    
    # Criar uma lista para armazenar os rasters de medias anuais
    anual_mean_temp <- list()
    
    # Calcular a media anual
    for(i in unique_years) {
      
      # Selecionar as camadas do ano atual
      selected_layers <- tas_crop_c[[which(years == i)]]
      
      # Calcular a média
      anual_mean_temp[[i]] <- mean(selected_layers, na.rm = TRUE)
      
    }
    names(anual_mean_temp)
    anual_mean_temp <- rast(anual_mean_temp) # transforma em SpatRaster de novo
    
    # Nomear as camadas no SpatRaster
    names(anual_mean_temp) <- paste0("CHELSA_brasil_tas_mean_anual_", 
                                     unique_years, "_V.2.1")
    plot(anual_mean_temp)
    names(anual_mean_temp)
    
    # Salvar os rasters anuais
    writeRaster(anual_mean_temp, paste0(CHELSA_tas_brasil, "/", 
                                        "CHELSA_brasil_tas_mean_anual_2013_2019_V.2.1.tif"),
                overwrite = TRUE)
    
  
  
  
  ## Temperatura Minima
  
    # Aplicar a funcao para obter os anos que calcularei a media
    years <- sapply(names(tasmin_crop_c), extract_year)
    # Obter os anos unicos
    unique_years <- as.character(unique(years))
    
    # Criar uma lista para armazenar os rasters de medias anuais
    anual_mean_temp_min <- list()
    
    # Calcular a media anual
    for(i in unique_years) {
      
      # Selecionar as camadas do ano atual
      selected_layers <- tasmin_crop_c[[which(years == i)]]
      
      # Calcular a média
      anual_mean_temp_min[[i]] <- mean(selected_layers, na.rm = TRUE)
    }
    
    anual_mean_temp_min <- rast(anual_mean_temp_min) # transforma em SpatRaster de novo
    
    # Nomear as camadas no SpatRaster
    names(anual_mean_temp_min) <- paste0("CHELSA_brasil_tas_min_anual_", 
                                         unique_years, "_V.2.1")
    plot(anual_mean_temp_min)
    
    # Salvar os rasters anuais
    writeRaster(anual_mean_temp_min, paste0(CHELSA_tasmin_brasil, "/", 
                                            "CHELSA_brasil_tas_min_anual_2013_2019_V.2.1.tif"),
                                            overwrite = TRUE)
    
  
  
  ## Temperatura Maxima
  
    # Aplicar a funcao para obter os anos que calcularei a media
    years <- sapply(names(tasmax_crop_c), extract_year)
    # Obter os anos unicos
    unique_years <- as.character(unique(years))
    
    # Criar uma lista para armazenar os rasters de medias anuais
    anual_mean_temp_max <- list()
    
    # Calcular a media anual
    for(i in unique_years) {
      
      # Selecionar as camadas do ano atual
      selected_layers <- tasmax_crop_c[[which(years == i)]]
      
      # Calcular a media
      anual_mean_temp_max[[i]] <- mean(selected_layers, na.rm = TRUE)
    }
    
    anual_mean_temp_max <- rast(anual_mean_temp_max) # transforma em SpatRaster de novo
    
    # Nomear as camadas no SpatRaster
    names(anual_mean_temp_max) <- paste0("CHELSA_brasil_tas_max_anual_", 
                                        unique_years, "_V.2.1")
    plot(anual_mean_temp_max)
    
    # Salvar os rasters anuais
    writeRaster(anual_mean_temp_max, paste0(CHELSA_tasmax_brasil, "/", 
                                            "CHELSA_brasil_tas_max_anual_2013_2019_V.2.1.tif"),
                overwrite = TRUE)
  
  
  ## Precipitacao
  
    # Aplicar a funcao para obter os anos que calcularei a media
    years <- sapply(names(pr_crop_mm), extract_year)
    # Obter os anos unicos
    unique_years <- as.character(unique(years))
    
    # Criar uma lista para armazenar os rasters de medias anuais
    anual_mean_pr <- list()
    
    # Calcular a media anual
    for(i in unique_years) {
      
      # Selecionar as camadas do ano atual
      selected_layers <- pr_crop_mm[[which(years == i)]]
      
      # Calcular a media
      anual_mean_pr[[i]] <- mean(selected_layers, na.rm = TRUE)
    }
    
    anual_mean_pr <- rast(anual_mean_pr) # transforma em SpatRaster de novo
    
    # Nomear as camadas no SpatRaster
    names(anual_mean_pr) <- paste0("CHELSA_brasil_pr_anual_", 
                                   unique_years, "_V.2.1")
    plot(anual_mean_pr)
    
    # Salvar os rasters anuais
    writeRaster(anual_mean_pr, paste0(CHELSA_pr_brasil, "/", 
                                      "CHELSA_brasil_pr_anual_2013_2018_V.2.1.tif"), overwrite = TRUE)
  
  


