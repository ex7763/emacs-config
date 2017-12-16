;; org mode
;; auto truncate line
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
;;indent
(setq org-startup-indented t)

;; org to html
;; 然后使用M-x org-publish-project，输入blog，就会自动开始生成HTML文件了，现在已经可以在public_html文件夹中访问了。
(require 'ox-publish)
(global-set-key (kbd "C-c C-7") 
   (lambda () 
      (interactive) 
      (org-publish-project "blog" t)  ;; t 是強制輸出
      (shell-command-to-string "/home/eh643027/org/blog.sh")  ;; 自動上傳
      ))

(global-set-key (kbd "C-c C-8") 
   (lambda () 
      (interactive) 
      (org-publish-project "blog")  ;; 只更新有變動的檔案
      (shell-command-to-string "/home/eh643027/org/blog.sh")  ;; 自動上傳
      ))


(defun org-publish-sitemap-entry-blog (entry style project)
  "Default format for site map ENTRY, as a string.
ENTRY is a file name.  STYLE is the style of the sitemap.
PROJECT is the current project."
  (cond ((not (directory-name-p entry))
	 (format "[[file:%s][%s]]"
		 entry
		 (org-publish-find-title entry project)))
	((eq style 'tree)
	 ;; Return only last subdir.
	 (file-name-nondirectory (directory-file-name entry)))
	(t entry)))

(defun org-publish-sitemap-blog (title list)
  "Default site map, as a string.
TITLE is the the title of the site map.  LIST is an internal
representation for the files to include, as returned by
`org-list-to-lisp'.  PROJECT is the current project."
  (concat "#+TITLE: " title "\n\n"
          (org-list-to-org list)))

(setq org-publish-project-alist
      ;; 把各部分的配置文件写到这里面来
      '(("blog-notes"
         :base-directory "/home/eh643027/org/blog/notes"
         :base-extension "org"
         :publishing-directory "/home/eh643027/org/www/public_html/"
         
         :html-doctype         "html5"
         :html-html5-fancy     t
         ;; :html-head-include-default-style nil  ;; 禁用預設css
         ;; :html-head-include-scripts nil  ;; 禁用預設js
         :html-head "
<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/favicon.ico\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/org.css\"/> 
<meta name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\">
<meta name=\"google-site-verification\" content=\"JawEHgT60KfbCLj__lEd-iUP-D8k1hyinLO_9vQAQ0U\" />
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-108871616-1\"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-108871616-1');
</script>"
         
         :htmlized-source t
         :recursive t
         :publishing-function org-html-publish-to-html

         :section-numbers nil

         :html-preamble "
<nav id=\"main_nav\"><ul>
<li><a id=\"brand\" href=\"/\">種程式</a></li>
<li><a href=\"/lists\">Lists</a></li>
<li><a href=\"/code\">Code</a></li>
<li><a href=\"/about\">About</a></li>
</ul></nav>
"
         :html-postamble "
<a class=\"author\" href=\"https://freelisp.nctu.me\">%a</a>
/
<span class=\"date\">%d</span>
<div id=\"disqus_thread\"></div>
<script>
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://freelisp.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
<div class=\"footer\">
<span>Copyright ©  2017 種程式 -  Powered by %c</span>
</div>"
         
         :auto-sitemap t
         :sitemap-filename "lists.org"
         :sitemap-title "Lists" 
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d %t")
("blog-nav"
 :base-directory "/home/eh643027/org/blog/"
 :base-extension "org"
 :publishing-directory "/home/eh643027/org/www/public_html/"
 
 :html-doctype         "html5"
 :html-html5-fancy     t
 ;; :html-head-include-default-style nil  ;; 禁用預設css
 ;; :html-head-include-scripts nil  ;; 禁用預設js
 :html-head "
<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/favicon.ico\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/org.css\"/> 
<meta name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\">
<meta name=\"google-site-verification\" content=\"JawEHgT60KfbCLj__lEd-iUP-D8k1hyinLO_9vQAQ0U\" />
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-108871616-1\"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-108871616-1');
</script>"
         
         :htmlized-source t
         :publishing-function org-html-publish-to-html

         :section-numbers nil

         :html-preamble "
<nav id=\"main_nav\"><ul>
<li><a id=\"brand\" href=\"/\">種程式</a></li>
<li><a href=\"/lists\">Lists</a></li>
<li><a href=\"/code\">Code</a></li>
<li><a href=\"/about\">About</a></li>
</ul></nav>
"
         :html-postamble "
<a class=\"author\" href=\"https://freelisp.nctu.me\">%a</a>
/
<span class=\"date\">%d</span>
<div id=\"disqus_thread\"></div>
<script>
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://freelisp.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
<div class=\"footer\">
<span>Copyright ©  2017 種程式 -  Powered by %c</span>
</div>"
         :auto-sitemap nil)
        ("blog-statics"
         :base-directory "/home/eh643027/org/blog/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico"
         :publishing-directory "/home/eh643027/org/www/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog" :components ("blog-notes" "blog-nav" "blog-statics"))))

(setq org-html-validation-link nil) 

(provide 'init-org)
