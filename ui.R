#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Stock Charts"),
    sidebarLayout(
        sidebarPanel(
            h4(textOutput("tick")),
            sliderInput("chooseticker", "Slide to choose a stock:", min = 1, max = 9, value = 4),
            sliderInput("target", "Slide to set price target:", min = 0, max = 150, value = 50),
            sliderInput("time", "Slide to set time frame (days):", min = 0, max = 500, value = 100),
            checkboxInput('avg50','50-day Average',value=TRUE),
            h4(textOutput("last")),
            h4(textOutput("ytd")),
            h5(strong(textOutput("risk"))),
            h5(strong(textOutput("up"))),
#            h5("----------------------------------------"),
            h4(tags$u("Forecast Returns")),
            h5(strong(textOutput("days"))),
            h5("Note: 250 trading days = 1 year"), 
            h5(strong(textOutput("annreturn"))),
            h5(strong(textOutput("absreturn"))),

        ),
        mainPanel(
        tabsetPanel(type='tabs',
                    tabPanel('Main Application',br(),
                        plotOutput("distPlot",click = "plot_click"),
                        h4("Click chart to check price"),
                        verbatimTextOutput("info"),
#                        h5(textOutput("risk")),
#                        submitButton("Refresh Downside/Upside"),
                    ),
                    tabPanel('Documentation',br(),
                            h3(em("About Application")),
                            h5("This application allows users to select one of 9 
                                stocks on the Bovespa exchange in Brazil and see
                                its price chart in 2019.  The app's interactivity 
                                is intuitive, but for reference, the inputs and 
                                outputs are explained below."),
                            h4("User Provided Inputs"),
                            h5("1. Slider to choose one of nine stock tickers from Bovespa exchange in Brazil"), 
                            h5("2. Slider for price target"),
                            h5("3. Slider for timeframe (days) for reaching price target"), 
                            h5("4. Tick box to display 50-day average (in red) of price chart"),
                            h5("5. Click on chart to check price at any point"),

                            h4("Outputs"),
                            h5("1. 2019 year to date price chart"),
                            h5("2. Annualized return of price target vs. last closing price"),
                            h5("3. Absolute return of price target vs. last closing price"),
                            h5("4. Price at crosshairs of mouse click on chart "),
                            h5("5. Downside risk from last price to year's ",strong("low")," in % terms"),
                            h5("6. Upside from last price to year's ",strong("high")," in % terms"),
                    ))) )))
#  https://pjrowe.shinyapps.io/final_shiny_app/
# id  1445497 – final_shiny_app 

