;; -*- mode: emacs-lisp; -*-

(custom-set-variables
  ;; Always end a file with newline
 '(require-final-newline t)
 ;; Dark theme is always preferred
 '(custom-enabled-themes (quote (manoj-dark)))
 ;; Don't ask me to ask for help anymore
 '(inhibit-startup-screen t))

;; Let's type y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Though I hate Ubuntu philosophically, Ubuntu fonts are
;; good and free (both Libre and Gratis).
;; Fonts should already be installed before you can use it.
(set-default-font "Ubuntu Mono-16")
(set-face-attribute 'default nil :height 150)

;; Hide space consuming things from screen
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Disable Fringes, the gray bar of about 0.5 cm (default)
;; on left and right of Emacs X11
(set-fringe-mode '(0 . 0))

;; Show battery info
(display-battery-mode 1)

;; Auto close bracket (", [, (, {, etc.).
;; Recommended Emacs version: 24.4+
(electric-pair-mode 1)

;; Highlight matching parenthesis
(show-paren-mode 1)

;; Show column number -- The number of characters from the beginning
;; of the current line up to the cursor
(column-number-mode 1)

;; Hide distracting info from `erc' IRC client
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;;;;;; Set some shortcuts ;;;;;;

;; Let Control-w kill a word back, as in shell.
(global-set-key "\C-w" 'backward-kill-word)
