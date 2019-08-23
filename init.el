(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq user-config-directory (concat user-emacs-directory "config/"))

(setq gc-cons-threshold (* 500 1024 1024))
(eval-when-compile (require 'cl))
(lexical-let ((emacs-start-time (current-time)))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
                (message "[Emacs initialized in %.3fs]" elapsed)))))

(load-file (expand-file-name "conf-init.el" user-config-directory))
