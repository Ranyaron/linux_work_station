#!/bin/bash

usage(){
    cat << EOF
This is a file editor
Usage: $0 [file(s)] [pattern(s)] [editor option(s)]
Examples:
  $0 --help
  $0 -d

EOF
   #sed --help | head -n -8
}

while  [[ $# -gt 0 ]] ; do
    [[ -d $1 ]] && dir+=($1) && shift && continue
    [[ -f ${dir}$1 ]] && echo "file ${dir}$1 exists" && exit 4
    FILES+="${dir}$1 " && shift  && continue
    CHMOD=(sudo chmod +x $FILES)
#    [[ -f $FILES ]] && echo "file est" && exit 4

    case $1 in
        --help)
            usage
            exit 0
        ;;
        -*|--*)
            ARGS+=($1)
            shift
        ;;
        *)
            TEXT+=($1)
            shift
        ;;
        -d)
            QWE=${FILES[@]}
            shift
        ;;
    esac
done

(( ${#dir[@]} == 0 )) && echo "not directory" && exit 1
(( ${#dir[@]} > 1 )) && echo "directory > 1" && exit 1
(( ${#FILES[@]} == 0 )) && echo "not files" && exit 2
#(( ${#FILES[@]} == "/" )) && echo "/ files" && exit 3

#touch ${QWE[@]}
touch $(echo "${ARGS[@]} ${TEXT[@]} ${QWE[@]} ${CHMOD[@]} ${FILES[@]}")
exit 0
