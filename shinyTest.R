app = shinyApp(
    ui = fluidPage(
        selectInput("inputId", "your choice", "cyl", selected = NULL, multiple = FALSE, selectize = TRUE, width = NULL, size = NULL),
        plotOutput("plot")
        ),

    server = function(input, output) {

            newDF = reactive({
                mtcars %>% 
                group_by_(input$inputId) %>%
                summarise(te = mean(drat))
            })

            output$plot <- renderPlot({
                newDF() %>%
                ggplot(aes_string(input$inputId, "te")) +
                geom_point()
            })
    }
)
app
