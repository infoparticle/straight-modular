(use-package expand-region
  :defer t
  )

(use-package paren-face
:defer t
:config
  (add-hook 'prog-mode-hook #'paren-face-mode))

(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :config
  (add-hook 'prog-mode-hook #'aggressive-indent-global-mode)
  (defvar aggressive-indent/excluded '())
  (setq aggressive-indent/excluded '(php-mode rst-mode html-mode ruby-mode python-mode yaml-mode haskell-mode))
  (dolist (i aggressive-indent/excluded)
    (add-to-list 'aggressive-indent-excluded-modes i)))

(use-package lispy
  :hook ((common-lisp-mode . lispy-mode)
         (emacs-lisp-mode . lispy-mode)
         (scheme-mode . lispy-mode)
         (racket-mode . lispy-mode)
         (hy-mode . lispy-mode)
         (lfe-mode . lispy-mode)
         (clojure-mode . lispy-mode))
  :config
  (lispy-set-key-theme '(paredit c-digits))
  (ef-add-hook lispy-mode-hook
    (if (fboundp 'turn-off-smartparens-mode)
        (turn-off-smartparens-mode))))

(use-package lispyville
  :hook (lispy-mode . lispyville-mode)
  :config
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     commentary
     additional-wrap
     slurp/barf-cp))
  (evil-define-key 'normal lispyville-mode-map "#" #'lispyville-comment-or-uncomment-line)
  (evil-define-key 'normal lispyville-mode-map "\\" #'lispyville-comment-or-uncomment-line)
  (evil-define-key 'visual lispyville-mode-map "#" #'lispyville-comment-or-uncomment)
  (evil-define-key 'visual lispyville-mode-map "\\" #'lispyville-comment-or-uncomment))

(use-package highlight-symbol
  :defer 10
  :bind (("M-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev))
  :init
  (setq highlight-symbol-idle-delay 0.3)
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (highlight-symbol-nav-mode))

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

(use-package impatient-mode
  :mode ("\\.html$" . impatient-mode)
)

(use-package origami
  :defer t
  :config
  (add-hook 'prog-mode-hook #'origami-mode))

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

(use-package web-mode
  :mode ("\\.html$" . web-mode)
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq js-indent-level 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t)
  (set-face-attribute 'web-mode-html-tag-bracket-face  nil :foreground "#aaaaaa")
  (add-hook 'web-mode-hook 'electric-pair-mode))
