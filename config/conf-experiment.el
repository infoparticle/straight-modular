(use-package org-brain 
  :init
  (setq org-brain-path "~/.em/myorgbrain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  ;(push '("b" "Brain" plain (function org-brain-goto-end)
  ;        "* %i%?" :empty-lines 1)
  ;      org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))
