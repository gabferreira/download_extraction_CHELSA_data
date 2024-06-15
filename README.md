# Download, preparação e extração de dados climáticos do CHELSA versao 2.1

### Descrição

<p align="justify">

Scripts para fazer o download e preparação de dados climáticos (temperatura média, máxima, mínima e precipitacao) da base de dados CHELSA versão 2.1 (https://chelsa-climate.org/timeseries/) e extração de valores climáticos para uma tabela com coordenadas geográficas.

</p>

## codigos

Todas os scripts sao construidos em [R language](https://www.r-project.org/) versao 4.3.2. Para rodar os scripts usei uma maquina com as seguintes especificaoes: ‘AMD® Ryzen 7 7800h with radeon graphics × 16 cores' with 40GB RAM, e 512 GB SSD. O software foi Windows 11. 

-   `1.download_variaveis_climaticas_chelsa`: download de variaveis climaticas
-   `2.preparacao_variaveis_climaticas_chelsa`: corta para o brasil e converte os valores para graus celsius e milimetros de precipitação
-   `3.extracao_variaveis_climaticas_pontos`: extrai as variaveis climaticas para pontos com coordenadas geográficas

## data

Dado de exemplo para extrair as variáveis climáticas:

-   `occs_sites_exemplo.R`: coordenadas geográficas para pontos de amostragem fictícios
