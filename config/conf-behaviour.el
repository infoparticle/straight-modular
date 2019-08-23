(use-package recentf
  :defer t
  :init
  ;;(idle-require-mode 1)
  :config (progn (setq recentf-auto-cleanup 'never
                       recentf-max-menu-items 50
                       recentf-max-saved-items 80
                       recentf-save-file
                       ;;(expand-file-name "temp/.recentf" user-emacs-directory)
                       (expand-file-name ".recentf" user-emacs-directory)
                       )
                 (recentf-mode t)))

(use-package ivy 
  :diminish (ivy-mode . "")
  :bind
  (:map ivy-mode-map
        ("C-'" . ivy-avy))
  :config

  (setq ivy-use-virtual-buffers t
        ivy-height 15
        ivy-display-style 'fancy
        ivy-count-format "(%d/%d) "
        ivy-initial-inputs-alist nil ; remove initial ^ input.
        ivy-extra-directories nil ; remove . and .. directory.
        ivy-wrap nil)

  (ivy-mode 1)
  ;; add ¡®recentf-mode¡¯ and bookmarks to ¡®ivy-switch-buffer¡¯.
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
        ;; allow input not in order
        '((t   . ivy--regex-ignore-order))))

(use-package counsel 
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-r") 'counsel-recentf)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'helm-do-grep-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  (setq projectile-completion-system 'ivy)
  )

(use-package swiper 
  :config)

(use-package smex
  :config
  (smex-initialize))

(use-package yasnippet
  :defer t
  :init
  (yas-global-mode 1)
  (setq yas/indent-line nil))

(use-package ivy-yasnippet
  :defer t
  :config
  )

(setq dired-recursive-copies (quote always)) ;no asking
(setq dired-recursive-deletes (quote top)) ; ask once
(setq dired-dwim-target t)

;hide details
(defun xah-dired-mode-setup ()
  "to be run as hook for `dired-mode'."
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'xah-dired-mode-setup)

(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file

; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package projectile
  :diminish projectile-mode
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode))

(defun my/tangle-dotfiles ()
  "If the current file is in '~/.dotfiles', the code blocks are tangled"
  (when (equal (file-name-directory (directory-file-name buffer-file-name)) user-config-directory)
    (org-babel-tangle)
    (message "%s tangled" buffer-file-name)))

(add-hook 'after-save-hook #'my/tangle-dotfiles)
