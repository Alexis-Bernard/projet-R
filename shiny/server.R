#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(readr)
library(shiny)
library(ggplot2)
library(dplyr)
library(ggforce)

objets_trouves <- read_delim(
  "../data/parsed-objets-trouves-restitution.csv",
  delim = ";",
  escape_double = FALSE,
  trim_ws = TRUE,
  show_col_types = FALSE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    output$graph <- renderPlot({
      
      title <- paste("8 types d'objets les plus perdus en", input$year)
      
      objets_trouves_year <- subset(objets_trouves, year = 2015)
      
      objets_trouves_year <- objets_trouves_year %>% 
        group_by(`Nature d'objets`) %>% 
        summarise(amount = n()) %>% 
        arrange(desc(amount)) %>% 
        slice(1:8)
      
      ggplot(subset(objets_trouves_year, year = input$year),
             aes(x0 = 0, y0 = 0, r0 = 0, r = 1,
                 amount = amount,
                 fill = `Nature d'objets`)
      ) +
        ggtitle(title) +
        xlab("") +
        ylab("") +
        coord_fixed() +
        geom_arc_bar(stat = "pie") +
        theme_minimal() +
        theme(
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()
        )

    })
})
