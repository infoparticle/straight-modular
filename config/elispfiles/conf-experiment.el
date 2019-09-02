(message "conf experiment loaded")
(use-package flycheck)
(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'rust-mode-hook #'lsp))

(use-package lsp-ui
  :requires (lsp-mode flycheck)
  :config

  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)

  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company
  :config
  (setq company-idle-delay 0.3)

  (global-company-mode 1)

  (global-set-key (kbd "C-<tab>") 'company-complete))

(use-package company-lsp
  :requires company
  :config
  (push 'company-lsp company-backends)

   ;; Disable client-side cache because the LSP server does a better job.
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))
(use-package hydra)

(use-package helm)

(use-package helm-lsp
  :config
  (defun netrom/helm-lsp-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-workspace-symbol)))

  (defun netrom/helm-lsp-global-workspace-symbol-at-point ()
    (interactive)
    (let ((current-prefix-arg t))
      (call-interactively #'helm-lsp-global-workspace-symbol))))

(use-package lsp-mode
  :requires (hydra helm helm-lsp)
  ;; ..
  :config
  (setq netrom--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" netrom/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" netrom/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        netrom--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")))

  ;; Create general hydra.
  (eval `(defhydra netrom/lsp-hydra (:color blue :hint nil)
           ,@(append
              netrom--general-lsp-hydra-heads
              netrom--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "C-c C-l") 'netrom/lsp-hydra/body))))
