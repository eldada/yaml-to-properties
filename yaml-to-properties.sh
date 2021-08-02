#!/usr/bin/env bash

FILE=

errorExit () {
    echo; echo "ERROR: $1"; echo
    exit 1
}

usage () {
    cat << END_USAGE

${SCRIPT_NAME} - Convert a YAML formatted file to properties format

Usage: ${SCRIPT_NAME} <options>

-f | --file <name>                : [MANDATORY] Yaml file to process
-h | --help                       : Show this usage

Examples:
========
$ ${SCRIPT_NAME} --file examples/simple.yaml

END_USAGE

    exit 1
}

checkYq () {
    [[ $(yq -V) =~ ' 4.' ]] || errorExit "Must have yq v4 installed (https://github.com/mikefarah/yq)"
}

processOptions () {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -f | --file)
                FILE="$2"
                shift 2
            ;;
            -h | --help)
                usage
                exit 0
            ;;
            *)
                usage
            ;;
        esac
    done
}

checkFileExists () {
    [ -n "${FILE}" ] || usage
    [ -f "${FILE}" ] || errorExit "File ${FILE} does not exist"
}

removeEmptyArrayAndMap () {
    TMP_FILE=$(mktemp)
    cp "$FILE" "$TMP_FILE"
    sed -e 's,\[[[:space:]]*\],,g' -e 's,{[[:space:]]*},,g' "$FILE" > "$TMP_FILE"
}

processYaml () {
    removeEmptyArrayAndMap
    yq eval '.. | select((tag == "!!map" or tag == "!!seq") | not) | (path | join(".")) + "=" + .' "$TMP_FILE"
    rm -f "$TMP_FILE"
}

main () {
    checkYq
    processOptions "$@"
    checkFileExists
    processYaml
}

######### Main #########

main "$@"
