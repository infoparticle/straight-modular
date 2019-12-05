(prefer-coding-system 'utf-8)
(setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
(setq explicit-bash.exe-args '("--login" "-i"))

(defun conf/ondemand/windows/spellcheck()
  (interactive)
  (progn
    (setq-default ispell-program-name "C:/opt/hunspell/bin/hunspell.exe")
    ;; "en_US" is key to lookup in `ispell-local-dictionary-alist`, please note it will be passed   to hunspell CLI as "-d" parameter
    (setq ispell-local-dictionary "en_US")
    (setq ispell-local-dictionary-alist
          '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
    (setq text-mode-hook '(lambda() (flyspell-mode t)))))


;; (conf/windows/spellcheck)

(defun conf/ondemand/windows/gpg()
  (interactive)
  (require 'epa-file)
  (custom-set-variables '(epg-gpg-program  "C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe"))
  (custom-set-variables '(epg-gpgconf-program  "C:\\Program Files (x86)\\GnuPG\\bin\\gpgconf.exe"))
  (custom-set-variables '(epg-gpg-home-directory  "c:\\Users\\gopinat\\AppData\\Roaming\\gnupg"))
  ;(epa-file-enable)
  )

(conf/ondemand/windows/gpg)

(require 'url-util) ;needed for encoding spaces to %20
(defun my/img-maker ()
  "Make folder if not exist, define image name based on time/date"
  (setq myvar/img-folder-path (concat default-directory ".img/" (buffer-name) "/"))

  (if (not (file-exists-p myvar/img-folder-path))
      (make-directory myvar/img-folder-path :parents))

  (setq myvar/img-name (concat (format-time-string "%Y%m%d-%H%M%S-") (read-from-minibuffer "image name:" (buffer-name)) ".png"))
  (setq myvar/img-Abs-Path (replace-regexp-in-string "/" "\\" (concat myvar/img-folder-path myvar/img-name) t t)) ;Relative to workspace.
  (setq myvar/relative-filename (concat "./.img/" (buffer-name) "/" myvar/img-name))
  (insert "[[file:" (url-encode-url myvar/relative-filename) "]]" "\n")
  )


;; TODO need to add the filename in the image

(defun org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
 sub-directory (%filenameIMG) as the org-buffer and insert a link to this file."
  (interactive)
  ;(evil-insert)
  (my/img-maker)
                                        ;(make-frame-invisible)
  ;(lower-frame)
  (call-process "c:\\opt\\irfan32\\i_view32.exe" nil nil nil (concat "/clippaste /convert="  myvar/img-Abs-Path))
  ;(raise-frame)
                                        ;(make-frame-visible)
  (org-display-inline-images)
  )

(global-set-key [f5] 'org-screenshot)

(setq my-owspc-dir "~/.em/em.owspc/")
;; windows python config
(when (file-exists-p "C:/opt/anaconda3/python.exe")
  (setq python-shell-interpreter "C:/opt/anaconda3/python.exe")
                                        ;(setq exec-path (append '("C:/opt/anaconda3/pkgs/python-3.7.3-h8c8aaf0_1") exec-path))
  )


(when (file-exists-p "C:/opt/ripgrep/rg.exe")
  (setq exec-path (append '("C:/opt/ripgrep") exec-path))
  (setq helm-grep-ag-command "C:\\opt\\ripgrep\\rg.exe --smart-case --no-heading --line-number %s %s %s"))

(cd "c:/my/tmp")
