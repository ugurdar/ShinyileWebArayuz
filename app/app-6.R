# Stock price ornegi
library(shiny)
library(dplyr)
library(quantmod)
library(highcharter)
library(DT)


ui <- fluidPage(
  titlePanel("Stock Grafigi"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Lutfen sembol giriniz."),
      textInput("symb", "Sembol", "SPY"),
      
      dateRangeInput("dates",
                     "Tarih araligi",
                     start = "2013-01-01",
                     end = as.character(Sys.Date())),
      actionButton("ciz","Grafik"),
      actionButton("tablo","Tablo"),
    ),
    mainPanel(
      highchartOutput("plot"),
      dataTableOutput("tablo")
      
      )
  )
)

server <- function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  output$plot <- renderHighchart({
    hchart(dataInput(), type = "ohlc") |> 
      hc_title(text = paste(input$symb,"-","Acilis Kapanis"))
  }) %>%
    bindEvent(input$ciz)
  
  output$tablo <- renderDataTable({
    datatable(dataInput())
  }) %>%
    bindEvent(input$tablo)
  
}

shinyApp(ui, server)
