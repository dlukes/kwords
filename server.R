library(shiny)

source("kwords.R")

shinyServer(function(input, output) {

  output$kwords_w <- renderDataTable({
    withProgress(din_from_text(input$txt,
                               input$ignore_nonword,
                               input$word_or_lemma),
                 message = "Zpracovávám data...\n",
                 value = 0)
  })

})
