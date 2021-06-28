

# https://stackoverflow.com/questions/41954183/how-can-i-extract-multiple-zip-files-and-read-those-csvs-in-r/41954523

suppressMessages(library(plyr))

# get all the zip files
zipF <- list.files(path = getwd(), pattern = "*.zip", full.names = TRUE)

# unzip all your files
ldply(
  .data = zipF, 
  .fun = unzip, 
  exdir = here::here("data", 
                     "raw_data",
                     "unziped"))



# https://theautomatic.net/2018/07/11/manipulate-files-r/
# With unlink, we can delete the selected files 
# we created above with file.create — also 
# in just one line of code.
sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              date, "Bens_Imoveis_Grupos", ".csv"), unlink)

sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              date, "Bens_Moveis_Grupos", ".csv"), unlink)

sapply(paste0(here::here("data", 
                         "raw_data",
                         "unziped"),"/", 
              "Significado_dos_campos_e_metricas", ".xlsx"), unlink)



# get the csv files
csv_files <- list.files(
  path = here::here("data", 
                    "raw_data",
                    "unziped"), 
  pattern = "*.csv")




# read the csv files
my_data <- ldply(.data = paste0(here::here("data", 
                                           "raw_data",
                                           "unziped"),"/", 
                                csv_files), 
                 .fun = read.csv2)




# -----------------------------------------------
# http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# SAVE 

# Save an object to a file
saveRDS(my_data, 
        file = here::here("data",
                          "database.rds")
        )

# # Restore the object
# database <- readRDS(file = here::here("data", 
#                           "database.rds")
#         )









