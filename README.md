# tmux-notepad

## tmux-notepad is a simple per-window notepad for tmux

To use tmux-notepad, add the following to your tmux.conf file.

```
bind N display-popup -E /path/to/tmux-notepad/tmux-notepad.sh
```

This will cause the tmux-notepad window to be opened when you press tmux prefix followed by N

By default, tmux prefix is ^B

![tmux-notepad](assets/tmux-notepad.gif)
