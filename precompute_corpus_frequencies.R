library(dplyr)
library(tidyr)

source("lib_nlp.R")

N <- list(
  araneum_polonicum_minus = 109947123
)

read_word_list <- function(file) {
  df <- tbl_df(read.csv2(file, as.is = TRUE, header = FALSE))
  names(df) <- c("id", "key", "n")
  # df$key <- factor(tolower(df$key))
  df$key <- normalize(df$key)
  df <- select(df, key, n) %>%
    group_by(key) %>%
    summarise(rel_fq_refc = sum(n) * 1e6 / N$araneum_polonicum_minus)
}

w <- read_word_list("./data/araneum_polonicum_minus-word_list-freq>4.csv")
l <- read_word_list("./data/araneum_polonicum_minus-lemma_list-freq>4.csv")

saveRDS(w, "./data/w.RData")
saveRDS(l, "./data/l.RData")
