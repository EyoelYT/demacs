;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; wasn't installed correctly. Font issues are rarely Doom issues!
;; refresh your font settings. If Emacs still can't find your font, it likely

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-ayu-mirage)
(setq doom-font (font-spec :family "Iosevka NFM" :size 18)) ;; can add :weight 'light
(setq-default fringe-mode 1)
;;(set-fringe-style 0)

;; Include hyphens (-) in keywords
(setq evil-symbol-word-search t)

;; Set the default frame size
(setq default-frame-alist
      '((width . 200)   ; Width set to 180 columns
        (height . 60))) ; Height set to 30 lines

;; Trun of those ugly squiggly lines
;;(setq global-vi-tilde-fringe-mode nil)

;; put all backup files into ~/MyEmacsBackups
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/EmacsBackups")))

;; Line and Line number Highlighting
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(after! hl-line
  (set-face-attribute 'line-number-current-line nil :inherit nil))

;; Custom font and background colors
;;(custom-set-faces!
  ;; use "foreground" for every of the set faces
  ;;'(default) ;; #FBF1C7 #EBDBB2
  ;;'(font-lock-string-face) ;; Strings
  ;;'(font-lock-variable-name-face) ;; Variable names #83A598 #FCFCFF
  ;;'(font-lock-keyword-face) ;; Language Keywords
  ;;'(font-lock-comment-face;; Comments #555555
  ;;'(font-lock-type-face) ;; Data-types #AF3A03
  ;;'(font-lock-constant-face) ;; Constants
  ;;'(font-lock-function-name-face) ;; Function and Methods
  ;;'(region) ;; Text selection (highlighted text)
  ;;'(line-number ) ;; Line Number
  ;;'(line-number-current-line) ;; Current line number
  ;;'(mode-line) ;; Active mode line
  ;;'(mode-line-inactive)) ;; Inactive mode line

;; vterm colors
;; (setq vterm-color-palette [vterm-color-white
;;                            vterm-color-red
;;                            vterm-color-green
;;                            vterm-color-yellow
;;                            vterm-color-blue
;;                            vterm-color-magenta
;;                            vterm-color-cyan
;;                            vterm-color-white])

;;doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 14)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/AllMyFiles/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(desktop-save-mode 1) ;: Enable desktop saving state
;; (setq desktop-restore-eager 10) ; Number of buffers to restore immediately
;; (setq desktop-save 'if-exists) ; Save desktop without asking if it already exists

;; Set whitespace-mode to none
(setq-default whitespace-style nil)

;; When entering lsp-mode, flycheck is off
;; (use-package! lsp-mode
;;   :hook
;;   (lsp-mode . (lambda ()
;;                 (unless lsp-auto-configure
;;                   (flycheck-mode -1)))))

;; Automatic Flycheck is annoying
;; (after! flycheck
;;   (after! lsp-mode
;;     (setq global-flycheck-mode nil)))

;;Set up pyright
;; (use-package! lsp-pyright
;;     :when (modulep! :tools lsp)
;;     :hook (python-mode . (lambda ()
;;                             (require 'lsp-pyright)
;;                             (lsp-deferred))) ; or lsp!
;;     :init
;;     (setq lsp-pyright-multi-root nil) ; or `t`
;;    (setq lsp-pyright-python-executable-cmd "python3")) ; adjust if needed

;; Set up jedi lsp server
;; (use-package! lsp-jedi
;;   :when (modulep! :tools lsp)
;;   :init
;;   (setq lsp-jedi-server-command '("jedi-language-server"))
;;   :config
;;   (add-to-list 'lsp-disabled-clients 'pyright)
;;   (add-to-list 'lsp-disabled-clients 'mspyls))

;; Set default lsp-mode to nil
;; (setq lsp-auto-configure nil) ;; Stops the lsp from automatically configuring itself
(setq lsp-enable-on-startup nil)

;; Switch j and k keybinds
;; (after! evil
;;   (map! :n "j" 'evil-previous-visual-line
;;         :n "k" 'evil-next-visual-line
;;         :v "j" 'evil-previous-visual-line
;;         :v "k" 'evil-next-visual-line
;;         :m "j" 'evil-previous-visual-line
;;         :m "k" 'evil-next-visual-line))

;; Remove the title bar
;;(add-to-list 'default-frame-alist '(undecorated . t))
;; Remove scroll bar
(scroll-bar-mode -1)
