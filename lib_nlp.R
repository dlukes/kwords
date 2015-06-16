library(dplyr)
library(stringi)

normalize <- function(string, lc = TRUE) {
  # remove soft hyphens
  string <- gsub("\U00AD", "", string) %>%
    # NFC normalize
    stri_trans_nfc() %>%
    # insert spaces between letters and (some) punctuation
    gsub("(\\p{L})(\\p{P}+)(\\s|$)", "\\1 \\2\\3", x = ., perl = TRUE) %>%
    gsub("(\\s|^)(\\p{P}+)(\\p{L})", "\\1\\2 \\3", x = ., perl = TRUE) %>%
    # separate punctuation
    gsub("(\\p{P})(?=\\p{P})", "\\1 ", x = ., perl = TRUE)
  if(lc) tolower(string) else string
}

tokenize <- function(string, lc = TRUE) {
  strsplit(normalize(string, lc), "\\s+", perl = TRUE)
}

rel_freqs <- function(tokens) {
  tokens <- unlist(tokens)
  N <- length(tokens)
  data.frame(key = tokens, stringsAsFactors = FALSE) %>%
    tbl_df %>%
    group_by(key) %>%
    summarise(rel_fq_txt = n() * 1e6 / N)
}

segment <- function(string) {
  string <- gsub("([,.\\?!:])\\s+", "\\1</s>\n<s>", string)
  paste0("<s>", string, "</s>")
}

to_lemmas <- function(string) {
  tmp <- "kwords_takipi_tag"
  tmp2 <- "kwords_takipi_tag"
  sink(tmp)
  cat(segment(string))
  sink()
  system(paste("./bin/to_lemmas.sh", tmp2))
  tolower(readLines(paste0(tmp2, ".out"), encoding = "UTF-8"))
}
