(defun joe-scroll-other-window()
  (interactive)
  (scroll-other-window 1))
(defun joe-scroll-other-window-down ()
  (interactive)
  (scroll-other-window-down 1))
(use-package ace-window
  :config
  (set-face-attribute
   'aw-leading-char-face nil
   :foreground "deep sky blue"
   :weight 'bold
   :height 3.0)
  (setq aw-keys '(?a ?s ?d ?f ?j ?k ?l)
        ;aw-dispatch-always t
        aw-dispatch-alist
        '((?x aw-delete-window "Ace - Delete Window")
          (?c aw-swap-window "Ace - Swap Window")
          (?n aw-flip-window)
          (?v aw-split-window-vert "Ace - Split Vert Window")
          (?h aw-split-window-horz "Ace - Split Horz Window")
          (?m delete-other-windows "Ace - Maximize Window")
          (?g delete-other-windows)
          (?b balance-windows)
          (?u (lambda ()
                (progn
                  (winner-undo)
                  (setq this-command 'winner-undo))))
          (?r winner-redo))
        )

  (use-package hydra
    :config
    (defhydra hydra-window-size (:color red)
      "Windows size"
      ("h" shrink-window-horizontally "shrink horizontal")
      ("j" shrink-window "shrink vertical")
      ("k" enlarge-window "enlarge vertical")
      ("l" enlarge-window-horizontally "enlarge horizontal"))
    (defhydra hydra-window-frame (:color red)
      "Frame"
      ("f" make-frame "new frame")
      ("x" delete-frame "delete frame"))
    (defhydra hydra-window-scroll (:color red)
      "Scroll other window"
      ("n" joe-scroll-other-window "scroll")
      ("p" joe-scroll-other-window-down "scroll down"))
    (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
    (add-to-list 'aw-dispatch-alist '(?o hydra-window-scroll/body) t)
    (add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t))
  (ace-window-display-mode -1) ;don't clutter mode-line
  (global-set-key (kbd "C-x o") 'ace-window))

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

(use-package avy :defer t
:config
(defhydra hydra-avy (:color teal)
  ("c" avy-goto-char "char")
  ("w" avy-goto-word-0 "word")
  ("l" avy-goto-line "line")
  ("p" avy-pop-mark "pop")))

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

(use-package evil-collection
  :custom (evil-collection-setup-minibuffer t)
  :init
  (setq evil-want-keybinding nil)
  (evil-collection-init))

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

; put directories first
(setq ls-lisp-dirs-first t)
(setq dired-recursive-deletes 'top)
(setq dired-listing-switches "-hal")
(setq diredp-hide-details-initially-flag nil)


(use-package dired-narrow)

(use-package dired+
  :init (setq diredp-hide-details-initially-flag nil)
  :config (progn
            (diredp-toggle-find-file-reuse-dir 1)
            ;(set-face-foreground 'diredp-dir-priv    "#33cc33") ; was "magenta3"
            ;(set-face-background 'diredp-dir-priv    nil)
            ;(set-face-foreground 'diredp-file-suffix "cornflower blue")
            ;(set-face-foreground 'diredp-file-name   "black")
            ;(set-face-foreground 'diredp-number      "gray60")
            ;(set-face-foreground 'diredp-dir-heading "Blue")
            ;(set-face-background 'diredp-dir-heading "bisque1")
            ;(set-face-background 'diredp-no-priv     "black")
            ;(set-face-foreground 'diredp-date-time   "#74749A9AF7F7")
))

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
  (interactive)
  "If the current file is in '~/.dotfiles', the code blocks are tangled"
  (when (equal (file-name-directory (directory-file-name buffer-file-name)) (concat user-emacs-directory "config/orgfiles/"))
    (org-babel-tangle)
    (message "%s tangled" buffer-file-name)
    (if (file-exists-p (concat buffer-file-name "c"))
        (delete-file (concat buffer-file-name "c")))
    (my/byte-compile-init-dir)
    (mapc '(lambda(x) (rename-file x (concat user-emacs-directory "config/elispfiles/") t))
          (directory-files (concat user-emacs-directory "config/orgfiles/") t ".el[c]*$"))))

(add-hook 'after-save-hook #'my/tangle-dotfiles)

(use-package super-save
  :config
  (setq super-save-auto-save-when-idle t)
  (setq auto-save-default nil) ; turnoff default backups
  (setq super-save-remote-files nil) ;don't autosave remote files
  (setq super-save-exclude '(".gpg")) ;avoid auto saving gpg files
  (super-save-mode +1))

(use-package eyebrowse
  :after (evil)
  :config
  (eyebrowse-mode t)
  ;; (eyebrowse-setup-evil-keys)
  (setq eyebrowse-mode-line-separator "]   ["
	eyebrowse-new-workspace t
	eyebrowse-wrap-around t
	eyebrowse-mode-line-style t))

(use-package hydra
  :after eyebrowse
  :config
  (defhydra hydra-eyebrowse-nav (:hint nil)
    "
_n_: next            _0_: window config 0
_p_: prev            _1_: window config 1
_l_: last            _2_: window config 2
_c_: create config   _3_: window config 3
_D_: delete config   _4_: window config 4
_r_: rename config   _q_:quit"
    ("n" eyebrowse-next-window-config)
    ("p" eyebrowse-prev-window-config)
    ("l" eyebrowse-last-window-config)
    ("c" eyebrowse-create-window-config)
    ("D" eyebrowse-close-window-config)
    ("r" eyebrowse-rename-window-config)
    ("0" eyebrowse-switch-to-window-config-0)
    ("1" eyebrowse-switch-to-window-config-1)
    ("2" eyebrowse-switch-to-window-config-2)
    ("3" eyebrowse-switch-to-window-config-3)
    ("4" eyebrowse-switch-to-window-config-4)
    ("q" nil :color blue))
  (global-set-key (kbd "C-;") 'hydra-eyebrowse-nav/body)
  )

  (use-package engine-mode
    :defer 3
    :config
    (defengine quixy
      "https://quixy.swinfra.net/quixy/query/detail.php?ISSUEID=%s"
      :keybinding "q")

    (defengine duckduckgo
      "https://duckduckgo.com/?q=%s"
      :keybinding "d")
)
