
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
                      (propertize "⚫" 'face
                                  (if (buffer-modified-p)
                                      '(:background "gray90" :foreground "Indian red" :weight bold)
                                    '(:background "gray90" :foreground "gray90" :weight bold ))))
                     
                     " %b    "
                     mode-line-misc-info)))
(set-face-attribute 'mode-line           nil :background "gray90" :box '(:line-width 1 :color "gray80" ))
(set-face-attribute 'mode-line-inactive  nil :background "gray90"   :box '(:line-width 1 :color "gray90" ))

