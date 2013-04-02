(require-package 'json)
(require-package 'js2-mode)
(require-package 'js-comint)
(require-package 'rainbow-delimiters)
(require-package 'flymake-json)


(defcustom preferred-javascript-mode 'js2-mode
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js-mode))
(defvar preferred-javascript-indent-level 4)

;; Need to first remove from list if present, since elpa adds entries too, which
;; may be in an arbitrary order
(eval-when-compile (require 'cl))
(setq auto-mode-alist (cons `("\\.js\\(\\.erb\\)?\\'" . ,preferred-javascript-mode)
                            (loop for entry in auto-mode-alist
                                  unless (eq preferred-javascript-mode (cdr entry))
                                  collect entry)))

(add-hook 'json-mode-hook 'flymake-json-maybe-load)

;; js2-mode

(add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS2")))

(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset preferred-javascript-indent-level
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p nil)

(eval-after-load 'js2-mode '(js2-imenu-extras-setup))

;; js-mode
(setq js-indent-level preferred-javascript-indent-level)

;; standard javascript-mode
(setq javascript-indent-level preferred-javascript-indent-level)

(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------

(when (featurep 'js2-mode)
  (require-package 'skewer-mode)
  (add-hook 'skewer-mode-hook (lambda () (inferior-js-keys-mode -1))))


(provide 'init-javascript)
