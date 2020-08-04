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

(setq org-agenda-root-dir "~/.em/emacs-apps/orgagenda") ; default

(with-system windows-nt
  (setq holiday-file  "i:/emacs-apps/orgagenda/holiday_list.el")
  (when (file-exists-p holiday-file)
    (setq org-agenda-root-dir "i:/emacs-apps/orgagenda")
    (load-file holiday-file)))

(setq org-log-done t
      org-link-file-path-type 'relative
      org-log-into-drawer t
      org-startup-indented t
      org-src-window-setup 'current-window
      org-indent-indentation-per-level 2
      org-src-fontify-natively t
      org-src-preserve-indentation t
      ;; org-image-actual-width nil
      org-tags-column 90

      ;; org agenda conf https://daryl.wakatara.com/easing-into-emacs-org-mode
      org-agenda-show-all-dates nil  ;org agenda skip empty days
      org-agenda-skip-deadline-if-done t
      org-deadline-warning-days 4
      org-agenda-skip-deadline-prewarning-if-scheduled t
      org-agenda-skip-scheduled-if-deadline-is-shown t
      org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled) ;;http://pragmaticemacs.com/emacs/org-mode-basics-vii-a-todo-list-with-schedules-and-deadlines/
      org-agenda-todo-list-sublevels t
      org-agenda-deadline-leaders '("" "In %3d d.: " "%2d d. ago: ")
      org-agenda-scheduled-leaders '("" "Sched.%2dx: ")
      org-agenda-files (list (concat org-agenda-root-dir "/gtd-inbox.org")
                             (concat org-agenda-root-dir "/gtd.org")
                             (concat org-agenda-root-dir "/anniv.org")
                             (concat org-agenda-root-dir "/tickler.org"))
)

(setq org-agenda-prefix-format
      (quote
       ((agenda . "%-12c%?-12t% s")
        (timeline . "% s")
        (todo . "%-12c")
        (tags . "%-12c")
        (search . "%-12c"))))
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
      org-pretty-entities t
      org-odd-levels-only t)

(custom-set-faces
 '(org-ellipsis ((t (:foreground "gray" :box nil :underline nil :overline nil :weight bold)))))
                                        ;https://punchagan.muse-amuse.in/blog/how-i-learnt-to-use-emacs-profiler/
;;(setq org-agenda-inhibit-startup t) ;; ~50x speedup
;;(setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

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
          ("lambda" . 955) ; λ
          ("->" . 8594)    ; →
          ("=>" . 8658)    ; ⇒
          ;("map" . 8614)   ; ↦
          ("#+TITLE:" . ? )
          ("Last Saved:" . 9997) ; ✍
          ("#+BEGIN_SRC" . 128187) ; 💻
          ("#+END_SRC" . 9210) ; black dot
          )))


(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'text-mode-hook 'add-pretty-lambda)
(add-hook 'prog-mode-hook 'add-pretty-lambda)
(add-hook 'org-mode-hook 'add-pretty-lambda)

(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))

(setq inhibit-compacting-font-caches t) ;;game changer in windows?

(when (member "Symbola" (font-family-list))
  (set-fontset-font "fontset-default" nil
                    (font-spec :size 20 :name "Symbola")))

(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))
