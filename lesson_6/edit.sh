#!/bin/bash

usage(){
    cat << EOF
This is a file editor
Usage: $0 [file(s)] [pattern(s)] [editor option(s)]
Examples:
  $0 --help
  $0 d text.txt - removes blank lines
  $0 u text.txt - replaces small letters with large letters
  $0 -w d text.txt - writing changes to a file
  $0 -w u text.txt - writing changes to a file

EOF
    sed --help | head -n -8
}

while  [[ $# -gt 0 ]] ; do
    [[ -f $1 || -h $1 ]] && FILES+=($1) && shift && continue

    case $1 in
        --help)
            usage
            exit 0
        ;;
        -w|--write)
            ARGS=(-i)
            shift
        ;;
        -*|--*)
            ARGS+=($1)
            shift
        ;;
        d)
            TEXT=("/^$/d")
            shift
        ;;
        u)
            TEXT=("s/.*/\U&/")
            shift
        ;;
    esac
done

(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 1
(( ${#TEXT[@]} == 0 )) && echo "Patterns not specified" && exit 2
sed $(echo "${ARGS[@]} ${TEXT[@]} ${FILES[@]}")
exit 0
