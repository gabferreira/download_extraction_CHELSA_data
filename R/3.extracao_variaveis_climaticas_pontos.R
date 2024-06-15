### Extraindo variaveis climaticas de um raster para um dataframe de pontos
## Gabriela Alves-Ferreira (gabriela-alves77@hotmail.com)
## Data: 30/05/2024
## R version 4.3.2

# pacote
install.packages("terra")
library(terra)

# defina seu diretorio onde estao os dados latlong
# LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
setwd("E:/Doutorado_UESC/Estagio_gestao/download_extraction_CHELSA_data/data")

## carregue seus dados com coordenadas geograficas e transforme em objeto espacial

  list.files()
  pontosdf <- read.csv("occs_sites_exemplo.csv", head = T, sep = ",")
  head(pontosdf)
  
  # converter para objeto espacial SpatVector
  # o nome das colunas no argumento geom = c("longitude", "latitude")
  # deve ser exatamente igual ao nome no seu data.frame
  names(pontosdf) # confira os nomes
  pontos <- vect(pontosdf, geom = c("longitude", "latitude"), 
                 crs = "+proj=longlat +datum=WGS84")
  plot(pontos)
  class(pontos)


## Carregando os rasters mensais e anuais
# lista os arquivos para carregar todos de uma vez no R

  ## Mensais
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_tas_mensal <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_brasil", 
                  pattern = "mensal_")
  list_tas_mensal # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_tasmin_mensal <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min_brasil", 
                     pattern = "mensal_")
  list_tasmin_mensal # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_tasmax_mensal <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max_brasil", 
                     pattern = "mensal_")
  list_tasmax_mensal # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_pr_mensal <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr_brasil", 
                 pattern = "mensal_")
  list_pr_mensal # confira se pegou o que deveria pegar
  
  ## Anuais
  list_tas_anual <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_brasil", 
                         pattern = "anual_")
  list_tas_anual # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_tasmin_anual <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min_brasil", 
                            pattern = "anual_")
  list_tasmin_anual # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_tasmax_anual <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max_brasil", 
                            pattern = "anual_")
  list_tasmax_anual # confira se pegou o que deveria pegar
  
  ## LEMBRE-SE DE MUDAR PARA O ENDERECO DO SEU COMPUTADOR
  list_pr_anual <- dir("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr_brasil", 
                        pattern = "anual_")
  list_pr_anual # confira se pegou o que deveria pegar
  
  # carrega os rasters mensais
  tas_mensal <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_brasil/", 
                     list_tas_mensal))
  plot(tas_mensal)
  
  tasmin_mensal <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min_brasil/", 
                        list_tasmin_mensal))
  plot(tasmin_mensal)
  
  tasmax_mensal <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max_brasil/",
                        list_tasmax_mensal))
  plot(tasmax_mensal)
  
  pr_mensal <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr_brasil/", 
                    list_pr_mensal))
  plot(pr_mensal)
  
  # carrega os rasters mensais
  tas_anual <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_brasil/", 
                            list_tas_anual))
  plot(tas_anual)
  
  tasmin_anual <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_min_brasil/", 
                               list_tasmin_anual))
  plot(tasmin_anual)
  
  tasmax_anual <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_tas_max_brasil/",
                               list_tasmax_anual))
  plot(tasmax_anual)
  
  pr_anual <- rast(paste0("E:/Doutorado_UESC/Estagio_gestao/Dados/CHELSA_pr_brasil/", 
                           list_pr_anual))
  plot(pr_anual)


## extraindo os dados climaticos pros pontos

  # mensal
  tas_mensal_points <- terra::extract(tas_mensal, pontos, method = 'simple')
  head(tas_mensal_points)
  
  tasmin_mensal_points <- terra::extract(tasmin_mensal, pontos, method = 'simple')
  head(tasmin_mensal_points)
  
  tasmax_mensal_points <- terra::extract(tasmax_mensal, pontos, method = 'simple')
  head(tasmax_mensal_points)
  
  pr_mensal_points <- terra::extract(pr_mensal, pontos, method = 'simple')
  head(pr_mensal_points)
  
  # anual
  tas_anual_points <- terra::extract(tas_anual, pontos, method = 'simple')
  head(tas_anual_points)
  
  tasmin_anual_points <- terra::extract(tasmin_anual, pontos, method = 'simple')
  head(tasmin_anual_points)
  
  tasmax_anual_points <- terra::extract(tasmax_anual, pontos, method = 'simple')
  head(tasmax_anual_points)
  
  pr_anual_points <- terra::extract(pr_anual, pontos, method = 'simple')
  head(pr_anual_points)
  
  # transforma em data.frame para salvar
  # mensal df
  tas_mensal_points_df <- data.frame(pontosdf, tas_mensal_points)
  head(tas_mensal_points_df)
  
  tasmin_mensal_points_df <- data.frame(pontosdf, tasmin_mensal_points)
  head(tasmin_mensal_points_df)
  
  tasmax_mensal_points_df <- data.frame(pontosdf, tasmax_mensal_points)
  head(tasmax_mensal_points_df)
  
  pr_mensal_points_df <- data.frame(pontosdf, pr_mensal_points)
  head(pr_mensal_points_df)
  
  # anual df
  tas_anual_points_df <- data.frame(pontosdf, tas_anual_points)
  head(tas_anual_points_df)
  
  tasmin_anual_points_df <- data.frame(pontosdf, tasmin_anual_points)
  head(tasmin_anual_points_df)
  
  tasmax_anual_points_df <- data.frame(pontosdf, tasmax_anual_points)
  head(tasmax_anual_points_df)
  
  pr_anual_points_df <- data.frame(pontosdf, pr_anual_points)
  head(pr_anual_points_df)
  

## salvando em csv

  # Lembre-se de mudar para o seu diretorio de trabalho
  setwd("E:/Doutorado_UESC/Estagio_gestao/Dados") # define o diretorio para salvar
  write.table(tas_mensal_points_df, "tas_mean_mensal_cenap_cams.csv")
  write.table(tasmin_mensal_points_df, "tas_max_mensal_cenap_cams.csv")
  write.table(tasmax_mensal_points_df, "tas_min_mensal_cenap_cams.csv")
  write.table(pr_mensal_points_df, "pr_mensal_cenap_cams.csv")
  
  write.table(tas_anual_points_df, "tas_mean_anual_cenap_cams.csv")
  write.table(tasmin_anual_points_df, "tas_max_anual_cenap_cams.csv")
  write.table(tasmax_anual_points_df, "tas_min_anual_cenap_cams.csv")
  write.table(pr_anual_points_df, "pr_anual_cenap_cams.csv")
  