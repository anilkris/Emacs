
(add-to-list 'load-path "~/.emacs.d/packages")
(require 'go-mode-load)

(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()(local-set-key (kbd "C-c i") 'go-goto-imports)))

;; Load JDEE for java
;;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")

;; Load other jdee support plugins for java
;;(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/plugins")
;;(require 'jde-lint) ;; java lint for static code check
;;(require 'jde-findbugs) ;; java findbugs code check
;;(require 'jde-jalopy)   ;; Java source code formatter beautifier pretty printer
;;(add-to-list 'load-path "~/.emacs.d/cedet/common")
;;(load-file "~/.emacs.d/cedet/common/cedet.el")
;;(add-to-list 'load-path "~/.emacs.d/elib")
;;(load "jde")

(add-to-list 'load-path "~/.emacs.d/packages/yasnippet-20140810.1626")
(require 'yasnippet) 
(yas-global-mode 1)


;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") )
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(server-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")



(add-to-list 'load-path "~/color-theme")
(require 'color-theme)
    (color-theme-initialize)
   ;; (color-theme-robin-hood)


;;(load-theme 'monokai t)
(load "~/.emacs.d/user.el")

;; JS file integration into emacs
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; if we want to add any other files to js extension
;(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))
;;
(flycheck-define-checker xml-xmllint
  "A XML syntax checker and validator using the xmllint utility."
  :command ("xmllint" "--noout" source)
  :error-patterns
  ((error line-start (file-name) ":" line ": " (message) line-end))
  :modes (xml-mode nxml-mode))

(flycheck-define-checker xhtml-xmllint
  "A XML syntax checker and validator using the xmllint utility."
  :command ("xmllint" "--noout" source)
  :error-patterns
  ((error line-start (file-name) ":" line ": " (message) line-end))
  :modes (web-mode)
  :next-checkers (html-tidy))

(add-to-list 'flycheck-checkers 'xml-xmllint)
(add-to-list 'flycheck-checkers 'xhtml-xmllint)


;;


;; js2 refactoing load
(require 'js2-refactor)
;; key bindings for refactoring code
(js2r-add-keybindings-with-prefix "C-c C-m")

;;js autocomplete using tern and tern autocomplete package
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
;;js commit, for node repl mode
(add-to-list 'load-path "~/jscommit/")
(require 'js-comint)
;; if use node.js, we need nice output
(setenv "NODE_NO_READLINE" "1")


;;swank js settings

;; swank-js settings
(add-to-list 'load-path "~/js2-mode.el")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(global-set-key [f5] 'slime-js-reload)
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))
;;(load-file "~/.emacs.d/setup-slime-js.el")

;;
;;(if (file-directory-p "e:/cygwin/bin")
;;(add-to-list 'exec-path "e:/cygwin/bin"))

 ;; (let* ((cygwin-root "e:/cygwin")
 ;;         (cygwin-bin (concat cygwin-root "/bin")))
 ;;    (when (and (eq 'windows-nt system-type)
 ;;  	     (file-readable-p cygwin-root))
    
 ;;      (setq exec-path (cons cygwin-bin exec-path))
 ;;      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))

;; auto complete
;;(require 'auto-complete)
;;(add-to-list 'load-path "~/.emacs.d/")
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;(ac-config-default)

(add-to-list 'load-path "e:/home/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "e:/home/.emacs.d/ac-dict")
(ac-config-default)

;; For rainbow parenthesis
(add-to-list 'load-path "~/.emacs.d/elpa/rainbow-delimiters")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; for showing opening and closing parenthesis
(add-to-list 'load-path "~/.emacs.d/elpa/mic-paren")
(require 'mic-paren)
(paren-activate)     ; activating
;To list the possible customizations type `C-h f paren-activate'

;; Setting the cygwin bash as the default shell
;;(setq shell-file-name "bash")
;; (setenv "SHELL" shell-file-name) 
;;(setq explicit-shell-file-name shell-file-name)
 ;; This removes unsightly ^M characters that would otherwise
 ;; appear in the output of java applications.
 ;; (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))


;;set tramp-default-method to “sshx” or “scpx”
 ;; (cond  ((eq window-system 'w32)
 ;;    (setq tramp-default-method "scpx"))
 ;;        (t
 ;;         (setq tramp-default-method "scpc")))
;; emacs for python
(add-to-list 'load-path "~/.emacs.d/emacs-for-python")
(require 'epy-setup)
(require 'epy-python)
(require 'epy-completion)

(epy-setup-checker "pyflakes %f")
(epy-setup-ipython)


(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)
 (when (load "flymake" t) 
         (defun flymake-pyflakes-init () 
           (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                              'flymake-create-temp-inplace)) 
              (local-file (file-relative-name 
                           temp-file 
                           (file-name-directory buffer-file-name)))) 
             (list "pyflakes" (list local-file)))) 

         (add-to-list 'flymake-allowed-file-name-masks 
                  '("\\.py\\'" flymake-pyflakes-init))) 

   (add-hook 'find-file-hook 'flymake-find-file-hook)

;; (require 'gradle-mode)

;; (gradle-mode 1)

(global-font-lock-mode 1)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
;; (autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
;; (add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))

;; (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make Groovy mode electric by default.
;; (add-hook 'groovy-mode-hook
;;           '(lambda ()
;;              (require 'groovy-electric)
;;              (groovy-electric-mode)))







;(require 'web-mode)


;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
                                        ;
;(setq web-mode-engines-alist
;      '(("php"    . "\\.phtml\\'")
;        ("blade"  . "\\.blade\\."))

;; ember js mode
(add-to-list 'load-path "~/.emacs.d/ember-mode/")
(require 'ember-mode)

;;emacs slowness might be due to failing DNS lookups of the laptop’s hostname.
(setq w32-get-true-file-attributes nil)

;; load jade mode
;; (require 'sws-mode)
;; (require 'jade-mode)    
;; (add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
;; (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
;; ;; flymake support for jade 
;; (defun flymake-jade-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                  'flymake-create-temp-intemp))
;;      (local-file (file-relative-name
;;                   temp-file
;;                   (file-name-directory buffer-file-name)))
;;      (arglist (list local-file)))
;;     (list "jade" arglist)))
;; (setq flymake-err-line-patterns
;;        (cons '("\\(.*\\): \\(.+\\):\\([[:digit:]]+\\)$"
;;               2 3 nil 1)
;;             flymake-err-line-patterns))
;; (add-to-list 'flymake-allowed-file-name-masks
;;          '("\\.jade\\'" flymake-jade-init))

(add-to-list 'load-path "~/.emacs.d/powerline/")
(require 'powerline)
(powerline-default-theme)

;; Complete anything mode enabled for all buffers.
(add-hook 'after-init-hook 'global-company-mode)

;; now that we have the complete anything, let's chagne the color
;;And if you’re using a theme with a dark background, here’s another quick option:
  (require 'color)
  
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


;; load evil mode & all it's related packages
;; *******************Evil mode packages begin*****************
(add-to-list 'load-path "~/.emacs.d/evil")  
(require 'evil)  
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil-numbers")
(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

(add-to-list 'load-path "~/.emacs.d/evil-surround")
(require 'evil-surround)
(global-evil-surround-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil-leader")
(require 'evil-leader)
(global-evil-leader-mode)
;; Set the key bindings now for some of the emacs functionalities 

(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

(add-to-list 'load-path "~/.emacs.d/evil-nerd-commenter")
(require 'evil-nerd-commenter)
(evilnc-default-hotkeys)

(add-to-list 'load-path "~/.emacs.d/evil-matchit")
(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; ***********Evil mode pakages completed***************
;; install projectile
(add-to-list 'load-path "~/.emacs.d/projectile")
(require 'projectile)
(projectile-global-mode)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; vim like nerd tree for emacs
 (add-to-list 'load-path "~/.emacs.d/neotree")
  (require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Code folding

(add-to-list 'load-path "~/.emacs.d/yafolding")
(require 'yafolding)
(define-key yafolding-mode-map (kbd "<C-S-return>") nil)
(define-key yafolding-mode-map (kbd "<C-return>") nil)
(define-key yafolding-mode-map (kbd "C-c <C-S-return>") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-c <C-return>") 'yafolding-toggle-element)

(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))

;; Load emacs eclim list package
(add-to-list 'load-path "~/.emacs.d/emacs-eclim/") 
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)
;; Tell emacs where is our eclipse installed
(custom-set-variables
  '(eclim-eclipse-dirs '("e:/eclipse"))
  '(eclim-executable "e:/eclipse/eclim"))

;; Helm package

(add-to-list 'load-path "~/.emacs.d/async/")

(add-to-list 'load-path "~/.emacs.d/helm/")
(require 'helm-config)

(setq temporary-file-directory "~/.emacs.d/tmp/")
