all: build-tmux

build-tmux: build-tmux-next-event build-tmux-audio-status

build-tmux-next-event:
	swiftc tmux/status/next-event-2.swift -o tmux/status/next-event-2

build-tmux-audio-status:
	swiftc tmux/status/audio-status-2.swift -o tmux/status/audio-status-2
