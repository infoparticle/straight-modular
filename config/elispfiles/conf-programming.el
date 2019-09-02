(use-package expand-region
  :defer t
  )
(use-package highlight-symbol
  :defer 10
  :bind (("M-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev))
  :init
  (setq highlight-symbol-idle-delay 0.3)
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (highlight-symbol-nav-mode))

(use-package rainbow-delimiters
  :defer t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package highlight-indentation
  :defer t
  :config
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
  )
