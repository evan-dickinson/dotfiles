#!/bin/sh
#
# usage: openWithPDFpen title options inputfile
#

tmpDir=`mktemp -d -t PDFpen`
newPath="$tmpDir/$1.pdf"
mv "$3" "$newPath"
open -a "PDFpen" "$newPath"
