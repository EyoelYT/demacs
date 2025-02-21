;;; additnl.el -*- lexical-binding: t; -*-

;;; This file serves to save code, and to clean up config.el

;; Unmap annoying maps
;; (map! "C-_" nil)

;; Cuz some version mismatch
;; (straight-use-package 'org)

;; Consult is my new favorite package

;; (require 'uniquify)
;; (setq uniquify-buffer-name-style 'forward)

(setq
 ;; doom-theme 'doom-spacegrey
 ;; doom-theme 'kanagawa
 ;; doom-theme 'eyth-kanagawa
 ;; doom-theme 'doom-molokai
 ;; doom-theme 'doom-oceanic-next
 ;; doom-theme 'doom-tomorrow-night
 ;; doom-theme 'doom-monokai-spectrum
 doom-theme 'doom-old-hope
 ;; doom-theme 'doom-ir-black
 ;; doom-theme 'leuven-dark
 ;; doom-theme 'ef-bio
 ;; doom-theme 'ef-symbiosis

 ;; best terminal themes
 ;; 'doom-gruvbox
 ;; 'doom-material
 ;; 'ef-dark
 ;; 'doom-pine
 doom-font (font-spec
            ;; Fav fonts: ComicShanns, Jetbrains, Iosevka, SF Mono, Victor Mono, Iosevka Comfy Motion

            ;; :family "Iosevka Nerd Font"
            ;; :size 22
            ;; :weight 'regular

            ;; :family "Iosevka Comfy Motion Fixed" ; Optionally Add "Fixed" for no ligatures
            ;; :size 22
            ;; :weight 'regular

            ;; :family "ComicShannsMono Nerd Font"
            ;; :size 21

            ;; :family "Iosevka Nerd Font"
            ;; :size 26
            ;; :weight 'regular

            ;; :family "Iosevka Comfy Fixed"
            ;; :size 25
            ;; :weight 'regular

            ;; :family "Iosevka Nerd Font"
            ;; :size 30
            ;; :weight 'light

            :family "JetBrainsMono Nerd Font"
            :size 19
            :weight 'regular

            ;; :family "RobotoMono Nerd Font"
            ;; :size 20
            ;; :weight 'light

            ;; :family "SFMono Nerd Font Mono"
            ;; :size 23
            ;; ;; :weight 'bold
            ;; :weight 'semi-bold

            ;; :family "DeJaVu SansM Nerd Font Mono"
            ;; :size 20
            ;; :weight 'light

            ;; :family "VictorMono Nerd Font"
            ;; :size 22
            ;; :weight 'bold

            )

 doom-variable-pitch-font (font-spec
                           :family (font-get doom-font :family)
                           :size (font-get doom-font :size)
                           :weight (font-get doom-font :weight)
                           )


 ;;; non-monospace fonts, for variable-pitch-mode or mixed-pitch-mode (e.g. sans fonts)
 ;; doom-variable-pitch-font (font-spec :family "Montserrat" :size (font-get doom-font :size))
 ;; doom-variable-pitch-font (font-spec :family "Iosevka Comfy Motion Duo" :size 18)
 ;; doom-variable-pitch-font (font-spec :family "Iosevka Comfy Duo" :size 18)
 ;; doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
 ;; doom-variable-pitch-font (font-spec :family "ETBookOT" :size 13)
 ;; doom-variable-pitch-font (font-spec :family "Alegreya" :size 18)
 ;; doom-variable-pitch-font (font-spec :name "Alegreya Sans" :size 18)

 ;;; sans-serif font to use wherever the `fixed-pitch-serif' face is used
 doom-serif-font (font-spec
                  :family (font-get doom-variable-pitch-font :family)
                  :size (font-get doom-variable-pitch-font :size)
                  :weight (font-get doom-variable-pitch-font :weight)
                  )
 ;; doom-serif-font (font-spec :family "Noto Serif" :size 18)

 nerd-icons-font-names '(
                         "NFM.ttf"
                         ;; "Symbols Nerd Font Mono.ttf"
                         )
 )

;; (setq-default fringe-mode 1) ; Wrong (?)
(fringe-mode 0)
(set-fringe-mode 0) ; Is this needed??
;; (setq-default left-fringe-width 4)

;; (map! "DEL" #'evil-delete-backward-char-and-join)

;; Disable the evil-mode line indicator in the ex section
(setq evil-echo-state nil)
;; (setq evil-insert-state-message   nil
;;       evil-replace-state-message  nil
;;       evil-visual-state-message   nil
;;       evil-normal-state-message   nil
;;       evil-motion-state-message   nil
;;       evil-operator-state-message nil)

;; If you want "tabs" mode instead of "space": Use M-x indent-tabs-mode | doom/toggle-indent-style

;; Keep buffers in sync with files, execute after idle 5 secs
;; (global-auto-revert-mode 1)
;; (setq global-auto-revert-non-file-buffers t)

;; (stillness-mode 1)

;; Put all backup files into a separate place
(setq backup-by-copying t)
;; (setq backup-directory-alist `((".*" . "/home/eyu/.local/share/Trash/files")))
;; (setq auto-save-file-name-transforms `((".*" "/home/eyu/.local/share/Trash/files" t)))
;; (setq delete-by-moving-to-trash t)

(defun remove-from-list (list elements-to-remove)
  "Remove ELEMENTS-TO-REMOVE from LIST."
  (seq-filter (lambda (item)
                (not (member item elements-to-remove)))
              list))

;; (defun ey/remove-dired-omit-mode-from-hook ()
;;   (remove-hook 'dired-mode-hook #'dired-omit-mode))

;; Turn off spell checker globally when first loading doom
;; (remove-hook 'doom-first-buffer-hook #'spell-fu-global-mode) ;? Works or not? If not, remove line

;; Jinx Mode, if (package! jinx) in package.el
;; (add-hook 'emacs-startup-hook #'global-jinx-mode)
;; (setq ispell-program-name "aspell")
;; (setq ispell-dictionary "en_US")  ; Set the default dictionary

;;; Remove scroll bar
;; (scroll-bar-mode -1)
;; (menu-bar-mode -1)
;; (tool-bar-mode -1)

;; Keybindings for Corfu in Doom Emacs
;; (map!
;;  :map corfu-mode-map ; corfu active mode
;;  :i "C-SPC"   #'corfu-complete
;;  :i "RET" nil
;;  :i "TAB" nil
;;  :map corfu-map ; popup
;;  :i "RET"     #'corf
;;  :i "C-SPC"   #'corfu-complete
;;  :i "TAB"     #'corfu-next
;;  :i "M-SPC"   #'corfu-insert-separator
;;  )

(after! org
  (map! :map org-mode-map
        :i "<tab>" nil)
  )

;; (defadvice! prompt-for-buffer (&rest _)
;;   :after '(evil-window-split evil-window-vsplit)
;;   (+vertico/switch-workspace-buffer))

;; expand-region
;; (after! expand-region
;;   (map! :nvi "C-=" #'er/expand-region)
;;   (map! :nvi "C--" #'er/contract-region)
;;   (setq expand-region-smart-cursor nil
;;         expand-region-subword-enabled nil))

(map! :leader
      "`" #'+popup/toggle ; Global leader binding
      ;; :map vterm-mode-map
      ;; :neovim "`" #'+popup/toggle
      )



;;; (after! undo-tree
;;   (map!
;;    :map undo-tree-mode-map
;;    "C-_" nil
;;    "C-/" nil
;;    "<undo>" nil
;;    :map undo-tree-map
;;    "C-_" nil
;;    "C-/" nil
;;    "<undo>" nil
;;    ))

;; (undefine-key! undo-tree-map "C-_")
;; (undefine-key! undo-tree-mode-map "C-_")



;;; Org nice alignment insertion underneath
;; (after! org
;;   :hook org-mode-hook
;;   (map! :nvi "C-j" #'+org/insert-item-below))



;; (setq +tree-sitter-hl-enabled-modes nil) ; default: '(not web-mode typescript-tsx-mode)

;;; Add local tree-sitter for certain file extensions only
;; (add-hook 'python-mode-local-vars-hook #'tree-sitter! 'append)
;; (add-hook 'rustic-mode-local-vars-hook #'tree-sitter! 'append)
;; (add-hook 'sh-mode-local-vars-hook     #'tree-sitter! 'append)
;; (add-hook 'css-mode-local-vars-hook    #'tree-sitter! 'append)
;; (add-hook 'yaml-mode-local-vars-hook   #'tree-sitter! 'append)
;; (add-hook 'csharp-mode-local-vars-hook #'tree-sitter! 'append)
;; (add-hook 'java-mode-local-vars-hook   #'tree-sitter! 'append)
;; (add-hook 'lua-mode-local-vars-hook    #'tree-sitter! 'append)

;; (add-hook! 'fennel-mode-local-vars-hook 'tree-sitter! 'append)
;; (add-hook! '(c-mode-local-vars-hook c++-mode-local-vars-hook) :append #'tree-sitter!)

;; (add-hook! '(json-mode-local-vars-hook
;;              jsonc-mode-local-vars-hook)
;;            :append #'tree-sitter!)

;; (add-hook! '(js2-mode-local-vars-hook
;;              typescript-mode-local-vars-hook
;;              typescript-tsx-mode-local-vars-hook
;;              rjsx-mode-local-vars-hook)
;;            :append #'tree-sitter!)

;; (when (fboundp #'csharp-tree-sitter-mode)
;;   (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))



;; GARBAGE COLLECTION
;; (setq gc-cons-threshold (* 511 1024 1024))
;; (setq gc-cons-percentage 0.6)
;; (run-with-idle-timer 15 t #'garbage-collect)
;; (setq garbage-collection-messages nil)



(defun ey/visual-to-last-non-blank-in-current-line ()
  "Visual mode and extend selection to the last non-blank char in the current line."
  (interactive)
  (unless (region-active-p)
    (let ((evil-move-cursor-back nil))
      (evil-normal-state 1)))
  (evil-visual-char)
  ;; (evil-last-non-blank)
  ;; (evil-end-of-visual-line)
  (doom/forward-to-last-non-comment-or-eol)
  (if (looking-at "[ \t\n]")
      (evil-backward-char)))



;; (defun ey/visual-to-first-non-blank-in-current-line ()
;;   "Visual mode and extend selection to the 1st non-blank char in the current line."
;;   (interactive)
;;   (evil-visual-char)
;;         ;; (evil-first-non-blank)
;;         (doom/backward-to-bol-or-indent)
;;   )

(defun ey/visual-to-first-non-blank-in-current-line ()
  "Visual mode and extend selection to the first non-blank char in the current line."
  (interactive)
  (let ((visual-start (or (mark) (point)))  ; Get the current visual start (or point if not in visual mode)
        (current-point (point)))
    ;; Ensure we're in visual mode
    (unless (region-active-p)
      (let ((evil-move-cursor-back nil))
        (evil-normal-state 1))
      (evil-visual-char))
    ;; Move to the first non-blank character
    (doom/backward-to-bol-or-indent)
    ;; Recalculate the visual region
    ;; (let ((new-point (point)))
    ;;   (if (< new-point visual-start)
    ;;       (evil-visual-extend new-point visual-start) ; Ensure the region is properly recalculated
    ;;     (evil-visual-extend visual-start new-point)))
    ))



;; (defun my/expand-region-keep-cursor ()
;;   "Expand the region but keep the cursor (point) at its original position."
;;   (interactive)
;;   (let ((original-pos (point)))  ; Remember the original cursor position
;;     (call-interactively 'er/expand-region)  ; Expand the region
;;     (when (> original-pos (region-beginning))
;;       (goto-char original-pos))))  ; Restore the cursor position if needed



;; ; Schedule :EVERYDAY: tasks to the current day automatically
;; (defun my/org-schedule-everyday-tasks ()
;;   "Schedule all TODO entries tagged with EVERYDAY for today if not already
;;    scheduled."
;;   (interactive)
;;   (let ((org-agenda-files (org-agenda-files))
;;         (today (format-time-string "%Y-%m-%d")))
;;     (dolist (file org-agenda-files)
;;       (with-current-buffer (find-file-noselect file)
;;         (org-mode)  ; Ensure org-mode is active in the buffer
;;         (goto-char (point-min))
;;         (while (re-search-forward "^\\*+ \\(TODO\\|PROJ\\|NEXT\\|DONE\\|CANCELLED\\|HOLD\\|WAITING\\) .* :EVERYDAY:" nil t)
;;           (let ((scheduled (org-get-scheduled-time (point))))
;;             (when (or (not scheduled)
;;                       (not (equal (org-format-time-string "%Y-%m-%d" scheduled) today)))
;;               (org-schedule nil today))))))))

;; (defun my/schedule-everyday-tasks-daily ()
;;   "Add a daily hook to schedule EVERYDAY tasks."
;;   (run-at-time "00:01" (* 24 60 60) 'my/org-schedule-everyday-tasks))

;; (my/schedule-everyday-tasks-daily)



;; (doom-require 'bookmark+)

;; (use-package! bookmark+
;;   :demand t
;;   )
;; (load "/home/eyu/.config/emacs/.local/straight/repos/bookmark-plus/bookmark+-mac.el")
;; (require 'bookmark+-mac nil t)



;; ;; Set insert evil mode to box
;; (if (display-graphic-p)
;;     ;; (setq evil-insert-state-cursor '(box))
;;     (setq evil-insert-state-cursor '(hollow))
;;   (setq evil-insert-state-cursor '(hbar))
;;   )

;; (setq evil-insert-state-cursor '(box +evil-emacs-cursor-fn))
;; (setq evil-normal-state-cursor '(box))



;; (defun eyth/toggle-cursor-blink ()
;;   "Toggle cursor blinking based on the current Evil mode."
;;   (if (evil-insert-state-p)
;;       (blink-cursor-mode 1)  ; Enable blinking in insert mode
;;     (blink-cursor-mode -1))) ; Disable blinking in other modes

;; (add-hook 'evil-insert-state-entry-hook 'eyth/toggle-cursor-blink)
;; (add-hook 'evil-insert-state-exit-hook 'eyth/toggle-cursor-blink)



;;; Automatically close successful build window
;; (defun ar/compile-autoclose (buffer string)
;;   "Hide successful builds window with BUFFER and STRING."
;;   (if (string-match "finished" string)
;;       (progn
;;         (message "Build finished :)")
;;         (run-with-timer 3 nil
;;                         (lambda ()
;;                           (when-let* ((multi-window (> (count-windows) 1))
;;                                       (live (buffer-live-p buffer))
;;                                       (window (get-buffer-window buffer t)))
;;                             (delete-window window)))))
;;     (message "Compilation %s" string)))

;; (setq compilation-finish-functions (list #'ar/compile-autoclose))



;;; Change my focus both during compilation and after
;; (defun finish-focus-comp (&optional buf-or-proc arg2)
;;     (let* ((comp-buf (if (processp buf-or-proc)
;;                          (process-buffer buf-or-proc)
;;                        buf-or-proc))
;;            (window (get-buffer-window comp-buf)))
;;       (if window
;;           (select-window window)
;;         (switch-to-buffer-other-window comp-buf))))
;; (add-hook 'compilation-finish-functions 'finish-focus-comp)
;; (add-hook 'compilation-start-hook 'finish-focus-comp)



;; (setq fancy-splash-image "/mnt/c/Users/Eyu/Documents/1. Eyu's School Files/Meritpages certificates_files/WolakLLC.png")



;; ;; Open links in predefined browser; switching focus to the browser is problematic
;; (defun open-url-in-min-browser (url &rest _args)
;;   (let ((min-browser-path "/mnt/c/Users/Eyu/AppData/Local/min/min.exe"))
;;     (start-process "xdg-open" nil "xdg-open" url)
;;     ))
;;     ;; (start-process "min-browser" nil min-browser-path url)
;;     ;; (make-process :name "min-browser" :command (list min-browser-path " " url) :noquery t)



;; Quick Google searches
;; (defun google-search (query)
;;   "Search Google for the QUERY."
;;   (interactive "sGoogle search: ")
;;   (browse-url (concat "https://www.google.com/search?q=" (url-hexify-string query))))

;; (global-set-key (kbd "C-q") #'google-search)

;; default google search
;; (defun google-search (query)
;;   "Search Google for the QUERY. Use selected text as the default input if available."
;;   (interactive
;;    (let ((selected-text (when (use-region-p)
;;                           (buffer-substring-no-properties (region-beginning) (region-end)))))
;;      (list (read-string "Google search: " selected-text))))
;;   (browse-url (concat "https://www.google.com/search?q=" (url-hexify-string query)))
;;   )



;; USE THESE WHEN WSL CLIPBOARD IS NOT WORKING, they are kinda slow
;; (defun wsl-paste ()
;;   "Paste text from Windows clipboard using PowerShell."
;;   (let ((coding-system-for-read 'dos))
;;     (string-trim
;;      (shell-command-to-string "powershell.exe Get-Clipboard"))))

;; (defun wsl-copy (text &optional push)
;;   "Copy TEXT to Windows clipboard using PowerShell."
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "clip.exe" "*Messages*" "clip.exe")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'wsl-copy)
;; (setq interprogram-paste-function 'wsl-paste)



;; TTY mode
(when (not (display-graphic-p))
  ;;   (blink-cursor-mode 0)
  ;;   (after! evil
  ;;     (map! :map evil-insert-state-map
  ;;           "C-@" #'corfu-first
  ;;           :map evil-replace-state-map
  ;;           "C-@" #'corfu-first
  ;;           ))
  ;; (add-hook 'diff-hl-mode-on-hook ; Add version control diff-hl in tty mode
  ;;           (lambda()
  ;;             (unless (display-graphic-p)
  ;;               (diff-hl-margin-local-mode)))
  ;;           )
  )

;; (diff-hl-margin-local-mode 0)

;;; Remove automatic diff-hl mode
;; (remove-hook! vc-dir-mode-hook #'turn-on-diff-hl-mode)
;; (remove-hook! 'doom-first-file-hook #'global-diff-hl-mode)



;; (desktop-save-mode 1) ; Enable desktop saving state here
;; (setq desktop-restore-eager 1
;;       desktop-restore-forces-onscreen 'all
;;       desktop-restore-frames t)
;; (setq desktop-restore-eager 10) ; Number of buffers to restore immediately
;; (setq desktop-save 'if-exists) ; Save desktop without asking if it already exists



;; (set-window-buffer nil (current-buffer))

;; (defun ey/find-file-under-selection ()
;;   "Open `find-file` with the current selection (if any) as the default filename."
;;   (interactive)
;;   (let ((selection (if (use-region-p)
;;                        (buffer-substring-no-properties (region-beginning) (region-end))
;;                      nil)))
;;     (find-file-other-window (read-file-name "Find file: " selection))))



;; ;; Keycast mode
;; (defun turn-on-keycast ()
;;   (interactive)
;;   (add-to-list 'global-mode-string '("" mode-line-keycast " ")))
;;
;; (defun turn-off-keycast ()
;;   (interactive)
;;   (setq global-mode-string (delete '("" mode-line-keycast " ") global-mode-string)))
;;
;; (after! keycast
;;   (define-minor-mode keycast-mode
;;     "Show current command and its key binding in the mode line."
;;     :global t
;;     (if keycast-mode
;;         (add-hook 'pre-command-hook 'keycast--update t)
;;       (remove-hook 'pre-command-hook 'keycast--update))))



;; (map!
;;  :map global-map
;;  :nv "C-i" #'better-jumper-jump-forward
;;  :map c-mode-base-map
;;  :nv "C-i" #'better-jumper-jump-forward
;;  )



;; (defadvice! doom--load-theme-a (fn theme &optional no-confirm no-enable)
;;   "Record `doom-theme', disable old themes, and trigger `doom-load-theme-hook'."
;;   :around #'load-theme
;;   ;; Run `load-theme' from an estranged buffer, where we can ensure that
;;   ;; buffer-local face remaps (by `mixed-pitch-mode', for instance) won't
;;   ;; interfere with recalculating faces in new themes.
;;   (with-temp-buffer
;;     (let ((last-themes (copy-sequence custom-enabled-themes)))
;;       ;; Disable previous themes so there are no conflicts. If you truly want
;;       ;; multiple themes enabled, then use `enable-theme' instead.
;;       (mapc #'disable-theme custom-enabled-themes)
;;       (prog1 (funcall fn theme no-confirm no-enable)
;;         (when (and (not no-enable) (custom-theme-enabled-p theme))
;;           (setq doom-theme theme)
;;           (put 'doom-theme 'previous-themes (or last-themes 'none))
;;           ;; DEPRECATED Hook into `enable-theme-functions' when we target 29
;;           (doom-run-hooks 'doom-load-theme-hook)
;;           ;; Fix incorrect fg/bg in new frames created after the initial frame
;;           ;; (which are reroneously displayed as black).
;;           (pcase-dolist (`(,param ,fn ,face)
;;                          '((foreground-color face-foreground default)
;;                            (background-color face-background default)
;;                            (cursor-color face-background cursor)
;;                            (border-color face-background border)
;;                            (mouse-color face-background mouse)))
;;             (when-let* ((color (funcall fn face nil t))
;;                         ((stringp color))
;;                         ((not (string-prefix-p "unspecified-" color))))
;;               (setf (alist-get param default-frame-alist) color))))))))

;; (defun consult-theme (theme)
;;   "Disable current themes and enable THEME from `consult-themes'.
;; The command supports previewing the currently selected theme."
;;   (interactive
;;    (list
;;     (let* ((regexp (consult--regexp-filter
;;                     (mapcar (lambda (x) (if (stringp x) x (format "\\`%s\\'" x)))
;;                             consult-themes)))
;;            (avail-themes (seq-filter
;;                           (lambda (x) (string-match-p regexp (symbol-name x)))
;;                           (cons 'default (custom-available-themes))))
;;            (saved-theme (car custom-enabled-themes)))
;;       (consult--read
;;        (mapcar #'symbol-name avail-themes)
;;        :prompt "Theme: "
;;        :require-match t
;;        :category 'theme
;;        :history 'consult--theme-history
;;        :lookup (lambda (selected &rest _)
;;                  (setq selected (and selected (intern-soft selected)))
;;                  (or (and selected (car (memq selected avail-themes)))
;;                      saved-theme))
;;        :state (lambda (action theme)
;;                 (pcase action
;;                   ('return (consult-theme (or theme saved-theme)))
;;                   ((and 'preview (guard theme)) (consult-theme theme))))
;;        :default (symbol-name (or saved-theme 'default))))))
;;   (when (eq theme 'default) (setq theme nil))
;;   (unless (eq theme (car custom-enabled-themes))
;;     (mapc #'disable-theme custom-enabled-themes)
;;     (when theme
;;       (if (custom-theme-p theme)
;;           (enable-theme theme)
;;         (load-theme theme :no-confirm))))
;;   (setq doom-theme theme))



;; (set-face-attribute 'org-block nil :foreground (face-attribute 'default :foreground))
;; (set-face-attribute 'cursor nil :background 'unspecified :foreground 'unspecified) ;; PROBLEM: already loaded themes do not change the color of the cursor -> it gets stuck from the previously loaded theme cursor color
;; (set-face-attribute 'cursor nil :background nil :foreground nil)



(defun ey/reload-theme (&optional _theme)
  "Reload the current Emacs theme."
  (interactive)
  (unless doom-theme
    (user-error "No theme is active"))
  (let ((themes (copy-sequence custom-enabled-themes)))
    (mapc #'disable-theme custom-enabled-themes)
    (let (doom-load-theme-hook)
      (mapc #'enable-theme (reverse themes)))
    (doom-run-hooks 'doom-load-theme-hook)
    (doom/reload-font)
    (message "%s %s"
             (propertize
              (format "Reloaded %d theme%s:"
                      (length themes)
                      (if (cdr themes) "s" ""))
              'face 'bold)
             (mapconcat #'prin1-to-string themes ", "))))

;; (advice-remove 'consult-theme
;;             (lambda (&rest args)
;;               (message "Consult-theme called with args: %s" args)
;;               (ey/reload-theme)))
;;
;; (advice-remove 'load-theme
;;             (lambda (&rest args)
;;               ;; (message "Consult-theme called with args: %s" args)
;;               (ey/reload-theme)))



;; ?? The `margin' mode function seems to be the one that incites the hook to have the immediate diff-hl changes seen
;; (advice-add 'diff-hl-mode :after #'diff-hl-margin-mode) ; !!, causes a lot of problems
;; (advice-remove 'diff-hl-mode #'diff-hl-margin-mode)



;(use-package! modus-themes
;  :config
;  ;; Add all your customizations prior to loading the themes
;  (setq modus-themes-italic-constructs nil
;        modus-themes-bold-constructs nil))



(defun ey/save-my-open-org-agenda-files ()
  "Save all open and modified org agenda files"
  (interactive)
  ;; gather modified files from `org-agenda-files'
  (let ((buffers-to-save nil))
    (dolist (file org-agenda-files)
      (when-let ((buffer (get-file-buffer file)))
        (when (buffer-modified-p buffer)
          (push buffer buffers-to-save))))
    (when buffers-to-save
      ;; save only the buffers that we target to save
      (save-some-buffers t (lambda () (memq (current-buffer) buffers-to-save))))))



;; (map! :map minibuffer-local-shell-command-map
;;       :i "C-@" #'completion-at-point
;;       )



;; (defhydra hydra-adjust-window-size (evil-window-map "C-w")
;;   "window size"
;;   ("+" #'evil-window-increase-width  "+width ")
;;   ("_" #'evil-window-decrease-width  "-width ")
;;   ("=" #'evil-window-increase-height "+height")
;;   ("-" #'evil-window-decrease-height "-height")
;;   (")" #'balance-windows             "balance" )
;;   (")" #'minimi-windows             "balance" ))

;; (defhydra hydra-scroll (evil-motion-state-map "z") ; overrides insert state? probably bc it initially was in the globalmap
;;   "scroll around"
;;   ("<left> " #'evil-scroll-left      "+width ")
;;   ("<right>" #'evil-scroll-right     "-width ")
;;   ("<up>   " #'evil-scroll-line-up   "+height")
;;   ("<down> " #'evil-scroll-line-down "-height"))



;;; (use-package! embrace
;;   :defer t
;;   :bind (("C-," . embrace-commander)))



;; (defun my-variable-watcher-debug (&rest args) (message "Watcher: %S" args) (debug))
;; (add-variable-watcher 'company-backends 'my-variable-watcher-debug)
;; (remove-variable-watcher 'company-backends 'my-variable-watcher-debug)



;; This command: make -f /home/eyu/.config/emacs/.local/straight/repos/pdf-tools/Makefile -C /home/eyu/.config/emacs/.local/straight/repos/pdf-tools/ server/epdfinfo
;; The binary should be in: "/home/eyu/.config/emacs/.local/straight/build-29.4/pdf-tools/epdfinfo"

;; Ok I kinda figured out to how to do it but it's a little hacky
(defun ey/build-epdfinfo ()
  "Build the PDF Tools epdfinfo binary using make, displaying
 output in the terminal."
  (let* ((repo-dir (expand-file-name "~/.config/emacs/.local/straight/repos/pdf-tools/"))
         (build-dir (expand-file-name "~/.config/emacs/.local/straight/build-29.4/pdf-tools/"))
         (binary-path (concat build-dir "epdfinfo"))
         (makefile (concat repo-dir "Makefile"))
         (default-directory repo-dir)
         (make-command (format "make -f %s -C %s server/epdfinfo" makefile repo-dir)))
    (if (file-exists-p binary-path)
        (print! (item "epdfinfo binary already exists. Skipping build."))
      (progn
        (print! (start "Building PDF Tools epdfinfo binary..."))
        (unless (file-exists-p build-dir)
          (make-directory build-dir t))
        (let ((result (call-process-shell-command make-command nil nil t)))
          (if (zerop result)
              (progn
                (print! (success "PDF Tools epdfinfo binary built successfully."))
                (if (file-exists-p (concat repo-dir "server/epdfinfo"))
                    (copy-file (concat repo-dir "server/epdfinfo") binary-path t)
                  (print! (error "Build succeeded, but epdfinfo binary not found in server/"))))
            (print! (error "Failed to build PDF Tools epdfinfo binary. Check the terminal output."))))))))

;; I haven't tested it thoroughly but it seems to work
;; I don't know how to make the `call-process-shell-command' print to stdout, only managed to output to buffer
;; Change the build dir when changing emacs versions, or modify the fucntion to accommodate the change dynamically
;; Make sure to change the build directory when changing emacs versions



;; (defun org-schedule (arg &optional time)
;;   "Insert a \"SCHEDULED:\" string with a timestamp to schedule an item.
;;
;; When called interactively, this command pops up the Emacs calendar to let
;; the user select a date.
;;
;; With one universal prefix argument, remove any scheduling date from the item.
;; With two universal prefix arguments, prompt for a delay cookie.
;; With argument TIME, scheduled at the corresponding date.  TIME can
;; either be an Org date like \"2011-07-24\" or a delta like \"+2d\"."
;;   (interactive "P")
;;   (if (and (org-region-active-p) org-loop-over-headlines-in-active-region)
;;       (org-map-entries
;;        (lambda () (org--deadline-or-schedule arg 'scheduled time))
;;        nil
;;        (if (eq org-loop-over-headlines-in-active-region 'start-level)
;;            'region-start-level
;;          'region)
;;        (lambda () (when (org-invisible-p) (org-end-of-subtree nil t))))
;;     (org--deadline-or-schedule arg 'scheduled time)))


;; (defun org-timestamp (arg &optional inactive)
;;   "Prompt for a date/time and insert a time stamp.
;;
;; If the user specifies a time like HH:MM or if this command is
;; called with at least one prefix argument, the time stamp contains
;; the date and the time.  Otherwise, only the date is included.
;;
;; All parts of a date not specified by the user are filled in from
;; the timestamp at point, if any, or the current date/time
;; otherwise.
;;
;; If there is already a timestamp at the cursor, it is replaced.
;;
;; With two universal prefix arguments, insert an active timestamp
;; with the current time without prompting the user.
;;
;; When called from Lisp, the timestamp is inactive if INACTIVE is
;; non-nil."
;;   (interactive "P")
;;   (let* ((ts (cond
;;               ((org-at-date-range-p t)
;;                (match-string (if (< (point) (- (match-beginning 2) 2)) 1 2)))
;;               ((org-at-timestamp-p 'lax) (match-string 0))))
;;          ;; Default time is either the timestamp at point or today.
;;          ;; When entering a range, only the range start is considered.
;;          (default-time (and ts (org-time-string-to-time ts)))
;;          (default-input (and ts (org-get-compact-tod ts)))
;;          (repeater (and ts
;;                         (string-match "\\([.+-]+[0-9]+[hdwmy] ?\\)+" ts)
;;                         (match-string 0 ts)))
;;          org-time-was-given
;;          org-end-time-was-given
;;          (time
;;           (if (equal arg '(16)) (current-time)
;;             ;; Preserve `this-command' and `last-command'.
;;             (let ((this-command this-command)
;;                   (last-command last-command))
;;               (org-read-date
;;                arg 'totime nil nil default-time default-input
;;                inactive)))))
;;     (cond
;;      ((and ts
;;            (memq last-command '( org-time-stamp org-time-stamp-inactive
;;                                  org-timestamp org-timestamp-inactive))
;;            (memq this-command '( org-time-stamp org-time-stamp-inactive
;;                                  org-timestamp org-timestamp-inactive)))
;;       (insert "--")
;;       (org-insert-timestamp time (or org-time-was-given arg) inactive))
;;      (ts
;;       ;; Make sure we're on a timestamp.  When in the middle of a date
;;       ;; range, move arbitrarily to range end.
;;       (unless (org-at-timestamp-p 'lax)
;;         (skip-chars-forward "-")
;;         (org-at-timestamp-p 'lax))
;;       (replace-match "")
;;       (setq org-last-changed-timestamp
;;             (org-insert-timestamp
;;              time (or org-time-was-given arg)
;;              inactive nil nil (list org-end-time-was-given)))
;;       (when repeater
;;         (backward-char)
;;         (insert " " repeater)
;;         (setq org-last-changed-timestamp
;;               (concat (substring org-last-inserted-timestamp 0 -1)
;;                       " " repeater ">")))
;;       (message "Timestamp updated"))
;;      ((equal arg '(16)) (org-insert-timestamp time t inactive))
;;      (t (org-insert-timestamp
;;          time (or org-time-was-given arg) inactive nil nil
;;          (list org-end-time-was-given))))))


;; (defun org-insert-timestamp-below-heading (arg &optional inactive)
;;   "Insert a timestamp below the closest heading or at point if no heading is found.
;;
;; - If the current point is within a heading, or there is a heading above:
;;   - If a `SCHEDULED` or `CLOSED` entry is found just below the heading,
;;     insert the timestamp one line below that entry.
;;   - Otherwise, insert the timestamp directly below the heading.
;;
;; - If no heading is found, insert the timestamp at the current point.
;;
;; With one prefix argument ARG, include time in the timestamp.
;; With two prefix arguments ARG, insert the current time as an active timestamp without prompting.
;;
;; When called from Lisp, the timestamp is inactive if INACTIVE is non-nil."
;;   (interactive "P")
;;   (let ((heading-pos nil)
;;         (scheduled-or-closed-pos nil))
;;     ;; Locate the current or nearest heading.
;;     (save-excursion
;;       (cond
;;        ((org-at-heading-p)
;;         (setq heading-pos (point)))
;;        ((org-previous-visible-heading 1)
;;         (setq heading-pos (point)))))
;;     ;; Check for `SCHEDULED` or `CLOSED` entry below the heading, if found.
;;     (when heading-pos
;;       (save-excursion
;;         (goto-char heading-pos)
;;         (forward-line)
;;         (while (and (not (eobp)) (looking-at-p "^\\s-*\\(?:SCHEDULED\\|CLOSED\\):"))
;;           (setq scheduled-or-closed-pos (point))
;;           (forward-line))))
;;     ;; Insert the timestamp at the appropriate location.
;;     (if heading-pos
;;         (progn
;;           (goto-char (or scheduled-or-closed-pos heading-pos))
;;           (forward-line)
;;           (org-timestamp arg inactive))
;;       ;; If no heading is found, insert timestamp at point.
;;       (org-timestamp arg inactive))))

;; (defun ey/custom-newline-and-indent ()

;;   "Insert a newline and indent based on the current context.
;;
;; This function provides context-aware indentation for structured code, such as
;; Python. Its behavior is as follows:
;;
;; 1. Immediate newline condition:
;;    - If the current line is not entirely whitespace AND the cursor is not at
;;      the end of the line, insert a newline at the cursor position. Then align
;;      the cursor vertically with the first non-whitespace character of the
;;      previous line. Stop the process here.
;;
;; 2. Context-aware indentation:
;;    - If the current line ends with a colon (`:`), it adds an additional level
;;      of indentation (equal to `tab-width') after the newline.
;;    - If there is no colon at the end of the line:
;;      - If the line contains non-blank characters, match its indentation level.
;;      - If the line is blank, the new line matches its whitespace level.
;;
;; I would say this function is ideal for languages with block-based syntax
;; (e.g., Python) or other structured indentation rules.
;;
;; Caveats of this function:
;;     - Does not clear trailing whitespaces; Not a problem if using packages
;;       like `ws-butler'
;;     - Does not continue comments, hyphens or other symbols in newlines
;;     - Does not play well with a whiespace-filled line that ends with a colon
;;     - Does not fully support indenting from symbols [{()}]
;;     - Does not support ARG number of newlines"
;;   (interactive)
;;   (or
;;    ;; Immediate newline condition
;;    (let ((current-line (buffer-substring-no-properties
;;                         (line-beginning-position)
;;                         (line-end-position))))
;;      (if (and (not (string-match-p "^[ \t]*$" current-line))
;;               (< (current-column) (length current-line)))
;;          (progn
;;            (newline)
;;            (indent-to (save-excursion
;;                         (forward-line -1)
;;                         (back-to-indentation)
;;                         ;; (beginning-of-line) ; this instead of
;;                                         ; `back-to-indentation' if we want
;;                                         ; staight vertical \n's for some reason
;;
;;                         (current-column)))
;;            t)
;;        nil))
;;    ;; Context aware indentation
;;    (let* ((col-pos (current-column))
;;           (indent-by-whitespace (save-excursion
;;                                   (beginning-of-line)
;;                                   (if (looking-at-p "^[ \t]*$")
;;                                       (move-to-column col-pos)
;;                                     (back-to-indentation)
;;                                     (current-column))))
;;           ;; extra indent if the current line ends with `:'
;;           (extra-indent (if (save-excursion
;;                               (end-of-line)
;;                               (looking-back ":\\s-*" nil))
;;                             4 ; or `tab-width' here
;;                           0)))
;;      (end-of-line)
;;      (newline)
;;      (indent-to (+ indent-by-whitespace extra-indent)))))
;;
;; ;; (setq-default tab-width 4)
;; ;; (define-key global-map (kbd "RET") 'ey/custom-newline-and-indent)
;; (define-key global-map (kbd "RET") 'newline-and-indent)



;;; Try to execute the `doom/reload' *compilation* buffer in 'evil-normal-state'
;;; evil mode

;; What somehow worked so far is inserting the `evil-normal-state' function in
;; both the macro and function

;; (defmacro doom--if-compile (command on-success &optional on-failure)
;;   (declare (indent 2))
;;   `(let ((doom-bin "doom")
;;          (default-directory doom-emacs-dir)
;;          (exec-path (cons doom-bin-dir exec-path)))
;;      (when (and (featurep :system 'windows)
;;                 (string-match-p "cmdproxy.exe$" shell-file-name))
;;        (unless (executable-find "pwsh")
;;          (user-error "Powershell 3.0+ is required, but pwsh.exe was not found in your $PATH"))
;;        (setq doom-bin "doom.ps1"))
;;      ;; Ensure the bin/doom operates with the same environment as this
;;      ;; running session.
;;      (letenv! (("PATH" (string-join exec-path path-separator))
;;                ("EMACS" (doom-path invocation-directory invocation-name))
;;                ("EMACSDIR" doom-emacs-dir)
;;                ("DOOMDIR" doom-user-dir)
;;                ("DOOMLOCALDIR" doom-local-dir)
;;                ("DEBUG" (if doom-debug-mode (number-to-string doom-log-level) "")))
;;        (with-current-buffer
;;            (compile (format ,command (expand-file-name doom-bin doom-bin-dir)) t)
;;            (evil-normal-state)
;;          (let ((w (get-buffer-window (current-buffer))))
;;            (select-window w)
;;            (add-hook
;;             'compilation-finish-functions
;;             (lambda (_buf status)
;;               (if (equal status "finished\n")
;;                   (progn
;;                     (delete-window w)
;;                     ,on-success)
;;                 ,on-failure))
;;             nil 'local))))))

;; (defun doom/reload ()
;;   "Reloads your private config.
;;
;; WARNING: This command is experimental! If you haven't configured your config to
;; be idempotent, then this could cause compounding slowness or errors.
;;
;; This is experimental! It will try to do as `bin/doom sync' does, but from within
;; this Emacs session. i.e. it reloads autoloads files (if necessary), reloads your
;; package list, and lastly, reloads your private config.el.
;;
;; Runs `doom-after-reload-hook' afterwards."
;;   (interactive)
;;   (mapc #'require (cdr doom-incremental-packages))
;;   (doom--if-compile doom-reload-command
;;       (with-doom-context 'reload
;;         (doom-run-hooks 'doom-before-reload-hook)
;;         (with-demoted-errors "PRIVATE CONFIG ERROR: %s"
;;           (general-auto-unbind-keys)
;;           (unwind-protect
;;               (startup--load-user-init-file nil)
;;             (general-auto-unbind-keys t)))
;;         (doom-run-hooks 'doom-after-reload-hook)
;;         ;; Switch compilation buffer to normal mode
;;         (let ((compilation-buffer (get-buffer "*compilation*")))
;;           (when compilation-buffer
;;             (with-current-buffer compilation-buffer
;;               (evil-normal-state))))
;;         (message "Config successfully reloaded!"))
;;     (user-error "Failed to reload your config")))



(defun ey/org-agenda-goto-subtree ()
  "Go to the heading in org-agenda and narrow to the subtree."
  (interactive)
  (org-agenda-goto)
  (org-narrow-to-subtree))



;; consult-imenu--select
;; consult-imenu--items

;; (autoload 'consult-imenu--select
;;   "~/.config/emacs/.local/straight/repos/consult/consult-imenu.el"
;;   "Autoload consult-imenu--select from consult-imenu.el." nil)

;; (autoload 'consult-imenu--items
;;   "~/.config/emacs/.local/straight/repos/consult/consult-imenu.el"
;;   "Autoload consult-imenu--items from consult-imenu.el." nil)

;; (setq consult-imenu-config nil)

;; (defun consult-imenu ()
;;   "Select item from flattened `imenu' using `completing-read' with preview.
;;
;; The command supports preview and narrowing.  See the variable
;; `consult-imenu-config', which configures the narrowing.
;; The symbol at point is added to the future history.
;;
;; See also `consult-imenu-multi'."
;;   (interactive)
;;   (consult-imenu--select
;;    "Go to item: "
;;    ;; sort the list of imenu ITEMS by the line numbers in their markers
;;    (sort
;;     (consult--slow-operation "Building Imenu..."
;;       (consult-imenu--items))
;;     (lambda (a b)
;;       (< (marker-position (cdr a))
;;          (marker-position (cdr b)))))))



;; (defmacro setup-positional-consult-imenu (file-path)
;;   "Set up autoloads and define the `consult-imenu` function from FILE-PATH."
;;   `(progn
;;      ;; Autoload consult-imenu--select
;;      (autoload 'consult-imenu--select
;;        ,file-path
;;        "Autoload consult-imenu--select from consult-imenu.el." nil)
;;
;;      ;; Autoload consult-imenu--items
;;      (autoload 'consult-imenu--items
;;        ,file-path
;;        "Autoload consult-imenu--items from consult-imenu.el." nil)
;;
;;      ;; Define consult-imenu function
;;      (setq consult-imenu-config nil)
;;      (defun consult-imenu ()
;;        "Select item from flattened `imenu' using `completing-read' with preview.

;; The command supports preview and narrowing.  See the variable
;; `consult-imenu-config', which configures the narrowing.
;; The symbol at point is added to the future history.
;;
;; See also `consult-imenu-multi'."
;;        (interactive)
;;        (consult-imenu--select
;;         "Go to item: "
;;         ;; Sort the list of imenu ITEMS by the line numbers in their markers
;;         (sort
;;          (consult--slow-operation "Building Imenu..."
;;            (consult-imenu--items))
;;          (lambda (a b)
;;            (< (marker-position (cdr a))
;;               (marker-position (cdr b)))))))))

;; (setup-positional-consult-imenu "~/.config/emacs/.local/straight/repos/consult/consult-imenu.el")



;; (defvar ey/original-consult-imenu-config
;;   '((emacs-lisp-mode
;;      :toplevel "Functions"
;;      :types ((102 "Functions" font-lock-function-name-face)
;;              (109 "Macros" font-lock-function-name-face)
;;              (112 "Packages" font-lock-constant-face)
;;              (116 "Types" font-lock-type-face)
;;              (118 "Variables" font-lock-variable-name-face))))
;;   "Original value of `consult-imenu-config`.")

;; (defvar ey/custom-consult-imenu-enabled nil
;;   "Indicates whether the custom `consult-imenu` is enabled.")

;; (autoload 'consult-imenu--select
;;   "~/.config/emacs/.local/straight/repos/consult/consult-imenu.el"
;;   "Autoload consult-imenu--select from consult-imenu.el." nil)

;; (autoload 'consult-imenu--items
;;   "~/.config/emacs/.local/straight/repos/consult/consult-imenu.el"
;;   "Autoload consult-imenu--items from consult-imenu.el." nil)

;; (defun ey/toggle-consult-imenu ()
;;   "Toggle between the original and a custom-positional `consult-imenu` function setups."
;;   (interactive)
;;   (if ey/custom-consult-imenu-enabled
;;       (progn
;;         ;; Revert to the original setup
;;         (setq consult-imenu-config ey/original-consult-imenu-config)
;;         (defun consult-imenu ()
;;           "Select item from flattened `imenu' using `completing-read' with preview.
;;
;; The command supports preview and narrowing.  See the variable
;; `consult-imenu-config', which configures the narrowing.
;; The symbol at point is added to the future history.
;;
;; See also `consult-imenu-multi'."
;;           (interactive)
;;           (consult-imenu--select
;;            "Go to item: "
;;            (consult--slow-operation "Building Imenu..."
;;              (consult-imenu--items))))
;;         (setq ey/custom-consult-imenu-enabled nil)
;;         (message "Reverted to original `consult-imenu` setup."))
;;     (progn
;;       ;; Enable the custom setup
;;       (setq consult-imenu-config nil)
;;       (defun consult-imenu ()
;;         "Select item from flattened `imenu' using `completing-read' with preview.
;;
;; The command supports preview and narrowing.  See the variable
;; `consult-imenu-config', which configures the narrowing.
;; The symbol at point is added to the future history.
;;
;; See also `consult-imenu-multi'."
;;         (interactive)
;;         (consult-imenu--select
;;          "Go to item: "
;;          ;; Sort the list of imenu ITEMS by the line numbers in their markers
;;          (sort
;;           (consult--slow-operation "Building Imenu..."
;;             (consult-imenu--items))
;;           (lambda (a b)
;;             (< (marker-position (cdr a))
;;                (marker-position (cdr b)))))))
;;       (setq ey/custom-consult-imenu-enabled t)
;;       (message "Enabled custom `consult-imenu` setup."))))



;; (map! :leader
;;       :prefix ("d" . "multiple cursors")
;;       :desc "Toggle cursor here" "SPC" #'+multiple-cursors/evil-mc-toggle-cursor-here
;;       :desc "Toggle cursor here" "d" #'+multiple-cursors/evil-mc-toggle-cursor-here
;;       :desc "Toggle cursor above" "<up>" (lambda () (interactive) (evil-mc-make-cursor-here) (evil-previous-line))
;;       :desc "Toggle cursor below" "<down>" (lambda () (interactive) (evil-mc-make-cursor-here) (evil-next-line))
;;       :desc "Toggle cursor left" "<left>" (lambda () (interactive) (evil-mc-make-cursor-here) (evil-backward-char))
;;       :desc "Toggle cursor right" "<right>" (lambda () (interactive) (evil-mc-make-cursor-here) (evil-forward-char)))

;; (map! "<M-left>" #'+multiple-cursors/evil-mc-toggle-cursor-here
;;       "<M-up>"
;;       (lambda () (interactive) (+multiple-cursors/evil-mc-toggle-cursor-here) (evil-previous-visual-line) )
;;       "<M-down>"
;;       (lambda () (interactive) (+multiple-cursors/evil-mc-toggle-cursor-here) (evil-next-visual-line))
;;       "<M-right>" #'+multiple-cursors/evil-mc-toggle-cursor-here)



(defun hs-cycle (&optional level)
  (interactive "p")
  (let (message-log-max
        (inhibit-message t))
    (if (= level 1)
        (pcase last-command
          ('hs-cycle
           (hs-hide-level 1)
           (setq this-command 'hs-cycle-children))
          ('hs-cycle-children
           ;; TODO: Fix this case. `hs-show-block' needs to be
           ;; called twice to open all folds of the parent
           ;; block.
           (save-excursion (hs-show-block))
           (hs-show-block)
           (setq this-command 'hs-cycle-subtree))
          ('hs-cycle-subtree
           (hs-hide-block))
          (_
           (if (not (hs-already-hidden-p))
               (hs-hide-block)
             (hs-hide-level 1)
             (setq this-command 'hs-cycle-children))))
      (hs-hide-level level)
      (setq this-command 'hs-hide-level))))

(defun hs-global-cycle ()
    (interactive)
    (pcase last-command
      ('hs-global-cycle
       (save-excursion (hs-show-all))
       (setq this-command 'hs-global-show))
      (_ (hs-hide-all))))

;; (defun hs-global-cycle-by-level ()



;; ;; Loop over all the symbols and get all hooks
;; (loop for sym being the symbols
;;       when (and (boundp sym) (string-suffix-p "-hook" (symbol-name sym)))
;;       collect (concat (symbol-name sym) ",\n"))



;; (defun ey/log-the-major-mode-hooks (hook &rest _args)
;;   "Log when a HOOK runs."
;;   (message "Running hook: %s" hook))

;; ;; (advice-add 'run-hooks :before #'ey/log-the-major-mode-hooks)
;; ;; (advice-remove 'run-hooks #'ey/log-the-major-mode-hooks)



;; (defun denz/comfort-mode-enable ()
;;   "Enable comfort mode settings."
;;   (blink-cursor-mode 1)  ; Enable blinking cursor
;;   (setq cursor-type 'bar)  ; Set cursor type to bar; doesn't seem to work cz of my evil mode??
;;   (setq line-spacing 2)  ; Set line spacing
;;
;;   ;; Enable org-modern-mode only for Org buffers
;;   (when (eq major-mode 'org-mode)
;;     (org-modern-mode 1)
;;     (let* ((variable-tuple
;;             (cond ((x-list-fonts "Lucida Sans") '(:font "Lucida Sans"))))
;;            (headline `(:weight bold)))
;;       (custom-theme-set-faces
;;        'user
;;        `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;        `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.125))))
;;        `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
;;        `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
;;        `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))))))

;; (defun denz/comfort-mode-disable ()
;;   "Disable comfort mode settings."
;;   (blink-cursor-mode -1)  ; Disable blinking cursor
;;   (setq cursor-type 'box)  ; Reset cursor type to box
;;   (setq line-spacing nil)  ; Reset line spacing
;;
;;   ;; Disable org-modern-mode only for Org buffers
;;   (when (eq major-mode 'org-mode)
;;     (org-modern-mode -1)
;;     ;; Reset org-level styles to default, not sure here
;;     (custom-theme-set-faces
;;      'user
;;      `(org-level-8 ((t (:inherit default))))
;;      `(org-level-7 ((t (:inherit default))))
;;      `(org-level-6 ((t (:inherit default))))
;;      `(org-level-5 ((t (:inherit default))))
;;      `(org-level-4 ((t (:inherit default))))
;;      `(org-level-3 ((t (:inherit default))))
;;      `(org-level-2 ((t (:inherit default))))
;;      `(org-level-1 ((t (:inherit default))))
;;
;; better way to reset?
;;      `(org-level-8 ((t (nil))))
;;      `(org-level-7 ((t (nil))))
;;      `(org-level-6 ((t (nil))))
;;      `(org-level-5 ((t (nil))))
;;      `(org-level-4 ((t (nil))))
;;      `(org-level-3 ((t (nil))))
;;      `(org-level-2 ((t (nil))))
;;      `(org-level-1 ((t (nil))))
;;
;;       )))

;; Add to hooks
;; (add-hook 'writeroom-mode-enable-hook #'denz/comfort-mode-enable)
;; (add-hook 'writeroom-mode-disable-hook #'denz/comfort-mode-disable)



;;; Make evil-insert-state to be emacs-state
;; (defalias 'evil-insert-state 'evil-emacs-state)
;; (define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
;; (setq evil-default-state 'insert)
;; (remove-hook 'magit-status-mode-hook 'evil-insert-state)
;; (remove-hook 'Custom-mode-hook 'evil-insert-state)



;;; Testing NANO
;; (after! doom-themes
;;   (consult-theme 'doom-nano-dark))

;; (add-to-list 'load-path "/home/eyu/.config/doom/custom-code/doom-nano-testing")
;; (require 'load-nano)



;; (defun ey/company-files-capf ()
;;   "A wrapper to use `company-files` with `completion-at-point-functions`."
;;   (let ((bounds (bounds-of-thing-at-point 'filename)))
;;     (when bounds
;;       (list (car bounds) (cdr bounds)
;;             (completion-table-dynamic
;;              (lambda (_)
;;                (all-completions
;;                 (buffer-substring-no-properties (car bounds) (cdr bounds))
;;                 (completion-table-dynamic
;;                  (lambda (prefix)
;;                    (let ((company-prefix prefix))
;;                      (company-files 'candidates prefix)))))))))))

;; (defun ey/add-company-files-to-capf ()
;;   "Add `ey/company-files-capf` to `completion-at-point-functions`."
;;   (add-hook 'completion-at-point-functions #'ey/company-files-capf nil t))

;; ;; Add this hook to the major modes where you want file completions
;; (add-hook 'prog-mode-hook #'ey/add-company-files-to-capf)
;; (add-hook 'text-mode-hook #'ey/add-company-files-to-capf)


;; (set-company-backend! 'prog-mode '(company-capf company-files company-yasnippet))

;; (set-company-backend! 'nxml-mode '(company-nxml company-yasnippet))



;; List to keep track of running commands
(defvar ey/eshell-running-commands nil
  "A list of currently running commands in Eshell with their buffer names.")

(defun ey/eshell-kill-command (command)
  "Kill the Eshell process running COMMAND, if any, and remove it from the list."
  (let ((entry (assoc command ey/eshell-running-commands)))
    (when entry
      (let ((buffer (cdr entry)))
        (when (buffer-live-p buffer)
          (with-current-buffer buffer
            (let ((process (get-buffer-process buffer)))
              (when process
                (kill-process process)
                (message "Killed process: %s" command)))))
        ;; Remove the command from the list
        (setq ey/eshell-running-commands
              (assq-delete-all command ey/eshell-running-commands))))))

(defun ey/eshell-build-and-run (command)
  "Run a build and run COMMAND in Eshell.
If the process is already running, terminate it and restart."
  (interactive "sCommand to build & run: ")
  ;; Kill the process if it's already running
  (ey/eshell-kill-command command)
  ;; Get or create the buffer for the command
  (let ((buffer (ey/eshell-get-or-create-buffer command)))
    ;; Bring the buffer to view
    (switch-to-buffer buffer)
    ;; Start the command
    (eshell-return-to-prompt)
    (insert command)
    (eshell-send-input)
    (message "Started process: %s in buffer %s" command (buffer-name buffer))))

(defun ey/eshell-get-or-create-buffer (command)
  "Return the Eshell buffer for COMMAND, creating a new one if necessary."
  (let ((entry (assoc command ey/eshell-running-commands)))
    (if (and entry (buffer-live-p (cdr entry)))
        ;; If a buffer exists for the command, return it
        (cdr entry)
      ;; Else create a new Eshell buffer and associate it with the command
      (let ((new-buffer (eshell)))
        (add-to-list 'ey/eshell-running-commands (cons command new-buffer))
        new-buffer))))



;; If buffer is available, get buffer. If not, create new buffer.
(defun ey/eshell-run (COMMAND)
  "Run COMMAND in Eshell. If the process is already
 running,terminate and restart it."
  (interactive "sCommand to run:")
  (let ((buffer (ey/eshell-get-buffer-of-command COMMAND))) ; Get the eshell buffer name (return string) based on "COMMAND" from `ey/eshell-running-commands'
    (if (bufferp buffer)
        (progn
          (switch-to-buffer buffer)
          ;; (ey/eshell-kill-command COMMAND) ; Kill current running command in the buffer and run "COMMAND"
          (eshell-kill-process)
          (eshell-return-to-prompt)
          (insert COMMAND)
          (eshell-send-input)
          (message "Restarted process: %s in buffer %s" COMMAND (buffer-name buffer)))
      (ey/eshell-create-buffer COMMAND) ; Create an eshell buffer, and add buffer name to the list `ey/eshell-running-commands', switch to the buffer
      (insert COMMAND)
      (eshell-send-input)
      (message "Started process: %s in an eshell-buffer" COMMAND)
      )))

(defun ey/eshell-get-buffer-of-command (COMMAND)
  "Return the eshell buffer that is currently running COMMAND, from the alist
`ey/eshell-running-commands'"
  (let ((command--buffer (assoc COMMAND ey/eshell-running-commands)))
    (if (and command--buffer (buffer-live-p (cdr command--buffer)))
        (cdr command--buffer) ; Return the buffer (type=string)
      nil)
  ))

(defun ey/eshell-create-buffer (COMMAND &optional BACKGROUND)
  "Create a new eshell buffer, and add COMMAND - Eshell Buffer Name into
`ey/eshell-running-commands' alist.
If BACKGROUND is any other value, do it in the background, without switching
to the buffer.
If BACKGROUND is 0, or negative, do a switch to the buffer.
"
  (let ((new-eshell-buffer (eshell)))
    (add-to-list 'ey/eshell-running-commands (cons COMMAND new-eshell-buffer))
    (if (> (prefix-numeric-value BACKGROUND) 0)
        nil
      new-eshell-buffer)))

;; add `ey/eshell-remove-buffer-from-list' function to `eshell-exit-hook'
(defun ey/eshell-remove-buffer-from-list ()
  "Remove the current Eshell buffer from `ey/eshell-running-commands'."
  (let ((buffer (current-buffer)))
    (setq ey/eshell-running-commands
          ;; Remove the killed buffer from the alist
          (cl-remove-if
           (lambda (entry)
             (eq buffer (cdr entry)))
           ey/eshell-running-commands))))



;; (require 'proof-site (expand-file-name "straight/PG/generic/proof-site" doom-local-dir))
;; (setq pg-init--pg-root "/home/eyu/.config/emacs/.local/straight/repos/PG/")

;; (use-package! proof-general
;;   :init
;;   (setq proof-splash-enable nil)
;;   (setq proof-next-command-insert-space nil)
;;   (setq proof-electric-terminator-enable nil)
;;   (setq coq-one-command-per-line nil)
;;   (setq proof-three-window-mode-policy 'hybrid)
;;   )

(defun proof-goto-point (&optional raw)
  "Assert or retract to the command at current position.
Calls `proof-assert-until-point' or `proof-retract-until-point' as
appropriate.
With prefix argument RAW, the activation of the omit proofs feature
(`proof-omit-proofs-option') is temporarily toggled,
so we can chose whether to check all proofs in the asserted region,
or to merely assume them and save time."
  (interactive "P")
  (let ((proof-omit-proofs-option proof-omit-proofs-option))
    (when raw
      (setq proof-omit-proofs-option (not proof-omit-proofs-option)))
    (save-excursion
      (if (> (proof-queue-or-locked-end) (point))
          (proof-retract-until-point)
        (if (proof-only-whitespace-to-locked-region-p)
            (progn
              (skip-chars-forward " \t\n")
              (forward-char 1)))
        (proof-assert-until-point)))))



;;; Custom face for a regex
(defface custom-latex-quest-face
  '((t :foreground "blue" :weight bold))
  "Face for highlighting \\quest{} in LaTeX."
  :group 'custom-faces)

(font-lock-add-keywords
 'plain-TeX-mode
 '(("\\\\quest" . 'custom-latex-quest-face)))



;; (after! tex
;;  (TeX-add-style-hook
;;   "cleveref"
;;   (lambda ()
;;     (TeX-add-symbols
;;       '("nameref" TeX-arg-cleveref-multiple-labels)))
;;   TeX-dialect))



;; (after! reftex
;;   (add-to-list 'reftex-ref-style-alist
;;                '("Hyperref"
;;                  "hyperref"
;;                  (("\\nameref" ?n))))
;;   (setq reftex-ref-style-default-list '("Hyperref" "Default")))



;; (font-lock-add-keywords
;;    'org-mode
;;    '(("^\\*+ \\(DONE\\) \\(.*\\)"
;;       (1 'org-done prepend)
;;       (2 '(:foreground "forest green" :strike-through t) prepend))
;;      ("^\\*+ \\(KILL\\) \\(.*\\)"
;;       (1 '(:foreground "dark red" :weight bold) prepend)
;;       (2 '(:foreground "dark blue" :strike-through t) prepend))))
;;
;; (font-lock-remove-keywords
;;    'org-mode
;;    '(("^\\*+ \\(DONE\\) \\(.*\\)"
;;       (1 'org-done prepend)
;;       (2 '(:foreground "forest green" :strike-through t) prepend))
;;      ("^\\*+ \\(CANCELLED\\) \\(.*\\)"
;;       (1 '(:foreground "dark red" :weight bold) prepend)
;;       (2 '(:foreground "dark gray" :strike-through t) prepend))))



;; (set-company-backend! 'python-mode '(company-capf company-files company-yasnippet))



;; Move by whitespace
;; Two defuns that move cursor position

;; In the forward direction:
;; when `ey/right-symbol' function is invoked:
;; - if next char to the cursor is a space char (of a whitespace), jump the space, then land just to the left of a non-space char.
;; - if next char to the cursor is a non-space char, use native `right-word' function
;; when `ey/left-symbol' function is invoked:
;; - if prev char to the cursor is a space char (of a whitespace), jump the space (or the sequence of spaces), then land just to the right of a non-space char.
;; - if prev char to the cursor is a non-space char, use native `left-word' function

;; (defun ey/right-symbol ()
;;   "Move forward by whitespace or to the next non-whitespace symbol."
;;   (interactive)
;;   (if (looking-at "[ \t\n]")
;;       (if (eq (current-column) 0)
;;           (progn
;;             (forward-char -1)
;;             (end-of-line))
;;         (skip-chars-forward " \t")
;;         )
;;     (evil-forward-word-begin)
;;     ;; (if (evil-insert-state-p)
;;     ;;     (forward-char))
;;     ))
;;
;; (defun ey/left-symbol ()
;;   "Move backward by whitespace or to the previous non-whitespace symbol."
;;   (interactive)
;;   (if (looking-back "[ \t\n]")
;;       (if (eq (current-column) 0)
;;           (progn
;;             (forward-char -1)
;;             (end-of-line))
;;         (skip-chars-backward " \t")
;;         )
;;     (evil-backward-word-begin)))

;; (map! "C-<right>" #'ey/right-symbol)
;; (map! "C-<left>" #'ey/left-symbol)
;;
;; (map! "C-<right>" #'right-word)
;; (map! "C-<left>" #'left-word)

;; (setq evil-cjk-emacs-word-boundary nil)



;; (map! (:leader :desc "Hydra resize" :n "w SPC" #'doom-window-resize-hydra/body))



(defun ok-org-fill-buffer-excluding-code-blocks ()
  "Fill the buffer, excluding code blocks."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let (start end)
      (setq start (point))
      (while (re-search-forward "#\\+BEGIN_SRC" nil t)
        (goto-char (bol))
        (setq end (1- (point)))
        (evil-visual-select start end)
        (org-fill-paragraph nil t)
        (when (re-search-forward "#\\+END_SRC" nil t)
          (setq start (1+ (point)))))
      (evil-visual-select start (point-max))
      (org-fill-paragraph nil t))))



;; FIXME: doesn't work
;; define a hydra to simplify window resizing
(defhydra doom-window-resize-hydra/body (:hint nil)
  " _k_ increase height
_h_ decrease width
_l_ increase width
_j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)

  ("q" nil))

(map! :leader :desc "Hydra resize" "w SPC" (cmd!! #'doom-window-resize-hydra/body))



;;; Doom-Nord Theme setup took from: https://github.com/elken/doom/blob/master/config.org#theme
;; (custom-theme-set-faces! 'doom-nord
;;   `(tree-sitter-hl-face:constructor :foreground ,(doom-color 'blue))
;;   `(tree-sitter-hl-face:number :foreground ,(doom-color 'orange))
;;   `(tree-sitter-hl-face:attribute :foreground ,(doom-color 'magenta) :weight bold)
;;   `(tree-sitter-hl-face:variable :foreground ,(doom-color 'base7) :weight bold)
;;   `(tree-sitter-hl-face:variable.builtin :foreground ,(doom-color 'red))
;;   `(tree-sitter-hl-face:constant.builtin :foreground ,(doom-color 'magenta) :weight bold)
;;   `(tree-sitter-hl-face:constant :foreground ,(doom-color 'blue) :weight bold)
;;   `(tree-sitter-hl-face:function.macro :foreground ,(doom-color 'teal))
;;   `(tree-sitter-hl-face:label :foreground ,(doom-color 'magenta))
;;   `(tree-sitter-hl-face:operator :foreground ,(doom-color 'blue))
;;   `(tree-sitter-hl-face:variable.parameter :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:punctuation.delimiter :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:punctuation.bracket :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:punctuation.special :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:type :foreground ,(doom-color 'yellow))
;;   `(tree-sitter-hl-face:type.builtin :foreground ,(doom-color 'blue))
;;   `(tree-sitter-hl-face:tag :foreground ,(doom-color 'base7))
;;   `(tree-sitter-hl-face:string :foreground ,(doom-color 'green))
;;   `(tree-sitter-hl-face:comment :foreground ,(doom-color 'base6))
;;   `(tree-sitter-hl-face:function :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:method :foreground ,(doom-color 'blue))
;;   `(tree-sitter-hl-face:function.builtin :foreground ,(doom-color 'cyan))
;;   `(tree-sitter-hl-face:property :foreground ,(doom-color 'blue))
;;   `(tree-sitter-hl-face:keyword :foreground ,(doom-color 'magenta))
;;   `(corfu-default :font "Iosevka Nerd Font Mono" :background ,(doom-color 'bg-alt) :foreground ,(doom-color 'fg))
;;   `(adoc-title-0-face :foreground ,(doom-color 'blue) :height 1.2)
;;   `(adoc-title-1-face :foreground ,(doom-color 'magenta) :height 1.1)
;;   `(adoc-title-2-face :foreground ,(doom-color 'violet) :height 1.05)
;;   `(adoc-title-3-face :foreground ,(doom-lighten (doom-color 'blue) 0.25) :height 1.0)
;;   `(adoc-title-4-face :foreground ,(doom-lighten (doom-color 'magenta) 0.25) :height 1.1)
;;   `(adoc-verbatim-face :background nil)
;;   `(adoc-list-face :background nil)
;;   `(adoc-internal-reference-face :foreground ,(face-attribute 'font-lock-comment-face :foreground)))

;;;  Org prettiness, from the same source from above
;; (setq org-superstar-headline-bullets-list '("› "))
;; (setq org-superstar-item-bullet-alist '((?* . ?⋆)
;;                                         (?+ . ?‣)
;;                                         (?- . ?•)))

;;(after! org
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "INPROG(i)" "PROJ(p)" "STORY(s)" "WAIT(w@/!)" "|" "DONE(d@/!)" "KILL(k@/!)")
;;         (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))
;;       ;; The triggers break down to the following rules:
;;
;;       ;; - Moving a task to =KILLED= adds a =killed= tag
;;       ;; - Moving a task to =WAIT= adds a =waiting= tag
;;       ;; - Moving a task to a done state removes =WAIT= and =HOLD= tags
;;       ;; - Moving a task to =TODO= removes all tags
;;       ;; - Moving a task to =NEXT= removes all tags
;;       ;; - Moving a task to =DONE= removes all tags
;;       org-todo-state-tags-triggers
;;       '(("KILL" ("killed" . t))
;;         ("HOLD" ("hold" . t))
;;         ("WAIT" ("waiting" . t))
;;         (done ("waiting") ("hold"))
;;         ("TODO" ("waiting") ("cancelled") ("hold"))
;;         ("NEXT" ("waiting") ("cancelled") ("hold"))
;;         ("DONE" ("waiting") ("cancelled") ("hold")))
;;
;;       ;; This settings allows to fixup the state of a todo item without
;;       ;; triggering notes or log.
;;       org-treat-S-cursor-todo-selection-as-state-change nil))



;;; Defer loading of font (great for portability)
;; (defun my-font-available-p (font-name)
;;   (find-font (font-spec :name font-name)))
;;
;; (cond
;;  ((my-font-available-p "Iosevka Nerd Font")
;;   (setq doom-font (font-spec :family "Iosevka Nerd Font" :size 20)
;;         doom-big-font (font-spec :family "Iosevka Nerd Font" :size 36)
;;         )))



(setq-default left-margin-width 1
              right-margin-width nil)
(set-window-buffer (selected-window) (get-buffer "config.el"))
(window-margins (selected-window))
