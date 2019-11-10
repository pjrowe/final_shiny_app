#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

# we put all the data on sidebar, since scope of variables seems to be limited to section
# where they are defined; i.e., it was difficult to get ticker and price to update on 
# upside / downside calculations when these lines were under the price check
        
# future improvements could include having line from last price to price target and the 
# timeline extended by the number of days of the chosen timeframe        
        mydata    <- read.csv('stocks.csv')
        mydata$date = as.Date(mydata$date,"%m/%d/%Y")
        
        chosenticker = switch(input$chooseticker,"MGLU3","ITUB4", "BBDC4", "BBAS3", 
                              "BTOW3", "SLED4", "PETR4", "VALE4", "ABEV4")
        chosendata = mydata[(mydata$ticker==chosenticker),]

        output$tick <- renderText({paste("Stock ticker chosen:", chosenticker)})
        output$days <- renderText({paste("Days to realize target of R$", 
                                        input$target,": ",input$time) })
        first = head(chosendata$price,1)
        lastprice <- tail(chosendata$price,1)
        output$last <- renderText({paste("Last price: R$",lastprice)}) 

        low = round(min(chosendata$price),2)
        high = round(max(chosendata$price),2)
        upside = round(high/lastprice-1,3)*100
        dnside = round(low/lastprice-1,3)*100    
        ytd_= round(lastprice/first-1,3)*100

        output$ytd <- renderText({paste("Year to date : ", ytd_,"%")})
        output$risk <- renderText({paste("Downside to 2019 low of R$",low,": ", dnside,"%")})
        output$up <- renderText({paste("Upside to 2019 high of R$",high,": ", upside,"%")})
        
        absret = round(100*(input$target/lastprice-1),1)
        output$absreturn = renderText({paste("Absolute return: ", absret,"%")})
        annret = round(((input$target/lastprice)^(1/(input$time/250))-1)*100,1)
        output$annreturn = renderText({paste("Annualized return: ",annret,"%") })

        # lastdate not used, but would be useful for future improvement of extending 
        # time axes for plotting projection to price target
        lastdate = tail(chosendata$date,1)

        mytitle = paste("Closing Stock Price of", chosenticker)
        plot(chosendata$date, chosendata$price, main=mytitle, xlab='2019', ylab='Price R$',
             ylim= c(.95*min(chosendata$price, input$target), 
                     1.05*max(chosendata$price, input$target)))
        lines(chosendata$date, chosendata$price)
        abline(h = input$target,lty=3,lwd=3)
        abline(h = high, col='green',lwd=3,lty=2)
        abline(h = low, col='red',lwd=3,lty=2)
        
        if(input$avg50){
            lines(chosendata$date, chosendata$fifty, col='red')
        }
    })
    output$info <- renderText({
        tryCatch(paste0("Price check = R$",round(input$plot_click$y,2)), 
                 error = function(e) paste0("Price check = R$"))
        })
    output$help <- renderText({
        paste0("Documentation")
    })
    
})

