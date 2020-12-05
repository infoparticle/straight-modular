(use-package org
:mode (("\\.org$" . org-mode))
:config
(progn
;; config stuff
(define-key org-mode-map (kbd "RET") 'org-return-indent)))

(use-package ox-clip
  :defer t)

(use-package org-cliplink
  :defer t
  :config
  (global-set-key (kbd "C-x p i") 'org-cliplink))

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-preview-latex-default-process 'dvipng)

(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/tools/plantuml.jar"))

(setq
 time-stamp-active t          ; do enable time-stamps
 time-stamp-pattern "34/\\(\\(L\\|l\\)ast\\( \\|-\\)\\(\\(S\\|s\\)aved\\|\\(M\\|m\\)odified\\|\\(U\\|u\\)pdated\\)\\|Time-stamp\\) *: [\"]%b %02d %a, %:y[\"]")

;; can also add this to source code: // (set-variable time-stamp-format "%04y-%:b-%02d %02H:%02M:%02S")

(add-hook 'before-save-hook 'time-stamp)  ; update time stamps when saving

(setq org-src-tab-acts-natively t)

(setq  org-link-file-path-type 'relative
      org-startup-indented t
      org-src-window-setup 'current-window
      org-indent-indentation-per-level 2
      org-src-fontify-natively t
      org-src-preserve-indentation t
      ;; org-image-actual-width nil
      org-tags-column 50
      org-ellipsis "   [+]"
      org-adapt-indentation t
      org-hide-leading-stars t
      org-odd-levels-only t
)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))

;; fix auto refresh of inline images after babel exec
(defun shk-fix-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))
(add-hook 'org-babel-after-execute-hook 'shk-fix-inline-images)

(add-hook 'org-mode-hook #'org-indent-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (ledger . t)
   (plantuml . t)
   (gnuplot . t)
   (haskell . t)
   (sql . t)))

;; http://kitchingroup.cheme.cmu.edu/blog/2015/03/12/Making-org-mode-Python-sessions-look-better/
(defun org-babel-python-strip-session-chars ()
  "Remove >>> and ... from a Python session output."
  (when (and (string=
              "python"
              (org-element-property :language (org-element-at-point)))
             (string-match
              ":session"
              (org-element-property :parameters (org-element-at-point))))

    (save-excursion
      (when (org-babel-where-is-src-block-result)
        (goto-char (org-babel-where-is-src-block-result))
        (end-of-line 1)
                                        ;(while (looking-at "[\n\r\t\f ]") (forward-char 1))
        (while (re-search-forward
                "\\(>>> \\|\\.\\.\\. \\|: $\\|: >>>$\\)"
                (org-element-property :end (org-element-at-point))
                t)
          (replace-match "")
          ;; this enables us to get rid of blank lines and blank : >>>
          (beginning-of-line)
          (when (looking-at "^$")
            (kill-line)))))))

(add-hook 'org-babel-after-execute-hook 'org-babel-python-strip-session-chars)

(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/tools/plantuml.jar"))
(setq python-shell-completion-native-enable nil)

(setq org-confirm-babel-evaluate nil)

(setq org-export-html-postamble nil)
(setq org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-hide-leading-stars t
      org-pretty-entities nil ; this enables _ ^ to behave as subscript/supersript -> annoying
      org-odd-levels-only t)

(setq life-agenda-file "~/.em/emacs-apps/orgagenda/life-inbox.org")
(setq work-agenda-file "~/.em/emacs-apps/orgagenda/work-inbox.org")

(use-package doct
  :commands (doct)
  :init (setq org-capture-templates
              (doct '(("TODO"
                       :keys "t"
                       :children (("life"
                                   :keys "l"
                                   :template ("* TODO %^{Description}"
                                              "SCHEDULED: %U"
                                              ":PROPERTIES:"
                                              ":Category: %^{Home|Family|Friends|Learnings|Misc}"
                                              ":END:"
                                              )
                                   :headline "Tasks"
                                   :file life-agenda-file)
                                  ("work"
                                   :keys "w"
                                   :template ("* TODO %^{Description}"
                                              "SCHEDULED: %U"
                                              ":PROPERTIES:"
                                              ":Category: %^{Work|Project}"
                                              ":Created: %U"
                                              ":END:"
                                              ":LOGBOOK:"
                                              "- State \"TODO\"       from \"\"           %U"
                                              ":END:")
                                   :headline "Tasks"
                                   :file work-agenda-file)))

                      ("Journal"
                       :keys "j"
                       :prepend t
                       :children (("general"
                                   :keys "g"
                                   :file "~/.em/em.ginbox/general-inbox.org"
                                   :template ("* %?" "%U")
                                   :datetree t)
                                  ("apm-journal"
                                   :keys "a"
                                   :file "c:/my/work/apm-bpm/apmbpm.git/private/agenda/apm-journal.org"
                                   :template ("* %?" "%U")
                                   :datetree t)
                                  ))

                      ("Bookmarks"
                       :keys "b"
                       :prepend t
                       :file "c:/my/gitrepos/bookmarks.git/partial/bookmarks-inbox.org"
                       :template ("* bm")
                       )
                      ))))

;;https://punchagan.muse-amuse.in/blog/how-i-learnt-to-use-emacs-profiler/
;;(setq org-agenda-inhibit-startup t) ;; ~50x speedup
;;(setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup

(setq org-todo-keywords '((sequence "PROJECT(p) TODO(t)"  "WAITING(w)" "|" "DONE(d)" "KILLED(k)"))
      org-tag-alist '(("hv" . ?h)
                      ("mv" . ?m)
                      ("lv" . ?l)))

;; default for unix/windows
(setq org-agenda-root-dir "~/.em/emacs-apps/orgagenda")
(setq holiday-file  "~/.em/emacs-apps/orgagenda/holiday_list.el")
(if (file-exists-p holiday-file)
    (load-file holiday-file))

;; if the agenda folder is somewhere else in windows
(with-system windows-nt
  (setq holiday-file  "i:/emacs-apps/orgagenda/holiday_list.el")
  (when (file-exists-p holiday-file)
    (setq org-agenda-root-dir "i:/emacs-apps/orgagenda")
    (load-file holiday-file)))

(setq org-log-done t
      org-log-into-drawer t
      org-agenda-start-day "1d"
      org-agenda-span 5
      org-agenda-start-on-weekday nil
      ;; org agenda conf https://daryl.wakatara.com/easing-into-emacs-org-mode
      org-agenda-show-all-dates nil  ;org agenda skip empty days
      org-agenda-skip-deadline-if-done t
      org-deadline-warning-days 7
      org-agenda-skip-deadline-prewarning-if-scheduled t
      org-agenda-skip-scheduled-if-deadline-is-shown t
      org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled) ;;http://pragmaticemacs.com/emacs/org-mode-basics-vii-a-todo-list-with-schedules-and-deadlines/
      org-agenda-todo-list-sublevels t
      org-agenda-deadline-leaders '("" "In %3d d.: " "%2d d. ago: ")
      org-agenda-scheduled-leaders '("" "Sched.%2dx: ")
      org-agenda-files (list ;;(concat org-agenda-root-dir "/gtd-inbox.org") ;; default-agenda-file
                        (concat org-agenda-root-dir "/gtd.org")
                        (concat org-agenda-root-dir "/anniv.org")
                        (concat org-agenda-root-dir "/tickler.org")
                        work-agenda-file
                        life-agenda-file
                        )

      )

