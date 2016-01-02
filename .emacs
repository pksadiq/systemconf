;; -*- mode: emacs-lisp; -*-

(custom-set-variables
 ;; Dark theme is always preferred
 '(custom-enabled-themes (quote (manoj-dark)))
 ;; Don't ask me to ask for help anymore
 '(inhibit-startup-screen t))

;; Hide space consuming things from screen
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Disable Fringes, the gray bar of about 0.5 cm (default)
;; on left and right of Emacs X11
(set-fringe-mode '(0 . 0))

;; Show battery info
(display-battery-mode 1)

;; Hide distracting info from `erc' IRC client
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
