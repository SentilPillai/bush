# Define server for application
shinyServer(function(input, output) {
    
    # Reactive expression to generate the requested distribution.
    # This is called whenever the inputs change. The output
    # functions defined below then all use the value computed from
    # this expression    
    
    pollDateData <- reactive({          
        
        subData <- subset(BushApproval, BushApproval$date >= strptime(input$dateRange[1],"%Y-%m-%d") 
                                     &  BushApproval$date <  strptime(input$dateRange[2],"%Y-%m-%d") )
        
        subData <- droplevels(subData)
        
        return(subData)
    })
    
    
    pollData <- reactive({
        
      subData <- subset(BushApproval, BushApproval$date >= strptime(input$dateRange[1],"%Y-%m-%d") 
                                   &  BushApproval$date <  strptime(input$dateRange[2],"%Y-%m-%d") )        
      subData <- droplevels(subData)
        
      subData <- subset(subData, subData$Pollster %in%  input$Poll)       
      subData <- droplevels(subData)          
      
      return(subData)
    })
    
    # Generate a plot of the data. Also uses the inputs to build
    # the plot label. 
    
    output$plot <- renderPlot({
        
        pDateData <- data.frame(pollDateData()) 
        pData <- data.frame(pollData()) 
            
        if (nrow(pollData()) > 1 )  {                           
            
            customGGplot +
                layer(data=pDateData
                     ,mapping=aes(x=date,y=approval)
                     ,stat="smooth"
                     ,stat_params=list(method="loess", formula=y ~ x)
                     ,geom="smooth"
                     ,geom_params=list(color="black")
                     ,position=position_identity()
                ) +
                layer(data=pData 
                     ,mapping=aes(x=date, y=approval, color=Pollster) 
                     ,stat="identity"
                     ,stat_params=list() 
                     ,geom="point" 
                     ,geom_params=list() 
                )
        } else {            
            customGGplot +
                layer(data=pDateData
                      ,mapping=aes(x=date,y=approval)
                      ,stat="smooth"
                      ,stat_params=list(method="loess", formula=y ~ x)
                      ,geom="smooth"
                      ,geom_params=list(color="black")
                      ,position=position_identity()
                ) 
        }
           
    })
    
    # Generate a summary of the data
    output$summary <- renderPrint({ 
   
       summary(pollData())
    
    })
    
    # Generate an HTML table view of the data
    output$table <- renderDataTable({
        
    if (nrow(pollData()) > 0 )  { 
        format(pollData())
    } else {
        format(nullDataFrame)  
    }
    
    })
    
})