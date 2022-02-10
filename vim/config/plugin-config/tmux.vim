" vimux
let g:VimuxHeight = "40"
let g:VimuxOrientation = "h"
let g:VimuxUseNearest = v:false
let g:VimuxPromptString = "❯ "
let g:VimuxCloseOnExit = v:true

 " Prompt for a command to run
 map <Leader>vp :VimuxPromptCommand<CR>

 " Run last command executed by VimuxRunCommand
 map <Leader>vl :VimuxRunLastCommand<CR>

 " Inspect runner pane
 map <Leader>vi :VimuxInspectRunner<CR>

 " Close vim tmux runner opened by VimuxRunCommand
 map <Leader>vq :VimuxCloseRunner<CR>

 " Interrupt any command running in the runner pane
 map <Leader>vx :VimuxInterruptRunner<CR>

 " Zoom the runner pane (use <bind-key> z to restore runner pane)
 map <Leader>vz :call VimuxZoomRunner()<CR>

 " Clear the terminal screen of the runner pane.
 map <Leader>v<C-l> :VimuxClearTerminalScreen<CR>

