;; Colourise CSS colour literals
(when (featurep 'color)
  ;; rainbow-mode needs color.el, bundled with Emacs >= 24.
  (require-package 'rainbow-mode))

(eval-after-load 'rainbow-mode
  '(dolist (hook '(css-mode-hook html-mode-hook stylus-mode-hook))
     (add-hook hook 'rainbow-mode)))


(defun maybe-flymake-css-load ()
  "Activate flymake-css as necessary, but not in derived modes."
  (when (eq major-mode 'css-mode)
    (flymake-css-load)))
(add-hook 'css-mode-hook 'maybe-flymake-css-load)

(provide 'init-css)
