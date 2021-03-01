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

(defun gs/volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))
    (delete-window)))

(global-set-key (kbd "C-x k") 'gs/volatile-kill-buffer)

(defun gs/find-file-reuse-buffer ()
  "find file and close previous file"
  (interactive)
  (save-buffer)
  (counsel-find-file)
  (kill-buffer (previous-buffer)))
(global-set-key (kbd "C-x C-f") 'gs/find-file-reuse-buffer)

(defun gs/vsplit-previous-buff ()
  "find file and close previous file"
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-x 2")   'gs/vsplit-previous-buff)

(defun gs/hsplit-previous-buff ()
  "find file and close previous file"
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-x 3")   'gs/hsplit-previous-buff)

(defun my/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


(defun gs/rotate-windows (count)
  "Rotate your windows.
Dedicated windows are left untouched. Giving a negative prefix
argument makes the windows rotate backwards."
  (interactive "p")
  (let* ((non-dedicated-windows (remove-if 'window-dedicated-p (window-list)))
         (num-windows (length non-dedicated-windows))
         (i 0)
         (step (+ num-windows count)))
    (cond ((not (> num-windows 1))
           (message "You can't rotate a single window!"))
          (t
           (dotimes (counter (- num-windows 1))
             (let* ((next-i (% (+ step i) num-windows))

                    (w1 (elt non-dedicated-windows i))
                    (w2 (elt non-dedicated-windows next-i))

                    (b1 (window-buffer w1))
                    (b2 (window-buffer w2))

                    (s1 (window-start w1))
                    (s2 (window-start w2)))
               (set-window-buffer w1 b2)
               (set-window-buffer w2 b1)
               (set-window-start w1 s2)
               (set-window-start w2 s1)
               (setq i next-i)))))))


(defun gs/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun my/util/beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))

(setq m/sidebar "~/.em/em.orgroot/sidebar.org")
(use-package load-theme-buffer-local :ensure t)
(setq m/is-sidebar-theme-set nil)
(defun m/showindex ()
  "Show the index of current projects"
  (interactive)
  (let ((buffer (get-file-buffer m/sidebar)))
    (progn
      (display-buffer-in-side-window buffer '((side . left) (window-width . 0.25)))
      (set-window-dedicated-p (get-buffer-window buffer) t)
      (select-window (get-buffer-window buffer))
      (when (not m/is-sidebar-theme-set)
        ;; (load-theme-buffer-local 'doom-gruvbox (get-file-buffer m/sidebar))
        (org-num-mode)
        (setq m/is-sidebar-theme-set t))
      ;; (m/index-faces)
      )))

(defun m/hideindex ()
  "Hide the index of current projects"
  (interactive)
  (let ((buffer (get-file-buffer m/sidebar)))
    (progn
      (delete-window (get-buffer-window buffer)))))

(defun m/toggleindex ()
  "Toggle the index of current projects"
  (interactive)
  (let* ((buffer (get-file-buffer m/sidebar))
         (window (get-buffer-window buffer)))
    (if (and buffer window)
        (m/hideindex)
      (progn
        (find-file-noselect m/sidebar)
        (m/showindex)))))

(defun m/toggleindex-public ()
  "Set the sidebar file and toggle it"
  (interactive)
  (setq m/sidebar "~/.em/em.orgroot/sidebar.org")
  (m/toggleindex))


(defun m/toggleindex-private ()
  "Set the sidebar file and toggle it"
  (interactive)
  (setq m/sidebar "~/.em/em.orgroot/sidebar-private.org")
  (m/toggleindex))

(global-set-key (kbd "C-<f1>") 'm/toggleindex-public)
(global-set-key (kbd "C-<f2>") 'm/toggleindex-private)

(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))
