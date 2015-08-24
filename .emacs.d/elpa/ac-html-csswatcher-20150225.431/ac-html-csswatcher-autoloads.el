;;; ac-html-csswatcher-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ac-html-csswatcher-setup ac-html-csswatcher+ ac-html-csswatcher-refresh)
;;;;;;  "ac-html-csswatcher" "ac-html-csswatcher.el" (21815 41265
;;;;;;  94563 183000))
;;; Generated autoloads from ac-html-csswatcher.el

(autoload 'ac-html-csswatcher-refresh "ac-html-csswatcher" "\
Interactive version of `ac-html-csswatcher-setup-html-stuff-async' with nice name.

Refresh csswatcher.

\(fn)" t nil)

(autoload 'ac-html-csswatcher+ "ac-html-csswatcher" "\
Enable csswatcher for this buffer, csswatcher called after each current buffer save.

\(fn)" t nil)

(autoload 'ac-html-csswatcher-setup "ac-html-csswatcher" "\
1. Enable for web, html, haml etc hooks `ac-html-csswatcher+'

2. Setup `after-save-hook' for CSS modes.
Currently we suport only `css-mode' and `less-mode', but later style, sass, scsc etc will be included
when `csswatcher' support them.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ac-html-csswatcher-pkg.el") (21815 41265
;;;;;;  114227 135000))

;;;***

(provide 'ac-html-csswatcher-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ac-html-csswatcher-autoloads.el ends here
