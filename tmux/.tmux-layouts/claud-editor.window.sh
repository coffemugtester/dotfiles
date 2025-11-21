# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
# window_root "${PWD}"

# Create new window. If no argument is given, window name will be based on
# layout file name.
window_root "${PWD}"
new_window "claude-editor"

run_cmd "nvim"     # runs in active pane

# Split window into panes.
split_h 20
send_keys "air"

split_v 30
run_cmd "npm i"
run_cmd "gst"

# Run commands.
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
