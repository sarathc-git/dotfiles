(setq user-email-address "sarathc.inbox@gmail.com")


;; ### Common directories 
(setq custom-file "~/.emacs.d/custom.el")
(setq abbrev-file-name "~/.emacs.d/.abbrev")
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;; ### Package Infra
;; (require 'package)
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;; 			 ("org" . "https://orgmode.org/elpa/") 
;;                          ("melpa" . "http://melpa.org/packages/")))
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; (package-initialize)
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))
;; (require 'use-package)
;;(setq use-package-always-ensure t)

;; straight.el
(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;;;; 

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
;; M-x straight-freeze-versions

;;; Clean startup
(setq debug-on-error nil)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq column-number-mode t)
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(electric-pair-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode)
(global-visual-line-mode 1)
(setq show-paren-style 'mixed)
(global-subword-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode t)
(winner-mode 1)

;;; Fonts
(set-face-attribute 'default nil :font "Menlo" :height 200)


;;; Some initial key bindings
(setq mac-left-option-modifier  'meta
      mac-right-option-modifier 'hyper
      mac-right-command-modifier 'super)

(setq scroll-preserve-screen-position 1)

(global-set-key (kbd "M-n") (kbd "C-v"))
(global-set-key (kbd "M-p") (kbd "M-v"))
(global-set-key (kbd "H-f i") 'open-init-file)
(global-set-key (kbd "H-b e") 'eval-buffer)

(global-set-key (kbd "<s-up>") 'shrink-window)
(global-set-key (kbd "<s-down>") 'enlarge-window)
(global-set-key (kbd "<s-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<s-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<C-M-z>") 'winner-undo)
(global-set-key (kbd "<C-M-a>") 'winner-redo)

;;;


;;; Using hydra for some convenient key bindings.
(straight-use-package 'hydra)

(defhydra hydra-zoom (:color red)
  "zoom"
  ("<up>" text-scale-increase "in")
  ("<down>" text-scale-decrease "out")
  )
(global-set-key (kbd "H-z") 'hydra-zoom/body)

(straight-use-package 'windmove)

(defhydra hydra-frames (:color red)
  "windows and frames"
  ("f" other-frame "other frame" :column "frames")
  ("n" make-frame "New frame")
  
  ("s-<up>"     windmove-up    "window-up"    :column "windows")
  ("s-<right>"  windmove-right "window-right")
  ("s-<left>"   windmove-left  "window-left")
  ("s-<down>"   windmove-down  "window-down")

  ("S-<up>" hydra-move-splitter-up "splitter up" :column "splitter")
  ("S-<down>" hydra-move-splitter-down "splitter down")
  ("S-<right>" hydra-move-splitter-right "splitter right")
  ("S-<left>" hydra-move-splitter-left "splitter left")

  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)) "split right and move":column "Split Window")
  ("_" (lambda ()
         (interactive)
         (split-window-below "split below and move")
         (windmove-down)))
  ("v" split-window-right "split right and stay")
  ("x" split-window-below "split right and stay")

  ("d" delete-window :column "Miscellaneous")
  )
(global-set-key (kbd "H-w") 'hydra-frames/body)

(straight-use-package 'use-package)

(use-package which-key
  :config
  (setq which-key-idle-delay 1.0)
;;  (which-key-setup-minibufer)
  (which-key-mode))

;;; TODO : Need to add org mode hydra menu.

;;; Magit 
(straight-use-package 'magit)

(defhydra hydra-magit (:color red)
  "magit"  
  ("p" magit-push "magit-push" :column "actions")
  ("c" magit-commit "magit-commit" )
  ("t" git-timemachine-toogle)
  
  ("la" magit-log-all "magit-log-all --graph" :column "status")
  ("s" magit-status "magit-status")
  ("d" magit-diff "magit-diff")
  )

(global-set-key (kbd "H-m") 'hydra-magit/body)

;;; TODO Org - Roam, PDF Tools, Org Noter, Org Drill

(use-package org
  :ensure org
  )
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(use-package emacsql-sqlite3
  :straight t)

(use-package org-roam
  :straight t
  :custom
  (org-roam-directory "~/orgs/roam")
  (org-roam-completion-everywhere t)
  (org-roam-database-connector 'sqlite3)
  (org-tags-column 10)
  :bind (("H-n b" . org-roam-buffer-toggle)
	 ("H-n f" . org-roam-node-find)
	 ("H-n i" . org-roam-node-insert)
	 ("H-n h" . org-id-get-create)
	 ("H-n t" . org-roam-buffer-toggle)
	 :map org-mode-map
	 ("H-n c" . completion-at-point))

  :config
  (org-roam-setup))

;;; LSP rest client 


