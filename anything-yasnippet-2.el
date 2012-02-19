;;; anything-yasnippet-2.el --- Quick listing of:

;; This file is not part of Emacs

;; Copyright (C)
;; http://www.rubyist.net/~rubikitch/archive/anything-c-yasnippet-2.el

;;; Installation:

;; Put this file where you defined your `load-path` directory or just
;; add the following line to your emacs config file:

;; (load-file "/path/to/anything-yasnippet-2.el")

;; Finally require it:

;; (require 'anything-yasnippet-2)

;; Usage:
;; M-x anything-yasnippet-2

;; There is no need to setup load-path with add-to-list if you copy
;; `anything-yasnippet-2.el` to load-path directories.

;; Requirements:

;; http://www.emacswiki.org/emacs/Anything

(require 'anything)
(require 'yasnippet)

(defvar *anything-yasnippet-2-buffer-name*
  "*Anything yasnippet2*")

(defun ays:candidates ()
  (with-current-buffer anything-current-buffer
    (yas/all-templates (yas/get-snippet-tables))))
(defun ays:real-to-display (template)
  (format "%s: %s"
          (file-name-nondirectory (yas/template-file template))
          (yas/template-name template)))
(defun ays:candidate-transformer (templates)
  (mapcar (lambda (template) (cons (ays:real-to-display template) template))
          templates))

;; http://www.rubyist.net/~rubikitch/archive/anything-c-yasnippet-2.el
(defvar anything-c-source-yasnippet-2
  '((name . "Yasnippet (reimplemented)")
    (candidates . ays:candidates)
    ;; FIXME real-to-display has a bug
    ;; (real-to-display . ays:real-to-display)
    (candidate-transformer . ays:candidate-transformer)
    (action
     ("expand" . (lambda (template)
                   (yas/expand-snippet (yas/template-content template))))
     ("open snippet file" . yas/visit-snippet-file-1))
    (persistent-action . (lambda (template)
                           (letf (((symbol-function 'find-file-other-window)
                                   (symbol-function 'find-file)))
                             (yas/visit-snippet-file-1 template))))))

;;;###autoload
(defun anything-yasnippet-2 ()
  "Find yasnippets."
  (interactive)
  (anything-other-buffer
   '(anything-c-source-yasnippet-2) *anything-yasnippet-2-buffer-name*))

(provide 'anything-yasnippet-2)
