#! /usr/bin/env bash
file=$(readlink -f "$1");
_f=$(basename "$file");
_d=$(dirname "$file");

echo "Processing $file...";
data="$(/usr/local/bin/SublerCLI -source "$file" -listmetadata)";
title="$(echo "$data" | grep "^Name:" | sed -e "s/^Name: //")";
season="$(echo "$data" | grep "^TV Season: " | sed -e "s/TV Season: //")";
episode="$(echo "$data" | grep "^TV Episode #: " | sed -e "s/TV Episode #: //")";
hd="$(echo "$data" | grep "^HD Video: " | sed -e "s/^HD Video: //")"

case $hd in
    2) resolution="1080p";;
    1) resolution="720p";;
    *) resolution="480p";;
esac

pattern="$season.$(printf "%02d" $episode) - $title (${resolution}).mp4";

mv -v "$_d/$_f" "$_d/$pattern";
