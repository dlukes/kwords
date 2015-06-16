library(shiny)

inputTextarea <- function(inputId, value = "") {
  tagList(
    singleton(tags$head(tags$script(src = "textarea.js"))),
    tags$textarea(id = inputId,
             class = "inputtextarea",
             as.character(value)))
}

sidebarPanelWithLogo <- function (..., width = 4)  {
  div(class = paste0("col-sm-", width),
      tags$form(class = "well",  ...),
      img(src = "https://trnka.korpus.cz/index-doc/logo/CNK-sirka-01-col-RGB.png",
          width = "66%"))
}

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "shortcut icon", href = "favicon.ico"),
    tags$link(rel = "stylesheet", type = "text/css", href = "kwords.css")),

  titlePanel("KWords.pl"),

  sidebarPanelWithLogo(radioButtons("word_or_lemma",
                                    "Vyhodnotit na základě frekvencí:",
                                    c("lemmat (pomalejší)" = "l",
                                      "slovních tvarů" = "w")),
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
               dataTableOutput("kwords_w")),

      tabPanel("Nápověda",
               tags$br(),
               p("Viz nápověda k původní aplikaci KWords na",
                 a(href = "http://wiki.korpus.cz/doku.php/manualy:kwords",
                   target = "_blank",
                   "wiki ÚČNK."),
                 "Jako referenční korpus pro vyhodnocení klíčovosti slov je zde
                 použit korpus",
                 a(href = "http://sketch.juls.savba.sk/aranea_about/index.html",
                   target = "_blank",
                   "Araneum Polonicum Minus"),
                 "od Vlada Benka z JÚĽŠ SAV."))))

))
