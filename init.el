(setq jit-lock-stealth-time nil)
(setq jit-lock-defer-time nil)
(setq jit-lock-defer-time 0.00)
(setq jit-lock-stealth-load 0)

;; Display startup message
(setq initial-scratch-message "Hello world!")

;; Disable splash screen and startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; start up fullscreen
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(edt-set-scroll-margins "1%" "1%")

;; Stop creating ~ files
(setq make-backup-files nil)

;; Set font
(set-face-attribute 'default nil
					:family "Iosevka"
					:weight 'regular
					:height 160)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
                    :font "Iosevka"
                    :weight 'regular
                    :height 160)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    :font "Iosevka"
                    :weight 'regular
                    :height 160)

;; Scroll
(setq scroll-step 1
      scroll-preserve-screen-position t
      scroll-margin 10
      scroll-conservatively 10
      maximum-scroll-margin 0.0
      scroll-up-aggressively 0.0
      scroll-down-aggressively 0.0)

;; Disable annoying ring-bell when backspace key is pressed in certain situations
(setq ring-bell-function 'ignore)
;; (setq-default cursor-type '(hbar . 6))

;; Set language environment to UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Display line number when programming
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


;; Word wrap
(global-visual-line-mode t)

;; Display paren (highlight matching brackets)
(show-paren-mode 1)
(column-number-mode 1)
(setq show-paren-delay 0)

;; Turn off menubar, toolbar, scollbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(set-fringe-style -1)
(tooltip-mode -1)

;; Set tab-width
(setq-default indent-tab-mode nil)
(setq-default tab-width 4) ; or any other preferred value
(setq indent-line-function 'insert-tab)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;disable cursor blinking
(blink-cursor-mode 0)
(setq visible-cursor nil)

;; Load package manager

(setq package-archives
	  '(("melpa" . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/melpa/")
		("org"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/org/")
		("gnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/gnu/")
		("nongnu"   . "https://raw.githubusercontent.com/d12frosted/elpa-mirror/master/nongnu/")
		))

(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (package-initialize)
   (package-refresh-contents)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; Set theme
;;(use-package doom-themes
;; :ensure t
;; :config
;; (load-theme 'doom-one t))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; (use-package idea-darkula-theme
;;   :ensure t
;;   :config
;;   (load-theme 'idea-darkula t))

;;(use-package solarized-theme
;;  :ensure t
;;  :config
;;  (load-theme 'solarized-dark t))

;; (use-package zenburn-theme
;;  :ensure t
;;  :config
;;  (load-theme 'zenburn t))

;; Status line
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon (display-graphic-p)
 		doom-modeline-major-mode-icon t
 		doom-modeline-major-mode-color-icon t
 		doom-modeline-buffer-state-icon t
 		doom-modeline-buffer-modification-icon t)
  )

;;(use-package spaceline
;;  :ensure t
;;  :config
;;  (spaceline-spacemacs-theme))

;; Code autocomplete
(use-package company
  :bind (:map company-active-map
			  ("C-n" . company-select-next)
			  ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0.0
		company-echo-delay 0.0
		company-minimum-prefix-length 10
		company-tooltip-align-annotations t
		company-tooltip-minimum-width 10
		company-tooltip-maximum-width 40
		company-tooltip-current-width 20
		company-tooltip-limit         15
		company-frontends '(company-pseudo-tooltip-frontend)
        company-backends '((
                            company-dabbrev-code
                            company-capf
                            company-files
                            company-semantic
                            ))
		company-selection-wrap-around t
		company-transformers '(company-sort-by-occurrence)
		company-dabbrev-other-buffers   t
		company-preview-overlay t
		company-tooltip-align-annotations t
		company-dabbrev-other-buffers t
        company-tooltip-margin 1
		)
  ;;(global-company-mode t)
  )

(use-package corfu
  :init
  (setq corfu-auto t
        corfu-quit-no-match t
		corfu-auto-prefix 10
		corfu-auto-delay 0.0
        corfu-quit-at-boundary 'separator)
  (global-corfu-mode))
;;(setq lsp-completion-provider :none)

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  :config
  (defun my-cape-dabbrev-accept-all ()
	(cape-wrap-accept-all #'cape-dabbrev))
  (add-to-list 'completion-at-point-functions #'my-cape-dabbrev-accept-all)
  )

(use-package smex
  :bind(("C-;" . smex))
  )

;; undo for evil mode
(use-package undo-fu
  :ensure t)

;;; Vim Bindings
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  ;; (setq evil-insert-state-cursor '((hbar . 4)))
  (setq evil-insert-state-cursor '((box . 4)))
  ;; (setq evil-insert-state-cursor '((bar . 4)))
  (evil-mode 1)
  ;; Evil key bindings
  (with-eval-after-load 'evil-maps
	;; normal mode
	(define-key evil-normal-state-map (kbd "/")         'swiper)
	(define-key evil-normal-state-map (kbd"<tab>")      'centaur-tabs-forward-tab)
	(define-key evil-normal-state-map (kbd"<backtab>")  'centaur-tabs-backward-tab)
	(define-key evil-normal-state-map (kbd"R")          'recompile)
	(define-key evil-normal-state-map (kbd"M-q")		'centaur-tabs--kill-this-buffer-dont-ask)
	(define-key evil-normal-state-map (kbd"C-h")		'evil-window-left)
	(define-key evil-normal-state-map (kbd"C-j") 		'evil-window-down)
	(define-key evil-normal-state-map (kbd"C-k")		'evil-window-up)
	(define-key evil-normal-state-map (kbd"C-l")		'evil-window-right)
	(define-key evil-normal-state-map (kbd"C--")        'text-scale-decrease)
	(define-key evil-normal-state-map (kbd"C-=")        'text-scale-increase)
	(define-key evil-normal-state-map (kbd"C-d")        'evil-multiedit-match-and-next)
	;; visual mode
	(define-key evil-visual-state-map (kbd"gc")          'xah-comment-dwim)
	(define-key evil-visual-state-map (kbd"C-d")          'evil-multiedit-match-and-next)
	;; insert mode
	;; (define-key evil-insert-state-map (kbd"C-SPC")       'company-dabbrev-code)
	(define-key evil-insert-state-map (kbd"C-SPC")         'completion-at-point)
	))

(defmacro evil-map (state key seq)
  "Map for a given STATE a KEY to a sequence SEQ of keys.
Can handle recursive definition only if KEY is the first key of SEQ.
Example: (evil-map visual \"<\" \"<gv\")"
  (let ((map (intern (format "evil-%S-state-map" state))))
    `(define-key ,map ,key
       (lambda ()
         (interactive)
         ,(if (string-equal key (substring seq 0 1))
              `(progn
                 (call-interactively ',(lookup-key evil-normal-state-map key))
                 (execute-kbd-macro ,(substring seq 1)))
            (execute-kbd-macro ,seq))))))

;; Keep the region active when shifting
(evil-map visual "<" "<gv")
(evil-map visual ">" ">gv")

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-multiedit
  :after evil
  :ensure t
  :config
  (setq evil-multiedit-dwim-motion-keys nil))

(use-package format-all
  :config
  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter)
  )

(use-package all-the-icons
  :if (display-graphic-p))

;; File explorer
(use-package neotree
  :ensure t
  :bind ("<f2>" . 'neotree-toggle)
  :init
  ;; slow rendering
  (setq inhibit-compacting-font-caches t)

  ;; set icons theme
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)

  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically
  (setq projectile-switch-project-action 'neotree-projectile-action)

  ;; show hidden files
  (setq-default neo-show-hidden-files t)
  )

;; Tab bar
(use-package centaur-tabs
  :ensure t
  :init (centaur-tabs-mode t)
  :config
  (setq   centaur-tabs-set-icons t
		  centaur-tabs-height 32
		  centaur-tabs-set-bar 'under)
  :hook
  (dired-mode . centaur-tabs-local-mode)
  )

;; Search
(use-package swiper
  :ensure t
  :config
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height-alist
		'((t
		   lambda (_caller)
		   (/ (frame-height) 4))))
  )

(use-package rust-mode
  :ensure t)

;; Autopair
(add-to-list 'load-path "~/.emacs.d/settings/")
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;; GCMH - the Garbage Collector Magic Hack
(require 'gcmh)
(gcmh-mode 1)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;;comment code
(defun xah-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line."
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let ((-lbp (line-beginning-position))
          (-lep (line-end-position)))
      (if (eq -lbp -lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) -lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region -lbp -lep)
            (forward-line )))))))

;; compilation mode
;; Convert shell escapes to  color
(add-hook 'compilation-filter-hook
          (lambda () (ansi-color-apply-on-region (point-min) (point-max))))

(defun run-shell ()
  (interactive)
  (let ((shell-file-name "cmd.exe"))
	(shell "*cmd.exe*")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(swiper centaur-tabs neotree all-the-icons format-all evil-multiedit evil-collection evil undo-fu smex cape corfu company use-package))
 '(warning-suppress-log-types '((iedit) (comp) (iedit) (iedit)))
 '(warning-suppress-types '((comp) (iedit) (iedit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
