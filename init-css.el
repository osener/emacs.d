;;; Colourise CSS colour literals
(when (eval-when-compile (>= emacs-major-version 24))
  ;; rainbow-mode needs color.el, bundled with Emacs >= 24.
  (require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook stylus-mode-hook))
    (add-hook hook 'rainbow-mode)))


;;; LESS
(require-package 'less-css-mode)
(require-package 'flymake-less)
(add-hook 'less-css-mode-hook 'flymake-less-load)

(provide 'init-css)
