all: build-tmux

build-tmux: build-tmux-next-event

build-tmux-next-event:
	swiftc tmux/status/next-event-2.swift -o tmux/status/next-event-2
