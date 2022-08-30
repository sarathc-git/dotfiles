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
;; (setq use-package-always-ensure t)

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
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out")
  )
(global-set-key (kbd "H-z") 'hydra-zoom/body)

(straight-use-package 'windmove)

(defhydra hydra-frames (:color red)
  "windows and frames"
  ("f" other-frame "other frame" :column "frames")
  ("n" make-frame "New frame")
  
  ("s-<up>" windmove-up "window-up" :column "windows")
  ("s-<right>" windmove-right "window-right" :column "windows")
  ("s-<left>" windmove-left "window-left")
  ("s-<down>" windmove-down "window-down")

  ("S-<up>" hydra-move-splitter-up "splitter up" :column "splitter")
  ("S-<down>" hydra-move-splitter-down "splitter down")
  ("S-<right>" hydra-move-splitter-right "splitter right")
  ("S-<left>" hydra-move-splitter-left "splitter left")

  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)) :column "Split Window")
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("v" split-window-right)
  ("x" split-window-below)

  ("d" delete-window :column "Miscellaneous")
  )
(global-set-key (kbd "H-w") 'hydra-frames/body)

;;; TODO : Need to add org mode hydra menu.

;;; Magit 
(straight-use-package 'magit)
