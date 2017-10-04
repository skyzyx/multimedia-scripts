# Multimedia Scripts

I have media files. I do some multimedia processing, and these scripts help me stay organized.

You can use these to write Automator-based services, for example.

## Points of note

* I only work with MP4 containers, so these are designed to work for that.
* I am assuming you're putting metadata into your media files with [Subler](https://subler.org) or a similar tool.
* I have installed [Bash 4 on my Mac](https://github.com/skyzyx/bash-mac), and some of these scripts _may_ use Bash 4 features.

## Prerequisites

* [SublerCLI](https://bitbucket.org/galad87/sublercli) (at `/usr/local/bin/SublerCLI`)
* [Homebrew](https://brew.sh)
* Install the `Brewfile`

## Scripts

### `rename-movies.sh`

After you have added metadata using Subler (or similar), look inside the media file to find the title of the movie and its resolution, and renames the file.

**Pattern:** `${TITLE} (${RESOLUTION}).mp4` (e.g., _Something in the Public Domain (480p).mp4_)

### `rewrap-video.sh`

Many media files exist where the person who did the encoding used _H.264_ video and _AC3_ audio inside of an _MKV_ container. These are non-standard formats that are popular among open-source players. Most _devices_ (iPhone, iPad, Apple TV, Xbox, Playstation, and others) support the ISO-backed trinity of _H.264_ video and _AAC_ audio inside an _MP4_ container.

This will look inside the file for an AAC stream.

1. If it finds one, cool. It'll just make sure that its wrapped in an MP4 container and move the `moov` atom to the front of the file.

2. If not, it'll convert the audio to AAC — and also make sure that its wrapped in an MP4 container and move the `moov` atom to the front of the file.
