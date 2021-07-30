# Ejemplo - actionButton

library(shiny)

ui <- fluidPage(
    actionButton(inputId = "clicks", 
                 label = "Clic Aquí")
)

server <- function(input, output) {
    observeEvent(input$clicks, {
        print(as.numeric(input$clicks))
    })
}

shinyApp(ui = ui, server = server)