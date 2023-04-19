# moving between panes with vim movement keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# resize the pane with vim
bind -r J resize-pane -D 3
bind -r K resize-pane -U 3
bind -r H resize-pane -L 3
bind -r L resize-pane -R 3

# more vim!!
bind v split-window -h -c "#{pane_current_path}"
bind s split-window -v -c "#{pane_current_path}"
bind X kill-pane
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel

# vim mode
setw -g mode-keys vi
setw -g monitor-activity on
set -g visual-activity on

# vim-tmux-navigator config
forward_programs="n?vim?|fzf"
should_forward="ps -o state= -o comm= -t '#{pane_tty}' \
  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?($forward_programs)(diff)?$'"
bind -n 'C-h' if-shell "$should_forward" 'send-keys C-h' '%if "#{?pane_at_left,0,1}" select-pane -L %endif'
bind -n 'C-j' if-shell "$should_forward" 'send-keys C-j' '%if "#{?pane_at_bottom,0,1}" select-pane -D %endif'
bind -n 'C-k' if-shell "$should_forward" 'send-keys C-k' '%if "#{?pane_at_top,0,1}" select-pane -U %endif'
bind -n 'C-l' if-shell "$should_forward" 'send-keys C-l' '%if "#{?pane_at_right,0,1}" select-pane -R %endif'
bind -n C-\\ if-shell "$should_forward" 'send-keys C-\\' 'select-pane -l'

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l
