(defun set-proxy()
(interactive)
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
        ("http" . "15.122.63.30:8080")
        ("https" . "15.122.63.30:8080"))))

(defun unset-proxy()
(interactive)
(setq url-proxy-services nil))

(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(defun volatile-kill-buffer ()
   "Kill current buffer unconditionally."
   (interactive)
   (let ((buffer-modified-p nil))
     (kill-buffer (current-buffer))
     (delete-window)))
