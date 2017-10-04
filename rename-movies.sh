#! /usr/bin/env bash
file=$(readlink -f $1);
_f=$(basename $file);
_d=$(dirname $file);

echo "Processing $1...";
data="$(/usr/local/bin/SublerCLI -source "$file" -listmetadata)";
name="$(echo "$data" | grep "^Name:" | sed -e "s/^Name: //")";
hd="$(echo "$data" | grep "^HD Video: " | sed -e "s/^HD Video: //")"

case $hd in
    2) resolution="1080p";;
    1) resolution="720p";;
    *) resolution="480p";;
esac

pattern="$name (${resolution}).mp4";

mv -v "$_d/$_f" "$_d/$pattern";
