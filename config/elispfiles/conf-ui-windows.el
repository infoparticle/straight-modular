(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (progn
    (set-face-attribute 'mode-line           nil :background "gray90" :box nil)
    (set-face-attribute 'mode-line-inactive  nil :background "gray95" :box nil)))

(global-hl-line-mode 1)
(set-face-background hl-line-face "lavender")

;; Adjust margins of all windows.
(defun center-windows () ""
  (walk-windows (lambda (window) (set-window-margins window 2 0)) nil 1))

;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)
(global-visual-line-mode)
