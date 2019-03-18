#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny App Example from RStudio"),
   p("This is a basic example of a shiny app to plot the Faithful Geyser Data"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        #add two options to plot different variables
        radioButtons("display_var",
                     "Which variable to display",
                     choices = c("Waiting time to next eruption" = "waiting",
                                 "Eruption time" = "eruptions"),
                     selected = "waiting"
        ),
        #color for the slider bar
        tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #003896}")),
        sliderInput("bins",
                   "Slide to select Number of bins:",
                   min = 1,
                   max = 50,
                   value = 20)
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     # set x-axis label depending on the value of display_var
     if (input$display_var == "eruptions") {
       xlabel <- "Eruption Time (in minutes)"
     } else if (input$display_var == "waiting") {
       xlabel <- "Waiting Time to Next Eruption (in minutes)"
     }
     # create plot
     ggplot(faithful, aes_string(input$display_var)) +
     geom_histogram(bins = input$bins,
                      fill = "#003896",
                      colour = "grey30") +
       xlab(xlabel) +
       theme_gray()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

