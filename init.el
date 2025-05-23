(setq user-email-address "sarathc.inbox@gmail.com")


;; ### Common directories 
(setq custom-file "~/.emacs.d/custom.el")
(setq abbrev-file-name "~/.emacs.d/.abbrev")
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(if init-file-debug
    (setq use-package-verbose t
          use-package-expand-minimally nil
          use-package-compute-statistics t
          debug-on-error t)
  (setq use-package-verbose nil
        use-package-expand-minimally t))

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

(use-package load-env-vars)
(load-env-vars "~/.env")

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
(setq mac-left-command-modifier  'meta    ; M-
      mac-left-option-modifier  'meta     ; M-
      mac-right-option-modifier 'hyper    ; H- 
      mac-right-command-modifier 'super)  ; s-

;;; S- is configured in this config to help with some of the navigation commands below.


(setq scroll-preserve-screen-position 1)

;;;; Keyboard based movement configuration
;;;; Characters 

(use-package load-env-vars)
(load-env-vars "~/.env")

;;;; Words
;;;;;  Backward: M-b, Forward: M-f
;;;;;  Backward: M-<left>, Forward: M-<right>
(global-set-key (kbd "M-<left>") 'backward-word)
(global-set-key (kbd "M-<right>") 'forward-word)


;;;; Lines
;;;;;; Previous : C-p, Next : C-n
;;;;;; Previous : <up>, Next : <down>
(global-set-key (kbd "<up>") 'previous-line)
(global-set-key (kbd "<down>") 'next-line)

;;;;;; Start of : C-a, End of: C-e 
;;;;;; Start of : S-<left>, End of: S-<right>
(global-set-key (kbd "S-<left>") 'beginning-of-visual-line)
(global-set-key (kbd "S-<right>") 'end-of-visual-line)

;;;; Pages
;;;;;; Scroll Up: M-v, Scroll Down : C-v
;;;;;; Scroll Up: M-p, Scroll Down : M-n
;;;;;; Scroll Up: M-<down>, Scroll Down : M-<up>

(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)

(global-set-key (kbd "M-<down>") 'scroll-up)
(global-set-key (kbd "M-<up>") 'scroll-down)

;;;; Buffer
;;;;;; Start of : S-<up>, End Of: S-<down>
(global-set-key (kbd "S-<down>") 'end-of-buffer)
(global-set-key (kbd "S-<up>") 'beginning-of-buffer)

(global-set-key (kbd "H-f i") 'open-init-file)
(global-set-key (kbd "H-b e") 'eval-buffer)
;;;;

;;; Using hydra for some convenient key bindings.
(straight-use-package 'hydra)

(defhydra hydra-keyboard (:color red)
  "Keyboard Movement"
  ("M-<left>" backward-word "backward-word" :column "Words")
  ("M-<right>" forward-word "forward-word")

  ("<up>" previous-line "previous-line" :column "Lines")
  ("<down>" next-line "next-line" :column "Lines")
  ("S-<left>" beginning-of-visual-line "beginning-of-visual-line" :column "Lines")
  ("S-<right>" end-of-visual-line "end-of-visual-line" :column "Lines")

  ("M-<up>" scroll-down "scroll-down" :column "Pages")
  ("M-<down>" scroll-up "scroll-up" :column "Pages") 

  ("S-<down>" beginning-of-buffer "beginning-of-buffer")
  ("S-<down>" end-of-buffer "end-of-buffer" :column "Buffers")

  )
(global-set-key (kbd "H-k") 'hydra-keyboard/body)


;;;;; End of movement config

(global-set-key (kbd "<s-up>") 'shrink-window)
(global-set-key (kbd "<s-down>") 'enlarge-window)
(global-set-key (kbd "<s-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<s-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<C-M-z>") 'winner-undo)
(global-set-key (kbd "<C-M-a>") 'winner-redo)

;;;



;;;;; start of Zoom 
(global-set-key (kbd "M-s-<up>") 'text-scale-increase)
(global-set-key (kbd "M-s-<down>") 'text-scale-decrease)

(defhydra hydra-zoom (:color red)
  "zoom"
  ("<up>" text-scale-increase "in")
  ("<down>" text-scale-decrease "out")
  )
(global-set-key (kbd "H-z") 'hydra-zoom/body)
;;;;; End of Zoom

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
         (windmove-right)) "split right and move" :column "Split Window")
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down))  "split below and move")
  ("v" split-window-right "split right and stay")
  ("x" split-window-below "split below and stay")
  )
(global-set-key (kbd "H-w") 'hydra-frames/body)


(use-package keycast
  :config
  (keycast-tab-bar-mode)
  ;;  (keycast-mode-line-mode)
  ;;  (keycast-header-line-mode)
  )
(global-set-key (kbd "H-c") 'keycast-log-mode)

(use-package which-key
  :config
  (setq which-key-idle-delay 0.75)
  (which-key-setup-minibuffer)
  (which-key-mode))

;;; Add completion capabilities with corfu, vertico, consult and orderless
(use-package corfu
  :straight t
  :bind
  (:map corfu-map
        ;; unbind other corfu stuffs
	("RET" . nil)
	("TAB" . nil)
	("[tab]" . nil)
	("<tab>" . nil)
        ;; bind corfu completion to C-enter
	("C-<return>" . corfu-insert))
)    ;; all your normal corfu stuffs)

(use-package vertico
  :init
  (vertico-mode))


(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult)
 

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;;;

;;; TODO : Need to add org mode hydra menu.

;;; Add gptel to the configuration
(use-package gptel
  :init
  (message (getenv "GEMINI_API_KEY"))
  :straight t
  :config
  (setq gptel-log-level 'debug)
  (setq gemini-key (getenv "GEMINI_API_KEY"))
  (setq gptel-backend (gptel-make-gemini "Gemini" :key gemini-key :stream t))
  (setq  gptel-model 'gemini-1.5-pro-latest)
  )
	
;;;; end of gptel block 

(use-package git-gutter
  :ensure t)

(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)
)

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

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))


;;; Some convenient key bindings
(use-package recentf
  :init
  (global-set-key (kbd "C-x r") 'recentf-open))


;;;;; Projectile setup and configuration.

;; (use-package projectile
;;   :ensure t
;;   :init
;;   (projectile-mode +1)
;;   :bind (:map projectile-mode-map
;;               ("C-c p" . projectile-command-map)))

;; ( defhydra hydra-project (:color red)
;;   "Projectile"
  
;;   )

;;;;; End of projectice setup and configuration.


;;;; Completion framework - Helm

;; (use-package helm
;;   :config
;;   (require 'helm-config)
;;   :init
;;   (helm-mode 1)
;;   :bind
;;   (("C-x C-f" . helm-find-files)
;;    ("C-x b" . helm-mini)
;;    ("C-x C-r" . helm-recentf)
;;    :map helm-map
;;    ("C-z"   . helm-select-action)
;;    ("<tab>" . helm-execute-persistent-action))
;;   )

;; ;;;; End of completion framewok - Helm  config


;; ;;;; Helm-projectile

;; ;; Helm Projectile
;; (use-package helm-projectile
;; :bind (("C-S-P" . helm-projectile-switch-project))
;; :ensure t
;; )




;; (use-package org
;;   :ensure org
;;   :config
;;   (setq org-confirm-babel-evaluate nil)
;;   :custom
;;   (org-directory "~/orgs")
;;   )
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;;;; Org-Agenda, org-timeline

;;;; Mermaid
;;; brew install  mermaid-cli
;; (use-package ob-mermaid
;;   :init
;;   (define-key org-mode-map
;;     (kbd "C-c C-c")
;;     (lambda () (interactive)
;;       (org-ctrl-c-ctrl-c)
;;       (org-display-inline-images)
;;       )
;;     )
;;   :config
;;   (setq ob-mermaid-cli-path "/usr/local/bin/mmdc")
;;   (org-display-inline-images))

;;; If the path is not picked up from the shell, node does not execute.

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

;;;; Org Roam
;; (use-package emacsql-sqlite3
;;   :straight t)

;; (use-package org-roam
;;   :straight t
;;   :custom
;;   (org-roam-directory "~/orgs/roam")
;;   (org-roam-completion-everywhere t)
;;   (org-roam-database-connector 'sqlite3)
;;   (org-tags-column 10)
;;   :bind (("H-n b" . org-roam-buffer-toggle)
;; 	 ("H-n f" . org-roam-node-find)
;; 	 ("H-n i" . org-roam-node-insert)
;; 	 ("H-n h" . org-id-get-create)
;; 	 ("H-n t" . org-roam-buffer-toggle)
;; 	 :map org-mode-map
;; 	 ("H-n c" . completion-at-point)
;; 	 ("H-n r" . org-roam-ui-mode))
 
  
;;   :config
;;   (org-roam-setup))



;; ;;; Org Roam UI
;; (use-package websocket
;;   :after org-roam)
;; (use-package org-roam-ui
;;   :after org-roam
;;   :config
;;   (setq org-roam-ui-sync-theme t
;; 	org-roam-ui-follow t
;; 	org-roam-ui-update-on-save t))


;; ;;;; Org Hydra
;; (defhydra hydra-org (:color red)
;;   "org"
;;   ("is" (org-insert-structure-template "src")     "src block" :column "blocks")
;;   ("im" (org-insert-structure-template "src mermaid :file test.png") "mermaid" )
;;   )
;; (global-set-key (kbd "s-o") 'hydra-org/body)
	
;;; TODO Figure out a way to use google drive from emacs.

;;; LSP rest client 

(use-package company
  :ensure t
  :config 
  ;; don't add any dely before trying to complete thing being typed
  ;; the call/response to gopls is asynchronous so this should have little
  ;; to no affect on edit latency
  (setq company-idle-delay 0)
  ;; start completing after a single character instead of 3
  (setq company-minimum-prefix-length 1)
  ;; align fields in completions
  (setq company-tooltip-align-annotations t)
  
  )

(use-package company-box
  :hook (company-mode . company-box-mode))


(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; Not able to add the pyenv that is active to the modeline. 

;; (use-package pyvenv
;;   :diminish
;;   :config
;;   (setq pyvenv-mode-line-indicator
;; 	'(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  
;;   (pyvenv-mode +1))


(use-package python-mode
  :ensure t
  :mode (
	 ("\\.py\\'" . python-mode))
  :custom
  (python-shell-interpreter "python3"))


(straight-use-package 'lsp-mode)
;;; LSP Mode
;;;;; 
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (python-mode . lsp)
	 (go-mode . lsp)
	 
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(straight-use-package 'envrc)
(envrc-global-mode)


(use-package go-mode
  :ensure t
  :bind (
	 ("C-c C-j" . lsp-find-definition)
	 ("C-c C-d" . lsp-describe-thing-at-point)
	 )
  
  :hook (
	 (go-mode . lsp-deferred)
	 (before-save . lsp-fomat-buffer)
	 (before-save . lsp-organize-imports)
	 ))

  

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package gopls-config		   ;;
;;  :ensure t			   ;;
;;  :hook (go-mode . gopls-mode))    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; optionally
(use-package lsp-ui
  :ensure t
  :straight t
  :commands lsp-ui-mode
  )
;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)



;; ;;; Typescript lsp-mode
;; ;;; npm i -g typescript-language-server; npm i -g typescript

;; ;;;; End of LSP Mode config

(defun test-all-getenv-inherited ()
  (interactive)
  (let* ((variable-list (list "PATH" "HOME" "USER" "SHELL" "EDITOR" "LOGNAME" "LANG"))) ; Add or remove variables as needed
    (mapcar #'test-getenv-inherited variable-list)))

(defun open-init-file ()
  "Open this very file."
  (interactive)
  (find-file user-init-file))

;;;;; Diagnostics for startup 

(add-hook 'emacs-startup-hook 'perfReport)

(defun perfReport ()
  (message "Emacs ready in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))		  

(perfReport)
