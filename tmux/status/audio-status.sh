#!/bin/bash

device=$(system_profiler SPAudioDataType -detailLevel mini -timeout 1 -xml |
  xpath -q -e '//key[text() = "coreaudio_default_audio_output_device"]
								/following-sibling::string[1][text() = "spaudio_yes"]
								/..
								/key[text() = "_name"]
								/following-sibling::string[1]
								/text()')

echo $device
if [[ $device == *"AirPods"* ]]; then
	echo ""
elif [[ $device == *"Crossfade"* ]]; then
	echo ""
else
	echo "ﰝ"
fi

