library(dplyr)

source("nlp_lib.R")

w <- readRDS("./data/w.RData")
l <- readRDS("./data/l.RData")

din <- function(txt_freqs, corpus_freqs) {
  joined <- left_join(txt_freqs, corpus_freqs, by = "key")
  joined$din <- with(joined, 100 * (rel_fq_txt - rel_fq_refc) / (rel_fq_txt + rel_fq_refc))
  return(joined[order(-joined$din), ])
}

din_w_from_text <- function(txt) {
  txt %>%
    tokenize() %>%
    rel_freqs() %>%
    din(w)
}
# t <- tokenize("być być jestem i i i Być Jestem i Ładnie")
# f <- rel_freqs(t)
