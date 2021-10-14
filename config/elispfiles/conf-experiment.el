(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title  "Welcome!"
        dashboard-startup-banner "~/.emacs.d/resources/images/screen-on-fire.png"
        dashboard-center-content t
        dashboard-set-file-icons nil
        dashboard-set-heading-icons nil
        dashboard-set-init-info t
        dashboard-set-navigator t
        dashboard-items '((recents . 25)
                          (bookmarks . 25)
                          (projects . 25)
                          (agenda . 25))
        initial-buffer-choice (lambda () (switch-to-buffer "*dashboard*"))))

(message "Conf experiment loaded!")
