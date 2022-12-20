# Basit dogrusal regresyon ornegi
library(shiny)
ui <- fluidPage(
  # En uste baslik yazar
  titlePanel("Basit Dogrusal Regresyon Analizi"),
  # Sol tarafa sidebar ekler
  sidebarLayout(
    # siderbarPanel ve mainPanelden olusur
    # siderbarPanel ekler
    sidebarPanel(
      selectInput("bagimli_deg", label = h3("Bagimli degisken"),
                  choices =names(swiss), selected = 1),
      
      selectInput("bagimsiz_deg", label = h3("Bagimsiz degisken"),
                  choices =names(swiss), selected = 1)
      
    ),
    # mainPanel ekler
    mainPanel(
      # tabset ekler
      tabsetPanel(type = "tabs",
                  # 1.panel  scatterplot
                  tabPanel("Scatterplot", plotOutput("scatterplot")), 
                  # 2.panel dagilimlar
                  tabPanel("Dagilimlar", 
                           fluidRow(
                             column(6, plotOutput("dagilim1")),
                             column(6, plotOutput("dagilim2")))
                  ),
                  # 3.panel model ozeti
                  tabPanel("Model Ozeti", verbatimTextOutput("summary")), # Regresyon ciktisi
                  tabPanel("Veri", DT::dataTableOutput('tbl')) # datatable olarak data ciktisi
                  
      )
    )
  ))

# SERVER
server <- function(input, output) {
  
  # Regressyon ciktisi
  output$summary <- renderPrint({
    fit <- lm(swiss[,input$bagimli_deg] ~ swiss[,input$bagimsiz_deg])
    names(fit$coefficients) <- c("Intercept", input$bagimsiz_deg)
    summary(fit)
  })
  
  # Datatable
  output$tbl = DT::renderDataTable({
    DT::datatable(swiss, options = list(lengthChange = FALSE))
  })
  
  
  # Scatterplot 
  output$scatterplot <- renderPlot({
    # scatter plot cizilmesi
    plot(swiss[,input$bagimsiz_deg], swiss[,input$bagimli_deg], main="Scatterplot",
         xlab=input$bagimsiz_deg, ylab=input$bagimli_deg, pch=19)
    # regresyon dogrusunun eklenmesi
    abline(lm(swiss[,input$bagimli_deg] ~ swiss[,input$bagimsiz_deg]), col="red")
    # lowess fonksiyonu snooth line grafigi cizilmesini saglar
    lines(lowess(swiss[,input$bagimsiz_deg],swiss[,input$bagimli_deg]), col="blue")
  }, height=400)
  
  
  # Histogram-1
  output$dagilim1 <- renderPlot({
    hist(swiss[,input$bagimli_deg], main="", xlab=input$bagimli_deg)
  }, height=300, width=300)
  
  # Histogram-1
  output$dagilim2 <- renderPlot({
    hist(swiss[,input$bagimsiz_deg], main="", xlab=input$bagimsiz_deg)
  }, height=300, width=300)
  
}

shinyApp(ui = ui, server = server)