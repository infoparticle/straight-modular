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
  (add-hook 'prog-mode-hook #'highlight-indentation-mode))

(when (version<= "26.0.50" emacs-version )
  (custom-set-faces '(line-number ((t (:inherit default :foreground "gray80")))))
  (add-hook 'prog-mode-hook #'display-line-numbers-mode))

(use-package haskell-mode :defer t)

(use-package web-mode
  :mode ("\\.html$" . web-mode)
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq js-indent-level 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t)
  (add-hook 'web-mode-hook 'electric-pair-mode))

(use-package emmet-mode
  :diminish (emmet-mode . "ε")
  :bind* (("C-)" . emmet-next-edit-point)
          ("C-(" . emmet-prev-edit-point))
  :commands (emmet-mode
             emmet-next-edit-point
             emmet-prev-edit-point)
  :init
  (setq emmet-indentation 2)
  (setq emmet-move-cursor-between-quotes t)
  :config
  ;; Auto-start on any markup modes
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode))

(use-package json-mode
  :mode "\\.json\\'"
  :config
  (bind-key "{" #'paredit-open-curly json-mode-map)
  (bind-key "}" #'paredit-close-curly json-mode-map))
