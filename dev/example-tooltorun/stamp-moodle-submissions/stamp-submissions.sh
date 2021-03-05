#!/bin/bash

# This script will batch process Moodle assignment submissions, to
# convert files to PDF, and stamp them with the name and number of the
# student, to ease the grades collection.

# To be started in an unzipped folder containing subfolders, one
# subfolder for each submission

usage()
{
cat << EOF
usage: $0 [options] URL

OPTIONS:
   -?                               Show this message
EOF
}

verbose=0

while getopts 'v' OPTION; do
    case $OPTION in
        'v')
            verbose=1
            ;;
	?)	usage
	exit 2
	;;
    esac
done

tool_dirname=$(dirname $(realpath $0))

unsupported=0
error_messages=()

exec 3>&1
exec 4>&2

if ((verbose)); then
    echo "Set verbose mode"
else
    #echo "verbose=0"
    exec 1>/dev/null
    exec 2>/dev/null
fi

# echo "this should be seen if verbose"
# echo "this should always be seen" 1>&3 2>&4


# Iterate over subdirs of the current dir. Each subdir name containes
# the student's name, in the form 'John
# DOE_12345_assignsubmission_file_'

submissions=0

OIFS="$IFS"
IFS=$'\n'
# find . -iname "*_assignsubmission_file_" -type d | tail -n +2 | while read dirname
for dirname in `find . -iname "*" -type d | tail -n +2`  
do
    submissions=`expr $submissions + 1`
    
    echo "Processing $dirname"
    cd "$dirname"
    filename="$(ls *.pdf *.doc* *.odt * 2>/dev/null | head -n 1)"
    #echo "$filename"
    dirname="$(realpath $dirname)"
    dirname=$(dirname "$dirname")
    dirname=$(basename "$dirname")
    outputfilenamebase=$(echo $dirname | sed "s/_assignsubmission_file_//g" | sed "s/ /_/g")

    stamptext="$outputfilenamebase"
    extension="${filename##*.}"
    #echo $extension

    case "$extension" in
        "docx" | "odt" | "rtf" | "doc")
            echo "Processing $filename:"
            soffice --headless --convert-to pdf "$filename"
            echo $?
            pdffile=$(basename "$filename" .$extension).pdf
            mv "$pdffile" ../"$outputfilenamebase"-converted.pdf
            $tool_dirname/pdf-add-header.sh ../"$outputfilenamebase"-converted.pdf ../"$outputfilenamebase"-stamped.pdf "$stamptext"
            rm ../"$outputfilenamebase"-converted.pdf
            ;;
        "pdf")
            $tool_dirname/pdf-add-header.sh "$filename" ../"$outputfilenamebase-stamped".pdf "$stamptext"
            ;;
        "txt")
            pandoc "$filename" -o ../"$outputfilenamebase"-converted.pdf
            $tool_dirname/pdf-add-header.sh ../"$outputfilenamebase"-converted.pdf ../"$outputfilenamebase-stamped".pdf "$stamptext"
            rm ../"$outputfilenamebase"-converted.pdf
            ;;
        *)
            echo "Unsupported extension '$extension' for '$filename' in '$dirname'" >&4
            unsupported=`expr $unsupported + 1`
            error_messages+=(`echo "Error: Unsupported extension '$extension' for '$filename' in '$dirname'"`)
            ;;
    esac

    cd - >/dev/null

done
IFS="$OIFS"

exec 1>&3
exec 2>&4

echo "Found $submissions submissions to be processed"

stamped=$(ls *-stamped.pdf | wc -l)

echo "Produced $stamped stamped files" '(*-stamped.pdf)'

if [ $unsupported -gt 0 ]; then
    echo "Attention: $unsupported unsupported file found :"
    for i in "${error_messages[@]}"
    do
        echo "$i"
    done
fi

submissions=`expr $submissions - $unsupported`
if [ $submissions -ne $stamped ]; then
    echo "Error: some other files could not be processed. Something went wrong" >&2
    exit 1
fi

exit 0
