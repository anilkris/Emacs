;;; jde-usages-class-completion.el --- jde-open-class-source-with-completion and related functions

;;; Commentary:
;; 


;;; History:
;; 

(require 'jde-usages-bsh)

;; Classname completion stuff
;;; Code:
(defvar jde-usages-known-classes (make-hash-table)
  "A hashtable storing the list of classes for each project.
The class names in the list are in a form that make for easier
completion when typing in the name.  The class full.package.Class
is listed as \"Class|full.package\"."  )


;; class completion
(defun jde-usages-get-all-known-classes ()
  "Return a list of classes in the current project."
  (let ((classes (gethash jde-current-project jde-usages-known-classes)))
    (when (jde-bsh-running-p)
      (jde-jeval (jde-create-prj-values-str)))
    (let ((need-refresh (jde-jeval "jde.util.Usages.getAllClasses (null);" t)))
      (when (or need-refresh (not classes))
        (setq classes     (sort (let ((classes-file (replace-regexp-in-string  "\\\\" "/" (if jde-xemacsp
                                                                                        (make-temp-name (expand-file-name "jde-usages" (temp-directory)))
                                                                                      (make-temp-file "jde-usages")))))
                            (jde-jeval (concat "out = new java.io.PrintStream (new java.io.BufferedOutputStream (new java.io.FileOutputStream (new java.io.File (\"" classes-file "\"))));"))
                            (jde-jeval "jde.util.Usages.getAllClasses (out);")
                            (jde-jeval "out.close();")
                            (with-temp-buffer
                              (insert-file-contents-literally classes-file)
                              (delete-file classes-file)
                              (read (current-buffer))
                              )
                            ) 'string<)
              )
        (puthash jde-current-project classes jde-usages-known-classes))
      )
    classes
    )
  )

(defsubst jde-usages-completing-read-function  ()
    "Return the completing function used in jde-usages.
This is normally `completing-read' but returns `ido-completing-read' if ido mode is active."
  (if (and (boundp 'ido-mode) ido-mode) 'ido-completing-read 'completing-read))

(defun jde-usages-read-class-with-completion (&optional exact-match)
"Read a class name from the minibuffer.
Provides completion with the list of classes from
'jde-usages-get-all-known-classes.  Returns a pair of classname
and fully qualified classname, if the user did not pick a class
from the completion list the cdr of the return value is nil
Optional argument EXACT-MATCH if non-nil, force the user to return a class that is in the all-known-users list for this project."
  (interactive)
  (apply (jde-usages-completing-read-function) "Class:" (jde-usages-get-all-known-classes) nil exact-match))

(defun jde-open-class-source-with-completion ()
  "A wrapper around 'jde-open-class-source providing class name completion.
The list of classnames is obtained from the jde-usages java
component by calling jde.util.Usages.getAllClasses() which
returns all the classes in the 'jde-global-classpath for the
current project.
            
This command checks if any classes were added or removed since
the last call, and will update the list of classes accordingly."
  (interactive)
  (let* ((class-name (jde-usages-get-fq-class-name-from-all-classes-list (jde-usages-read-class-with-completion))))
    (if (string-match "\." class-name)
        (jde-find-class-source class-name)
      (jde-open-class-source class-name))))

(defun jde-usages-get-fq-class-name-from-all-classes-list (reversed-class-name)
  "Convert a class name entry, REVERSED-CLASS-NAME,  in `jde-usages-known-classes' to a fully qualified class name."
  (let* ((pipe-index (string-match "|" reversed-class-name))
         (class-name (if pipe-index
                         (concat (substring reversed-class-name (+ 1 pipe-index)) (substring reversed-class-name 0 pipe-index))
                       reversed-class-name)))
    class-name
  ))


(defun jde-usages-reload-class-list-for-project ()
  "Throw away the old list of classed for this project and get it again."
  (interactive)
  (puthash jde-current-project (jde-usages-get-all-known-classes) jde-usages-known-classes)
)

(provide 'jde-usages-class-completion)
;;; jde-usages-class-completion.el ends here
