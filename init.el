(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq user-config-directory (concat user-emacs-directory "/config"))

(setq gc-cons-threshold (* 500 1024 1024))
(eval-when-compile (require 'cl))
(lexical-let ((emacs-start-time (current-time)))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
                (message "[Emacs initialized in %.3fs]" elapsed)))))

(setq vc-handled-backends nil)
(eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))

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

(load-user-file "conf-ui.el")
(load-user-file "conf-behaviour.el")
(load-user-file "conf-defaults.el")
(load-user-file "conf-evil.el")
(load-user-file "conf-org.el")
(load-user-file "conf-behaviour-helpers.el")
(load-user-file "conf-workflow-helpers.el")
(load-user-file "conf-programming.el")
(load-user-file "conf-keybindings.el")
(load-user-file "conf-ondemand-toolbox.el")

(with-system windows-nt
  (setq custom-file (expand-file-name "conf-windows.el" user-config-directory))
  (load custom-file))

(with-system gnu/linux
  (setq custom-file (expand-file-name "conf-linux.el" user-config-directory))
  (load custom-file))
