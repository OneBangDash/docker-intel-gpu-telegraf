#!/bin/bash

#This is so messy...

#Beat intel_gpu_top into submission
JSON=$(/usr/bin/timeout -k 3 3 /usr/bin/intel_gpu_top -J)
VIDEO_UTIL=$(echo "$JSON"|grep '"Video":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
RENDER_UTIL=$(echo "$JSON"|grep '"Render/3D":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
BLITTER_UTIL=$(echo "$JSON"|grep '"Blitter":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
VIDENHANCE_UTIL=$(echo "$JSON"|grep '"VideoEnhance":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)

#Spit out something telegraf can work with
echo "[{\"time\": $(date +%s), \"intel_gpu_video\": "$VIDEO_UTIL", \"intel_gpu_render\": "$RENDER_UTIL", \"intel_gpu_blitter\": "$BLITTER_UTIL", \"intel_gpu_video_enhance\": "$VIDENHANCE_UTIL"}]"

#Exit cleanly
exit 0