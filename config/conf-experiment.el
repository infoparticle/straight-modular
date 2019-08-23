(set-face-attribute 'fringe nil :background nil)
(defun my-tone-down-fringes ()
  (set-face-attribute 'fringe nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default)))
(my-tone-down-fringes)
