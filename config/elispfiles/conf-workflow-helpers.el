(setq my-owspc-dir "~/.em/em.owspc/")
(defun /o/scratch       () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-scratch.org")))
(defun /o/inbox         () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-inbox.org")))
(defun /o/backlog       () (interactive) (find-file  (concat my-owspc-dir "apps/agenda/goals-backlog.org")))
(defun /o/web-bookmarks () (interactive) (find-file  (concat my-owspc-dir "apps/bookmarks/web-bookmarks.org")))
(defun /o/gtd           () (interactive) (find-file  "~/.em/emacs-apps/orgagenda/gtd-inbox.org"))
(defun /o/config        () (interactive) (dired  "~/.emacs.d/config"))
(defun /o/master-wiki   () (interactive) (split-window-right 30) (find-file  "~/.em/master-wiki.org"))

(defun my/one-page-project-management ()
  (interactive)
  (persp-mode t)
  (persp-frame-switch "one-page")
  (delete-other-windows)
  (find-file "c:/users/gopinat/dropbox/emacs-apps/agile/one-page-projects.org")
  (split-window-right)
  (find-file "c:/users/gopinat/dropbox/emacs-apps/agile/one-page-agenda.org"))

(defun my/open-wiki (wiki-root wiki-name)
  (if(file-directory-p wiki-root)
      (progn
        (persp-mode t)
        (persp-frame-switch wiki-name)
        (delete-other-windows)
        (find-file  (concat wiki-root "/" wiki-name "/contents/index.org"))
        (split-window-right 30)
        (find-file-other-window (concat wiki-root "/" wiki-name "/tmp/" wiki-name "-" "inbox.org"))
        (when (file-exists-p  (concat wiki-root "/" ".config.el"))
          (load-file  (concat wiki-root "/" ".config.el"))))
    (message "Wiki not found %s" wiki-root)))

(defun /o/work-wiki    () (interactive) (my/open-wiki "~/.em/" "em.work-wiki"))
(defun /o/books-wiki   () (interactive) (my/open-wiki "~/.em/" "em.books-wiki"))
(defun /o/swcraft-wiki () (interactive) (my/open-wiki "~/.em/" "em.swcraft-wiki"))
(defun /o/life-wiki    () (interactive) (my/open-wiki "I:/emacs-apps/wikis/" "life-wiki"))
(defun /o/trading-wiki () (interactive) (my/open-wiki "~/.em/" "trading-wiki"))
(defun /o/home-wiki    () (interactive) (my/open-wiki "C:\\Users\\gopinat\\Dropbox\\wikis\\" "home-wiki"))
(defun /o/password     () (interactive) (find-file   "E:/mydata/credentials/pass.org.gpg"))


(use-package projectile
  :config
  (defun my/open-projectile-file(pathprefix filename)
    (find-file (concat (projectile-project-root) pathprefix (projectile-project-name) "-" filename ".org")))

  (defun my/open-projectile-file-scratch()
    (interactive)
    (my/open-projectile-file "tmp/" "scratch" ))

  (defun my/open-projectile-file-inbox ()
    (interactive)
    (my/open-projectile-file "tmp/" "inbox"))


                                        ; (file-name-directory (directory-file-name "/a/b/c"))     ;;returns /a/b
                                        ; (file-name-nondirectory (directory-file-name "/a/b/c"))  ;;returns c

  (defun my/open-projectile-wiki-index ()
    (interactive)
    (my/open-wiki
     (file-name-directory (directory-file-name (projectile-project-root)))
     (file-name-nondirectory (directory-file-name (projectile-project-root)))))
  )

(defun /ref/bash/if        () (interactive) (find-file-other-window "~/.em/em.ref/bash/if.org"))
(defun /ref/bash/scripting () (interactive) (find-file-other-window "~/.em/em.ref/bash/scripting.org"))
(defun /ref/bash/bash-to-python () (interactive) (find-file-other-window "~/.em/em.ref/bash/bash-to-python.org"))
(defun /ref/bash/sed-awk () (interactive) (find-file-other-window "~/.em/em.ref/bash/sed-awk.org"))
(defun /ref/emacs/tramp    () (interactive) (find-file-other-window "~/.em/em.ref/emacs/tramp.org"))
(defun /bm/trading-inbox () (interactive) (find-file-other-window "~/.em/em.finance/trading/trading-inbox.org"))

(defun /bm/orgroot-journal       () (interactive) (find-file  "~/.em/em.orgroot/gtd/daily-journal.org"))

(use-package general
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "oj" '(/bm/orgroot-journal       :which-key "orgroot:daily-journal")
   "ow" '(my/pick-wiki-name         :which-key "Open wiki")
   "oo" '(my/one-page-project-management         :which-key "Open one-page-project-manager")
   "rb" '(/ref/bash/scripting       :which-key "bash:scripting" )))


(with-system windows-nt
  (defun /bm/work () (interactive) (dired "c:/root/work")))

(defun my/pick-wiki-name-action-list-candidates (str pred _)
  (setq wiki-root "C:\\Users\\gopinat\\Dropbox\\wikis")
  (setq wiki-list  (cl-delete-if (lambda (k) (string-match-p "\\." k))
                                 (directory-files wiki-root))))

(defun my/pick-wiki-name-action (x)
  (my/open-wiki  "C:/Users/gopinat/Dropbox/wikis" x))

(defun my/pick-wiki-name ()
  "pick a wiki from dropbox folder."
  (interactive)
  (ivy-read "List of wikis: "  #'my/pick-wiki-name-action-list-candidates
            :preselect (ivy-thing-at-point)
            :require-match t
            :action #'my/pick-wiki-name-action
            :caller 'my/pick-wiki-name))

(setq work-agenda-file "c:/Users/gopinat/AppData/Roaming/.em/em.work-wiki/contents/work-agenda-del.org")
(setq org-capture-templates
      '(
        ("t" "Tasks")

        ;; TODO     (t) Todo template
        ("tc" "TODO" entry (file work-agenda-file)
         "* TODO %?
  :PROPERTIES:
  :Created: %U
  :Type:  %^{Type|Case|Task|Project}

  :END:
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:" :empty-lines 1)


        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")

        ("i" "inbox" entry (file+datetree "~/org/org-inbox.org")
         "* %?
  :PROPERTIES:
  :Created: %U
  :Category:  %^{Category|Work|Philosophy|Trading|Others}
  :END:" :empty-lines 1)
        ("E" "Create Event and Clock In" entry
         (file+datetree+prompt "~/org/events.org")
         "* %?\n%T" :clock-in t :clock-keep t)
        )
      )

(defun open-in-browser()
  "open buffer in browser, unless it is not a file. Then fail silently (ouch)."
  (interactive)
  (if (buffer-file-name)
      (let ((filename (buffer-file-name)))
        (shell-command (concat "start firefox.exe \"file://" filename "\"")))))
