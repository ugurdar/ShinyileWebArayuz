library(shiny)

# UI fonksiyonu
ui <- fluidPage(
    textOutput("text")
)

# Server fonksiyonu
server <- function(input, output) {

    output$text <- renderText({
     paste("cikti-1")
    })

    
}

# Uygulamanin calistirilmasi:
# Run App butonu bu fonksiyon varsa görünür.
shinyApp(ui = ui, server = server)
