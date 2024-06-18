# Scripts para download, preparação e extração de dados climáticos do CHELSA versao 2.1 e construção de mapas de área de estudo

### Descrição

<p align="justify">

Scripts para fazer o download e preparação de dados climáticos (temperatura média, máxima, mínima e precipitacao) da base de dados CHELSA versão 2.1 (https://chelsa-climate.org/timeseries/), extração de valores climáticos para uma tabela com coordenadas geográficas e construção de mapas de área de estudo.

</p>

## Códigos

Todas os scripts sao construidos em [R language](https://www.r-project.org/) versao 4.3.2. Para rodar os scripts usei uma maquina com as seguintes especificaoes: ‘AMD® Ryzen 7 7800h with radeon graphics × 16 cores' with 40GB RAM, e 512 GB SSD. O software foi Windows 11. Scripts localizados na pasta "R".

-   `1.download_variaveis_climaticas_chelsa`: download de variaveis climaticas
-   `2.preparacao_variaveis_climaticas_chelsa`: corta para o brasil e converte os valores para graus celsius e milimetros de precipitação
-   `3.extracao_variaveis_climaticas_pontos`: extrai as variaveis climaticas para pontos com coordenadas geográficas
-   `4.mapa_area_estudo`: construção de um mapa de área de estudo

## Dados

Dado de exemplo para extrair as variáveis climáticas na pasta "data":

-   `occs_sites_exemplo.R`: coordenadas geográficas para pontos de amostragem fictícios
