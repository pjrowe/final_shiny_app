#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        mydata    <- read.csv('stocks.csv')
        mydata$date=as.Date(mydata$date,"%m/%d/%Y")
        
        len=length(unique(mydata$ticker))
        indexticker <- reactive({input$chooseticker})
        pricetarget <- reactive({input$target})

        chosenticker=unique(mydata$ticker)[indexticker()]
        chosendata=mydata[(mydata$ticker==unique(mydata$ticker)[indexticker()]),]

        output$index=renderText({indexticker() })
        output$tick= renderText({paste(chosenticker) })
        output$days= renderText({input$time })
        lastprice=tail(chosendata$price,1)
        output$last= renderText({lastprice })
        absret=round(100*(pricetarget()/lastprice-1),1)
        output$absreturn = renderText({absret})
        annret=round(((pricetarget()/lastprice)^(1/(input$time/250))-1)*100,1)
        output$annreturn = renderText({annret })
        
        mytitle=paste("Closing Stock Price of",chosenticker)
        plot(chosendata$date,chosendata$price,main=mytitle,xlab='2019',ylab='Price R$',
             ylim=c(.95*min(chosendata$price,pricetarget()),1.05*max(chosendata$price,pricetarget())))
        lines(chosendata$date,chosendata$price,col=)
        abline(h=pricetarget())

        if(input$avg50){
            lines(chosendata$date,chosendata$fifty, col='red')
                  
        }

                
    })

})
