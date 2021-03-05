#!/bin/sh

pdftk *-stamped.pdf cat output all-submissions.pdf

echo "Merged all stamped submissions into all-submissions.pdf"


