# Ejemplo-eventReactive

library(shiny)

ui <- fluidPage(
    sliderInput(inputId = "num", 
                label = "Seleccione un número", 
                value = 25, min = 1, max = 100),
    actionButton(inputId = "go", 
                 label = "Actualizar"),
    plotOutput("hist")
)

server <- function(input, output) {
    data <- eventReactive(input$go, {
        rnorm(input$num) 
    })
    
    output$hist <- renderPlot({
        hist(data(), main=paste(input$num," Datos Aleatorios"))
    })
}

shinyApp(ui = ui, server = server)