(require-package 'slime)
(require-package 'slime-fuzzy)
(require-package 'slime-repl)
(require-package 'ac-slime)
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

     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

     (add-hook 'slime-repl-mode-hook 'smp/set-up-slime-repl-auto-complete)

     (eval-after-load 'auto-complete
       '(add-to-list 'ac-modes 'slime-repl-mode))))


(setq slime-load-hook nil)

(provide 'init-slime)
