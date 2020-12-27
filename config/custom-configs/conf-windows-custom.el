(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3C3836" "#FB4933" "#86C9D3" "#8DD1CA" "#419BB0" "#A59FC0" "#3FD7E5" "#EBDBB2"])
 '(custom-safe-themes
   '("0b9803c76a76f283dd3f2ac69a323a94373fb6170f4870d45b46c1e653275da7" "9df867652415c5a54d184fd5010b31b47f5dcbb260fdef410d226165b719a941" "427333ca345649edad1166c767bfb8511c2620720908695274a6b513b1f856d4" "1d75ba6aab722be7b13e72e159073bf2114997ef4f0f80442169e47974cfd753" "2bc02a7d0304b9777d03f4d27af5cba46b8a310250ba2602daadafd4c12a00b4" "e95fe28e830d6b52d0336979b31922a088feb83cd148f1dcdc688c00ad72b1de" "165e3571f414b5f18517431f1fe6d1c7b62a0dad26e781be02ff2b3b91d49f17" "7dc5bc5051faea608b0f32fecf3f4848b5d8370fe9801955a0afff34526cd5d6" "69f90c4ad6f03846429055c4590c5bb6ba187a43129affa85c64b730020f14b0" "44d381559580e02345f1b5ee07ee4bfd9a2260c6be24ea1103a5620ae788be79" "2f3693f5610757748cbaefee90c0b5456aaf576d5d9fba19e0c124d329d24c3a" "7acd52c1af3443cf762b9c33790f202d431664983008cab928cb114a4739fa1e" "7b2f3f5064423615c6cb185afba6718f36750ee030b70386974b58c0aec744a2" "30ffdfb3a769bd329b520f8c4463a974e38c4c4a8703c6bb21f8fe9acf4b927d" "b053b3ab4c1ee722b60bc109903131907e1b858ed5bfdf7af4a22056a45b95f5" "78f9793674cc82b887bcd7df27c1c89ec0f9b89aaa51ed81bcb6f4ea49ef31a7" "5e57277a3ab7b6db80a79b8c6eca2aa3b6ffafd5a16745d343da0b9a1eddca1f" "5834d07f57c62e7172ba067eb16ccf7eb0acb35223d3d2b8b97677f15808721d" "6a009f59b65ef73a128747cf01f1baf14c6c8df18dc5dc4de4f7bbfbab63b60b" "e3b2bad7b781a968692759ad12cb6552bc39d7057762eefaf168dbe604ce3a4b" "da0468f37373855e845e7ebfd7cdc334e0ea92de4dcf6695a4eefd1dc884410d" "13d194a1846d5fa1226593b8b41ec5186e1f82cc3698c8ace35d777ae24ce98d" "fcbbc893cdf7675e078b781c09041e1d2e4dc17375c808f9f4b120cc9a70f2ca" default))
 '(epg-gpg-home-directory "c:\\Users\\gopinat\\AppData\\Roaming\\gnupg")
 '(epg-gpg-program "C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe")
 '(epg-gpgconf-program "C:\\Program Files (x86)\\GnuPG\\bin\\gpgconf.exe")
 '(evil-collection-setup-minibuffer t)
 '(fci-rule-color "#4C566A")
 '(jdee-db-active-breakpoint-face-colors (cons "#191C25" "#81A1C1"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#191C25" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#191C25" "#434C5E"))
 '(objed-cursor-color "#BF616A")
 '(org-agenda-files
   '("~/.em/emacs-apps/orgagenda/gtd.org" "~/.em/emacs-apps/orgagenda/anniv.org" "~/.em/emacs-apps/orgagenda/work-inbox.org" "~/.em/emacs-apps/orgagenda/life-inbox.org"))
 '(ox-clip-w32-cmd
   "c:/opt/anaconda3/python.exe c:/Users/gopinat/AppData/Roaming/.emacs.d/straight/build/ox-clip/html-clip-w32.py")
 '(pdf-view-midnight-colors (cons "#ECEFF4" "#2E3440"))
 '(pos-tip-background-color "#1A3734")
 '(pos-tip-foreground-color "#FFFFC8")
 '(rustic-ansi-faces
   ["#2E3440" "#BF616A" "#A3BE8C" "#EBCB8B" "#81A1C1" "#B48EAD" "#88C0D0" "#ECEFF4"])
 '(safe-local-variable-values
   '((eval when
           (fboundp 'rainbow-mode)
           (rainbow-mode 1))
     (eval add-hook 'after-save-hook
           (lambda nil
             (org-html-export-to-html t))
           t t)
     (checkdoc-package-keywords-flag)
     (eval progn
           (pp-buffer)
           (indent-buffer))))
 '(vc-annotate-background "#2E3440")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A3BE8C")
    (cons 40 "#bbc28b")
    (cons 60 "#d3c68b")
    (cons 80 "#EBCB8B")
    (cons 100 "#e2b482")
    (cons 120 "#d99d79")
    (cons 140 "#D08770")
    (cons 160 "#c68984")
    (cons 180 "#bd8b98")
    (cons 200 "#B48EAD")
    (cons 220 "#b77f96")
    (cons 240 "#bb7080")
    (cons 260 "#BF616A")
    (cons 280 "#a05b67")
    (cons 300 "#815664")
    (cons 320 "#625161")
    (cons 340 "#4C566A")
    (cons 360 "#4C566A")))
 '(vc-annotate-very-old-color nil)
 '(zoom-window-mode-line-color "darkgreen"))
(put 'dired-find-alternate-file 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit default :foreground "gray80"))))
 '(org-block-begin-line ((t (:background nil))))
 '(org-block-end-line ((t (:inherit org-block-begin-line :background nil))))
 '(org-document-title ((t (:weight bold :height 400 :family "Georgia"))))
 '(org-level-1 ((t (:inherit outline-1 :background nil :height 200 :family "High Tower Text"))))
 '(org-level-2 ((t (:inherit outline-2 :background nil :height 180 :family "High Tower Text"))))
 '(org-level-3 ((t (:inherit outline-3 :background nil :height 160 :family "High Tower Text"))))
 '(org-level-4 ((t (:inherit outline-4 :background nil :height 150 :family "High Tower Text")))))
