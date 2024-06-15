## Download de rasters de temperatura e precipitacao do CHELSA
## Gabriela Alves-Ferreira (gabriela-alves77@hotmail.com)
## Data: 30/05/2024
## R version 4.3.2

# Pacote e
install.packages("terra")

# Carrega os pacotes
library(terra)

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

# Define anos de interesse
anos <- as.character(seq(2013, 2019, 1)) # vetor com anos
anos # check

# Define meses de interesse
meses <- seq(1, 12, 1) # vetor com meses
meses <- ifelse(meses < 10, paste0("0", meses), meses) # adiciona 0 antes dos meses menores que 10 = ex: 01, 02, etc.
meses # check

## Download

## Temperatura media

  # Crie uma pasta para armazenar os rasters de temperatura
  # Quando for criar a pasta, lembre-se que "E:/Doutorado_UESC/Estagio_gestao/Dados/"
  # eh o endereco no seu computador onde a pasta deve ser criada e que "CHELSA_tas"
  # sera a nova pasta criada no seu computador. Portanto ao modificar para adequar ao 
  # endereco do seu computador lembre de manter a parte final: "CHELSA_tas"
  
  CHELSA_tas <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas/" # decide o nome da pasta e onde cria-la
  CHELSA_tas <- "C:/SEUS_DIRETORIOS_NO_SEU_COMPUTADOR/CHELSA_tas/" # decide o nome da pasta e onde cria-la
  
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas)) {
    dir.create(CHELSA_tas, recursive = TRUE)
  }
  
  # setwd("./CHELSA_tas") # pasta para os dados de temperatura
  
  options(timeout = 5e6) # aumentando o tempo de download
  
  # Loop aninhado para baixar os dados pra todos os meses e todos os anos necessarios
  for(i in meses){
    
    for(j in anos){
      
      url <- paste0("https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/tas/CHELSA_tas_",
                    i, "_", j, "_V.2.1.tif")
      
      # criando o nome do arquivo
      destfile <- paste0("CHELSA_tas", "_", 
                         i, # definindo meses
                         "_",j, # definindo ano
                         "_V.2.1.tif") 
      
      
      # download dos dados
      download.file(url = url, destfile = paste0(CHELSA_tas, destfile), 
                    mode = "wb")
      
    } 
    
  }



## Temperatura minima

  # Crie uma pasta para armazenar os rasters de temperatura
  CHELSA_tas_min <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min/" # define o nome da pasta e onde cria-la
  
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas_min)) {
    dir.create(CHELSA_tas_min, recursive = TRUE)
  }
  
  options(timeout = 5e6) # aumentando o tempo de download
  
  # Loop aninhado para baixar os dados pra todos os meses e todos os anos necessarios
  for(i in meses){
    
    for(j in anos){
      
      url <- paste0("https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/tasmin/CHELSA_tasmin_",
                    i, "_", j, "_V.2.1.tif")
      
      # criando o nome do arquivo
      destfile <- paste0("CHELSA_tasmin", "_", 
                         i, # definindo meses
                         "_",j, # definindo ano
                         "_V.2.1.tif") 
      
      # download dos dados
      download.file(url = url, destfile = paste0(CHELSA_tas_min, destfile), 
                    mode = "wb")
      
    } 
    
  }
  



## Temperatura maxima

  # Crie uma pasta para armazenar os rasters de temperatura
  CHELSA_tas_max <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max/" # define o nome da pasta e onde cria-la
  
  # Comando que cria a pasta SE ela ainda nao tiver sido criada
  if (!dir.exists(CHELSA_tas_max)) {
    dir.create(CHELSA_tas_max, recursive = TRUE)
  }
  
  options(timeout = 5e6) # aumentando o tempo de download
  
  meses <- meses[6:12]
  
  # Loop aninhado para baixar os dados pra todos os meses e todos os anos necessarios
  for(i in meses){
    
    for(j in anos){
      
      url <- paste0("https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/tasmax/CHELSA_tasmax_",
                    i, "_", j, "_V.2.1.tif")
      
      # criando o nome do arquivo
      destfile <- paste0("CHELSA_tasmax", "_", 
                         i, # definindo meses
                         "_",j, # definindo ano
                         "_V.2.1.tif") 
      
      # download dos dados
      download.file(url = url, destfile = paste0(CHELSA_tas_max, destfile), mode = "wb")
      
    } 
    
  }
  



## Precipitation

  # a precipitacao esta disponivel apenas ate junho de 2019
  # Vamos redefinir os anos aqui para se adaptar aos dados de prec
  anos <- as.character(seq(2013, 2018, 1)) # vetor com anos
  anos # check
  anos <- anos[[6]]
  
  # Define meses de interesse
  meses <- seq(1, 12, 1) # vetor com meses
  meses <- ifelse(meses < 10, paste0("0", meses), meses) # adiciona 0 antes dos meses menores que 10 = ex: 01, 02, etc.
  meses # check
  
  CHELSA_pr <- "E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr/" # decide o nome da pasta e onde cria-la
  
  # Comando que cria a pasta SE ela ainda nao tiver sido criada no comando anterior
  if (!dir.exists(CHELSA_pr)) {
    dir.create(CHELSA_pr, recursive = TRUE)
  }
  
  # setwd("./CHELSA_pr") # pasta para os dados de temperatura
  options(timeout = 5e6) # aumentando o tempo de download
  
  for(i in meses){
    
    for(j in anos){
      
      url <- paste0("https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/GLOBAL/monthly/pr/CHELSA_pr_",
                    i, "_", j, "_V.2.1.tif")
      
      # criando o nome do arquivo
      destfile <- paste0("CHELSA_pr", "_", 
                         i, # definindo meses
                         "_",j, # definindo ano
                         "_V.2.1.tif") 
      
      # download dos dados
      download.file(url = url, destfile = paste0(CHELSA_pr, destfile), mode = "wb")
      
    } 
    
  }
  

