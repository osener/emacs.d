(require-package 'slime)

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

(defun smp/set-up-slime-repl-auto-complete ()
  "Bind TAB to `indent-for-tab-command', as in regular Slime buffers."
  (local-set-key (kbd "TAB") 'indent-for-tab-command))

(eval-after-load 'slime
  '(progn
     (add-to-list 'load-path (concat (directory-of-library "slime") "/contrib"))
     (setq slime-protocol-version 'ignore)
     (setq slime-net-coding-system 'utf-8-unix)
     (setq slime-complete-symbol*-fancy t)
     (slime-setup '(slime-repl slime-js))

     (dolist (hook '(sldb-mode-hook slime-repl-mode-hook))
       (add-hook hook 'inhibit-autopair))

     ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
     (defun override-slime-repl-bindings-with-paredit ()
       (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil))
     (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

     (add-hook 'slime-mode-hook 'set-up-slime-hippie-expand)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-hippie-expand)

     (add-hook 'slime-repl-mode-hook (lambda () (setq show-trailing-whitespace nil)))

     (add-hook 'slime-repl-mode-hook 'smp/set-up-slime-repl-auto-complete)))


(setq slime-load-hook nil)

(provide 'init-slime)
