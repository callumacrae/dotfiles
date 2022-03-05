#!/usr/bin/env bash

device=$(system_profiler SPAudioDataType -detailLevel mini -timeout 1 -xml |
  xpath -q -e '//key[text() = "coreaudio_default_audio_output_device"]
  							/following-sibling::string[1][text() = "spaudio_yes"]
  							/..
  							/key[text() = "_name"]
  							/following-sibling::string[1]
  							/text()')

if [ -z $device ]; then
  echo "#[fg=red]ﱝ"
  exit 0
fi

is_headphones=false
if [[ $device == *"AirPods"* || $device == *"Crossfade"* ]]; then
	is_headphones=true
fi

muted_value=$(osascript -e 'output muted of (get volume settings)')
is_muted=false
if [[ $muted_value == "true" ]]; then
	is_muted=true
fi

if $is_headphones && $is_muted; then
  echo "ﳌ"
elif $is_headphones; then
  echo ""
elif $is_muted; then
	echo "ﱝ"
else
  echo ""
fi

