# Reaktif
# Reaktif programlamannin ana fikri, bir girdi degistiginde ilgili tum ciktilarin
# otomatik olarak guncellenmesi mantigina dayanir.
# eventReactive(),reactive(),observe(),observeEvent()

library(shiny)
library(ggplot2)
library(dplyr)

# Ornek veri seti.
dt <- data.frame(x=runif(1000), y=runif(1000))

ui <- fluidPage(
  numericInput("y_ekseni", label=NULL, value=1, min=1),
  actionButton("ciz","Cizdir"),
  
  plotOutput("graph")
)

server <- function(input,output){
  plot_reactive <- reactive({
    plot <- ggplot(dt, aes(x,y)) +
      geom_point() +
      scale_y_continuous(limits = function(x){
        c(min(x), input$y_ekseni)
      })
    
  
    return(plot)
  })
  
  output$graph <- renderPlot({
    plot_reactive()
  })  %>% 
    # Cizdir'e cizdirir. Bu eklenmez ise ilk cizdir'e basildiktan sonra
    # her bir numericInput degistiginde grafik de otomatik olarak degisir.
    bindEvent(input$ciz)
}

shinyApp(ui=ui, server=server)
