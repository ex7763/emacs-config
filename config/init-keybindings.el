;;switch buffer
(global-set-key (kbd "M-o")  'mode-line-other-buffer)

;; set mark C-@ to C-z
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'set-mark-command)

(provide 'init-keybindings)
