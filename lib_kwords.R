library(dplyr)

source("lib_nlp.R")

refc <- list(
  w = readRDS("./data/w.RData"),
  l = readRDS("./data/l.RData"))

din <- function(txt_freqs, corpus_freqs) {
  joined <- left_join(txt_freqs, corpus_freqs, by = "key")
  joined$rel_fq_refc[is.na(joined$rel_fq_refc)] <- 0
  joined$din <- with(joined, 100 * (rel_fq_txt - rel_fq_refc) / (rel_fq_txt + rel_fq_refc))
  return(joined[order(-joined$din), ])
}

log <- function(throwaway, call) {
  call
}

remove_nonwords <- function(din_tbl) {
  din_tbl[!grepl("^[[:punct:][:digit:]]+$", din_tbl$key), ]
}

din_from_text <- function(txt, hide_nonword = TRUE, word_or_lemma = "w") {
  if (word_or_lemma == "w") {
    setProgress(1/4, "Provádím tokenizaci...")
    tokens <- tokenize(txt)
  } else {
    setProgress(1/4, "Provádím tokenizaci a lemmatizaci...")
    tokens <- to_lemmas(txt)
  }

  din_tbl <- tokens %T>%
    log(setProgress(1/2, "Počítám relativní frekvence v textu...")) %>%
    rel_freqs() %T>%
    log(setProgress(2/3, "Počítám DIN...")) %>%
    din(refc[[word_or_lemma]])

  if (hide_nonword) {
    setProgress(.9, "Odstraňuji z výsledků číslice a interpunkci...")
    din_tbl <- remove_nonwords(din_tbl)
  }

  if (word_or_lemma == "w") {
      names(din_tbl) <- c("slovní tvar", "i.p.m. v textu", "i.p.m. v ref. korpusu",
                          "DIN")
  } else {
      names(din_tbl) <- c("lemma", "i.p.m. v textu", "i.p.m. v ref. korpusu",
                          "DIN")
  }

  return(din_tbl)
}

# t <- "być być jestem i i i Być Jestem i Ładnie"
