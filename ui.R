library(shiny)

inputTextarea <- function(inputId, value = "") {
  tagList(
    singleton(tags$head(tags$script(src = "www/textarea.js"))),
    tags$textarea(id = inputId,
             class = "inputtextarea",
             as.character(value)))
}

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "kwords.css")),

  # Application title
  titlePanel("KWords / polština"),

  sidebarPanel("Nastavení",
               radioButtons("word_or_lemma",
                            "Vyhodnotit na základě frekvencí:",
                            c("slov" = "w", "lemmat" = "l")),
               checkboxInput("ignore_nonword",
                             "Ignorovat číslice a interpunkci",
                             value = TRUE)),

  mainPanel(
    tabsetPanel(
      tabPanel("Vstupní data",
               p("Vložte text:"),
               inputTextarea("txt", "")),

      tabPanel("Klíčová slova",
               tags$br(),
               dataTableOutput("kwords_w"))))

))
