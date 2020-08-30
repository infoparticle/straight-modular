(setq my-owspc-dir "~/.em/em.owspc/")
(defun /o/scratch       () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-scratch.org")))
(defun /o/inbox         () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-inbox.org/owspc-inbox.org")))
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
  (find-file "c:/users/gopinat/dropbox/emacs-apps/agile/one-page-agenda.org")
  (split-window-right 45)
  (find-file "c:/users/gopinat/dropbox/emacs-apps/agile/main.org")
)

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
(defun /bm/trade-journal       () (interactive) (find-file
"c:/Users/gopinat/Dropbox/emacs-apps/wikis/trading-wiki/contents/trading/journal/2020/trade-journal-2020-may-aug.org/trade-journal-2020-may-aug.org"
))

(use-package general
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
                                         :non-normal-prefix "M-SPC"
   "oj" '(/bm/orgroot-journal            :which-key "orgroot:daily-journal")
   "ow" '(my/pick-wiki-name              :which-key "Open wiki")
   "oo" '(my/one-page-project-management :which-key "Open one-page-project-manager")
   "rs" '(my/refer/code                  :which-key "refer:code" )
   "rP" '(my/refer/personal-projects     :which-key "personal projects" )
   "rp" '(my/refer/work-projects         :which-key "work projects" )
   "rc" '(my/refer/work-cases            :which-key "work cases" )
   "oi" '(hydra-open-inboxes/body        :which-key "inboxes" )
))


(with-system windows-nt
  (defun /bm/work () (interactive) (dired "c:/root/work")))

(setq wiki-root "C:\\Users\\gopinat\\Dropbox\\emacs-apps\\wikis")

(defun my/pick-wiki-name-action-list-candidates (str pred _)
  (setq wiki-list  (cl-delete-if (lambda (k) (string-match-p "^\\." k))
                                 (directory-files wiki-root))))

(defun my/pick-wiki-name-action (x)
  (my/open-wiki  wiki-root x))

