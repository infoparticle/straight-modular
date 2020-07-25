(require 'url-util) ;needed for encoding spaces to %20

(defun my/create-rich-doc()
  (interactive)
  ;; (setq parent-dir (file-name-nondirectory (directory-file-name (file-name-directory buffer-file-name))))
  (setq myvar/img-folder-path (concat default-directory ".img/"))
  (if (file-exists-p myvar/img-folder-path)
      (message "need NOT create new dirs")
    (progn
      (setq myvar/cursor-location (point))
      (save-buffer)
      (rename-file buffer-file-name (concat buffer-file-name "-tmp"))
      ;; (make-directory buffer-file-name)
      (setq myvar/img-folder-path (concat buffer-file-name "/.img/"))
      (make-directory myvar/img-folder-path :parents)
      (setq target-file-path (concat buffer-file-name "/" (file-name-nondirectory buffer-file-name)))
      (rename-file (concat buffer-file-name "-tmp")  target-file-path)
      (kill-buffer)
      (find-file target-file-path)
      (forward-char myvar/cursor-location))))

(defun my/img-maker ()
  (my/create-rich-doc)
  (setq myvar/img-name (concat (format-time-string "%Y%m%d-%H%M%S") ".png"))
  (setq myvar/img-Abs-Path (replace-regexp-in-string "/" "\\" (concat myvar/img-folder-path myvar/img-name) t t)) ;Relative to workspace.
  (setq myvar/relative-filename (concat "./.img/" myvar/img-name))
  (org-insert-heading)
  (insert (concat (read-string (format"Enter Image Header (%s): " myvar/img-name) nil nil  myvar/img-name) "\n"))
  (insert "\n[[file:" (url-encode-url myvar/relative-filename) "]]" "\n")
  )

(defun org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
 sub-directory (%filenameIMG) as the org-buffer and insert a link to this file."
  (interactive)
                                        ;(evil-insert)
  (my/img-maker)
                                        ;(make-frame-invisible)
                                        ;(lower-frame)
  (message myvar/img-Abs-Path)
  (call-process "c:\\opt\\irfan32\\i_view32.exe" nil nil nil (concat "/clippaste /convert="  myvar/img-Abs-Path))
                                        ;(raise-frame)
                                        ;(make-frame-visible)
  (org-display-inline-images)
  )

(global-set-key [f5] 'org-screenshot)
