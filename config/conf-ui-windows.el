(setq-default mode-line-format
              (
               quote(
                     " "
                     (:eval
                      (when (eql buffer-read-only t)
                        (propertize " 🔒 " 'face
                                    '( ; :background "color-88"
                                      :foreground "gray60" :weight bold))))
                     (:eval
                      (propertize "●" 'face
                                  (if (buffer-modified-p)
                                      '(:background "gray90" :foreground "Indian red" :weight bold)
                                    '(:background "gray90" :foreground "gray90" :weight bold ))))
                     
                     " %b    "
                     mode-line-misc-info)))
(set-face-attribute 'mode-line           nil :background "gray90" :box '(:line-width 1 :color "gray80" ))
(set-face-attribute 'mode-line-inactive  nil :background "gray90"   :box '(:line-width 1 :color "gray90" ))

(defun highlight-selected-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "gray95"))
                      (visual-line-mode 1)))))
  (buffer-face-set 'default)
  (visual-line-mode -1))
(add-hook 'buffer-list-update-hook 'highlight-selected-window)

(global-hl-line-mode 1)
(set-face-background hl-line-face "lavender")

;; Adjust margins of all windows.
(defun center-windows () ""
  (walk-windows (lambda (window) (set-window-margins window 2 0)) nil 1))

;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)
(global-visual-line-mode)
