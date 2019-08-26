(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 100
                    :weight 'normal
                    :width 'normal)
(load-file (expand-file-name "themes/my-default-theme.el" user-config-directory))

(defun highlight-selected-window ()
  "Highlight selected window with a different background color."
  (walk-windows (lambda (w)
                  (unless (eq w (selected-window))
                    (with-current-buffer (window-buffer w)
                      (buffer-face-set '(:background "gray95"))))))
  (buffer-face-set 'default))
(add-hook 'buffer-list-update-hook 'highlight-selected-window)

(global-hl-line-mode 1)
(set-face-background hl-line-face "lavender")

;; Adjust margins of all windows.
(defun center-windows () ""
  (walk-windows (lambda (window) (set-window-margins window 2 0)) nil 1))

;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)
(global-visual-line-mode)

(with-system windows-nt
  (load-user-file "conf-ui-windows.el"))

(with-system gnu/linux
  (load-user-file "conf-ui-linux.el"))
