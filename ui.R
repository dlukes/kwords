library(shiny)

inputTextarea <- function(inputId, value = "") {
  tagList(
    singleton(tags$head(tags$script(src = "textarea.js"))),
    tags$textarea(id = inputId,
             class = "inputtextarea",
             as.character(value)))
}

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "kwords.css")),

  # Application title
  titlePanel("KWords / polština"),

  sidebarPanel(radioButtons("word_or_lemma",
                            "Vyhodnotit na základě frekvencí:",
                            c("lemmat" = "l", "slov" = "w")),
               checkboxInput("hide_nonword",
                             "Nezobrazovat číslice a interpunkci",
                             value = TRUE)),

  mainPanel(
    tabsetPanel(
      tabPanel("Vstupní data",
               tags$br(),
               p("Vložte text a přepněte na záložku", em("Klíčová slova"), ":"),
               inputTextarea("txt", "")),

      tabPanel("Klíčová slova",
               tags$br(),
               dataTableOutput("kwords_w"))))

))