(defun my/pick-wiki-name ()
  "pick a wiki from dropbox folder."
  (interactive)
  (ivy-read "List of wikis: "  #'my/pick-wiki-name-action-list-candidates
            :preselect (ivy-thing-at-point)
            :require-match t
            :action #'my/pick-wiki-name-action
            :caller 'my/pick-wiki-name))

(defun my/list-candidates (str pred _)
  (cl-delete-if (lambda (k) (string-match-p "^\\." k))
                (directory-files proj-dir-root)))

(defun my/pick-action (x)
  (projectile-find-file-in-directory  (concat proj-dir-root "/" x)))

(defun my/pick-proj-and-file (proj-dir-root)
  "pick a wiki from dropbox folder."
  (ivy-read "List of references: "  #'my/list-candidates
            :preselect (ivy-thing-at-point)
            :require-match t
            :action #'my/pick-action
            :caller 'my/pick-proj-and-file))

(defun my/refer/code ()
  (interactive)
  (my/pick-proj-and-file "c:/users/gopinat/dropbox/emacs-apps/references/code-refs"))

(defun my/refer/quotes ()
  (interactive)
  (my/pick-proj-and-file "c:/users/gopinat/dropbox/emacs-apps/references/quote-refs"))

(defun my/refer/facts ()
  (interactive)
  (my/pick-proj-and-file "c:/users/gopinat/dropbox/emacs-apps/references/fact-refs"))



(defun my/refer/personal-projects ()
  (interactive)
  (my/pick-proj-and-file "c:/users/gopinat/dropbox/emacs-apps/projects"))

(defun my/refer/work-projects ()
  (interactive)
  (my/pick-proj-and-file  my/work/project-dir-root))


(defun my/refer/work-cases ()
  (interactive)
  (my/pick-proj-and-file "C:\\my\\home\\.em\\em.work-2.0\\cases\\curr"))

(defun my/refer/work-tasks ()
  (interactive)
  (my/pick-proj-and-file "C:\\my\\home\\.em\\em.work-2.0\\tasks"))

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

(setq  my/work/case-data-dir-root "C:/my/work/cpe/data-dir/")
(setq  my/work/case-dir-root      "c:/my/home/.em/em.work-2.0/cases/")
(setq  my/work/task-dir-root      "C:/my/home/.em/em.work-2.0/tasks/")
(setq  my/work/project-dir-root   "C:/my/home/.em/em.work-2.0/projects/")

(setq my/work/personal-project-dir-root "c:/Users/gopinat/Dropbox/emacs-apps/projects/")

(require 'subr-x)
(defun encode-title-to-file-name (string)
  (replace-regexp-in-string "-*-" "-" (replace-regexp-in-string "[.!?'\"]+" "" (replace-regexp-in-string "[ \|.,:;/\\]+" "-" (string-trim string)))))

(defun my/work/create-new-case-or-project (prompt root-dir dir-suffix)
  (setq case-title
        (encode-title-to-file-name
         (setq actual-title
               (read-string prompt))))

  (message actual-title)
  (setq case-title-dir (concat root-dir case-title "." dir-suffix "/"))
  (mkdir (concat case-title-dir "/.img/") :parents)
  (mkdir (concat case-title-dir "/casedata/") :parents)
  (write-region (concat  "#+TITLE:" actual-title "\n" "#+Last Saved: <Jun 20, 2020>\n\n")
                nil (concat case-title-dir case-title "-summary.org"))
  (write-region "" nil (concat case-title-dir  ".projectile")))

(defun my/work/create-new-case () (interactive)
       (progn
         (my/work/create-new-case-or-project "Enter Case Title: "  (concat my/work/case-dir-root "curr/") "case")
                                        ;(mkdir (concat my/work/case-data-dir-root case-title))
         ))

(defun my/work/archive-cases () (interactive)
       (progn
        (find-file (concat my/work/case-dir-root "case-archive"))
        (split-window-right)
        (find-file (concat my/work/case-dir-root "curr"))))

(defun my/work/create-new-work-project () (interactive)
       (my/work/create-new-case-or-project "Enter Project Title: "  my/work/project-dir-root "proj"))

(defun my/work/create-new-personal-project () (interactive)
       (my/work/create-new-case-or-project "Enter Project Title: "  my/work/personal-project-dir-root "proj"))

(defun my/work/create-new-task () (interactive)
       (my/work/create-new-case-or-project "Enter Project Title: "  my/work/task-dir-root "task"))

(defun my/split-find-file(width_in_chars file-name)
(split-window-right width_in_chars) (find-file  file-name))
(defhydra hydra-open-inboxes (:color blue :hint nil :columns 1)
  "Wiki List"
  ("w" (my/split-find-file 80 "C:\\my\\home\\.em\\em.work-2.0\\inbox\\work-inbox.org") "Work 2.0 Inbox")
  ("q" nil "cancel" :color blue)
)

(defun my/string-utils/convert-backward-slash-to-forward-slash ()
  (interactive)
  (save-excursion
    (save-restriction
      (narrow-to-region (point) (mark))
      (goto-char (point-min))
      (while (search-forward "\\" nil t)
        (replace-match "/" nil t)))))

(defun my/trade/file-a-chart()
  (interactive)
  (progn
    (setq chart-gallery-root "C:/my/trading/charts/")
    (setq chart-file-name (concat chart-gallery-root (format-time-string "%Y/%b/%d-%a/%Y-%m-%d-%a.org")))
    (mkdir (concat chart-gallery-root (format-time-string "%Y/%b/%d-%a/.img")) :parents)
    (find-file chart-file-name)))

(defun my/trade/file-a-chart-quickly()
  (interactive)
  (progn
    (setq chart-gallery-root "C:/my/trading/charts/quick")
    (setq chart-file-name (concat chart-gallery-root (format-time-string "%Y/%b/%d-%a/%Y-%m-%d-%a.org")))
    (mkdir (concat chart-gallery-root (format-time-string "%Y/%b/%d-%a/.img")) :parents)
    (find-file chart-file-name)))
