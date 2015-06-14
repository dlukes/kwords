library(shiny)

source("kwords.R")

shinyServer(function(input, output) {

  output$kwords_w <- renderDataTable({
    din_w_from_text(input$txt)
  })

})
