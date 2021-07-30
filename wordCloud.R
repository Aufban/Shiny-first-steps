library(shiny)
library(tm)
library(wordcloud)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("WordCloud"),
    sidebarLayout(
        sidebarPanel(
            fileInput('file', 'Archivo TXT', placeholder= 'Seleccione el archivo', buttonLabel = 'Buscar'),
            #actionButton('update', 'Generar'),
            hr(),
            sliderInput("freq",
                        "Frecuencia Mínima:",
                        min = 1,
                        max = 50,
                        value = 10),
            
            sliderInput("num",
                        "Máximo de palabras:",
                        min = 10,
                        max = 200,
                        value = 50),
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("wordcloud", height = "800px")
        ),
    )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    words <- reactive({
        validate(
            need(!is.null(input$file), "Seleccione archivo")
        )
        text <- readLines(input$file$datapath,encoding='UTF-8')
        myCorpus = Corpus(VectorSource(text))
        myCorpus = tm_map(myCorpus, content_transformer(tolower))
        myCorpus = tm_map(myCorpus, removePunctuation)
        myCorpus = tm_map(myCorpus, removeNumbers)
        
        myDTM = TermDocumentMatrix(myCorpus,
                                   control = list(minWordLength = 1))
        
        m = as.matrix(myDTM)
        
         v = sort(rowSums(m), decreasing = TRUE)
        
        return(v)
    })
    #para poder repetir el dibujado
    wordcloud_rep <- repeatable(wordcloud)
    
    output$wordcloud <- renderPlot({
        v <- words()
        wordcloud_rep(names(v), v, scale=c(4,0.5),
                      min.freq = input$freq, max.words=input$num,
                      colors=brewer.pal(8, "Dark2"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
