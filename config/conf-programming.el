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
