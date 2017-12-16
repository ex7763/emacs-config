;; line number
(global-linum-mode t)

;; line high light
(global-hl-line-mode 1)

;; hide welcome screen, scratch
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; hide toolbar
(tool-bar-mode -1)

;; hide menu
;;(menu-bar-mode -1)

;; hide mode-line
(setq-default mode-line-format nil) 
;; three line scroll
(setq scroll-margin 1)

;; show file title and directory
(setq frame-title-format "%n%b (%f) - %F")

;; no beep
(setq visible-bell t)

;; big kill ring
(setq kill-ring-max 300)

;; tab to space
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

;; parentheses
(show-paren-mode t)
;; parentheses auto-complete
(electric-pair-mode 1)

(provide 'init-custom)
