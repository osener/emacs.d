;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc clojure tweaks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)

(defmacro defclojureface (name color desc &optional others)
  `(defface ,name '((((class color)) (:foreground ,color ,@others))) ,desc :group 'faces))

(defclojureface clojure-parens       "DimGrey"   "Clojure parens")
(defclojureface clojure-braces       "#49b2c7"   "Clojure braces")
(defclojureface clojure-brackets     "SteelBlue" "Clojure brackets")
(defclojureface clojure-keyword      "khaki"     "Clojure keywords")
(defclojureface clojure-java-call    "#4bcf68"   "Clojure Java calls")
(defclojureface clojure-special      "#b8bb00"   "Clojure special")
(defclojureface clojure-double-quote "#b8bb00"   "Clojure special" (:background "unspecified"))

(defun tweak-clojure-syntax ()
  (dolist (x '((("#?['`]*(\\|)"       . 'clojure-parens))
               (("#?\\^?{\\|}"        . 'clojure-brackets))
               (("\\[\\|\\]"          . 'clojure-braces))
               ((":\\w+#?"            . 'clojure-keyword))
               (("#?\""               0 'clojure-double-quote prepend))
               (("nil\\|true\\|false\\|%[1-9]?" . 'clojure-special))
               (("(\\(\\.[^ \n)]*\\|[^ \n)]+\\.\\|new\\)\\([ )\n]\\|$\\)" 1 'clojure-java-call))
               ))
    (font-lock-add-keywords nil x)))

(add-hook 'clojure-mode-hook 'tweak-clojure-syntax)

(eval-after-load 'gist
  '(add-to-list 'gist-supported-modes-alist '(clojure-mode . ".clj")))

(provide 'init-clojure)
