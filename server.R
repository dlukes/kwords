library(shiny)

source("kwords.R")

shinyServer(function(input, output) {

  output$kwords_w <- renderDataTable({
    withProgress(din_w_from_text(input$txt),
                 message = "Zpracovávám data...\n",
                 value = 0)
  })

})
