library(shiny)
library(shinydashboard)
#################################################################
##                            App 1                            ##
#################################################################
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)


#################################################################
##                            App 2                            ##
#################################################################
ui <- dashboardPage(
  dashboardHeader(title = "Dashboard basligi"),
  dashboardSidebar(),
  dashboardBody(
    # Box fonksiyonu sat??r(fluidRow) ya sutun(column) icerisinde kullanilmali.
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      
      box(
        title = "Slider Input",
        sliderInput("slider", "Gozlem sayisi:", 1, 100, 50)
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)


#################################################################
##                            App 3                            ##
#################################################################

sidebar <- dashboardSidebar(
  sidebarSearchForm(label = "Search...", "searchText", "searchButton"),
  sliderInput("slider", "Slider:", 1, 20, 5),
  textInput("text", "Text input:"),
  dateRangeInput("daterange", "Date Range:")
)

ui <- dashboardPage(
  dashboardHeader(title = "Sidebar inputs"),
  sidebar,
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)

#################################################################
##                            App 4                            ##
#################################################################
ui <- dashboardPage(
  dashboardHeader(title = "Info boxes"),
  dashboardSidebar(),
  dashboardBody(
    # infoBoxes with fill=FALSE
    fluidRow(
      # A static infoBox
      infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
      # Dynamic infoBoxes
      infoBoxOutput("progressBox"),
      infoBoxOutput("approvalBox")
    ),
    
    # infoBoxes with fill=TRUE
    fluidRow(
      infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
      infoBoxOutput("progressBox2"),
      infoBoxOutput("approvalBox2")
    ),
    
    fluidRow(
      # Clicking this will increment the progress amount
      box(width = 4, actionButton("count", "Increment progress"))
    )
  )
)

server <- function(input, output) {
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple"
    )
  })
  output$approvalBox <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
  # Same as above, but with fill=TRUE
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE
    )
  })
}

shinyApp(ui, server)

#################################################################
##                            App 5                            ##
#################################################################
body <- dashboardBody(
  fluidRow(
    box(
      title = "Box title",
      status = "primary",
      plotOutput("plot1", height = 240)
    ),
    box(
      status = "warning",
      plotOutput("plot2", height = 240)
    )
  ),
  
  fluidRow(
    column(width = 4,
           box(
             title = "Title 1", solidHeader = TRUE, status = "primary",
             width = NULL,
             sliderInput("orders", "Orders", min = 1, max = 500, value = 120),
             radioButtons("fill", "Fill", inline = TRUE,
                          c(None = "none", Blue = "blue", Black = "black", red = "red")
             )
           ),
           box(
             width = NULL,
             background = "black",
             "A box with a solid black background"
           )
    ),
    column(width = 4,
           box(
             title = "Title 2",
             solidHeader = TRUE,
             width = NULL,
             p("Box content here")
           ),
           box(
             title = "Title 5",
             width = NULL,
             background = "light-blue",
             "A box with a solid light-blue background"
           )
    ),
    column(width = 4,
           box(
             title = "Title 3",
             solidHeader = TRUE, status = "warning",
             width = NULL,
             selectInput("spread", "Spread",
                         choices = c("0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80, "100%" = 100),
                         selected = "60"
             )
           ),
           box(
             title = "Title 6",
             width = NULL,
             background = "maroon",
             "A box with a solid maroon background"
           )
    )
  )
)

ui <- dashboardPage(
  dashboardHeader(title = "Mixed layout"),
  dashboardSidebar(),
  body
)

server <- function(input, output) {
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    if (is.null(input$orders) || is.null(input$fill))
      return()
    
    data <- histdata[seq(1, input$orders)]
    color <- input$fill
    if (color == "none")
      color <- NULL
    hist(data, col = color)
  })
  
  output$plot2 <- renderPlot({
    spread <- as.numeric(input$spread) / 100
    x <- rnorm(1000)
    y <- x + rnorm(1000) * spread
    plot(x, y, pch = ".", col = "blue")
  })
}

shinyApp(ui, server)