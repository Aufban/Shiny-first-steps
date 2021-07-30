# Ejemplo -isolate

library(shiny)

ui <- fluidPage(
    sliderInput(inputId = "num", 
                label = "Seleccione un número", 
                value = 25, min = 1, max = 100),
    textInput(inputId = "title", 
              label = "Escribe un título",
              value = "Histograma de valores normales aleatorios"),
    plotOutput("hist")
)

server <- function(input, output) {
    output$hist <- renderPlot({
        hist(rnorm(input$num), main = isolate(input$title))
    })
}

shinyApp(ui = ui, server = server)