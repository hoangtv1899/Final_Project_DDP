library(shiny)
library(plotly)
library(readr)
library(h2o)
shinyServer(function(input, output) {
  h2o.init()
  model<-h2o.loadModel("DeepLearning_model_R_1485633846874_1")
  h <- eventReactive(input$goButton,
                     {
                       test<-read_csv("test1.csv")
                       h1<-runif(1,1, dim(test)[1])
                     })
  output$img_ <- renderPlotly({
    test<-read_csv("test1.csv")
    temp_img<-matrix(unlist(test[h(),-1]),nrow=28, byrow=T)
    p<-plot_ly(x=1:28,y=1:28,z=(temp_img[c(28:1),]),type="heatmap",colors="Greys", showscale=F) %>%
      layout(title="Random Test Image", xaxis=list(ticks="", showticklabels=FALSE), yaxis=list(ticks="", showticklabels=FALSE))
    p
#    res<-h2o.predict(model, test_h2o)
#    res$predict
  })
  output$resultText <- renderText({
    test<-read_csv("test1.csv")
    test_h2o<-as.h2o(test[h(),-1])
    res<-h2o.predict(model, test_h2o)
    res1<-as.character(res$predict)
    paste("The classification result is:", res1[1,1])
  })
})
