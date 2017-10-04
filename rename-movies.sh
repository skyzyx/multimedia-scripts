#! /usr/bin/env bash
file=$(/usr/local/opt/coreutils/libexec/gnubin/readlink -f "$1");
_f=$(/usr/local/opt/coreutils/libexec/gnubin/basename "$file");
_d=$(/usr/local/opt/coreutils/libexec/gnubin/dirname "$file");

echo "Processing $file...";
data="$(/usr/local/bin/SublerCLI -source "$file" -listmetadata)";
name="$(echo "$data" | /usr/bin/grep "^Name:" | /usr/local/opt/gnu-sed/libexec/gnubin/sed -e "s/^Name: //")";
hd="$(echo "$data" | /usr/bin/grep "^HD Video: " | /usr/local/opt/gnu-sed/libexec/gnubin/sed -e "s/^HD Video: //")"

case $hd in
    2) resolution="1080p";;
    1) resolution="720p";;
    *) resolution="480p";;
esac

pattern="$name (${resolution}).mp4";

/usr/local/opt/coreutils/libexec/gnubin/mv -v "$_d/$_f" "$_d/$pattern";
