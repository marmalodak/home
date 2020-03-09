#!/usr/bin/env bash

set -e
set -x
set -u
set -o pipefail
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

xmlfile=${1%.adoc}.xml
mdfile=${1%.adoc}.md

asciidoctor -b html5 "$1"
asciidoctor-pdf "$1"
asciidoctor -b docbook "$1"
#iconv -t utf8 ${xmlfile} | pandoc -f docbook -t gfm | iconv -f utf-8 > ${mdfile}
pandoc -t gfm -f docbook --wrap=none -o ${mdfile} ${xmlfile} 

set +e
set +x
set +u

exit 0

# https://gist.github.com/cheungnj/38becf045654119f96c87db829f1be8e
comments = "
# Adapted from https://tinyapps.org/blog/nix/201701240700_convert_asciidoc_to_markdown.html

# Convert asciidoc to docbook using asciidoctor

$ asciidoctor -b docbook foo.adoc

# foo.xml will be output into the same directory as foo.adoc

# Convert docbook to markdown

$ pandoc -f docbook -t gfm foo.xml -o foo.md

# Unicode symbols were mangled in foo.md. Quick workaround:

$ iconv -t utf-8 foo.xml | pandoc -f docbook -t gfm | iconv -f utf-8 > foo.md

# Pandoc inserted hard line breaks at 72 characters. Removed like so:

$ pandoc -f docbook -t gfm --wrap=none # don't wrap lines at all

$ pandoc -f docbook -t gfm --columns=120 # extend line breaks to 120
"
