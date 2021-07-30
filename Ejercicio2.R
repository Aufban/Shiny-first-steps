library(shiny)
library(datasets)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Ejercicio Práctico 2 con Iris"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Número de grupos 1:",
                        min = 1,
                        max = 20,
                        value = 10),
            textInput("texto","Título de Gráfico", placeholder="Escriba texto aquí"  ),
            sliderInput("num",
                        "Número de elementos en dataset :",
                        min = 10,
                        max = 150,
                        value = 30),
            actionButton('update', 'Calcular/Actualizar')
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            plotOutput( "scatter")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    new_iris <- eventReactive(input$update, {
        data("iris")
        iris <- iris[sample(nrow(iris),input$num),]
        return(iris)
    })
    output$distPlot <- renderPlot({
        hist(new_iris()$Petal.Length, 
             breaks= input$bins,
             main=isolate(input$texto),
             col='lightBlue',
             xlab='Largo de Pétalo')
        
    })
    output$scatter <- renderPlot({
        plot(new_iris()$Petal.Width, 
             new_iris()$Petal.Length,
             main='Scatterplot de Prueba',
             col=new_iris()$Species,
             pch=19,
             xlab='Ancho de Pétalo',
             ylab='Largo del Pétalo')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
