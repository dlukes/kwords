library(shiny)

source("kwords.R")

shinyServer(function(input, output) {

  output$kwords_w <- renderDataTable({
    if (nchar(input$txt) > 0) {
      withProgress(din_from_text(input$txt,
                                 input$hide_nonword,
                                 input$word_or_lemma),
                   message = "Zpracovávám data...\n",
                   value = 0)
    }
  })

})
