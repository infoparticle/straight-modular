(defun conf/ondemand/restclient ()
  (interactive)
  (use-package restclient
    :config
    (use-package ob-restclient
      :config
      (org-babel-do-load-languages 'org-babel-load-languages
                                   (append org-babel-load-languages
                                           '((restclient . t))))))
  (message "loaded tool: restclient and ob-restclient"))

(defun conf/ondemand/ledger-cli ()
  (interactive)
  (use-package ledger-mode
    :mode "\\.ledger\\'"
    :config
    (define-key ledger-mode-map (kbd "C-c c") 'ledger-mode-clean-buffer)
    (setq ledger-post-amount-alignment-at :decimal
          ledger-post-amount-alignment-column 80
          ledger-clear-whole-transactions t)
    (with-system windows-nt
      (setq ledger-binary-path "c:/opt/ledger3/ledger.exe"))
    (use-package flycheck-ledger)))
