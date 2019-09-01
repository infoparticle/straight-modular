(setq my-owspc-dir "~/.em/em.owspc/")
(defun /o/scratch       () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-scratch.org")))
(defun /o/inbox         () (interactive) (find-file  (concat my-owspc-dir "inbox/owspc-inbox.org")))
(defun /o/backlog       () (interactive) (find-file  (concat my-owspc-dir "apps/agenda/goals-backlog.org")))
(defun /o/web-bookmarks () (interactive) (find-file  (concat my-owspc-dir "apps/bookmarks/web-bookmarks.org")))
(defun /o/gtd           () (interactive) (find-file  "~/.em/emacs-apps/orgagenda/gtd-inbox.org"))
(defun /o/config        () (interactive) (dired  "~/.emacs.d/config"))
(defun /o/master-wiki   () (interactive) (split-window-right 30) (find-file  "~/.em/master-wiki.org"))

(defun my/open-wiki (wiki-root wiki-name)
  (delete-other-windows)
  (find-file  (concat wiki-root "/" wiki-name "/contents/index.org"))
  (split-window-right 30)
  (find-file-other-window (concat wiki-root "/" wiki-name "/tmp/" wiki-name "-" "inbox.org"))
  )

(defun /o/work-wiki    () (interactive) (my/open-wiki "~/.em/" "em.work-wiki"))
(defun /o/books-wiki   () (interactive) (my/open-wiki "~/.em/" "em.books-wiki"))
(defun /o/swcraft-wiki () (interactive) (my/open-wiki "~/.em/" "em.swcraft-wiki"))
(defun /o/life-wiki    () (interactive) (my/open-wiki "I:/emacs-apps/wikis/" "life-wiki"))
(defun /o/trading-wiki () (interactive) (my/open-wiki "~/.em/" "trading-wiki"))
(defun /o/home-wiki    () (interactive) (my/open-wiki "C:\\Users\\gopinat.CORPDOM\\Dropbox\\wikis\\" "home-wiki"))
(defun /o/password     () (interactive) (find-file   "z:/emacs-apps/pass.org"))

(defhydra hydra-open-wiki (:color blue :hint nil :columns 1)
"Wiki List"
   ("a" (my/open-wiki "I:/emacs-apps" "accounting") "Accounting Wiki")
   ("w" (my/open-wiki "~/.em" "em.work-wiki") "Work Wiki")
   ("s" (my/open-wiki "~/.em/" "em.swcraft-wiki") "Software Craft Wiki")
   ("q" nil "cancel" :color blue)
)

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
   "ow" '(hydra-open-wiki/body           :which-key "Open wiki")
   "rb" '(/ref/bash/scripting       :which-key "bash:scripting" )))


(with-system windows-nt
  (defun /bm/work () (interactive) (dired "c:/root/work")))
