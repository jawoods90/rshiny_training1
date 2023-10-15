#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
    # date slider
    sliderInput(inputId = "dob", label = "when were you born?", 
                min = as.Date("1980-01-01", "%Y-%m-%d"), 
                max = as.Date("2023-10-15", "%Y-%m-%d"),
                value = as.Date("1990-05-20", "%Y-%m-%d"),
                timeFormat = "%Y-%m-%d"),
    
    # mutiple choice select from list cell
    selectInput(inputId = "state", label = "what is your favourite state?", 
                choice = state.name,
                multiple = TRUE),
    
    # set up user input controls
    selectInput(inputId = "dataset", label = "Dataset", choices = ls("package:datasets")),
    
    # set where to put rendered output - these are output types linked to render functions
    verbatimTextOutput(outputId = "summary"),
    tableOutput(outputId = "table"),
    dataTableOutput(outputId = "dynamictable")
)
server <- function(input, output, session) {
    # Create a reactive expression
    dataset <- reactive({
        get(input$dataset, "package:datasets")
    })
    
    output$summary <- renderPrint(summary(dataset()))
    output$table <- renderTable(dataset())
    output$dynamictable <- renderDataTable(dataset(), options = list(pageLength = 5))
}
shinyApp(ui, server)
