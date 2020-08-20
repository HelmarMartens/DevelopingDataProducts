
library(shiny)
data(mtcars)
data(iris)
data(trees)

shinyServer(function(input, output) {

  selectedDataset_var <- reactive({
   get(input$dsName)
  })

  output$Variables <- renderUI({
    if (input$dsName == ""){
      selectInput("Variables", "Select a variables to inspect:" , choices = c("No dataset provided") , multiple=FALSE)
    }
    else{
      selectInput("Variables", "Select a variables to inspect:" , choices = names(selectedDataset_var()) , multiple=FALSE)
    }
  })

   output$datasetName <- renderText({
     if (input$dsName == ""){
       paste("Dataset name:  No dataset name has been provided yet.")
     }
     else{
      paste("Dataset name: ", input$dsName)
   }
     })

    # Display information about the selected dataset
   output$datasetInfo <- renderTable({
     if (input$dsName == ""){
       Info <- c("No data to display")
       df <- data.frame(Info)
     }
     else{    
         ds <- get(input$dsName)
         Rows <- dim(ds)[1]
         Columns <- dim(ds)[2]
         Class <- class(ds)
         df <- data.frame(Rows,Columns, Class)
     }
   })

   # Display information about the selected variable
   output$varInfo <- renderTable({
     
     if (input$dsName == ""){
       Info <- c("No data to display")
       df <- data.frame(Info)
     }
     else{ 
         ds <- get(input$dsName)
         attach(ds)
         v <- get(input$Variables)
         Stat <- "Variable Name"
         Value <- as.character(input$Variables)
    
         df <- data.frame(Stat, Value)
         df[2,1] <- "Class"
         df[3,1] <- "Variable type"
         df[4,1] <- "Has NA"
         df[5,1] <- "Mean"
         df[6,1] <- "Miminum"
         df[7,1] <- "Maximum"
         df[8,1] <- "Variance"
         df[9,1] <- "Standard deviation"
    
         df[2,2] <- class(v)
         df[3,2] <- typeof(v)
         df[4,2] <- anyNA(ds$v)
         df[5,2] <- mean(v)
         df[6,2] <- min(v)
         df[7,2] <- max(v)
         df[8,2] <- var(v)
         df[9,2] <- sd(v)
    
         detach(ds)
         df
     }
   })



})
