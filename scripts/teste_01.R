

# link do bacen para baixar os dados
# https://www.bcb.gov.br/Fis/Consorcios/Port/BD/201004Consorcios.zip

# Usando o pacote here
# install.packages("here")
library(here)

# definir o diretorio
dest_file <- "C:/Users/user/Documents/Temp"

# download zip to destination file location
url_zip <- "https://www.ssa.gov/oact/babynames/state/namesbystate.zip"

# create the placeholder file
file.dowloaded = tempfile(tmpdir=dest_file, fileext=".zip")

# download into the placeholder file
download.file(url_zip, file.dowloaded,
              method = "auto", quiet = FALSE)


# unzip the file to the temporary directory
unzip(file.dowloaded, exdir=dest_file, overwrite=TRUE)

# carregar os dados
library(readr)

babynames <- read_csv("Temp/FL.TXT", col_types = cols(`239` = col_number()))

View(babynames)






data_inicial <- "2010-01-01"
data_final <- "2021-03-01"


date <- seq(as.Date(data_inicial), 
            as.Date(data_final), 
            by = "month")




