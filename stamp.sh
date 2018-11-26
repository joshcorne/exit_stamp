#! /bin/bash

if [ $# != 2 ] ; then
echo "Usage: ./foo/ 20"
exit 1
fi

if ! test -r "$1" ; then
echo "Error opening the file: $1"
exit 2
fi

if [ $2 -gt 3 -a $2 -lt 100 ] ; then
SIZE=$2
else
echo "Font size \"$2\" is outside the permitted range (3-100)."
exit 3
fi

mkdir -p "$1"/stamped

for file in "$1"/*.jpg; do
    [ -f "$file" ] || break
    file_name=$(basename "$file" .jpg);
    echo "Generating $file_name image."
    DATETIME=$(exiftool -s -s -s -DateTimeOriginal "$file")

    # Generación y adición de los datos
    montage  -geometry +0+0  \
    -pointsize $SIZE  \
    -background black \
    -fill white       \
    -label "$DATETIME" \
    "$file" "$1/stamped/${file_name}_dated.jpg"
done

