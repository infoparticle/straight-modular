(global-set-key "\C-s" 'save-buffer)

(use-package which-key 
  :defer 10
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1.0))

(use-package key-chord 
  :after (evil)
  :config
  (key-chord-mode +1)
  (setq key-chord-two-keys-delay 0.2)

  (defun er-switch-to-previous-buffer ()
    "Switch to previously open buffer.
     Repeated invocations toggle between the two most recently open buffers."
    (interactive)
    (switch-to-buffer (other-buffer (current-buffer) 1)))

  (key-chord-define-global "JJ" #'er-switch-to-previous-buffer))

(use-package general
  :config
  (general-define-key :keymaps 'evil-normal-state-map
                      (general-chord " 0") 'delete-window
                      (general-chord " j") 'avy-goto-char-2
                      (general-chord " l") 'avy-goto-line
                      )
  
  (general-define-key :keymaps 'dired-mode-map
                      "C-c C-n" 'dired-narrow)
  
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "SPC" '(counsel-M-x                :which-key "M-x")
   "."   '(dired-jump                 :which-key "dired-jump")
   "0"   '(delete-window              :which-key "delete-window")
   "1"   '(delete-other-windows       :which-key "delete-other-windows")
   "2"   '(split-window-below         :which-key "split-window-below")
   "3"   '(split-window-right         :which-key "split-window-right")
   "B"   '(counsel-bookmark           :which-key "bookmarks")
  ;"a"   '(org-agenda                 :which-key "org-agenda")
   "a"   '(hydra-avy/body             :which-key "hydra-avy")
   "A"   '(cfw:open-org-calendar      :which-key "open-org-calendar")
   
   "c"   '(org-capture                :which-key "org-capture")
   "e"   '(hydra-eyebrowse-nav/body   :which-key "eyebrowse")
   "g"   '(keyboard-quit              :which-key "keyboard-quit")
   "s"   '(swiper                :which-key "swiper")
   "n"   '(org-narrow-to-subtree      :which-key "org-narrow-to-subtree")
   "N"   '(widen                      :which-key "widen")
   "im"  '(helm-imenu-anywhere        :which-key "helm-imenu-anywhere")
   "il"  '(imenu-list-smart-toggle    :which-key "imenu-list-smart-toggle")
   "y"   '(ivy-yasnippet             :which-key "ivy-yasnippet")
   
   ;; expand region
   ;"er" 'er/expand-region
   ;; quickly open files
   "oi"  '(/o/inbox :which-key "owspc-inbox.org")
   "os"  '(/o/scratch                 :which-key "owspc-scratch.org")
   "oc"  '(/o/config                  :which-key "config.org")
   "ob"  '(/o/web-bookmarks           :which-key "web-bookmarks.org")
   "og"  '(/o/gtd                     :which-key "gtd-inbox.org")

   "ws"  '(/o/swcraft-wiki            :which-key "swcraft-wiki")
   "ww"  '(/o/work-wiki               :which-key "work-wiki")
   "wb"  '(/o/books-wiki              :which-key "books-wiki")
   "wl"  '(/o/life-wiki               :which-key "life-wiki")
   "wt"  '(/o/trading-wiki            :which-key "trading-wiki")
   "wh"  '(/o/home-wiki               :which-key "home-wiki")
   ;; buffers
   "TAB" '(switch-to-next-buffer      :which-key "next buffer")

   ;; togglies
   "tl" 'display-line-numbers-mode
   "tw" 'whitespace-mode
   "tp"  'parinfer-toggle-mode
   "tt"  'toggle-truncate-lines

   ;; git
   "G" '(:ignore t                    :which-key "GIT")
   "Gs" 'magit-status
   "Gd" 'magit-diff-dwim

   ;; ztree
   "zt"   'ztree-dir
   )
  (general-evil-setup)
  (general-nvmap
    "'" (general-simulate-key "C-c C-x")
    "M-'" 'evil-goto-mark
    "M-b" 'counsel-ibuffer
    ;; ...
    )
  (general-omap
    :prefix "SPC"
    "." 'avy-goto-word-or-subword-1
    "l" 'evil-avy-goto-line
    "e" 'evil-avy-goto-subword-0 )

  (general-def 'motion
    ";" 'evil-ex
    ":" 'evil-repeat-find-char)
  (general-def 'normal emacs-lisp-mode-map
    "K" 'elisp-slime-nav-describe-elisp-thing-at-point)

  (general-create-definer my-leader-def
    ;; :prefix my-leader
    :prefix "\\")

  (my-leader-def 'normal
    "s" 'helm-cscope-find-this-symbol
    "f" 'helm-cscope-find-this-file
    "t" 'helm-cscope-find-this-text-string
    "g" 'helm-cscope-find-global-definition
    "c" 'helm-cscope-find-calling-this-function
    "d" 'helm-cscope-find-called-function
    ;; ...
    )
  
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "C-c"
   ;; bind "C-c a" to 'org-agenda
   "C-j" 'worf-goto
   "l"   'org-store-link
   ))

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"

 "ff"  '(counsel-find-file :which-key "counsel-find-file")
 "fs"  '(save-buffer       :which-key "save-buffer")
 "fr"  '(counsel-recentf   :which-key "counsel-recentf"))

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"

 "pp"  '(projectile-switch-project       :which-key "projectile-switch-project")
 "pf"  '(projectile-find-file            :which-key "projectile-find-file")
 "pw"  '(my/open-projectile-wiki-index   :which-key "wiki-index")
 "ps"  '(my/open-projectile-file-scratch :which-key "open-project-scratch")
 "pi"  '(my/open-projectile-file-inbox   :which-key "open-project-inbox"))

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 
"bb"   '(ivy-switch-buffer    :which-key "ivy-switch-buffer")
"bd"   '(delete-window        :which-key "delete-window")
"bk"   '(kill-buffer          :which-key "kill-buffer")
"bK"   '(volatile-kill-buffer :which-key "volatile kill buff")
"bj"   '(ace-jump-buffer      :which-key "ace jump buffer")
)

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"

"qq"   '(save-buffers-kill-terminal   :which-key "save-buffers-kill-terminal")
)

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 
"mot"   '(org-babel-tangle   :which-key "org-babel-tangle")
)
