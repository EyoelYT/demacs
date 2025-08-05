;;; $DOOMDIR/defaults.el -*- lexical-binding: t; -*-



(setq user-full-name "Eyoel Tesfu")
(setq user-mail-address "EyoelYTesfu@gmail.com")

(after! package
  (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/")))

;;; Better defaults
(setq bookmark-default-file (concat doom-user-dir "bookmarks"))
(setq bookmark-fringe-mark nil)
(setq history-delete-duplicates t)
(setq bookmark-save-flag 1)
(setq make-pointer-invisible t)
(setq line-spacing nil)
(setq read-process-output-max (* 1024 1024)) ; 1mb
(setq display-line-numbers-type nil)
(setq display-time-day-and-date t)
(setq garbage-collection-messages nil)
(setq echo-keystrokes 0)
(setq-default display-line-numbers-width 4)  ; min default width
(setq display-line-numbers-width-start nil)  ; automatically calculate the `display-line-numbers-width' on buffer start
                                        ; width (empty space) grows to the left of the numbers
(setq split-width-threshold 160)
(setq-default cursor-in-non-selected-windows nil)
(setq-default left-margin-width 1)
(setq-default right-margin-width 0)
(setq-default fringes-outside-margins t)
(setq insert-default-directory t)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))
(setq comment-empty-lines t)
(setq-default truncate-lines t)

(setq load-prefer-newer t)
(setq xref-search-program 'ripgrep)
(setq scroll-conservatively 0)
(setq scroll-step 0)
(setq scroll-preserve-screen-position 'always)
(setq scroll-margin 0)
(setq jit-lock-defer-time nil) ; don't defer fontification
(setq trash-directory nil) ; necessary for trashing to be compliant with freedesktop.org specification
(setq delete-by-moving-to-trash (not noninteractive))

(setq pop-up-frames nil)
(setq pop-up-windows t)

(setq duplicate-line-final-position 1)
(setq duplicate-region-final-position 0)
(setq auto-save-visited-interval 10)
(setq auto-save-default nil)
(setq doom-leader-alt-key-states '(normal visual motion insert emacs)) ; want to use M-SPC everywhere
(setq tab-first-completion nil)
(setq dabbrev-case-replace nil)
(setq blink-cursor-blinks 10 ; my default -1
      blink-cursor-delay 0.5 ; my default 0.2
      blink-cursor-interval 0.5) ; my default 0.7
(setq rainbow-delimiters-max-face-count 4)

;; (setq eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i --simple-prompt")
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

;; Set Clipboards
(setq save-interprogram-paste-before-kill t
      ;; interprogram-cut-function #'gui-select-text
      ;; interprogram-paste-function #'gui-sele
      select-active-regions nil
      select-enable-clipboard t
      select-enable-primary nil)

(add-to-list 'auto-mode-alist '("\\.jai\\'" . jai-mode))
(add-to-list 'auto-mode-alist '("\\.xaml\\'" . nxml-mode))

;; (defun shut-up--advice (fn &rest args)
;;   (let ((inhibit-message t)
;;         (message-log-max))
;;     (apply fn args)))
;; (advice-add #'repeat-mode :around #'shut-up--advice)

;; (display-time-mode 1)
;; (global-hide-mode-line-mode 1)
;; (tab-jump-out-global-mode 1)
(global-subword-mode 1)
(global-display-line-numbers-mode -1)
(repeat-mode 1)
(blink-cursor-mode 1)
(global-eldoc-mode -1)
(auto-save-visited-mode 1)

;;; FONTS
(setq doom-theme 'tangonov
      doom-font (font-spec
                 :family (if (getenv "WSLENV")
                             "FantasqueSansM Nerd Font"
                           "Iosevka Nerd Font")
                 :size (if (getenv "WSLENV") 22 14)
                 :weight 'regular)

      doom-variable-pitch-font (font-spec
                                :family (font-get doom-font :family)
                                :size (font-get doom-font :size)
                                :weight (font-get doom-font :weight))

      ;; sans-serif font to use wherever the `fixed-pitch-serif' face is used
      doom-serif-font (font-spec
                       :family (font-get doom-variable-pitch-font :family)
                       :size (font-get doom-variable-pitch-font :size)
                       :weight (font-get doom-variable-pitch-font :weight))

      nerd-icons-font-names '("NFM.ttf")) ; "Symbols Nerd Font Mono.ttf"

(setq global-text-scale-adjust--increment-factor 1 ; default = 5
      doom-font-increment 1
      text-scale-mode-step 1.04) ; try `global-text-scale-adjust--default-height'??

;;; FRAME DEFAULTS
(defun ey/add-stuff-to-default-buffer-alist ()
  "Add values to `default-frame-alist'"
  (if (getenv "WSLENV")
      (progn
        (add-to-list 'default-frame-alist `(width . (text-pixels . 2300))) ; 2145
        (if (string-match-p (regexp-quote "LUCID") system-configuration-features)
            (add-to-list 'default-frame-alist `(height . (text-pixels . 1480)))
          (add-to-list 'default-frame-alist `(height . (text-pixels . 1490))))
        (add-to-list 'default-frame-alist '(top . 15))
        (add-to-list 'default-frame-alist '(left . 15))
        (add-to-list 'default-frame-alist '(internal-border-width . 20))
        (add-to-list 'default-frame-alist '(undecorated . t))
        (add-to-list 'default-frame-alist '(tool-bar-lines . 0))
        (add-to-list 'default-frame-alist '(alpha . 90)))
    (add-to-list 'default-frame-alist '(undecorated . t))
    (add-to-list 'default-frame-alist '(alpha . 90))))

(ey/add-stuff-to-default-buffer-alist)

;; Read and translate Terminal Sequences
(defun ey/set-input-decoder-mappings ()
  "Set my bindings for Emacs in Terminal"
  ;; (define-key input-decode-map "SPC-`"     (kbd "C-`"  ))
  (define-key input-decode-map "\e[105;5u" (kbd "<C-i>"))
  (define-key input-decode-map "\e[105;6u" (kbd "C-S-a"))
  (define-key input-decode-map "\e[100;6u" (kbd "C-S-d"))
  (define-key input-decode-map "\e[73;6u"  (kbd "C-S-i"))
  (define-key input-decode-map "\e[96;5u"  (kbd "C-`"  ))
  (define-key input-decode-map "\e[8;5u"   (kbd "C-<backspace>"))
  (define-key input-decode-map "\e[130;5u" (kbd "C-<return>"))
  (define-key input-decode-map "\e[131;5u" (kbd "C-S-<return>"))
  (define-key input-decode-map "\e[132;5u" (kbd "C-'"))
  (define-key input-decode-map "\e[133;5u" (kbd "C-;"))
  (define-key input-decode-map "\e[134;5u" (kbd "C-S-e"))
  (define-key input-decode-map "\e[135;5u" (kbd "C-M-<return>"))
  (define-key input-decode-map "\e[136;5u" (kbd "<tab>"))
  (define-key input-decode-map "\e[137;5u" (kbd "<return>")) ; not working??
  (define-key input-decode-map "\e[138;5u" (kbd "<backspace>"))
  (define-key input-decode-map "\e[139;5u" (kbd "C-S-<backspace>"))
  (define-key input-decode-map "\e[140;5u" (kbd "C-SPC"))
  (define-key input-decode-map "\e[141;5u" (kbd "C-."))
  (define-key input-decode-map "\e[142;5u" (kbd "S-<return>")))

(if (daemonp)
    (progn
      (add-hook 'after-make-frame-functions #'ey/set-input-decoder-mappings)
      ;;       (add-hook 'before-make-frame-hook #'ey/add-stuff-to-default-buffer-alist)
      )
  (ey/set-input-decoder-mappings)
  ;;   (ey/add-stuff-to-default-buffer-alist)
  )



;;; Override/Custom FACES
(custom-set-faces!
  '(tree-sitter-hl-face:variable :inherit default) ; Variable Initialization Faces
  '(separator-line :background unspecified) ; TODO: kanagawa doesn't react to this
  '(org-done :foreground "#5B6268" :strike-through unspecified)
  '(org-agenda-done :foreground "#5B6268" :strike-through unspecified)
  '(org-headline-done :foreground "#5B6268" :strike-through unspecified)
  '(+org-todo-onhold :foreground "#E0D063" :inherit org-todo)
  '(+org-todo-active :foreground "#FB6268" :inherit org-todo)
  '(+org-todo-cancel :inherit (error org-todo))
  '(+org-todo-project :inherit org-todo)
  ;; '(fringe nil) ; fg: #484854 :bg #1a1b26 :inherit default
  '(italic :slant normal) ; Disable italics (when inherited)
  ;; '(italic nil) ; Enable italics (when inherited)
  '(bold :weight normal) ; Disable bold (when inherited)
  ;; '(bold nil) ; Enable bold (when inherited)
  ;; BLEND THE DOOM MODELINE BAR WITH THE BACKGROUND
  `(doom-modeline-bar
    :foreground ,(face-attribute 'mode-line :background nil nil)
    :background ,(face-attribute 'mode-line :background nil nil))
  `(doom-modeline-bar-inactive
    :foreground ,(face-attribute 'mode-line-inactive :background nil nil)
    :background ,(face-attribute 'mode-line-inactive :background nil nil))
  '(mode-line-active :inherit (mode-line)) ; turn off the wierd box when in sp-padding mode
  '(mode-line-inactive :inherit (mode-line)) ; turn off the wierd box when in sp-padding mode
  ;; '(hl-line :background unspecified)
  '(diff-added :extent nil)
  '(blamer-face :foreground "#7a88cf" :slant unspecified)
  ;; '(font-lock-variable-name-face :foreground nil :inherit default)
  ;; '(font-lock-variable-name-face nil)
  `(header-line
    :background ,(face-attribute 'mode-line :background nil nil)
    :overline   ,(face-attribute 'mode-line :overline nil nil)
    :foreground ,(face-attribute 'mode-line :foreground nil nil)
    :box        ,(face-attribute 'mode-line :box nil nil)))

;;; Global HOOKS!
;; Turn off highlighting the whole line the cursor is at
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(add-hook 'doom-first-file-hook #'ey/workspace-behavior-advices)
(add-hook 'doom-first-file-hook #'ey/disable-which-key)
(add-hook 'doom-first-file-hook #'ey/toggle-mark-all-buffers-as-real)
(add-hook! 'doom-first-file-hook
  (defun ey/disable-global-flycheck-mode ()
    (global-flycheck-mode -1)))

;;; Rainbow delimiters mode (colored brackets) and Highlighted numbers
(add-hook! '(prog-mode-hook conf-mode-hook) #'rainbow-delimiters-mode)
(add-hook! '(prog-mode-hook conf-mode-hook) #'highlight-numbers-mode)

;;; Turn off automatic spell checker
(remove-hook 'text-mode-hook #'spell-fu-mode)
(remove-hook 'text-mode-hook 'visual-line-mode) ; still has `+word-wrap-mode' in there

(remove-hook! '(org-mode-hook
                markdown-mode-hook
                TeX-mode-hook
                rst-mode-hook
                mu4e-compose-mode-hook
                message-mode-hook
                git-commit-mode-hook) #'flyspell-mode)

;;; Remove opening automatic tide server when opening rjsx/tsx/web-mode files
(remove-hook! '(typescript-mode-local-vars-hook
                typescript-tsx-mode-local-vars-hook
                web-mode-local-vars-hook
                rjsx-mode-local-vars-hook)
  '+javascript-init-lsp-or-tide-maybe-h) ; initialize tide-mode using
                                        ; `tide-setup'/`ey/start-tide-mode-interactively'

;; C/C++ Lsp; I want to manually invoke the lsp if I want to
(remove-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

(remove-hook 'c-mode-local-vars-hook #'lsp!)
(remove-hook 'c++-mode-local-vars-hook #'lsp!)
(remove-hook 'objc-mode-local-vars-hook #'lsp!)
(remove-hook 'cmake-mode-local-vars-hook #'lsp!)
(remove-hook 'cuda-mode-local-vars-hook #'lsp!)

;; Remove automatic anaconda mode initiation `anaconda-mode'
(remove-hook 'python-mode-local-vars-hook '+python-init-anaconda-mode-maybe-h)

;; hs-minor mode
(add-hook! prog-mode-hook #'hs-minor-mode)

;; (add-hook! 'org-load-hook :append ;; REVIEW: this was fixed??
;;   (defun +org-fix-keybindings ()
;;     (map! :map org-mode-map
;;           :ie [tab] nil))) + (yas-minor-mode +1)

;; Add anaconda-mode-completion whenever `anaconda-mode' is active
(after! anaconda-mode (add-hook 'anaconda-mode-hook #'ey/add-anaconda-completion-to-local-capfs))

;;; Remove `solaire-mode' because I am currently using spacious padding mode
(remove-hook 'doom-load-theme-hook 'solaire-global-mode)
(advice-remove 'load-theme #'solaire-mode--prepare-for-theme-a)
(if (modulep! :ui popup) (remove-hook '+popup-buffer-mode-hook 'turn-on-solaire-mode))

(add-hook 'org-mode-hook #'ey/turn-on-gptel-mode-in-special-dir--h)
(add-hook 'markdown-mode-hook #'ey/turn-on-gptel-mode-in-special-dir--h)


;;; ADVICES!

;; Fixes Bug where `doom-theme' doesn't get updated after interactively changing themes
(advice-add 'consult-theme :after #'ey/set-doom-theme)
(advice-add 'consult-theme :after #'ey/set-custom-faces)
;; (advice-add 'consult-theme :after #'ey/reload-theme) ; Was trying
;; (advice-remove 'consult-theme #'ey/reload-theme)

;; Make `+default/yank-pop'/`consult-yank-pop' work in vterm
(advice-add '+default/yank-pop :around #'vterm-consult-yank-pop-action)

;; Make `mark-sexp' enter evil-visual-state
(advice-add 'mark-sexp :after #'ey/evil-do-normal-state-w/o-cursor-jumpback)
                                        ; TODO: add/PR `evil-want-modal-mark-sexp'
                                        ; variable into official evil repo?

(advice-add 'ey/window-search :after #'ey/evil-do-normal-state-w/o-cursor-jumpback)

;; On using `consult-line', set copy-mode to on -> search thing -> set copy-mode
;; off with no cursor movement
(defadvice! +vterm-incite-copy-mode--a (fn &rest args)
  :around #'+default/search-buffer
  (if (or (equal major-mode 'vterm-mode)
          (derived-mode-p 'vterm-mode))
      (progn (vterm-copy-mode 1)
             (apply fn args)
             (cl-letf (((symbol-function 'vterm-reset-cursor-point) #'ignore))
               (vterm-copy-mode -1)))
    (apply fn args)))

;; (advice-remove '+default/search-buffer #'+vterm-incite-copy-mode--a)

;; (advice-add 'helpful-variable :around #'+vterm-incite-copy-mode--a) ; These not working!!
;; (advice-remove 'helpful-variable #'+vterm-incite-copy-mode--a)
;; (advice-add 'describe-variable :around #'+vterm-incite-copy-mode--a)
;; (advice-remove 'describe-variable #'+vterm-incite-copy-mode--a)

(advice-add #'+default/search-buffer :around #'doom-set-jump-a)
