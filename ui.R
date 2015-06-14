library(shiny)

inputTextarea <- function(inputId, value = "") {
  tagList(
    singleton(tags$head(tags$script(src = "www/textarea.js"))),
    tags$textarea(id = inputId,
             class = "inputtextarea",
             as.character(value))
  )
}

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "kwords.css")
  ),

  # Application title
  titlePanel("KWords for Polish"),

  mainPanel(
    tabsetPanel(
      tabPanel("Vstupní data",
               p("Vložte text:"),
               inputTextarea("txt", "")),

      tabPanel("Výsledek Klíčová slova (word frequencies)",
               dataTableOutput("kwords_w"))
    )
  )

))
