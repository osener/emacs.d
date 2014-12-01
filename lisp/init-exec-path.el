(require-package 'exec-path-from-shell)

(after-load 'exec-path-from-shell
  (setq exec-path-from-shell-variables
        '("LC_CTYPE" "LANG" "GPG_AGENT_INFO" "SSH_AGENT_PID"
          "SSH_AUTH_SOCK" "MANPATH")))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path)
