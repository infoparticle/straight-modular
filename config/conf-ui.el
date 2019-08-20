(set-face-attribute 'default nil
                                        ;:family "Fira Code medium"
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

(with-system windows-nt
  (load-user-file "conf-ui-windows.el"))

(with-system gnu/linux
  (load-user-file "conf-ui-linux.el"))
