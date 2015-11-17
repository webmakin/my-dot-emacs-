;;(add-to-list 'load-path "/home/asif/Downloads/php-mode-1.13.1")
(add-to-list 'load-path "/home/asif/.emacs.d")
;;(add-to-list 'load-path "/home/asif/mu/mu4e")

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
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" default)))
 '(dtrt-indent-mode nil nil (dtrt-indent))
 '(wakatime-api-key "5fc86bc1-1cbe-4ad0-89fc-3227ceb82a7d")
 '(wakatime-cli-path "/usr/local/bin/wakatime"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;zenburn
(load-theme 'zenburn t)

;;eshell
(global-set-key [f1] 'eshell)

;; ;;rcirc
;; (require 'rcirc)
;; (setq rcirc-default-nick "asifsk")
;; ;;(setq rcirc-notify-popup-timeout 30)
;; ;;(setq rcirc-notify-timeout 10)
;; (rcirc-connect "localhost"); 
;; ;;(require 'rcirc-notify)
;; ;;(require 'rcirc-alert)
;; (require 'rcirc-alertify)
;; (rcirc-alertify-enable)
;; (setq alert-default-style 'libnotify)

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

;;use twitter master password instead of token
(setq twittering-use-master-password t)

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

;;set the indentation correctly
;; (require 'web-mode)
;; (defun my-web-mode-hook ()
;;   "Hooks for Web mode."
;;   (setq web-mode-markup-indent-offset 2)
;; )
;; (add-hook 'web-mode-hook  'my-web-mode-hook)

;;wakatime
(global-wakatime-mode t)

;;js2 mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;;(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;;origami mode for code folding
(require 'origami)
(global-set-key (kbd "C-c O") 'origami-mode)
(global-set-key (kbd "C-c 0") 'origami-close-node)
(global-set-key (kbd "C-c 1") 'origami-open-node)
(global-set-key (kbd "C-c -") 'origami-toggle-all-nodes)

;;w3m open links in background
;;(global-set-key (kbd "C-return") 'w3m-goto-url-new-session)

;;make indenting use space instead of tabs
(setq-default indent-tabs-mode nil)
;;(setq js-indent-level 2)
(setq default-tab-width 2)
(setq javascript-indent-level 2)

;;dtrt
(require 'dtrt-indent)
(dtrt-indent-mode t)
;;auto indent
;; (require 'auto-indent-mode)
;; (auto-indent-global-mode)
