
(setq-default mode-line-format
	      (
	       quote(
		     " "
		     (:eval
		      (propertize "[RO]" 'face
				  (if (eql buffer-read-only t)
				      '(:background "gray90" :foreground "gray60" :weight bold)
				    '(:background "gray90" :foreground "gray90" :weight bold ))))
	
		     (:eval
		      (propertize " [M]" 'face
				  (if (buffer-modified-p)
				      '(:background "gray90" :foreground "gray60" :weight bold)
				    '(:background "gray90" :foreground "gray90" :weight bold ))))
		     
		     " %b ")))
(set-face-attribute 'mode-line           nil :background "gray90" :box '(:line-width 1 :color "gray80" ))
(set-face-attribute 'mode-line-inactive  nil :background "gray90"   :box '(:line-width 1 :color "gray90" ))

