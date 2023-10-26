#!/usr/bin/env bash

# Check for required commands
command -v convert >/dev/null 2>&1 || { echo >&2 "The script requires 'convert' from ImageMagick but it's not installed. Aborting."; exit 1; }

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-h] [-i INPUT] [-o OUTPUT] [-r RESOLUTIONS]
Resize images to multiple resolutions.

    -h              display this help and exit
    -i INPUT        input image. (Required)
    -o OUTPUT       output directory. Defaults to current directory.
    -r RESOLUTIONS  comma separated list of resolutions (e.g. "800x600,1024x768"). (Required)

Example: ${0##*/} -i image.jpg -o resized/ -r "800x600,1024x768"
EOF
}

# Initialize our own variables
INPUT_IMAGE=""
OUTPUT_DIR="./"
RESOLUTIONS=""

# Parse command line options
OPTIND=1 # Reset is necessary if getopts was used previously in the script
while getopts "h?i:o:r:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    i)  INPUT_IMAGE=$OPTARG
        ;;
    o)  OUTPUT_DIR=$OPTARG
        ;;
    r)  RESOLUTIONS=$OPTARG
        ;;
    esac
done

# Check for mandatory parameters
if [[ -z "$INPUT_IMAGE" ]]; then
    echo "Input image is required. Use -i to specify it."
    exit 1
fi

if [[ -z "$RESOLUTIONS" ]]; then
    echo "Resolutions are required. Use -r to specify them."
    exit 1
fi

# Loop through resolutions and resize
IFS=',' read -ra RES_LIST <<< "$RESOLUTIONS"
for res in "${RES_LIST[@]}"; do
    OUTPUT_FILE="${OUTPUT_DIR}/$(basename "$INPUT_IMAGE" | cut -d. -f1)-${res}.$(basename "$INPUT_IMAGE" | cut -d. -f2)"
    convert "$INPUT_IMAGE" -resize "$res" "$OUTPUT_FILE"
    echo "Saved: $OUTPUT_FILE"
done

echo "Done!"
