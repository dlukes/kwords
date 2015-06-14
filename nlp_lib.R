library(dplyr)
library(stringi)

normalize <- function(string, lc = TRUE) {
  if(lc) tolower(string) else string %>%
    # remove soft hyphens
    gsub("\U00AD", "", x = .) %>%
    stri_trans_nfc()
}

tokenize <- function(string, lc = TRUE) {
  strsplit(normalize(string, lc),
           "[[:punct:]]*\\s+|^[[:punct:]]+|[[:punct:]]+$")
}

rel_freqs <- function(tokens) {
  tokens <- unlist(tokens)
  N <- length(tokens)
  data.frame(key = tokens, stringsAsFactors = FALSE) %>%
    tbl_df %>%
    group_by(key) %>%
    summarise(rel_fq_txt = n() / N)
}
