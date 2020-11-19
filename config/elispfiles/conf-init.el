(setq vc-handled-backends nil)
(eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
        ("http" . "15.122.63.30:8080")
        ("https" . "15.122.63.30:8080")))

;(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq load-prefer-newer t)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))

;(package-initialize)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

(defmacro with-system (type &rest body)
  "Evaluate BODY if `system-type' equals TYPE.
   usage: (with-system windows-nt  <code> )
        : (with-system gnu/linux  <code> ) "
  (declare (indent defun))
  `(when (eq system-type ',type)
     ,@body))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-config-directory)))

(load-user-file "conf-org.el")
(load-user-file "conf-ui.el")
(load-user-file "conf-general-features.el")
(load-user-file "conf-defaults.el")
(load-user-file "conf-evil.el")
(load-user-file "conf-general-utils.el")
(load-user-file "conf-workflow-helpers.el")
(load-user-file "conf-programming.el")

(with-system gnu/linux
(load-user-file "conf-prog-cpp.el")) ;ccls binaries not there in windows

(load-user-file "conf-keybindings.el")
(load-user-file "conf-ondemand-toolbox.el")
(load-user-file "conf-experiment.el")

(with-system windows-nt
  (load-user-file "conf-windows.el")
  (setq custom-file (expand-file-name "../custom-configs/conf-windows-custom.el" user-config-directory))
  (load custom-file)
  ;;(load-user-file "conf-my-theme-light.el")
  )

(with-system gnu/linux
  (load-user-file "conf-linux.el")
  (setq custom-file (expand-file-name "../custom-config/conf-linux-custom.el" user-config-directory))
  (load custom-file))
