library(shiny)
# widgets'lara asagidaki linkten ulasilabilir.
# https://shiny.rstudio.com/gallery/widget-gallery.html

# Render fonksiyonu:
# Ciktinin hangi girdileri kullandigini otomatik olarak izleyen ozel bir
# reaktif baglam kurar

# R kodudunun ciktisini bir web sayfasinda goruntulemek icin HTML'e donusturur.

# UI 
ui <- fluidPage(
  # 1 - checkbox
  # checkbox fonksiyonunda parametreler
  # id, label (checkbox'da ne yazacagi), value TRUE ya da FALSE 
  # checkboxInput("b", label = "secenek A-1", value = FALSE),
  # textOutput("text_checkb")
  
  # # 2 - checkbox group
  # checkboxlar birden fazla secenegi de barindirabilir.
  # checkboxGroupInput("check_grup", label = h2("Checkbox"),
  #                    choices = list("secenek 1" = 1, "secenek 2" = 2, "secenek 3" = "a"),
  #                    selected = c("a")),
  # textOutput("text_checkb_grup")
  # 
  # # 3 - radiobuttons
  # # Farkli secenekler icerisinden tek secenek sectirilmek istendiginde kullanilabilir
  # radioButtons("radio", label = h3("Radiobuttons"),
  #              choices = list("Secenek 1" = 1, "Secenek 2" = 2, "Secenek 3" = 3),
  #              selected = 1),
  # textOutput("text_radio")
  # 
  # # 4 - numericinput
  # numericInput("numeric", label = h3("Numeric girdi"), value = 5, min=3, max=7,  step = 2),
  # textOutput("text_numeric")
  # 
  # # 5 - textinput
  # textInput("text_girdi", label = h3("Text girdi"), value = "Text giriniz"),
  # textOutput("text_girdi"),
  # 
  # 6 - select box
  # selectInput("selectbox", label = h3("Select box"),
  #             choices = unique(mtcars$cyl),
  #             selected = 1),
  # textOutput('text_selectbox')
  # SelectInput icerisinde birden fazla secim yapilabilir bunun
  # icin multiple=TRUE olarak degistirilmelidir.
  # selectInput(
  #   "selectbox_multi", "Select mtcars cyl", unique(mtcars$cyl),
  #   multiple = TRUE
  # )
  # 
  # # 7 - slider
  # sliderInput("slider", label = h3("Slider"), min = 0,
  #             max = 100, value = 50),
  # textOutput('text_slider'),
  # # 
  # # # 8 - slider range
  # sliderInput("slider_range", label = h3("Slider Range"), min = 0,
  #                  max = 100, value = c(40, 60)),
  # textOutput('text_slider_range')
  # 
  # # 9- action button
  actionButton("action", label = "Action"),
  # # req(input$action) ile ciktilar kontrol edilebilir.
  
  # 10- fluidRow fonksiyonu ile layout ayarlama.
  fluidRow(
    column(6,
           sliderInput("slider", label = h3("Slider"), min = 0,
                        max = 100, value = 50, width = '70%')),
    column(6,
           sliderInput("slider_range", label = h3("Slider Range"), min = 0,
                            max = 100, value = c(40, 60)))
  )
   )

# Server fonksiyonu
server <- function(input, output) {
  # 1 - checkbox
  # output$text_checkb <- renderText({
  #   input$checkbox
  # })
  # 2 - checkbox group
  output$text_checkb_grup <- renderText({
    input$check_grup
  })
  # # 3 - radiobuttons
  output$text_radio <- renderText({
    input$radio
  })
  # # 4 - numericinput
  output$text_numeric <- renderText({
    input$numeric
  })
  # # 5 - numericinput
  output$text_girdi <- renderText({
    input$text_girdi
  })
  # # 6 - selectbox
  output$text_slider <- renderText({
    input$slider
  })
  # # 7 - slider
  output$text_slider_range <- renderText({
    input$slider_range
  })

}

# Uygulamanin calistirilmasi
# Run App butonu bu fonksiyon varsa eklenir
shinyApp(ui = ui, server = server)
