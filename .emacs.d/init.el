;; (setq url-proxy-services
;; '(("http"     . "10.203.190.5:80")
;;  ("https"     . "10.203.190.5:80")
;;  ("ftp"      . "proxy.example.com:8080")
;; ))


(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'cider)
  (package-install 'cider))
;; Set a key binding for occur
(global-set-key (kbd "C-c o") 'occur)
