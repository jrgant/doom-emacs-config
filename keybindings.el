;;; $DOOMDIR/keybindings.el -*- lexical-binding: t; -*-

(map!
 "C-c c" #'clipboard-kill-ring-save
 "C-c x" #'clipboard-kill-region
 "C-c v" #'clipboard-yank
 )
