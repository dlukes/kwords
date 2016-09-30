#!/usr/bin/env python3

# Convert input text segmented into sentences (within <s/> elements) to a file
# with the corresponding lemmas, one per line.

# E.g. <s>Jest zajebiste!</s> is converted to:
# być
# zajebisty
# !

import os
import sys
import subprocess as subp

import re
import html
from html.parser import HTMLParser

html_parser = HTMLParser()
if hasattr(html_parser, "unescape"):
    unescape = html_parser.unescape
else:
    unescape = html.unescape


def main():
    inp = sys.argv[1]
    out, tmp = inp + ".out", inp + ".tmp"
    env = dict(LD_LIBRARY_PATH=os.path.join(os.path.expanduser("~"), ".local", "lib"))
    cmd = ["/home/lukes/.local/bin/takipi", "-old", "-i", inp, "-o", out]
    with subp.Popen(cmd, env=env) as proc:
        proc.wait()
    with open(out) as xml_fh, open(tmp, "wt") as plain_fh:
        for line in xml_fh:
            m = re.search(r"<lex disamb.*?<base>(.*?)</base>", line)
            if m:
                print(unescape(m.group(1)), file=plain_fh)
    os.remove(out)
    os.rename(tmp, out)


if __name__ == "__main__":
    main()
