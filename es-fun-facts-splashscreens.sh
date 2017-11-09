#!/usr/bin/env bash

readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly FUN_FACTS_TXT="$SCRIPT_DIR/fun_facts.txt"

function check_dependencies() {
    if ! which convert > /dev/null; then
        echo "ERROR: The imagemagick package is not installed!"
        echo "Please, install it with 'sudo apt-get install imagemagick'."
        exit 1
    fi
    if [[ -n "$DISPLAY" ]] && ! which feh  > /dev/null; then
        echo "ERROR: The feh package is not installed!"
        echo "Please, install it with 'sudo apt-get install feh'."
        exit 1
    fi
}

check_dependencies

random_fact="$(shuf -n 1 $FUN_FACTS_TXT)"
echo "$random_fact"

time convert splash4-3.png \
    -size 1000x100 \
    -interline-spacing 5 \
    -background transparent \
    -fill white \
    caption:"$random_fact" \
    -gravity south \
    -geometry +0+25 \
    -composite \
    result.png
    
feh --full-screen result.png
