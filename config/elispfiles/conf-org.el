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

(use-package plantuml-mode :ensure t)
(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/tools/plantuml.jar"))

(setq
time-stamp-active t          ; do enable time-stamps
time-stamp-pattern "34/\\(\\(L\\|l\\)ast\\( \\|-\\)\\(\\(S\\|s\\)aved\\|\\(M\\|m\\)odified\\|\\(U\\|u\\)pdated\\)\\|Time-stamp\\) *: [\"]%:B %02d %:A, %:y[\"]")

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
    org-ellipsis "  \u2935"
    org-adapt-indentation t
    org-hide-leading-stars t
    org-odd-levels-only t
    org-cycle-separator-lines -1
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

;; avoid tangling into dos eol in linux files edited using tramp
(add-hook 'org-babel-pre-tangle-hook (lambda () (setq coding-system-for-write 'utf-8-unix)))

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
                                            ;;"SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+1d\"))"
                                            "%^{SCHEDULED}p"
                                            ":PROPERTIES:"
                                            ":Category: %^{Home|Family|Friends|Learnings|Misc}"
                                            ":END:"
                                            )
                                :headline "Tasks"
                                :file life-agenda-file)
                                ("work"
                                :keys "w"
                                :template ("* TODO %^{Description}"
                                            "%^{SCHEDULED}p"
                                            ":PROPERTIES:"
                                            ":Category: %^{sprint|learning|Misc}"
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

(setq org-todo-keywords
    (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING" "EVENT"))))

(setq org-todo-keyword-faces
      (quote (("TODO"      :background "red" :foreground "white" :weight bold)
              ("NEXT"      :background "slate blue" :foreground "white" :weight bold)
              ("DONE"      :background "forest green" :foreground "white" :weight bold)
              ("WAITING"   :background "orange" :foreground "white" :weight bold)
              ("HOLD"      :background "magenta" :foreground "white" :weight bold)
              ("CANCELLED" :background "forest green" :foreground "white" :weight bold)
              ("MEETING"   :background "forest green" :foreground "white" :weight bold)
              ("EVENT"     :background "black" :foreground "white" :weight bold)
              )))
(setq org-todo-state-tags-triggers
    (quote (("CANCELLED" ("CANCELLED" . t))
            ("WAITING" ("WAITING" . t))
            ("HOLD" ("WAITING") ("HOLD" . t))
            (done ("WAITING") ("HOLD"))
            ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
            ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
            ("EVENT" ("WAITING") ("CANCELLED") ("HOLD"))
            ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;https://punchagan.muse-amuse.in/blog/how-i-learnt-to-use-emacs-profiler/
;;(setq org-agenda-inhibit-startup t) ;; ~50x speedup
;;(setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
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
    org-agenda-span 'day
    org-agenda-start-on-weekday nil
    ;; org agenda conf https://daryl.wakatara.com/easing-into-emacs-org-mode
    org-agenda-show-all-dates nil  ;org agenda skip empty days
    org-agenda-skip-deadline-if-done t
    org-deadline-warning-days 7
    org-agenda-skip-deadline-prewarning-if-scheduled t
    org-agenda-skip-scheduled-if-deadline-is-shown t
    org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled) ;;http://pragmaticemacs.com/emacs/org-mode-basics-vii-a-todo-list-with-schedules-and-deadlines/
    org-agenda-todo-list-sublevels t
    org-stuck-projects (quote ("" nil nil ""))
    org-agenda-deadline-leaders '("" "In %3d d.: " "%2d d. ago: ")
    org-agenda-scheduled-leaders '("" "Sched.%2dx: ")
    org-agenda-files (list ;;(concat org-agenda-root-dir "/gtd-inbox.org") ;; default-agenda-file
                    (concat org-agenda-root-dir "/gtd.org")
                    (concat org-agenda-root-dir "/anniv.org")
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


(defface org-checkbox-done-text
'((t (:foreground "#71696A" :strike-through t)))
"Face for the text part of a checked org-mode checkbox.")

(font-lock-add-keywords
'org-mode
`(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
1 'org-checkbox-done-text prepend))
'append)

(defun my-custom-agenda-fn ()
(setq truncate-lines t))

(add-hook 'org-agenda-finalize-hook 'my-custom-agenda-fn)



(setq org-agenda-format-date (lambda (date) (concat "\n"
                                                (make-string (window-width) 9472)
                                                "\n"
                                                (org-agenda-format-date-aligned date))))

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; to keep the agenda view fast
(setq org-agenda-span 'day)

;; any TODO with no NEXT action is stuck
(setq org-stuck-projects (quote ("" nil nil "")))

;; Custom agenda command definitions
(setq org-agenda-custom-commands
    (quote (("N" "Notes" tags "NOTE"
            ((org-agenda-overriding-header "Notes")
            (org-tags-match-list-sublevels t)))
            ("h" "Habits" tags-todo "STYLE=\"habit\""
            ((org-agenda-overriding-header "Habits")
            (org-agenda-sorting-strategy
                '(todo-state-down effort-up category-keep))))
            (" " "Agenda"
            ((agenda "" nil)
            (tags "REFILE"
                    ((org-agenda-overriding-header "Tasks to Refile")
                    (org-tags-match-list-sublevels nil)))
            (tags-todo "-CANCELLED/!"
                        ((org-agenda-overriding-header "Stuck Projects")
                        (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                        (org-agenda-sorting-strategy
                            '(category-keep))))
            (tags-todo "-CANCELLED/!NEXT"
                        ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                (if bh/hide-scheduled-and-waiting-next-tasks
                                                                    ""
                                                                " (including WAITING and SCHEDULED tasks)")))
                        (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                        (org-tags-match-list-sublevels t)
                        (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-sorting-strategy
                            '(todo-state-down effort-up category-keep))))
            (tags-todo "-HOLD-CANCELLED/!"
                        ((org-agenda-overriding-header "Projects")
                        (org-agenda-skip-function 'bh/skip-non-projects)
                        (org-tags-match-list-sublevels 'indented)
                        (org-agenda-sorting-strategy
                            '(category-keep))))
            (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                        ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                (if bh/hide-scheduled-and-waiting-next-tasks
                                                                    ""
                                                                " (including WAITING and SCHEDULED tasks)")))
                        (org-agenda-skip-function 'bh/skip-non-project-tasks)
                        (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-sorting-strategy
                            '(category-keep))))
            (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                        ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                (if bh/hide-scheduled-and-waiting-next-tasks
                                                                    ""
                                                                " (including WAITING and SCHEDULED tasks)")))
                        (org-agenda-skip-function 'bh/skip-project-tasks)
                        (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-sorting-strategy
                            '(category-keep))))
            (tags-todo "-CANCELLED+WAITING|HOLD/!"
                        ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                (if bh/hide-scheduled-and-waiting-next-tasks
                                                                    ""
                                                                " (including WAITING and SCHEDULED tasks)")))
                        (org-agenda-skip-function 'bh/skip-non-tasks)
                        (org-tags-match-list-sublevels nil)
                        (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                        (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
            ;; (tags "-REFILE/"
            ;;       ((org-agenda-overriding-header "Tasks to Archive")
            ;;        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
            ;;        (org-tags-match-list-sublevels nil)))
            )
            nil))))

;; filter context-based tasks
(defun bh/org-auto-exclude-function (tag)
"Automatic task exclusion in the agenda with / RET"
(and (cond
    ((string= tag "hold")
        t)
    ((string= tag "backburner")
        t))
    (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)

;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
"Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
(when (not (and (boundp 'org-capture-mode) org-capture-mode))
(cond
    ((and (member (org-get-todo-state) (list "TODO"))
        (bh/is-task-p))
    "NEXT")
    ((and (member (org-get-todo-state) (list "NEXT"))
        (bh/is-project-p))
    "TODO"))))

(defun bh/find-project-task ()
"Move point to the parent (project) task if any"
(save-restriction
(widen)
(let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
    (while (org-up-heading-safe)
    (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
        (setq parent-task (point))))
    (goto-char parent-task)
    parent-task)))

(defun bh/punch-in (arg)
"Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
(interactive "p")
(setq bh/keep-clock-running t)
(if (equal major-mode 'org-agenda-mode)
    ;;
    ;; We're in the agenda
    ;;
    (let* ((marker (org-get-at-bol 'org-hd-marker))
            (tags (org-with-point-at marker (org-get-tags-at))))
    (if (and (eq arg 4) tags)
        (org-agenda-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))
;;
;; We are not in the agenda
;;
(save-restriction
    (widen)
    ; Find the tags on the current task
    (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
        (org-clock-in '(16))
    (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
(interactive)
(setq bh/keep-clock-running nil)
(when (org-clock-is-active)
(org-clock-out))
(org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
(save-excursion
(org-with-point-at org-clock-default-task
    (org-clock-in))))

(defun bh/clock-in-parent-task ()
"Move point to the parent (project) task if any and clock in"
(let ((parent-task))
(save-excursion
    (save-restriction
    (widen)
    (while (and (not parent-task) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
        (setq parent-task (point))))
    (if parent-task
        (org-with-point-at parent-task
            (org-clock-in))
        (when bh/keep-clock-running
        (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "15f4cc8b-d018-45e2-81ef-8c900b260029")

(defun bh/clock-in-organization-task-as-default ()
(interactive)
(org-with-point-at (org-id-find bh/organization-task-id 'marker)
(org-clock-in '(16))))

(defun bh/clock-out-maybe ()
(when (and bh/keep-clock-running
            (not org-clock-clocking-in)
            (marker-buffer org-clock-default-task)
            (not org-clock-resolving-clocks-due-to-idleness))
(bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

(require 'org-id)
(defun bh/clock-in-task-by-id (id)
"Clock in a task by id"
(org-with-point-at (org-id-find id 'marker)
(org-clock-in nil)))

(defun bh/clock-in-last-task (arg)
"Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
(interactive "p")
(let ((clock-in-to-task
        (cond
        ((eq arg 4) org-clock-default-task)
        ((and (org-clock-is-active)
            (equal org-clock-default-task (cadr org-clock-history)))
        (caddr org-clock-history))
        ((org-clock-is-active) (cadr org-clock-history))
        ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
        (t (car org-clock-history)))))
(widen)
(org-with-point-at clock-in-to-task
    (org-clock-in nil))))

(defun bh/org-auto-exclude-function (tag)
"Automatic task exclusion in the agenda with / RET"
(and (cond
    ((string= tag "hold")
        t)
    ((string= tag "backburner")
        t))
    (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)

(defun bh/is-project-p ()
"Any task with a todo keyword subtask"
(save-restriction
(widen)
(let ((has-subtask)
        (subtree-end (save-excursion (org-end-of-subtree t)))
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
    (forward-line 1)
    (while (and (not has-subtask)
                (< (point) subtree-end)
                (re-search-forward "^\*+ " subtree-end t))
        (when (member (org-get-todo-state) org-todo-keywords-1)
        (setq has-subtask t))))
    (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
"Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
(let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                            (point))))
(save-excursion
    (bh/find-project-task)
    (if (equal (point) task)
        nil
    t))))

(defun bh/is-task-p ()
"Any task with a todo keyword and no subtask"
(save-restriction
(widen)
(let ((has-subtask)
        (subtree-end (save-excursion (org-end-of-subtree t)))
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
    (forward-line 1)
    (while (and (not has-subtask)
                (< (point) subtree-end)
                (re-search-forward "^\*+ " subtree-end t))
        (when (member (org-get-todo-state) org-todo-keywords-1)
        (setq has-subtask t))))
    (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
"Any task which is a subtask of another project"
(let ((is-subproject)
    (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
(save-excursion
    (while (and (not is-subproject) (org-up-heading-safe))
    (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
        (setq is-subproject t))))
(and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
"Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
This is normally used by skipping functions where this variable is already local to the agenda."
(if (marker-buffer org-agenda-restrict-begin)
    (setq org-tags-match-list-sublevels 'indented)
(setq org-tags-match-list-sublevels nil))
nil)

(defun bh/list-sublevels-for-projects ()
"Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
This is normally used by skipping functions where this variable is already local to the agenda."
(if (marker-buffer org-agenda-restrict-begin)
    (setq org-tags-match-list-sublevels t)
(setq org-tags-match-list-sublevels nil))
nil)

(defvar bh/hide-scheduled-and-waiting-next-tasks t)

(defun bh/toggle-next-task-display ()
(interactive)
(setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
(when  (equal major-mode 'org-agenda-mode)
(org-agenda-redo))
(message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

(defun bh/skip-stuck-projects ()
"Skip trees that are not stuck projects"
(save-restriction
(widen)
(let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (if (bh/is-project-p)
        (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                (has-next ))
        (save-excursion
            (forward-line 1)
            (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
            (unless (member "WAITING" (org-get-tags-at))
                (setq has-next t))))
        (if has-next
            nil
            next-headline)) ; a stuck project, has subtasks but no next task
    nil))))

(defun bh/skip-non-stuck-projects ()
"Skip trees that are not stuck projects"
;; (bh/list-sublevels-for-projects-indented)
(save-restriction
(widen)
(let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (if (bh/is-project-p)
        (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                (has-next ))
        (save-excursion
            (forward-line 1)
            (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
            (unless (member "WAITING" (org-get-tags-at))
                (setq has-next t))))
        (if has-next
            next-headline
            nil)) ; a stuck project, has subtasks but no next task
    next-headline))))

(defun bh/skip-non-projects ()
"Skip trees that are not projects"
;; (bh/list-sublevels-for-projects-indented)
(if (save-excursion (bh/skip-non-stuck-projects))
    (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
        (cond
        ((bh/is-project-p)
        nil)
        ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
        nil)
        (t
        subtree-end))))
(save-excursion (org-end-of-subtree t))))

(defun bh/skip-non-tasks ()
"Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
(save-restriction
(widen)
(let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (cond
    ((bh/is-task-p)
    nil)
    (t
    next-headline)))))

(defun bh/skip-project-trees-and-habits ()
"Skip trees that are projects"
(save-restriction
(widen)
(let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (cond
    ((bh/is-project-p)
    subtree-end)
    ((org-is-habit-p)
    subtree-end)
    (t
    nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
"Skip trees that are projects, tasks that are habits, single non-project tasks"
(save-restriction
(widen)
(let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (cond
    ((org-is-habit-p)
    next-headline)
    ((and bh/hide-scheduled-and-waiting-next-tasks
            (member "WAITING" (org-get-tags-at)))
    next-headline)
    ((bh/is-project-p)
    next-headline)
    ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
    next-headline)
    (t
    nil)))))

(defun bh/skip-project-tasks-maybe ()
"Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
(save-restriction
(widen)
(let* ((subtree-end (save-excursion (org-end-of-subtree t)))
        (next-headline (save-excursion (or (outline-next-heading) (point-max))))
        (limit-to-project (marker-buffer org-agenda-restrict-begin)))
    (cond
    ((bh/is-project-p)
    next-headline)
    ((org-is-habit-p)
    subtree-end)
    ((and (not limit-to-project)
            (bh/is-project-subtree-p))
    subtree-end)
    ((and limit-to-project
            (bh/is-project-subtree-p)
            (member (org-get-todo-state) (list "NEXT")))
    subtree-end)
    (t
    nil)))))

(defun bh/skip-project-tasks ()
"Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
(save-restriction
(widen)
(let* ((subtree-end (save-excursion (org-end-of-subtree t))))
    (cond
    ((bh/is-project-p)
    subtree-end)
    ((org-is-habit-p)
    subtree-end)
    ((bh/is-project-subtree-p)
    subtree-end)
    (t
    nil)))))

(defun bh/skip-non-project-tasks ()
"Show project tasks.
Skip project and sub-project tasks, habits, and loose non-project tasks."
(save-restriction
(widen)
(let* ((subtree-end (save-excursion (org-end-of-subtree t)))
        (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (cond
    ((bh/is-project-p)
    next-headline)
    ((org-is-habit-p)
    subtree-end)
    ((and (bh/is-project-subtree-p)
            (member (org-get-todo-state) (list "NEXT")))
    subtree-end)
    ((not (bh/is-project-subtree-p))
    subtree-end)
    (t
    nil)))))

(defun bh/skip-projects-and-habits ()
"Skip trees that are projects and tasks that are habits"
(save-restriction
(widen)
(let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (cond
    ((bh/is-project-p)
    subtree-end)
    ((org-is-habit-p)
    subtree-end)
    (t
    nil)))))

(defun bh/skip-non-subprojects ()
"Skip trees that are not projects"
(let ((next-headline (save-excursion (outline-next-heading))))
(if (bh/is-subproject-p)
    nil
    next-headline)))

(defvar bh/insert-inactive-timestamp nil)

(defun bh/toggle-insert-inactive-timestamp ()
(interactive)
(setq bh/insert-inactive-timestamp (not bh/insert-inactive-timestamp))
(message "Heading timestamps are %s" (if bh/insert-inactive-timestamp "ON" "OFF")))

(defun bh/insert-inactive-timestamp ()
(interactive)
(org-insert-time-stamp nil t t nil nil nil))

(defun bh/insert-heading-inactive-timestamp ()
(save-excursion
(when bh/insert-inactive-timestamp
    (org-return)
    (org-cycle)
    (bh/insert-inactive-timestamp))))

(add-hook 'org-insert-heading-hook 'bh/insert-heading-inactive-timestamp 'append)

(global-set-key (kbd "<f10>") 'org-agenda)
;; (global-set-key (kbd "<f8>") 'bh/org-todo)
;; (global-set-key (kbd "<S-f5>") 'bh/widen)
;; (global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
;; (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
;; (global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'mycalendar)
;; (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> g") 'gnus)
;; (global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)

(global-set-key (kbd "<f9> i") 'bh/punch-in)
(global-set-key (kbd "<f9> o") 'bh/punch-out)

;; (global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

;; (global-set-key (kbd "<f9> r") 'boxquote-region)
;; (global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
;; (global-set-key (kbd "C-<f9>") 'previous-buffer)
;; (global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
;; (global-set-key (kbd "C-x n r") 'narrow-to-region)
;; (global-set-key (kbd "C-<f10>") 'next-buffer)

(global-set-key (kbd "<f9> j") 'org-clock-goto)
(global-set-key (kbd "C-<f9>") 'org-clock-in)
;; (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
;; (global-set-key (kbd "C-c c") 'org-capture)

; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                ("STYLE_ALL" . "habit"))))

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
        ("#+BEGIN_SRC" . 955)
        ("#+END_SRC" . 8945)
        ("#+begin_src" . 955)
        ("#+end_src" . 8945)
        ("#+RESULTS:" . 187)
        ("#+BEGIN_SRC" . 128187)
        ("#+END_SRC" . 9210)
        (":PROPERTIES:" . ":")
        (":END:" . 8945)
        ("#+BEGIN_EXAMPLE" . "~")
        ("#+begin_example"  . "~")
        ("#+END_EXAMPLE" . "~")
        ("#+end_example" . "~")
        ("#+begin_quote" . "~")
        ("#+end_quote" . "~")
        ("#+TBLFM:" . 8747)
        ("[ ]" .  9744)
        ("[X]" . 9745 )
        ("[-]" . 10061 )
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

(use-package org-sidebar :ensure t)
