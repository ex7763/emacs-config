
;; 啟動視窗的大小
(setq default-frame-alist
      `((top . 0)
        (left . 0)
        (width . 80)
        (height . 30)
        ))
(setq initial-frame-alist default-frame-alist)
;; 修正新開frame大小不一的問題，emacsclient適用
(defun new-frame-size (&rest frame)
  (if window-system
      (let ((f (if (car frame)
                   (car frame)
                 (selected-frame))))
        (progn
          (set-frame-position f 0 32)
          (set-frame-size f 40 17)
          (setq default-frame-alist
                `((top . 0)
                  (left . 0)
                  (width . 40)
                  (height . 17)
                  ))))))
(add-hook 'after-make-frame-functions 'new-frame-size t)

;; 啟動全屏的快捷鍵
(global-set-key [f11] 'my-fullscreen) 
;; 全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )

;; line kill and copy
;; copy region or whole line
(global-set-key "\M-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))
;; kill region or whole line
(global-set-key "\C-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line")))))

;; Edit currently visited file as root
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.
With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
(global-set-key (kbd "C-x C-r") 'sudo-edit)

(provide 'init-better-defaults)
