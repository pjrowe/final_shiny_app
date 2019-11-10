User Guide for Shiny Web Application for Plotting Stock Charts and Calculating Returns
========================================================
author: Phillip Rowe     
date: November 9, 2019
#### Coursera Data Science Specialization: Developing Data Products

##### *This html documentation for the web application can be found at:*

### https://pjrowe.github.io/final_shiny_app/

About Application
========================================================
This application allows users to select one of 9 stocks on the Bovespa exchange in Brazil and see its daily closing price chart through October 25, 2019

A number of important reference levels are calculated, providing information for the user to set target projections and time frames 

The app's interactivity is intuitive, and the ouptuts react immediately to changes in inputs

A simplified description of the app and its inputs and outputs is provided on a Documentation tab of the app

Note: The code excerpt and chart plot in the slides below are illustrative only (the shiny app cannot be embedded in Rmarkdown, so inputs are hardcoded in the example code)

Outputs are reactive to changes in inputs
========================================================

### User-Provided Inputs

1. Slider to choose one of nine stock tickers from the Bovespa exchange in Brazil 
2. Slider for price target
3. Slider for timeframe (days) for reaching price target 
4. Tick box to display 50-day average (in red) of price chart
5. Click on chart to check price at any point

***

### Outputs

1. Several outputs are based on historical prices (e.g., price chart, year to date return, downside to year low, upside to year high) 
2. Two are projected returns: annualized return, and ... 
3. ...absolute return, of price target vs. last closing price
4. Price in chart can be queried at crosshairs with a mouse click 

Example Server Code
========================================================


```r
mydata    <- read.csv('stocks.csv')
mydata$date=as.Date(mydata$date,"%m/%d/%Y")

indexticker <- 1
pricetarget <- 50
chosenticker=
    switch(indexticker,"MGLU3","ITUB4", "BBDC4", "BBAS3", "BTOW3", "SLED4", "PETR4", 
           "VALE4", "ABEV4")
chosendata = mydata[(mydata$ticker==chosenticker),]

first=head(chosendata$price,1)
lastprice <- tail(chosendata$price,1)
low = round(min(chosendata$price),2)
high = round(max(chosendata$price),2)

absret=round(100*(pricetarget/lastprice-1),1)
paste("Absolute return: ", absret,"%")
```

```
[1] "Absolute return:  19 %"
```

Output Charts
========================================================


```
[1] "Absolute return:  19 %"
```

```
[1] "Annualized return:  54.6 %"
```

<img src="Final_project-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="500px" height="500px" />



