(if (and (not (getenv "TERM_PROGRAM"))
         (executable-find "/usr/local/bin/fish"))
    (let ((path (split-string
                 (shell-command-to-string
                  "/usr/local/bin/fish -c \"printf \\\"\\\$PATH\\\"\"")
                 " ")))
      (setq exec-path path)
      (setenv "PATH" (mapconcat 'identity path ":"))))

(provide 'init-preload-local)
