library(dplyr)
library(tidyr)

read_word_list <- function(file) {
  df <- tbl_df(read.csv2(file, as.is = TRUE, header = FALSE))
  names(df) <- c("id", "key", "freq")
  # df$key <- factor(tolower(df$key))
  df$key <- tolower(df$key)
  df <- select(df, key, freq) %>%
    group_by(key) %>%
    summarise(freq = sum(freq))
}

w <- read_word_list("./data/araneum_polonicum_minus-word_list-freq>4.csv")
l <- read_word_list("./data/araneum_polonicum_minus-lemma_list-freq>4.csv")

saveRDS(w, "./data/w.RData")
saveRDS(l, "./data/l.RData")
