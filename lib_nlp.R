library(dplyr)
library(stringi)
library(digest)

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
  stri_trans_nfc(paste0("<s>", string, "</s>"))
}

to_lemmas <- function(string) {
  tmp <- paste0("cache/kwords_takipi_tag.", digest(string))
  out <- paste0(tmp, ".out")
  if (!file.exists(out)) {
    writeLines(segment(string), tmp)
    system(paste("./bin/to_lemmas.py", tmp))
    unlink(tmp)
  }
  tolower(readLines(out, encoding = "UTF-8"))
}
