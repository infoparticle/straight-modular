;;; Цветные скобочки
(use-package
  rainbow-delimiters
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (setq rainbow-delimiters-max-face-count 9))

;;; Scrolling
(setq scroll-step               1) ;; one line
(setq scroll-margin            10) ;; scroll buffer to 10 lines at going to last line
(setq scroll-conservatively 10000)
(setq directory-free-space-args "-Pm")
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

