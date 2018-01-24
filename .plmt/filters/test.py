#!/usr/bin/env python3

from panflute import *
import re

def test(elem, doc):
    if isinstance(elem, Str):
        if (elem.text == "usual"):
            return Str("usual")

def main(doc=None):
    return run_filter(test, doc=doc)

if __name__ == "__main__":
    main()
