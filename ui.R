
library(shiny)

shinyUI(fluidPage(

  titlePanel("General information about datasets and their variables"),

  # Sidebar with two input controls: Dataset name and variables cointained in this dataset.
  sidebarLayout(
    sidebarPanel(
      textInput("dsName", "Enter a dataset name to inspect:"),
      uiOutput("Variables"),
     h3("Help"),
     p("Enter a valid dataset name. For instance: mtcars, iris, trees, etc.  
       The dataset needs to be of the class data.frame. The dataset name is case sensitive.  
       Therefore, type mtcars, as opposed to Mtcars. "),
     p("The dataset needs to be pre-loaded into the R environment 
       in order to be used by this application. 
       This application pre-loads the following datasets for you: mtcars, iris, and trees. Other datasets also can be used, but they need to be pre-loaded manually by you."),
     p("Once a valid dataset is provided, the select control is populated with all the variables in that dataset. "),
     p("Users can choose one variable at a time to see general information about that variable as well as a number of statistics."),
     br(),
     h3("Future development"),
     p("For future development, the application could incorporate the display of sample data, such as the output of the head command 
       as well as boxplot and other type of charts appropriate for the selected variable. These extra features would be displayed on demand, responding to checkboxes selected by the user." )
     
    ),

    mainPanel(
      textOutput("datasetName"),
      textOutput("selectedDataset"),
      tableOutput("datasetInfo"),
      tableOutput("varInfo")
    )
  )
))
