(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("25da85b0d62fd69b825e931e27079ceeb9fd041d14676337ea1ce1919ce4ab17" default)))
 '(global-auto-revert-mode t)
 '(org-agenda-start-on-weekday nil)
 '(org-enforce-todo-dependencies t)
 '(org-modules
   (quote
    (org-w3m org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-eww org-habit)))
 '(package-selected-packages
   (quote
    (ir-black-theme dash-functional org-mind-map org-bullets free-keys org-journal orgalist org-edna)))
 '(safe-local-variable-values (quote ((buffer-auto-save-file-name)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB  " :slant normal :weight normal :height 99 :width normal)))))

(require 'package)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(add-hook 'org-mode-hook #'(lambda ()

                             ;; make the lines in the buffer wrap around the edges of the screen.
                             
                             ;; to press C-c q  or fill-paragraph ever again!
                             (visual-line-mode)
                             (org-indent-mode)))

(setq default-directory "~/Dropbox/" )

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(setq org-startup-folded 'content)

(require 'org-sort-tasks)

(require 'org-agenda)

(setq org-agenda-skip-function-global 
      '(org-agenda-skip-entry-if 'todo '("DONE" "CANCELLED")))

(require 'org-checklist)

;; Allow automatically handing of created/expired meta data.
; (require 'org-expiry)

; (org-expiry-insinuate)

; (setq org-expiry-inactive-timestamps t)

(setq org-journal-dir "~/Dropbox/org/journal")
(setq org-journal-file-format  "%m_%d_%Y.org")

(require 'org-bullets)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-journal)

(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil)

(defun risky-local-variable-p (sym &optional _ignored) nil)

(setq epa-file-cache-passphrase-for-symmetric-encryption nil)

;; Custom journal file format so that we can edit in org mode to begin with
;; Not sure what this will break...
; (global-set-key (kbd "C-c C-g")  'org-journal-new-entry)

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

;; Automatically update parent TODO when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(require 'org-id)

(global-set-key (kbd "C-c C-g")  'org-journal-new-entry)

;; Whenever a TODO entry is created, I want a timestamp
;; Advice org-insert-todo-heading to insert a created timestamp using org-expiry
; (defadvice org-insert-todo-heading (after mrb/created-timestamp-advice activate)
;  "Insert a CREATED property using org-expiry.el for TODO entries"
;  (mrb/insert-created-timestamp)
					;  )

;; Make it active
; (ad-activate 'org-insert-todo-heading)

; (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

; (defun eos/org-custom-id-get (&optional pom create prefix)
;  "Get the CUSTOM_ID property of the entry at point-or-marker POM.
;   If POM is nil, refer to the entry at point. If the entry does
;   not have an CUSTOM_ID, the function returns nil. However, when
;   CREATE is non nil, create a CUSTOM_ID if none is present
;   already. PREFIX will be passed through to `org-id-new'. In any
;   case, the CUSTOM_ID of the entry is returned."
;  (interactive)
;  (org-with-point-at pom
;    (let ((id (org-entry-get nil "CUSTOM_ID")))
;      (cond
;       ((and id (stringp id) (string-match "\\S-" id))
;        id)
;       (create
;        (setq id (org-id-new (concat prefix "h")))
;        (org-entry-put pom "CUSTOM_ID" id)
;	(org-cycle)
;        (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
;        id)))))

;(defun eos/org-add-ids-to-headlines-in-file ()
;  "Add CUSTOM_ID properties to all headlines in the
;   current file which do not already have one."
;  (interactive)
;  (org-map-entries (lambda () (eos/org-custom-id-get (point) 'create))))

; (add-hook 'org-mode-hook
;          (lambda ()
;            (add-hook 'before-save-hook
;                      (lambda ()
;                        (when (and (eq major-mode 'org-mode)
;                                   (eq buffer-read-only nil))
;                          (eos/org-add-ids-to-headlines-in-file))))))

(require 'org-contacts
)
(require 'org-clock)

(setq org-directory "~/Dropbox")
(setq org-default-notes-file "~/Dropbox/org/swap.org")
(defvar org-default-journal-file "/Dropbox/org/journal.org")
(setq org-agenda-files (list "~/Dropbox/org/swap.org" "~/Dropbox/org/next.org" "~/Dropbox/org/tickler.org"))
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	("NEXT" :foreground "blue" :weight bold)
	("DONE" :foreground "forest green" :weight bold)
	("WAITING" :foreground "orange" :weight bold)
	("INACTIVE" :foreground "magenta" :weight bold)
	("CANCELLED" :foreground "forest green" :weight bold)))


(setq org-todo-state-tags-triggers
      '(("CANCELLED" ("CANCELLED" . t))
	("WAITING" ("WAITING" . t))
	("INACTIVE" ("WAITING") ("INACTIVE" . t))
	(done ("WAITING") ("INACTIVE"))
	("TODO" ("WAITING") ("CANCELLED") ("INACTIVE"))
	("NEXT" ("WAITING") ("CANCELLED") ("INACTIVE"))
	("DONE" ("WAITING") ("CANCELLED") ("INACTIVE"))))

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emac

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "WAITING" "|" "CANCELLED" "DONE")))

;; Define the custum capture templates
(setq org-capture-templates
      '(("s" "Swap" entry (file+headline "~/Dropbox/org/swap.org" "Swap space")
         "* TODO %?\n  %i\n")
        ("j" "Journal entry" entry (function org-journal-find-location)
         "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")))

(setq org-refile-targets '((nil :maxlevel . 9) ("~/Dropbox/org/someday.org" :maxlevel . 1 ) ("~/Dropbox/org/backburner.org" :maxlevel . 1 ) (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(require 'ox-org)
(require 'org-mind-map)

(load-theme 'ir-black t)
(set-face-attribute 'default (selected-frame) :height 100)

(global-set-key (kbd "H-k") 'previous-line)
(global-set-key (kbd "H-j") 'next-line)
(global-set-key (kbd "H-h") 'left-char)
(global-set-key (kbd "H-l") 'right-char)
(tool-bar-mode -1)
(menu-bar-mode -1)

(load-theme 'ir-black t)
