
(setq
  time-stamp-active t          ; do enable time-stamps
  ;; time-stamp-line-limit 34     ; check first N buffer lines for Time-stamp: <2019-August-18 17:58:34>
  ;; example: Tuesday, July 15, 2008  10:59:09  (by dinoch)
  ;;time-stamp-format "%:a, %:b %02d, %04y  %02H:%02M:%02S %Z (by %u)") ; date format
  ;;time-stamp-format "%04y-%:b-%02d %02H:%02M:%02S" ; date format
  time-stamp-pattern "34/\\(\\(L\\|l\\)ast\\( \\|-\\)\\(\\(S\\|s\\)aved\\|\\(M\\|m\\)odified\\|\\(U\\|u\\)pdated\\)\\|Time-stamp\\) *: <%04y-%:b-%02d %02H:%02M:%02S>")

;; can also add this to source code: // (set-variable time-stamp-format "%04y-%:b-%02d %02H:%02M:%02S")

(add-hook 'before-save-hook 'time-stamp)  ; update time stamps when saving

(setq org-src-tab-acts-natively t)
