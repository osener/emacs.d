(require-package 'slime)
;; package.el compiles the contrib subdir, but the compilation order
;; causes problems, so we remove the .elc files there. See
;; http://lists.common-lisp.net/pipermail/slime-devel/2012-February/018470.html
(mapc #'delete-file
      (file-expand-wildcards (concat user-emacs-directory "elpa/slime-2*/contrib/*.elc")))

;; There are 2 versions of Slime available as packages. The 2010* version
;; is for Clojure compatibility, and uses separate packages for slime-fuzzy
;; and slime-repl. The other version is the latest available, which
;; contains a complete "contrib" dir.
(let ((slime-contrib-dir (concat (directory-of-library "slime") "/contrib")))
  (if (file-directory-p slime-contrib-dir)
      ;; Ensure contrib dir is ahead of any slime-{fuzzy,repl} package
      (add-to-list 'load-path slime-contrib-dir)
    (require-package 'slime-fuzzy)
    (require-package 'slime-repl)))

(require-package 'hippie-expand-slime)


;;; Lisp buffers

(defun sanityinc/slime-setup ()
  "Mode setup function for slime lisp buffers."
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t))

(after-load 'slime
  (setq slime-protocol-version 'ignore)
  (setq slime-net-coding-system 'utf-8-unix)
  (slime-setup '(slime-repl slime-fuzzy))
  (setq slime-complete-symbol*-fancy t)
  (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  (add-hook 'slime-mode-hook 'sanityinc/slime-setup))


;;; REPL

(defun sanityinc/slime-repl-setup ()
  "Mode setup function for slime REPL."
  (sanityinc/lisp-setup)
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t)
  (setq show-trailing-whitespace nil))

(after-load 'slime-repl
  ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
  (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil)

  ;; Bind TAB to `indent-for-tab-command', as in regular Slime buffers.
  (define-key slime-repl-mode-map (kbd "TAB") 'indent-for-tab-command)

  (add-hook 'slime-repl-mode-hook 'sanityinc/slime-repl-setup))

(after-load 'auto-complete
  (add-to-list 'ac-modes 'slime-repl-mode))

(setq slime-load-hook nil)

(provide 'init-slime)
