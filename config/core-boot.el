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


(defun highlight-selected-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "gray95"))))))
  (buffer-face-set 'default))
(add-hook 'buffer-list-update-hook 'highlight-selected-window)

(defun init-mode-line-for-gui()
  (progn
    (setq-default mode-line-format
                  (
                   quote(
                         " "
                         (:eval
                          (when (eql buffer-read-only t)
                            (propertize " 🔒 " 'face
                                        '(; :background "color-88"
                                          :foreground "gray60" :weight bold))))
                         (:eval
                          (propertize "⚫" 'face
                                      (if (buffer-modified-p)
                                          '(
                                        ;:background "light slate blue"
					                        :background "gray90"
							                :foreground "Indian red"
							                :weight bold)
                                        '(
					                      :background "gray90"
                                          :foreground "gray90"
                                          :weight bold :underline nil :height 100 )
                                        )))
                         
                         " %b    "
                         mode-line-misc-info)))

    ;(set-face-attribute 'mode-line           nil :background "slateblue" :box '(:line-width 1 :color "slateblue" ))
    ;(set-face-attribute 'mode-line-inactive  nil :background "gray60"   :box '(:line-width 1 :color "gray60" ))))
    (set-face-attribute 'mode-line           nil :background "gray90" :box '(:line-width 1 :color "gray80" ))
    (set-face-attribute 'mode-line-inactive  nil :background "gray90"   :box '(:line-width 1 :color "gray90" ))))

(init-mode-line-for-gui)
