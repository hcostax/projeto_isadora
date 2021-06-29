
# https://rpubs.com/mclaire19/ggplot2-custom-themes


# building a theme plot

# # The palette with grey:
# liberumpalette <- c("#fb6404", "#515464", "#b9b6b8",
#                     "#f27f47", "#748c94", "#fcb47c")



suppressMessages(library(tidyverse))       # collection of packages
suppressMessages(library(scales))          # Scale Functions for Visualization

suppressMessages(library(extrafont))       # Pacote para customizar a fonte nos plots

# funcao para importar a fonte
#font_import("./")
#y
# ao importar, o sistema pedira 
# que confirme a importacao
# rode essa letra "y" para confirmar

# carregar as fontes para customizacao
loadfonts(device = "win")


# ------

# Define custom_theme() function

theme_custom <- function(){
  
  font <- "Myriad Pro"            # assign font family up front
  
  #theme_minimal() %+replace%    # replace elements we want to change
    
    theme(
      
      #grid elements
      panel.grid.major = element_blank(),    # strip major gridlines
      panel.grid.minor = element_blank(),    # strip minor gridlines
      axis.ticks = element_blank(),          # strip axis ticks
      
      # since theme_minimal() already strips axis lines, 
      # we don't need to do that again
      
      # text elements
      plot.title = element_text(             # title
        family = font,            # set font family
        size = 20,                # set font size
        face = 'bold',            # bold typeface
        color = "#fb6404",        # set font color
        hjust = 0.5,              # middle align*
        vjust = 2),               # raise slightly*
      
      # *The value of hjust and vjust are only defined between 0 and 1:
      # 0 means left-justified
      # 1 means right-justified
      # 0.5 means middle-justified
      
      plot.subtitle = element_text(          # subtitle
        family = font,                       # font family
        color= "#2e2e2e",                    # set font color
        size = 12,
        hjust = 0.5,              # middle align*
        vjust = 2),                          # font size
      
      plot.caption = element_text(           # caption
        family = font,                       # font family
        size = 9,                            # font size
        face = "italic",                     # italic typeface
        colour = "#4c4c4c",                  # set font color
        hjust = 1),                          # right align
      
      axis.title = element_text(             # axis titles
        family = font,                       # font family
        face = 'bold',                       # bold typeface
        color = "#2e2e2e",                   # set font color
        size = 10),                          # font size
      
      axis.text = element_text(              # axis text
        family = font,                       # axis family
        color = "#2e2e2e",                   # set font color
        size = 9),                           # font size
      
      axis.text.x = element_text(            # margin for axis text
        color = "#2e2e2e",                   # set font color
        margin=margin(5, b = 10)),
      
      axis.text.y = element_text(            # margin for axis text
        color = "#2e2e2e",                   # set font color
        margin=margin(10, b = 20)),
      
      legend.position="bottom",              # set the legend position
      
      legend.title = element_blank(),        # set NULL legend tittle
      
      legend.text = element_text(
        colour="#2e2e2e",                    # set legend text color 
        family = font                       # font family
      )
      
      
      # since the legend often requires manual tweaking 
      # based on plot content, don't define it here
    )
}
