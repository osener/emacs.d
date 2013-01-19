(eval-after-load 'exec-path-from-shell
  '(progn
     (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO"))
       (add-to-list 'exec-path-from-shell-variables var))))


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(if (and (not (getenv "TERM_PROGRAM"))
         (executable-find "/usr/local/bin/fish"))
    (let ((path (split-string
                 (shell-command-to-string
                  "/usr/local/bin/fish -c \"printf \\\"\\\$PATH\\\"\"")
                 " ")))
      (setq exec-path path)
      (setenv "PATH" (mapconcat 'identity path ":"))))

(provide 'init-exec-path)
