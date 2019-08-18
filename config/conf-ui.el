(set-face-attribute 'default nil
                                        ;:family "Fira Code medium"
                    :family "Consolas"
                    :height 100
                    :weight 'normal
                    :width 'normal)
(load-file (expand-file-name "themes/my-default-theme.el" user-config-directory))

(with-system windows-nt
  (load-user-file "conf-ui-windows.el"))

(with-system gnu/linux
  (load-user-file "conf-ui-linux.el"))
