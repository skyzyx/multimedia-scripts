#! /usr/bin/env bash
file=$(/usr/local/opt/coreutils/libexec/gnubin/readlink -f "$1");
_f=$(/usr/local/opt/coreutils/libexec/gnubin/basename "$file");
_d=$(/usr/local/opt/coreutils/libexec/gnubin/dirname "$file");
_e="$(echo ${_f##*.} | /usr/local/opt/coreutils/libexec/gnubin/tr '[:upper:]' '[:lower:]')"

echo "Processing $file...";

case $_e in
    mkv)
        echo "mkv";
        data="$(mkvinfo "$file")"
        aac="$(echo -n "$data" | /usr/bin/grep "Codec ID:" | /usr/bin/grep "AAC" | /usr/local/opt/coreutils/libexec/gnubin/wc -l)";
        ;;
    mp4|m4v)
        echo "mp4";
        data="$(mp4info "$file")"
        aac=$(echo -n "$data" | /usr/bin/grep "MPEG-4 AAC" | /usr/local/opt/coreutils/libexec/gnubin/wc -l);
        ;;
esac

if [ "$aac" -eq 0 ]; then
    echo "No AAC format detected. Converting audio to AAC.";
    ffmpeg -i "$file" -c:v copy -c:a aac -movflags +faststart "$file".mp4
else
    echo "Converting container to MP4 and/or optimizing atoms.";
    ffmpeg -i "$file" -c copy -movflags +faststart "$file".mp4
fi;
