#!/bin/sh

# Add a header to a PDF file.

#set -x

inputfilename="$1"
outputfilename="$2"
stampmessage="$3"

pagenum=$(pdftk "$inputfilename" dump_data | grep "NumberOfPages" | cut -d":" -f2)
(for i in $(seq "$pagenum"); do echo; done) | enscript -L1 --header="$stampmessage"'||Page $% of $=' --output - | ps2pdf - | pdftk "$inputfilename" multistamp - output "$outputfilename"


