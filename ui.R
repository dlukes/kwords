library(shiny)

inputTextarea <- function(inputId, value="") {
  tagList(
    singleton(tags$head(tags$script(src="textarea.js"))),
    tags$textarea(id=inputId,
             class="inputtextarea",
             as.character(value)))
}

sidebarPanelWithLogo <- function (..., width=4)  {
  div(class=paste0("col-sm-", width),
      tags$form(class="well",  ...),
      tags$br(),
      tags$br(),
      img(src="https://trnka.korpus.cz/index-doc/logo/CNC-sirka-01-col-RGB.png",
          width="66%"),
      tags$br(),
      tags$br(),
      tags$br(),
      p("Lemmatization (as part of morpho-syntactic tagging) by",
        a(href="http://nlp.pwr.wroc.pl/takipi/", target="_blank", "TaKIPI.")))
}

shinyUI(fluidPage(
  tags$head(
    tags$link(rel="shortcut icon", href="favicon.ico"),
    tags$link(rel="stylesheet", type="text/css", href="kwords.css")),

  titlePanel("KWords.pl"),

  sidebarPanelWithLogo(radioButtons("word_or_lemma",
                                    "Estimate keywords based on:",
                                    c("lemma frequencies (first run slower because of lemmatization)"="l",
                                      "word form frequencies"="w")),
                       checkboxInput("hide_nonword",
                                     "Hide numbers and punctuation",
                                     value=TRUE)),

  mainPanel(
    tabsetPanel(
      tabPanel("Input data",
               tags$br(),
               p("Paste input text and switch to the", em("Keywords"), "tab:"),
               inputTextarea("txt", "")),

      tabPanel("Keywords",
               tags$br(),
               downloadButton("download_csv", "Download as .csv"),
               tags$br(),
               tags$br(),
               dataTableOutput("kwords_w")),

      tabPanel("Help",
               tags$br(),
               p("See help for the original KWords app on the",
                 a(href="http://wiki.korpus.cz/doku.php/manualy:kwords",
                   target="_blank",
                   "CNC wiki."),
                 "The reference frequency figures against which the keyness of words in the input text is estimated are taken from the",
                 a(href="http://sketch.juls.savba.sk/aranea_about/index.html",
                   target="_blank",
                   "Araneum Polonicum Minus"),
                 "corpus, compiled by Vlado Benko (JÚĽŠ SAV)."))))

))
