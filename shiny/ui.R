#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Objets perdus à la SNCF"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput(
              "year",
              "Année:",
              min = 2014,
              max = 2021,
              value = 2018),
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("graph")
        )
    )
))
