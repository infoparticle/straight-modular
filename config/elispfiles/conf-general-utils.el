(defun set-proxy()
  (interactive)
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|10.*\\)")
          ("http" . "15.122.63.30:8080")
          ("https" . "15.122.63.30:8080"))))

(defun unset-proxy()
  (interactive)
  (setq url-proxy-services nil)
  (setenv "HTTP_PROXY" "")
  (setenv "HTTPS_PROXY" "")
)

(defun server-shutdown ()
"Save buffers, Quit, and Shutdown (kill) server"
(interactive)
(save-some-buffers)
(kill-emacs)
)

(defun my/byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory (concat user-emacs-directory "config/elispfiles/") 0))

(defun volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))
    (delete-window)))

(global-set-key (kbd "C-x k") 'volatile-kill-buffer)

(defun my/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun my/util/beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))

(setq m/sidebar "~/.em/em.orgroot/sidebar.org")
(defun m/index-faces ()
  (setq header-line-format nil)
  (face-remap-add-relative 'default '(:background "#f8f7fa" :foreground default))
  (face-remap-add-relative 'org-level-1 '(:foreground "#756a6b"))
  (face-remap-add-relative 'org-hide '(:background "#f8f7fa"))
  (face-remap-add-relative 'org-agenda-filter-tags '(:background "#f8f7fa" :foreground "#ff6678") :box '(:line-width 5 :color "#f8f7fa"))
  (face-remap-add-relative 'org-block-begin-line '(:background "#f8f7fa"))
  (face-remap-add-relative 'org-block-end-line '(:background "#f8f7fa"))
  (face-remap-add-relative 'org-block '(:background "#f3f2f5"))
  )
(defun m/showindex ()
  "Show the index of current projects"
(interactive)
  (let ((buffer (get-file-buffer m/sidebar)))
    (progn
      (display-buffer-in-side-window buffer '((side . left) (window-width . 0.25)))
      (set-window-dedicated-p (get-buffer-window buffer) t)
      (select-window (get-buffer-window buffer))
      (m/index-faces)
      )))

(defun m/hideindex ()
  "Hide the index of current projects"
(interactive)
  (let ((buffer (get-file-buffer m/sidebar)))
    (progn
      (delete-window (get-buffer-window buffer))
      )))

(defun m/toggleindex ()
  "Toggle the index of current projects"
  (interactive)
  (let* ((buffer (get-file-buffer m/sidebar))
         (window (get-buffer-window buffer)))
    (if window
        (m/hideindex)
      (m/showindex)
      )))

(global-set-key (kbd "C-M-SPC") 'm/toggleindex)
