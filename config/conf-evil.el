(use-package evil
  :init ;; tweak evil's configuration before loading it
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil) ;make tab work in evil-org
  :config ;; tweak evil after loading it
  (evil-mode)
                                        ;(add-hook 'evil-insert-state-entry-hook (lambda() (global-hl-line-mode -1)))
                                        ;(add-hook 'evil-insert-state-exit-hook (lambda() (global-hl-line-mode +1)))

  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))
