library(shiny)
library(plotly)
shinyUI(fluidPage(
  titlePanel('Hand Digits Recognition using Deep Learning'),
  column(2,
    actionButton("goButton", "Classify!")
  ),
  column(6,
         plotlyOutput("img_"),
         hr(),
         verbatimTextOutput("resultText")
         )  
)
)

