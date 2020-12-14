;; Emacs starts with at 120 x 120 
(when window-system (set-frame-size (selected-frame) 120 120))

;; Hide start menu
(setq inhibit-startup-message t)

;; C-x C-f starts at the home directory 
(setq default-directory (concat (getenv "HOME") "/"))

;; Show line numbers by default
(global-linum-mode 1)

;; restore previous window state ctl-c left/right
(winner-mode 1)

;; Access to Melpa packages
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
'("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; Installed packages 
(use-package evil
:ensure t)
(evil-mode)

;; Enable Ivy for better searching
(use-package ivy
  :ensure t)
(ivy-mode 1)

(use-package which-key
  :ensure t)

;; Enable Which-Key for a guide to keyboard shortcuts
(which-key-mode)

;; swap between windows easily
(use-package ace-window
:ensure t
:init
(progn
(global-set-key [remap other-window] 'ace-window)
(windmove-default-keybindings)
(custom-set-faces
'(aw-leading-char-face
((t (:inherit ace-jump-face-foreground :height 3.0)))))
))

;; this is were ispell is installed on my machine
(setq ispell-program-name "/usr/local/bin/ispell")

;; Emacs color theme
(load-theme 'misterioso)

;; c++ language server protocol (eglot and clangd)
;; had to first brew install llvm
;; then add the following to .bash_rc: export PATH="/usr/local/opt/llvm/bin:$PATH"
;; then install exec-path-from-shell
;;eglot
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(global-company-mode 1)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
