#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Stock Charts"),
    sidebarLayout(
        sidebarPanel(
            h4("Stock ticker chosen:", textOutput("tick")),
            sliderInput("chooseticker", "Slide to choose a stock:", min = 1, max = 9, value = 4),
            sliderInput("target", "Slide to set price target:", min = 0, max = 500, value = 50),
            sliderInput("time", "Slide to set time frame (days):", min = 0, max = 500, value = 100),
            checkboxInput('avg50','50-day Average',value=TRUE),
            h4("Time frame to realize target"),
            h5("Note: 250 trading days = 1 year"), 
            h4(textOutput("days")),
            h4("Last price"),
            h4(textOutput("last")),
            h4("Annualized return:"),
            h4(textOutput("annreturn")),
            h4("Absolute return(%):"),
            h4(textOutput("absreturn"))
            
        ),
    mainPanel(
        plotOutput("distPlot"),

        )
    )
))

#  https://pjrowe.shinyapps.io/final_shiny_app/
# id  1445497 – final_shiny_app 

