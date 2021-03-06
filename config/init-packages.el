;; cnfonts
;; 自動設定中英文對齊，在org的表格特別明顯
(cnfonts-enable)

;; rainbow-delimiters
;; 產生彩虹括弧，寫lisp好用
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; iBuffer
;; 比原本的buffer好一點
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Dired"
          (mode . dired-mode))
         ("Org"
          (or (mode . org-mode)
              (mode . org-agenda-mode)))
         ("C/C++" (or
               (mode . c-mode)
               (mode . c++-mode)))
         ("Lisp" (or
                  (mode . lisp-mode)
                  (mode . slime-mode)
                  (mode . REPL-mode)
                  (name . "^\\*scratch\\*$")
                  (name . "^\\*Messages\\*$")))
         ("Ruby" (or
                  (mode . ruby-mode)
                  (mode . enh-ruby-mode)
                  (mode . inf-ruby-mode))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; htmlize
;; 讓org-mode有語法高亮
(require 'htmlize)
(setq org-src-fontify-natively t)

;; pangu-spacing
;; 全形跟半形中間加入空白
;; (require 'pangu-spacing)
;; (global-pangu-spacing-mode 1)

;; undo-tree
;; 很厲害的還原功能
(require 'undo-tree)
(global-undo-tree-mode)

;; neotree
;; 資料夾的路徑
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; ace-jump-mode
;; 快速移動cursor
(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; dired
(require 'dired)
;這行請記得加，不然無法使用隱藏檔案等功能
(require 'dired-x)
(require 'dired+)
;; 目錄排在檔案之前
(defun dired-directory-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook 'dired-directory-sort)
;;自動隱藏以.開頭的檔案（使用 C-x M-o 顯示/隱藏）
(setq dired-omit-files "^\\...+$")
;; Dired Omit 加強:
;; 簡單來說，這個能夠紀錄下目前的「隱藏狀態」，所以當你按
;; C-x M-o 隱藏以.為開頭的檔案後，即使到了不同目錄下，以.開頭的檔案
;; 依舊是處於隱藏狀態，直到你重新按 C-x M-o 為止。
(defvar v-dired-omit t
  "If dired-omit-mode enabled by default. Don't setq me.")
(defun dired-omit-and-remember ()
  "This function is a small enhancement for `dired-omit-mode', which will
        \"remember\" omit state across Dired buffers."
  (interactive)
  (setq v-dired-omit (not v-dired-omit))
  (dired-omit-auto-apply)
  (revert-buffer))
(defun dired-omit-auto-apply ()
  (setq dired-omit-mode v-dired-omit))
(define-key dired-mode-map (kbd "C-x M-o") 'dired-omit-and-remember)
(add-hook 'dired-mode-hook 'dired-omit-auto-apply)
;;使用 KB, MB 等方式顯示檔案大小（這個應該是 Unix 限定...Windows 我不
;;知該怎麼辦）。
(setq dired-listing-switches "-alh")
;; 使用 f 搜尋目前目錄（這個部份可能也是 Unix 限定）
(define-key dired-mode-map "f" 'dired-find-name-in-current-directory)
(defun dired-find-name-in-current-directory ()
  (interactive)
  (find-name-dired default-directory
                   (format "*%s*" (read-from-minibuffer "Pattern: ")))
  (set-buffer-multibyte t))
(setq find-name-arg "-iname")

;; company mode
;; 重要，寫程式都靠這個，代碼補全功能
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.1)

;; slime-company
;; 對common-lisp的補全資料
(slime-setup '(slime-fancy slime-company))

;; yasnippet
;; 建立模板
(require 'yasnippet)
(yas-global-mode 1)
;; Auto add HEADER in new file
(add-hook 'find-file-hook
          '(lambda ()
             (when (and (buffer-file-name)
                        (not (file-exists-p (buffer-file-name)))
                        (= (point-max) 1))
               (let ((header-snippet "HEADER")
                     (yas/fallback-behavior 'return-nil))
                 (insert header-snippet)
                 ;; if can't expand snippet, delete insert string
                 (if (not (yas/expand))
                     (delete-region (point-min) (point-max)))))))

;; switch-window
;; 比較方便的在buffer中移動
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)
(setq switch-window-shortcut-style 'qwerty)
(setq switch-window-qwerty-shortcuts
      '( "h" "t" "n" "s" "a" "o" "e" "u" "," "." "c" "r"))
(setq switch-window-increase 3)

;; evil mode
;;(add-to-list 'load-path "~/.emacs.d/evil")
;;(require 'evil)
;;(evil-mode 1)

;; elpy
;; python的編輯環境
(elpy-enable)

;; smex
;;  M-x enhancement
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                                        ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(provide 'init-packages)
