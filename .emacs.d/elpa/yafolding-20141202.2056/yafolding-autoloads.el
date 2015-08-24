;;; yafolding-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (yafolding-mode) "yafolding" "yafolding.el" (21711
;;;;;;  14822 683553 897000))
;;; Generated autoloads from yafolding.el

(defvar yafolding-mode-map (let ((map (make-sparse-keymap))) (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element) (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all) (define-key map (kbd "<C-return>") #'yafolding-toggle-element) map))

(autoload 'yafolding-mode "yafolding" "\
Toggle yafolding mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("yafolding-pkg.el") (21711 14822 715041
;;;;;;  374000))

;;;***

(provide 'yafolding-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; yafolding-autoloads.el ends here
