#Ejemplo reactivo

#importando shiny
library(shiny)

#creando interfaz gráfica
ui <- fluidPage(
    sliderInput(inputId = "num", 
                label = "Seleccione un número", 
                value = 25, min = 1, max = 100),
    plotOutput("hist"),
    verbatimTextOutput("stats")
)

#manejando servidor
server <- function(input, output) {
    #elemento de datos reactivos independientes
    data <- reactive({
        rnorm(input$num)
    })
    # acá solo usamos los datos que creamos
    output$hist <- renderPlot({
        hist(data(), main=paste(input$num," Datos Aleatorios"))
    })
    output$stats <- renderPrint({
        summary(data())
    })
}

shinyApp(ui = ui, server = server)