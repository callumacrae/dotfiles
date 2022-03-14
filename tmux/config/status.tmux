orange=colour202
brightorange=colour208
hard_black=colour233
xgray1=colour235
xgray2=colour236
xgray3=colour237
xgray4=colour238
xgray5=colour239
xgray6=colour240

set -g status-style fg=brightwhite,bg=$xgray1

setw -g pane-border-style fg=$xgray3,bg=default
setw -g pane-active-border-style fg=white,bg=default

set -g @prefix_highlight_fg 'black'
set -g @prefix_highlight_bg 'brightwhite'
set -g @prefix_highlight_show_copy_mode 'on'
set -g status-left-style fg=brightwhite,bg=$xgray1
set -g status-left "#[fg=brightwhite,bg=$xgray4,bold] #S #[fg=brightwhite,bg=$xgray3] #I:#P "
set -g status-left-length 30

setw -g window-status-current-style fg=brightwhite,bg=$xgray1
setw -g window-status-current-format " #W (#F) "
setw -g window-status-style fg=brightwhite,bg=$xgray1
setw -g window-status-format " #W (#F) "
set -g status-right-style fg=brightwhite,bg=$xgray1

prefix_highlight="#{?client_prefix,#[fg=$xgray1]#[bg=brightwhite] ^A #[default] ,#{?pane_in_mode,#[default]#[fg=white]#[bold]#[bg=blue] COPY #[default] ,}}"
battery_status="#{battery_color_charge_fg}#[bg=$xgray3]#{battery_icon_charge} #{battery_percentage}#{battery_icon_status}"
cpu_load="#(~/.dotfiles/tmux/status/cpu-load.sh)"
audio_status="#(~/.dotfiles/tmux/status/audio-status.sh)"
next_event="#(~/.dotfiles/tmux/status/next-event-2)"
notifications="#(~/.dotfiles/tmux/status/notifications-2.sh)"
set -g status-right "${prefix_highlight}#[default]${cpu_load} #[fg=brightwhite,bg=$xgray3] #{online_status}  #[fg=brightwhite]${audio_status}  ${battery_status}#[fg=brightwhite]${next_event} ${notifications}#[fg=brightwhite,bg=$xgray5,nobold] %H:%M | %F "
set -g status-right-length 90

set -g @batt_color_charge_primary_tier8 brightgreen
set -g @batt_color_charge_primary_tier7 brightgreen
set -g @batt_color_charge_primary_tier6 brightgreen
set -g @batt_color_charge_primary_tier5 yellow
set -g @batt_color_charge_primary_tier4 yellow
set -g @batt_color_charge_primary_tier3 yellow
set -g @batt_color_charge_primary_tier2 brightred
set -g @batt_color_charge_primary_tier1 brightred
set -g @batt_color_charge_secondary_tier8 $xgray1
set -g @batt_color_charge_secondary_tier7 $xgray1
set -g @batt_color_charge_secondary_tier6 $xgray1
set -g @batt_color_charge_secondary_tier5 $xgray1
set -g @batt_color_charge_secondary_tier4 $xgray1
set -g @batt_color_charge_secondary_tier3 $xgray1
set -g @batt_color_charge_secondary_tier2 $xgray1
set -g @batt_color_charge_secondary_tier1 $xgray1

set -g @batt_icon_charge_tier8 " "
set -g @batt_icon_charge_tier7 " "
set -g @batt_icon_charge_tier6 " "
set -g @batt_icon_charge_tier5 " "
set -g @batt_icon_charge_tier4 " "
set -g @batt_icon_charge_tier3 " "
set -g @batt_icon_charge_tier2 " "
set -g @batt_icon_charge_tier1 " "

set -g @batt_icon_status_charged " "
set -g @batt_icon_status_charging "  "
set -g @batt_icon_status_discharging " "
set -g @batt_icon_status_attached " "
set -g @batt_icon_status_unknown " "

set -g @route_to_ping "1.1.1.1"
set -g @online_icon "#[fg=cyan]"
set -g @offline_icon "#[fg=red]"
set -g status-interval 5
