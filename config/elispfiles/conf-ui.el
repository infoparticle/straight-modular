(set-face-attribute 'default nil
                    :family "Consolas"
                    :height 100
                    :weight 'normal
                    :width 'normal)
(load-file (expand-file-name "config/themes/my-default-theme.el" user-emacs-directory))

(with-system windows-nt
  (load-user-file "conf-ui-windows.el"))

(with-system gnu/linux
  (load-user-file "conf-ui-linux.el"))
