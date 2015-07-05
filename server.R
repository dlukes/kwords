library(shiny)

source("lib_kwords.R")

shinyServer(function(input, output) {

  kwords_df <- reactive({
    if (nchar(input$txt) > 0) {
      withProgress(din_from_text(input$txt,
                                 input$hide_nonword,
                                 input$word_or_lemma),
                   message = "Zpracovávám data...\n",
                   value = 0)
    }
  })

  output$kwords_w <- renderDataTable({
    kwords_df()
  })

  output$download_csv <- downloadHandler(
                           filename = "kwords.csv",
                           content = function(file) {
                             write.csv(kwords_df(), file, row.names = FALSE)
                           }
                         )

})
