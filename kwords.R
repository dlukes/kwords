library(dplyr)

source("nlp_lib.R")

w <- readRDS("./data/w.RData")
l <- readRDS("./data/l.RData")

din <- function(txt_freqs, corpus_freqs) {
  joined <- left_join(txt_freqs, corpus_freqs, by = "key")
  joined$rel_fq_refc[is.na(joined$rel_fq_refc)] <- 0
  joined$din <- with(joined, 100 * (rel_fq_txt - rel_fq_refc) / (rel_fq_txt + rel_fq_refc))
  return(joined[order(-joined$din), ])
}

log <- function(throwaway, call) {
  call
}

din_w_from_text <- function(txt) {
  txt %T>%
    log(setProgress(1/3, "Provádím tokenizaci...")) %>%
    tokenize() %T>%
    log(setProgress(2/3, "Počítám relativní frekvence v textu...")) %>%
    rel_freqs() %T>%
    log(setProgress(1, "Počítám DIN...")) %>%
    din(w)
}
# t <- tokenize("być być jestem i i i Być Jestem i Ładnie")
# f <- rel_freqs(t)
