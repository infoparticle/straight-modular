;; some of the configurations make windows painfully slow
;; some configurations are path dependent, all these configs belong here.


(defun conf/windows/spellcheck()
  (interactive)
  (progn
    (setq-default ispell-program-name "C:/opt/hunspell/bin/hunspell.exe")
    ;; "en_US" is key to lookup in `ispell-local-dictionary-alist`, please note it will be passed   to hunspell CLI as "-d" parameter
    (setq ispell-local-dictionary "en_US") 
    (setq ispell-local-dictionary-alist
          '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
    (setq text-mode-hook '(lambda() (flyspell-mode t)))))


;; (conf/windows/spellcheck)


;; org-agenda
;; (setq org-agenda-include-diary t)
;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
;; (setq org-agenda-files (list "C:/Users/gopinat.CORPDOM/Dropbox/Orgzly/gtd-inbox.org"
;;                              "C:/Users/gopinat.CORPDOM/Dropbox/Orgzly/gtd.org"
;;                              "C:/Users/gopinat.CORPDOM/Dropbox/Orgzly/tickler.org"))
(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))



(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

;; (require 'epa-file)
;; (custom-set-variables '(epg-gpg-program  "C:\\msys64\\usr\\bin\\gpg.exe"))
;; (custom-set-variables '(epg-gpgconf-program  "C:\\msys64\\usr\\bin\\gpgconf.exe"))
;; (custom-set-variables '(epg-gpg-home-directory  "c:\\Users\\gopinat\\AppData\\Roaming\\gnupg"))
;; (epa-file-enable)


(defun conf/windows/gpg()
  (interactive)
  (require 'epa-file)
  (custom-set-variables '(epg-gpg-program  "C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe"))
  (custom-set-variables '(epg-gpgconf-program  "C:\\Program Files (x86)\\GnuPG\\bin\\gpgconf.exe"))
  (custom-set-variables '(epg-gpg-home-directory  "c:\\Users\\gopinat.CORPDOM\\AppData\\Roaming\\gnupg"))
  (epa-file-enable)
  )

(conf/windows/gpg)
;; (setf epa-pinentry-mode 'loopback)

;; pdf-tools
;;; put precompiled epdfinfo.exe ~/.emacs.d/elpa/pdf-tools-yyyymmdd.vvv/epdfinfo.exe
;; more tips: http://pragmaticemacs.com/emacs/more-pdf-tools-tweaks/
;; (use-package pdf-tools :ensure t
;;   :config
;;   (setenv "PATH" (concat "C:\\opt\\emaxw64\\bin;" (getenv "PATH"))))
;; (pdf-tools-install)

;;; screenshot capture
(require 'url-util)
(defun my/img-maker ()
  "Make folder if not exist, define image name based on time/date"
  (setq myvar/img-folder-path (concat default-directory ".img/"))

                                        ; Make img folder if it doesn't exist.
  (if (not (file-exists-p myvar/img-folder-path)) ;[ ] refactor this and screenshot code.
      (mkdir myvar/img-folder-path))

  (setq myvar/img-name (concat (format-time-string "%Y%m%d_%H%M%S_") (read-from-minibuffer "image name:" (buffer-name)) ".png"))
  (setq myvar/img-Abs-Path (replace-regexp-in-string "/" "\\" (concat myvar/img-folder-path myvar/img-name) t t)) ;Relative to workspace.
  (setq myvar/relative-filename (concat "./.img/" myvar/img-name))
  (insert "[[file:" (url-encode-url myvar/relative-filename) "]]" "\n")
  )


;; TODO need to add the filename in the image

(defun org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
 sub-directory (%filenameIMG) as the org-buffer and insert a link to this file."
  (interactive)
  (my/img-maker)
                                        ;(make-frame-invisible)
  (lower-frame)
  (call-process "c:\\opt\\irfan32\\i_view32.exe" nil nil nil (concat "/clippaste /convert="  myvar/img-Abs-Path))
  (raise-frame)
                                        ;(make-frame-visible)
  (org-display-inline-images)
  )

(global-set-key [f5] 'org-screenshot)


;;https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/d8cmm7v/
(setq gc-cons-threshold (* 511 1024 1024))
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 10 t #'garbage-collect)


;; org work space directory

(setq my-owspc-dir "~/.em/em.owspc/")

(setenv "PATH" (concat "c:/opt/ripgrep;C:/opt/gnuplot/bin;" (getenv "PATH")))
(cd "c:/root/work/tmp")


(add-to-list 'load-path "~/.emacs.d/site-lisp/gnuplot-mode/")
(require 'gnuplot)
(setq gnuplot-program "C:\\opt\\gnuplot\\bin\\gnuplot.exe")

;; windows python config
(when (file-exists-p "C:/opt/anaconda3/pkgs/python-3.7.3-h8c8aaf0_1/python.exe")
  (setq python-shell-interpreter "C:/opt/anaconda3/pkgs/python-3.7.3-h8c8aaf0_1/python.exe")
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-home-directory "c:\\Users\\gopinat.CORPDOM\\AppData\\Roaming\\gnupg")
 '(epg-gpg-program "C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe")
 '(epg-gpgconf-program "C:\\Program Files (x86)\\GnuPG\\bin\\gpgconf.exe")
 '(org-hide-emphasis-markers nil)
 )


(setq exec-path (append '("C:/opt/ripgrep") exec-path))
