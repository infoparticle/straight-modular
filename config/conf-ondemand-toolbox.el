(defun conf/ondemand/restclient ()
  (interactive)
  (use-package restclient
    :config
    (use-package ob-restclient
      :config
      (org-babel-do-load-languages 'org-babel-load-languages
                                   (append org-babel-load-languages
                                           '((restclient . t))))))
  (message "loaded tool: restclient and ob-restclient"))
