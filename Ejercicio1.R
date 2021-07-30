library(shiny)
library(datasets)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Ejercicio Práctico 1 con Iris"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Número de grupos 1:",
                        min = 1,
                        max = 50,
                        value = 30),
            sliderInput("bins2",
                        "Número de grupos 2:",
                        min = 1,
                        max = 50,
                        value = 30),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            plotOutput( "distPlot2")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        data(iris) #podría ir afuera
        hist(iris$Petal.Length, 
             breaks= input$bins,
             main='Histograma de Lago de pétalo',
             col='green',
             xlab='Largo de Pétalo')
        
    })
    output$distPlot2 <- renderPlot({
        data(iris) # podría ir afuera
        hist(iris$Petal.Width, 
             breaks = input$bins2,
             main='Histograma de Ancho de pétalo',
             col='blue',
             xlab='Ancho de Pétalo')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
