#!/bin/bash

JSON=$(/usr/bin/timeout -k 3 3 /usr/bin/intel_gpu_top -J)
VIDEO_UTIL=$(echo "$JSON" | grep '"Video/0":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
RENDER_UTIL=$(echo "$JSON" | grep '"Render/3D/0":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
BLITTER_UTIL=$(echo "$JSON" | grep '"Blitter/0":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
VIDENHANCE_UTIL=$(echo "$JSON" | grep '"VideoEnhance/0":' -A 1 | tail -1 | grep busy | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
GPU_WATT_UTIL=$(echo "$JSON" | grep '"GPU":' | tail -1 | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
PKG_WATT_UTIL=$(echo "$JSON" | grep '"Package":' | tail -1 | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
RC6_UTIL=$(echo "$JSON" | grep '"rc6":' -A 1 | tail -1 | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)

echo "[{\"time\": $(date +%s), \"intel_gpu_video0\": "$VIDEO_UTIL", \"intel_gpu_render0\": "$RENDER_UTIL", \"intel_gpu_blitter0\": "$BLITTER_UTIL", \"intel_gpu_video_enhance0\": "$VIDENHANCE_UTIL", \"intel_gpu_watts\": "$GPU_WATT_UTIL", \"intel_gpu_pkg_watts\": "$PKG_WATT_UTIL", \"intel_gpu_rc6\": "$RC6_UTIL"}]"

exit 0