library(shiny)
data(iris)

app <- shinyApp(
    ui <- fluidPage(
        titlePanel("Iris data"),

        sidebarPanel(
            radioButtons("color",
                        label = "Select histogram color",
                        choices = c("Red", "Green", "Blue"),
                        selected = "Red")
        ),

        mainPanel(
            textOutput("text1"),
            plotOutput(outputId = "myhist")
        )
    ),

    server <- function(input, output) {
        output$text1 <- renderText({
            paste("Histogram color is", input$color)
        })

        output$myhist <- renderPlot({
            x <- iris$Sepal.Length
            x <- na.omit(x)
            hist(x,
                col = input$color,
                main = "Histogram of sepal length",
                breaks = seq(min(x), max(x), length.out = 20),
                xlab = "Sepal length")
        })
    }
)

runApp(app)