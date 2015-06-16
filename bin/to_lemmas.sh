#!/usr/bin/env bash

# Convert input text segmented into sentences (within <s/> elements) to a file
# with the corresponding lemmas, one per line.

# E.g. <s>Jest zajebiste!</s> is converted to:
# być
# zajebisty
# !

#/home/rosen/mybin/fix_tok.pl <$1 >"$1.tmp0"
#/home/rosen/mybin/icu2ut.sh "$1.tmp0" "$1.tmp1"
#/home/rosen/mybin/ipi2ic1.sed < "$1.tmp2" | /export/home/rosen/mybin/ipi2ic1.sed | /export/home/rosen/mybin/ipi2ic2.sed > "$1.tmp3"
#/home/rosen/mybin/icut2u.sh "$1.tmp3" "$1.tmp"

export LD_LIBRARY_PATH="$HOME/.local/lib"

/home/lukes/.local/bin/takipi -old -i "$1" -o "$1.out"
perl -i -CSAD -MHTML::Entities -nle 'print decode_entities($1) if /<lex disamb.*?<base>(.*?)<\/base>/' "$1.out"
