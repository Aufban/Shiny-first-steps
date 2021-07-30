library(shiny)

ui <- navbarPage(title = "Generador Aleatorio",
           
                    tabPanel(title = "Normal",
                             plotOutput("norm"),
                             actionButton("renorm", "Muestrear")
                    ),
                    tabPanel(title = "Uniforme",
                             plotOutput("unif"),
                             actionButton("reunif", "Muestrear")
                    ),
                    tabPanel(title = "Chi Cuadrado",
                             plotOutput("chisq"),
                             actionButton("rechisq", "Muestrear")
                    )
                
)

server <- function(input, output) {
    
    rv <- reactiveValues(
        norm = rnorm(500), 
        unif = runif(500),
        chisq = rchisq(500, 2))
    
    observeEvent(input$renorm, { rv$norm <- rnorm(500) })
    observeEvent(input$reunif, { rv$unif <- runif(500) })
    observeEvent(input$rechisq, { rv$chisq <- rchisq(500, 2) })
    
    output$norm <- renderPlot({
        hist(rv$norm, breaks = 30, col = "grey", border = "white",
             main = "500 valores normales")
    })
    output$unif <- renderPlot({
        hist(rv$unif, breaks = 30, col = "grey", border = "white",
             main = "500 valores uniformes")
    })
    output$chisq <- renderPlot({
        hist(rv$chisq, breaks = 30, col = "grey", border = "white",
             main = "500 valores chi cuadrado con dos grados de libertad")
    })
}

shinyApp(server = server, ui = ui)