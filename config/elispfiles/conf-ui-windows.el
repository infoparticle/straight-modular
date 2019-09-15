(setq-default mode-line-format
              (
               quote(
                     "  "
                     (:eval
                      (when (eql buffer-read-only t)
                        (propertize " [R] " 'face
                                    '( ; :background "color-88"
                                      :foreground "gray60" :weight bold))))
                     (:eval
                      (propertize "●" 'face
                                  (if (buffer-modified-p)
                                      '(:foreground "Indian red" :weight bold)
                                    '(:foreground "gray93" :weight bold ))))

                     (:eval (propertize " %b" 'face
                                      '(:foreground "gray30" :weight bold)))

                     mode-line-misc-info)))
(set-face-attribute 'mode-line           nil :background "gray90" :box '(:line-width 1 :color "gray80" ))
(set-face-attribute 'mode-line-inactive  nil :background "gray95" :box nil)

(defun highlight-selected-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "gray95"))))))
  (buffer-face-set 'default))
;(add-hook 'buffer-list-update-hook 'highlight-selected-window)

(global-hl-line-mode 1)
(set-face-background hl-line-face "lavender")

;; Adjust margins of all windows.
(defun center-windows () ""
  (walk-windows (lambda (window) (set-window-margins window 2 0)) nil 1))

;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)
(global-visual-line-mode)
