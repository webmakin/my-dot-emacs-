(add-to-list 'load-path "/home/asif/Downloads/php-mode-1.13.1")
(add-to-list 'load-path "/home/asif/.emacs.d")
(add-to-list 'load-path "/home/asif/mu/mu4e")

;;for adding melpa packages
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;smarty-mode
(require 'smarty-mode)

;;phpmode
(require 'php-mode)
;; To use abbrev-mode, add lines like this:
(add-hook 'php-mode-hook
'(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))
;; (defun clean-php-mode ()
;; (interactive)
;; (php-mode)
;; (setq c-basic-offset 2) ; 2 tabs indenting
;; (setq indent-tabs-mode nil)
;; (setq fill-column 78)
;; (c-set-offset 'case-label '+)
;; (c-set-offset 'arglist-close 'c-lineup-arglist-operators))
;; (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
;; (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values

;;tree-mode
(require 'tree-mode)
;;windata
(require 'windata)
;;dirtree
(require 'dirtree)
;;make directories auto when finding files
(defun my-create-non-existent-directory ()
      (let ((parent-directory (file-name-directory buffer-file-name)))
        (when (and (not (file-exists-p parent-directory))
                   (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
          (make-directory parent-directory t))))
(add-to-list 'find-file-not-found-functions #'my-create-non-existent-directory)
;;disable menu bar
(menu-bar-mode -1)

;;midnight mode
(require 'midnight)
(cancel-timer midnight-timer)

;;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;kill buffers if they were last disabled more than this seconds ago
(setq clean-buffer-list-delay-special 900)

(defvar clean-buffer-list-timer nil
  "Stores clean-buffer-list timer if there is one. You can disable clean-buffer-list by (cancel-timer clean-buffer-list-timer).")

;; run clean-buffer-list every 2 hours
(setq clean-buffer-list-timer (run-at-time t 7200 'clean-buffer-list))

;; kill everything, clean-buffer-list is very intelligent at not killing
;; unsaved buffer.
(setq clean-buffer-list-kill-regexps '("^.*$"))

;; keep these buffer untouched
;; prevent append multiple times
(defvar clean-buffer-list-kill-never-buffer-names-init
  clean-buffer-list-kill-never-buffer-names
  "Init value for clean-buffer-list-kill-never-buffer-names")
(setq clean-buffer-list-kill-never-buffer-names
      (append
       '("*Messages*" "*cmd*" "*scratch*" "*w3m*" "*localhost*" "*w3m-cache*" "*Inferior Octave*" "&bitlbee@localhost" "Summary")
       clean-buffer-list-kill-never-buffer-names-init))

;; prevent append multiple times
(defvar clean-buffer-list-kill-never-regexps-init
  clean-buffer-list-kill-never-regexps
  "Init value for clean-buffer-list-kill-never-regexps")
;; append to *-init instead of itself
(setq clean-buffer-list-kill-never-regexps
      (append '("^\\*EMMS Playlist\\*.*$")
	            clean-buffer-list-kill-never-regexps-init))

;;tern and tern autocomplete
;;(add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;;for html and smarty syntax
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;prevent backup #files# from getting created
(setq make-backup-files nil) 

;;auto revert mode for switching git branches
(global-auto-revert-mode t)

;;time in status bar
(setq display-time-day-and-date t
                display-time-24hr-format t)
             (display-time)

;;disable toolbar and menu bar in gui emacs
(tool-bar-mode -1) 
(toggle-scroll-bar -1) 

(set-face-attribute 'default nil :height 105)

;; save/restore opened files and windows config
(desktop-save-mode 1) ; 0 for off

;;MACROS
;;add double quotes around a line
(fset 'add_quotes
   "\C-a\C-i\"\C-e\",")
(global-set-key (kbd "C-c a q") 'add_quotes)

;;find the next pipe and hit enter, tab
(fset 'pipe-enter
   [?\M-f right return tab ?\M-x ?e ?n tab ?d ?- ?k tab])
(global-set-key (kbd "C-c n") 'pipe-enter)

;;add double quotes to the first word and move to the beginning of next line
(fset 'new-add-quotes
   [tab ?\" ?\M-f ?\" down ?\C-a ?\M-x ?e ?n ?d tab ?l tab backspace backspace backspace ?\M-d ?\M-d ?= backspace ?- ?k tab])
(global-set-key (kbd "C-c q") 'new-add-quotes)

;;comment a selected region
(global-set-key (kbd "C-c c") 'comment-region)

;;uncomment a selecte region
(global-set-key (kbd "C-c u") 'uncomment-region)

;;call smarty mode
(fset 'smarty-macro
   [?\M-x ?s ?m ?a ?r ?t ?y ?- ?m ?o ?d ?e return])
(global-set-key (kbd "C-c s") 'smarty-macro)

;;call html mode
(fset 'html-shortcut
   [?\M-x ?h ?t ?m ?l ?- ?m ?o ?d ?e return])
(global-set-key (kbd "C-c h") 'html-shortcut)

;;call javascript mode
(global-set-key (kbd "C-c j") 'javascript-mode)

;;call yafolding mode
(fset 'yafolding-start
   [?\M-x ?y ?a ?f ?o ?l tab ?m ?o tab return])
(global-set-key (kbd "C-c y") 'yafolding-start)

;;call web mode
(fset 'web-mode-macro
   [?\M-x ?w ?e ?b ?- ?m ?o ?d ?e return])
(global-set-key (kbd "C-c w") 'web-mode-macro)

(windmove-default-keybindings 'meta)

;;switch to other pane
;;(fset 'switch-to-other-pane
;;   [?\C-x ?o])
;;(global-set-key (kbd "C-<tab>") 'next-buffer)
(global-set-key [(control tab)] 'next-buffer)
(global-set-key [C-S-iso-lefttab] 'previous-buffer)

(visual-line-mode -1)

;;winner mode
(when (fboundp 'winner-mode)
      (winner-mode 1))

;;magit status
(global-set-key (kbd "C-c m") 'magit-status)

;;w3m
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)
(add-to-list 'exec-path "/home/asif/.emacs.d/elpa/w3m-20150513.1")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (tsdh-light)))
 '(custom-safe-themes (quote ("6a9606327ecca6e772fba6ef46137d129e6d1888dcfc65d0b9b27a7a00a4af20" default)))
 '(fci-rule-color "#383838")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;zenburn
;;(load-theme 'zenburn t)

;;eshell
(global-set-key [f1] 'eshell)

;;rcirc
(require 'rcirc)
(setq rcirc-default-nick "asifsk")
;;(setq rcirc-notify-popup-timeout 30)
;;(setq rcirc-notify-timeout 10)
(rcirc-connect "localhost"); 
;;(require 'rcirc-notify)
;;(require 'rcirc-alert)
(require 'rcirc-alertify)
(rcirc-alertify-enable)
(setq alert-default-style 'libnotify)

;;wanderlust for email
;;(autoload 'wl "wl" "Wanderlust" t)

;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "imap.googlemail.com")
(setq elmo-imap4-default-user "asif@sportskeeda.com") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t) 

;;(setq wl-draft-send-mail-function 'wl-draft-send-mail-with-pop-before-smtp)

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
;;(setq wl-smtp-posting-port 465)
;;(setq smtpmail-stream-type 'ssl)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "asif@sportskeeda.com")
(setq wl-smtp-posting-server "smtp.googlemail.com")
(setq wl-local-domain "sportskeeda.com")

;;syncing
(setq elmo-message-fetch-confirm t)
(setq elmo-message-fetch-threshold 250000)

;;sorting by date
;; sort the summary
(defun my-wl-summary-sort-hook ()
  (wl-summary-rescan "date"))
(add-hook 'wl-summary-prepared-hook 'my-wl-summary-sort-hook)

(setq wl-default-folder "%inbox")
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
(setq wl-trash-folder "%[Gmail]/Trash")
(setq wl-from "asif@sportskeeda.com")
(setq wl-folder-check-async t) 

(setq elmo-imap4-use-modified-utf7 t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;;mouse avoidance
(mouse-avoidance-mode 1)
(defun mouse-avoidance-banish-destination ()
  "The position to which Mouse-Avoidance mode `banish' moves the mouse.
You can redefine this if you want the mouse banished to a different corner."
  (let* ((pos (window-edges)))
    (cons (- (nth 2 pos) 2)
	  (+ (nth 1 pos) 1))))

;;remove blank lines
(fset 'remove_blank_lines
   [?\C-x ?h ?\M-x ?f ?l ?u ?s ?h tab return ?^ ?$ return])
(global-set-key (kbd "C-c F") 'remove_blank_lines)
