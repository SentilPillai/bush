
# Define UI for the application 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Comparison of pollsters"),
    
    # left Sidebar with controls to select.
    sidebarLayout(
        sidebarPanel(
            helpText("Data set: U.S. President George W. Bush approval rating during first term ",
                     "as reported by six different pollsters."),
            
            checkboxGroupInput(inputId  = "Poll", 
                               label    = "Choose one or more pollster organization : ",
                               choices  = c("fox" = "fox", "gallup" = "gallup",
                                            "newsweek" = "newsweek", "time.cnn" = "time.cnn",
                                            "upenn" = "upenn", "zogby" = "zogby"),
                               selected = c("fox", "gallup", "newsweek",
                                            "time.cnn", "upenn", "zogby"),
                               inline   = FALSE
                               ),
            
            br(),               
            
            dateRangeInput(inputId   = "dateRange",
                           label     = "Choose poll date range : ",
                           start     = bushStartDate,
                           end       = bushEndDate,
                           min       = bushStartDate,
                           max       = bushEndDate,
                           format    = "yyyy-mm-dd",
                           separator = " to "),
            
            br(),
            
            helpText("Three tabs on the right reactively re-displays the data with ",
                     "the specified poll date range and the chosen pollsters.")
                    
        ),
        
        # Show a tabset that includes a plot, table view and summary
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", plotOutput("plot")),                       
                        tabPanel("Data table", dataTableOutput("table")),
                        tabPanel("Data summary", verbatimTextOutput("summary")) 
            )                            
        )
    )
))