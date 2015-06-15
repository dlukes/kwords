library(dplyr)
library(pryr)
library(stringi)

normalize <- function(string, lc = TRUE) {
  # remove soft hyphens
  string <- gsub("\U00AD", "", string) %>%
    # NFC normalize
    stri_trans_nfc()
  if(lc) tolower(string) else string
}

tokenize <- function(string, lc = TRUE, ignore_nonword = TRUE) {
  tokens <- strsplit(normalize(string, lc),
                     "[[:punct:]]*\\s+|^[[:punct:]]+|[[:punct:]]+$")
  if (ignore_nonword) {
    return(lapply(tokens,
                  partial(Filter,
                          Negate(partial(grepl, "[[:punct:][:digit:]]")))))
  } else {
    return(tokens)
  }
}

rel_freqs <- function(tokens) {
  tokens <- unlist(tokens)
  N <- length(tokens)
  data.frame(key = tokens, stringsAsFactors = FALSE) %>%
    tbl_df %>%
    group_by(key) %>%
    summarise(rel_fq_txt = n() * 1e6 / N)
}