(setq org-agenda-prefix-format
      '((agenda  . "%i %12:c%?-12t   %s")
        (todo  . " %(let ((scheduled (org-get-scheduled-time (point)))) (if scheduled (format-time-string \"%Y-%m-%d\" scheduled) \"\")) %i %12:c  ")
        (tags  . " %i %15:c")
        (timeline . "% s")
        (search . " %i %-12:c")))

(defun my-custom-agenda-fn ()
  (setq truncate-lines t))

(add-hook 'org-agenda-finalize-hook 'my-custom-agenda-fn)

(use-package org-super-agenda
  :ensure t
  :init (progn
          (org-super-agenda-mode)
          )
  :config
  (setq org-super-agenda-groups
        '((:name "Today"
                 :time-grid t
                 :scheduled today)
          (:name "Due today"
                 :deadline today)
          (:name "Important"
                 :priority "A")
          (:name "Overdue"
                 :deadline past)
          (:name "Due soon"
                 :deadline future)
          (:name "Waiting"
                 :todo "WAIT")
          (:name "Home"
                 :tag "Home"))))

(defun my/org/org-reformat-buffer ()
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))

(global-prettify-symbols-mode 1)
(defun add-pretty-lambda ()
  "make some word or string show as pretty Unicode symbols"
  (setq prettify-symbols-alist
        '(
          ("lambda" . 955)
          ("->" . 8594)
          ("=>" . 8658)
          ("#+TITLE:" . ? )
          ("Last Saved:" . 9997)
          ("#+BEGIN_SRC" . 128187)
          ("#+END_SRC" . 9210)
          (push '("[ ]" .  "☐") prettify-symbols-alist)
          (push '("[X]" . "☑" ) prettify-symbols-alist)
          (push '("[-]" . "❍" ) prettify-symbols-alist)
          )))


(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'text-mode-hook 'add-pretty-lambda)
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)

(when (member "Symbola" (font-family-list))
  (set-fontset-font "fontset-default" nil
                    (font-spec :size 20 :name "Symbola")))

(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

(defun chunyang-org-mode-hide-stars ()
  (font-lock-add-keywords
   nil
   '(("^\\*+ "
      (0
       (prog1 nil
         (put-text-property (match-beginning 0) (match-end 0)
                            'face (list :foreground
                                        (face-attribute
                                         'default :background)))))))))

(add-hook 'org-mode-hook #'chunyang-org-mode-hide-stars)

(use-package toc-org :ensure t
  :config
  (progn
    (add-to-list 'load-path "~/.emacs.d/toc-org")
    (if (require 'toc-org nil t)
        (add-hook 'org-mode-hook 'toc-org-mode)

      ;; enable in markdown, too
      (add-hook 'markdown-mode-hook 'toc-org-mode)
      (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point))
    (warn "toc-org not found")))

(defun my/tangle-all-config-files ()
  (interactive)
  "go through all config org files and output compiled elisp in elispfiles"
  ;; move compiled files to elispfiles folder
  (mapc '(lambda(x) (org-babel-tangle-file x "emacs-lisp"))
        (directory-files (concat user-emacs-directory "config/orgfiles/") t ".org$"))

  ;; move compiled files to elispfiles folder
  (mapc '(lambda(x) (rename-file x (concat user-emacs-directory "config/elispfiles/") t))
        (directory-files (concat user-emacs-directory "config/orgfiles/") t ".el[c]*$"))

  (byte-recompile-directory (concat user-emacs-directory "config/elispfiles/") 0))

(defun my/tangle-this-config-file ()
  (interactive)
  "If the current file is in 'config/orgfiles', the code blocks are tangled"
  (when (equal (file-name-directory (directory-file-name buffer-file-name)) (concat user-emacs-directory "config/orgfiles/"))
    (progn
      (org-babel-tangle)
      (message "%s tangled" buffer-file-name)
      (mapc '(lambda(x) (rename-file x (concat user-emacs-directory "config/elispfiles/") t))
            (directory-files (concat user-emacs-directory "config/orgfiles/") t ".el[c]*$"))
      (byte-recompile-directory (concat user-emacs-directory "config/elispfiles/") 0))))

;;(add-hook 'after-save-hook #'my/tangle-dotfiles)
