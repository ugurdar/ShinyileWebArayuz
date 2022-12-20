library(shiny)
library(ggplot2)

# grafigi cizdirmek icin
freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}

# t testi sonucundan guven araliklari ve p value'yu almak icin
t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
    sprintf(
    "p value: %0.3f\n Guven araligi:[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}
# UI fonksiyonu
ui <- fluidPage(
  fluidRow(
    column(4, 
           "Distribution 1",
           numericInput("n1", label = "n", value = 1000, min = 1),
           numericInput("mean1", label = "mu", value = 0, step = 0.1),
           numericInput("sd1", label = "sigma", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4, 
           "Distribution 2",
           numericInput("n2", label = "n", value = 1000, min = 1),
           numericInput("mean2", label = "mu", value = 0, step = 0.1),
           numericInput("sd2", label = "sigma", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4,
           "Frequency polygon",
           numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
           sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
    )
  ),
  fluidRow(
    column(9, plotOutput("hist")),
    column(3, verbatimTextOutput("ttest"))
  ),
   actionButton("action", label = "Cizdir")
  
)

# Server fonksiyonu
server <- function(input, output, session) {
  output$hist <- renderPlot({
    req(input$action)
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)

    freqpoly(x1, x2, binwidth = input$binwidth, xlim = input$range)
  }, res = 96)
  cat(1)
  
  output$ttest <- renderText({
    # req(input$action)

    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)

    t_test(x1, x2)
  })
}

# Uygulamanin calistirilmasi
# Run App butonu bu fonksiyon varsa eklenir
shinyApp(ui = ui, server = server)
