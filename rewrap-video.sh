#! /usr/bin/env bash
file=$(readlink -f "$1");
_f=$(basename "$file");
_d=$(dirname "$file");
_e="$(echo ${_f##*.} | tr '[:upper:]' '[:lower:]')"

echo "Processing $file...";

case $_e in
    mkv)
        echo "mkv";
        data="$(mkvinfo "$file")"
        aac="$(echo -n "$data" | grep "Codec ID:" | grep "AAC" | wc -l)";
        ;;
    mp4|m4v)
        echo "mp4";
        data="$(mp4info "$file")"
        aac=$(echo -n "$data" | grep "MPEG-4 AAC" | wc -l);
        ;;
esac

if [ "$aac" -eq 0 ]; then
    echo "No AAC format detected. Converting audio to AAC.";
    ffmpeg -i "$file" -c:v copy -c:a aac -movflags +faststart "$file".mp4
else
    echo "Converting container to MP4 and/or optimizing atoms.";
    ffmpeg -i "$file" -c copy -movflags +faststart "$file".mp4
fi;
