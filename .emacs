(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(package-initialize)

;;;; editor
;; font
;;(set-default-font "inconsolata-18")
;; English font
(set-face-attribute
 'default nil :font "inconsolata 18")
;; Chinese font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
            charset
            (font-spec :family "文泉驛等寬微米黑" :size 22)))
;; line number
(global-linum-mode t)
;; line high light
(global-hl-line-mode 1)
;; hide welcome screen
(setq inhibit-startup-screen t)
;; hide toolbar
;; (tool-bar-mode -1)
;; hide menu
(menu-bar-mode -1)
;; three line scroll
(setq scroll-margin 1)
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
;;switch buffer
(global-set-key (kbd "M-o")  'mode-line-other-buffer)
;;compile c/c++ file
;; (defun compile-file ()
;;   (interactive)
;;   (if (eq major-mode 'c-mode)
;;       (setq command
;;             (concat "gcc -Wall -o "
;;                     (file-name-sans-extension
;;                      (file-name-nondirectory buffer-file-name))
;;                     " "
;;                     (file-name-nondirectory buffer-file-name)
;;                     " -g -lm "))
;;     (if (eq major-mode 'c++-mode)
;;         (setq command
;;               (concat "g++ -Wall -o "
;;                       (file-name-sans-extension
;;                        (file-name-nondirectory buffer-file-name))
;;                       " "
;;                       (file-name-nondirectory buffer-file-name)
;;                       " -g -lm ")))))
;; (global-set-key (kbd"<f5>") 'compile-file)


;; set mark C-@ to C-z
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'set-mark-command)

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

;;;; Package
;;rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;iBuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;htmlize
;;讓org-mode有語法高亮
(require 'htmlize)
(setq org-src-fontify-natively t)

;;org mode
;; auto truncate line
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;;indent
(setq org-startup-indented t)

;;org to html
;; 然后使用M-x org-publish-project，输入blog，就会自动开始生成HTML文件了，现在已经可以在public_html文件夹中访问了。
(require 'ox-publish)
(setq org-publish-project-alist
      ;; 把各部分的配置文件写到这里面来
      '(("blog-notes"
         :base-directory "/home/eh643027/Project/lisp/web/HPC-blog/org/notes"
         :base-extension "org"
         :publishing-directory "/home/eh643027/Project/lisp/web/HPC-blog/static/public_html/"
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/org.css\"/>"
         :htmlized-source t
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :section-numbers nil
         :auto-sitemap nil
         :org-html-postamble nil)                ; Generate sitemap.org automagically...
         ;; :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         ;; :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         ;; :sitemap-sort-files anti-chronologically
         ;; :sitemap-file-entry-format "%d %t")
        ("blog-static"
         :base-directory "/home/eh643027/Project/lisp/web/HPC-blog/org/notes/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "/home/eh643027/Project/lisp/web/HPC-blog/static/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("blog-notes" "blog-static"))))

;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;;neotree
(add-to-list 'load-path "/some/path/neeotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;;ace-jump-mode
(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;;dired
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

;;company mode
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.1)

;;yasnippet
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

;;slime-company
(slime-setup '(slime-fancy slime-company))

;;smart-mode-line
(setq sml/no-confirm-load-theme t)
(sml/setup)

;;switch-window
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
(elpy-enable)

;; common lisp, slime, sbcl
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#515151"))
 '(custom-enabled-themes (quote (sanityinc-solarized-dark)))
 '(custom-safe-themes
   (quote
    ("67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#515151")
 '(package-selected-packages
   (quote
    (yasnippet htmlize slime-company elpy zenburn-theme undo-tree switch-window smart-mode-line-powerline-theme slime rainbow-delimiters neotree molokai-theme markdown-mode dired+ company color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-theme ace-jump-mode)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
