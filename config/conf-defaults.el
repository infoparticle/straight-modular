(setq load-prefer-newer t) ;; always load new .elc never older


(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-terminal-coding-system  'utf-8)          ; make sure that UTF-8 is used everywhere
(set-keyboard-coding-system  'utf-8)
(set-language-environment    'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(prefer-coding-system        'utf-8)
(set-input-method nil)

(setq system-time-locale "en_US")

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; RET key autoindents
(define-key global-map (kbd "RET") 'newline-and-indent)
;; delete the selection with a keypress
(delete-selection-mode t)


(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)

;; electric indent
(electric-indent-mode t)
(transient-mark-mode t)

(global-auto-revert-mode t)

(when (featurep 'menu-bar) (menu-bar-mode -1))
(when (featurep 'tool-bar) (tool-bar-mode -1))
(when (featurep 'scroll-bar) (scroll-bar-mode -1))
(blink-cursor-mode -1)
(set-fringe-mode 0)

(setq inhibit-startup-screen t)
(blink-cursor-mode -1)

(setq visible-bell nil)
(setq ring-bell-function #'ignore)
(setq initial-scratch-message "")

                                        ;(setq-default truncate-lines t)
(toggle-truncate-lines)

;;better wild cards in search
(setq search-whitespace-regexp ".*?")

;;enable narrow-to-region
(put 'narrow-to-region 'disabled nil)

;; pcomplete
(setq pcomplete-ignore-case t)

;; imenu
(setq-default imenu-auto-rescan t)

(defconst user-cache-directory
  (file-name-as-directory (concat user-emacs-directory ".cache"))
  "My emacs storage area for persistent files.")
;; create the `user-cache-directory' if not exists
(make-directory user-cache-directory t)
(setq url-configuration-directory (concat user-cache-directory "url/"))
(setq tramp-persistency-file-name (concat user-cache-directory "tramp"))

(setq initial-major-mode 'org-mode) ; scratch buffer is in org-mode now

(global-superword-mode 1)
;(global-hl-line-mode 1)
;(set-face-background hl-line-face nil)
(eldoc-mode 1)
(setq inhibit-compacting-font-caches t)

;;; Scrolling
(setq scroll-step               1) ;; one line
(setq scroll-margin            10) ;; scroll buffer to 10 lines at going to last line
(setq scroll-conservatively 10000)
(setq directory-free-space-args "-Pm")

(show-paren-mode 1)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-mismatch nil 
                    :weight 'bold :underline t :overline nil :slant 'normal)
(custom-set-faces
 '(show-paren-match ((((class color) (background light)) (:background "linen")))))
