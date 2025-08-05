;;; $DOOMDIR/functions.el -*- lexical-binding: t; -*-



(defun ey/evil-do-insert-state--advice (&rest _)
  (if (not (evil-insert-state-p))
      (evil-insert-state)))

(defun doom/delete-forward-word (arg)
  "Like `kill-word', but doesn't affect the kill-ring."
  (interactive "p")
  (let ((kill-ring nil) (kill-ring-yank-pointer nil))
    (ignore-errors (kill-word arg))))

(advice-add 'doom/delete-forward-word :after #'ey/evil-do-insert-state--advice)
(advice-add 'doom/delete-backward-word :after #'ey/evil-do-insert-state--advice)
(advice-add 'evil-delete-backward-char-and-join :before #'ey/evil-do-insert-state--advice)

;; (defun presorted-completion-table (completions)
;;   (lambda (string pred action)
;;     (if (eq action 'metadata)
;;         `(metadata (display-sort-function . ,#'identity))
;;       (complete-with-action action completions string pred))))

(after! persp-mode
  (defun +workspace/swap-this-and-other (other-persp)
  "Swap the current workspace with the Nth workspace. OTHER-PERSP could be
a string containing a number, like \"5\", or \"[1] main \", or could be
just a number, like 1"
  (interactive
   (let* ((persps (+workspace-list-names))
          (curr-name (+workspace-current-name))
          (curr-index (cl-position curr-name persps :test #'equal))
          (curr-pos (1+ curr-index)))
     (list (completing-read
            (concat
             "Swap workspace "
             (propertize (format " [%s] %s " curr-pos curr-name)
                         'face
                         '+workspace-tab-selected-face)
             " with: ")
            (lambda (string pred action)
              (if (eq action 'metadata)
                  `(metadata (display-sort-function . ,#'identity))
                (complete-with-action
                 action
                 (remove (format "[%s] %s" curr-pos curr-name)
                         (cl-loop for persp in persps
                                  for i to (length persps)
                                  collect (format "[%d] %s" (1+ i) persp)))
                 string pred)))
            nil t))))
  (let* ((other-pos (cond ((integerp other-persp) other-persp)
                          ((string-match "\\[\\([0-9]+\\)\\]" other-persp)
                           (string-to-number (match-string 1 other-persp)))
                          ((string-match "\\([0-9]+\\)" other-persp)
                           (string-to-number (match-string 1 other-persp)))
                          (t (user-error "Entry must resemble a number"))))
         (other-index (- other-pos 1))
         (persps (+workspace-list-names))
         (curr-name (+workspace-current-name))
         (curr-index (cl-position curr-name persps :test #'equal))
         (other-name (elt persps other-index))
         (others (remove curr-name persps))
         (same-persp (eq curr-index other-index))
         (out-of-bounds (or (< other-index 0) (> other-index (- (length persps) 1))))
         (swapping-left-to-right (< curr-index other-index)))
    (cond (same-persp (user-error "Can't swap with same workspace"))
          ((not others) (user-error "Only one workspace"))
          (out-of-bounds (user-error "Workspace [%s] doesn't exist" other-pos)))
    (let ((persps-cache
           (if swapping-left-to-right
               (append (cl-subseq persps 0 curr-index)
                       (list other-name)
                       (cl-subseq persps (+ curr-index 1) other-index)
                       (list curr-name)
                       (cl-subseq persps (+ other-index 1)))
             (append (cl-subseq persps 0 other-index)
                     (list curr-name)
                     (cl-subseq persps (+ other-index 1) curr-index)
                     (list other-name)
                     (cl-subseq persps (+ curr-index 1))))))
      (if persps-cache (setq persp-names-cache persps-cache))
      (when (called-interactively-p 'any)
        (+workspace/display)))))

  (defun +workspace/yank-current-workspace-name ()
    "Copy the current workspace's name to the kill ring."
    (interactive)
    (if-let* ((workspace-name (+workspace-current-name)))
        (progn
          (kill-new workspace-name)
          (if (string= workspace-name (car kill-ring))
              (message "Copied workspace name: \"%s\"" workspace-name)
            (user-error "Couldn't copy workspace name")))
      (error "Couldn't find workspace name"))))

(defun ey/disable-which-key ()
  (which-key-mode -1) ; Use `(kbd "C-h")' instead (`embark-prefix-help-command')
  (setq echo-keystrokes 0)) ; echoing keybinds in minibuffer area

(defun ey/region-active-p ()
  "Return non-nil if selection or evil visual region is active"
  (or (and (fboundp 'evil-visual-state-p)
           (evil-visual-state-p))
      (use-region-p)))

(defun ey/region-beginning ()
  "Return beginning position of selection or evil visual region"
  (or (and (fboundp 'evil-visual-state-p)
           (evil-visual-state-p)
           (markerp evil-visual-beginning)
           (marker-position evil-visual-beginning))
      (region-beginning)))

(defun ey/region-end ()
  "Return beginning position of selection or evil visual region"
  (or (and (fboundp 'evil-visual-state-p)
           (evil-visual-state-p)
           (markerp evil-visual-end)
           (marker-position evil-visual-end))
      (region-end)))



(defvar ey/compile-start-time nil
  "Stores the time when compilation starts.")

(defun ey/compile-start-timer (_proc)
  "Set the start time for compilation."
  (setq ey/compile-start-time (current-time)))

(defun ey/compile-show-time (buffer message)
  "Display the time taken for compilation."
  (when ey/compile-start-time
    (let* ((elapsed (float-time (time-subtract (current-time) ey/compile-start-time)))
           (face 'font-lock-number-face)
           (msg (format " (%.2f seconds)\n" elapsed))
           (start (- (point-max) 1)))
      (with-current-buffer buffer
        (goto-char start)
        (insert (propertize msg 'face face))
        (add-face-text-property start (point) face)))))

;; Override compilation mode keyword faces
(defvar compilation-mode-font-lock-keywords
  '(;; configure output lines.
    ("^[Cc]hecking \\(?:[Ff]or \\|[Ii]f \\|[Ww]hether \\(?:to \\)?\\)?\\(.+\\)\\.\\.\\. *\\(?:(cached) *\\)?\\(\\(yes\\(?: .+\\)?\\)\\|no\\|\\(.*\\)\\)$"
     (1 font-lock-variable-name-face)
     (2 (compilation-face '(4 . 3))))
    ;; Command output lines. Recognize `make[n]:' lines too.
    ("^\\([[:alnum:]_/.+-]+\\)\\(\\[\\([0-9]+\\)\\]\\)?[ \t]*:"
     (1 font-lock-function-name-face) (3 compilation-line-face nil t))
    (" --?o\\(?:utfile\\|utput\\)?[= ]\\(\\S +\\)" . 1)
    ("^Compilation \\(finished\\).*"
     (0 '(face nil compilation-message nil help-echo nil mouse-face nil) t)
     (1 compilation-info-face))
    ("^Compilation \\(exited abnormally\\|interrupt\\|killed\\|terminated\\|segmentation fault\\)\\(?:.*with code \\([0-9]+\\)\\)?.*"
     (0 '(face nil compilation-message nil help-echo nil mouse-face nil) t)
     (1 compilation-error-face)
     (2 compilation-error-face nil t))
    ;; Highlight duration at the end of "Compilation finished" message.
    ("\\([0-9]+\\.?[0-9]* seconds\\)"
     (1 compilation-info-face)))
  "Additional things to highlight in Compilation mode.
This gets tacked on the end of the generated expressions.")

(add-hook 'compilation-start-hook 'ey/compile-start-timer)
(add-hook 'compilation-finish-functions 'ey/compile-show-time)



(defun ey/open-url-in-min-browser (url &rest _args)
  "Open URL in min-browser using xdg-open while temporarily unsetting DISPLAY."
  (let ((min-browser-path "/mnt/c/Users/Eyu/AppData/Local/min/min.exe")
        (process-environment (copy-sequence process-environment))) ; Create a copy of the environment
    (setenv "DISPLAY" nil) ; Temporarily unset DISPLAY
    (start-process "xdg-open" nil "xdg-open" url)))

;; (setq browse-url-browser-function 'ey/open-url-in-min-browser)
(setq browse-url-browser-function 'browse-url-default-browser)

(defun ey/evil-do-normal-state-w/o-cursor-jumpback (&rest _)
  (let ((evil-move-cursor-back nil))
    (if (not (evil-visual-state-p))
        (if (memq (evil-initial-state major-mode) '(normal motion))
            (evil-change-to-initial-state)
          (evil-normal-state 1)))))

;;; Interactive FUNCTIONS

(after! evil
  (defun ey/scroll-line-and-window-up ()
    "TODO: description"
    (interactive)
    (evil-scroll-line-up 1)
    (evil-previous-visual-line 1))
  (defun ey/scroll-line-and-window-down ()
    "TODO: description"
    (interactive)
    (evil-scroll-line-down 1)
    (evil-next-visual-line 1))
  (evil-define-command ey/evil-scroll-left (count)
    "Scroll the window COUNT one-tenth-screenwidths to the left."
    :repeat nil
    :keep-visual t
    (interactive "p")
    (evil-with-hproject-point-on-window
      (scroll-right (* count (/ (window-width) 10)))))
  (evil-define-command ey/evil-scroll-right (count)
    "Scroll the window COUNT one-tenth-screenwidths to the right."
    :repeat nil
    :keep-visual t
    (interactive "p")
    (evil-with-hproject-point-on-window
      (scroll-left (* count (/ (window-width) 10))))))

(defun +org-appear-toggle ()
  "Toggle `org-appear-mode' if in an org-mode buffer"
  (interactive)
  (if (eq major-mode 'org-mode)
      (message "org-appear-mode: %s" (org-appear-mode 'toggle))
    (message "Current major-mode is not Org-mode")))

(defun ey/visual-to-last-non-blank-in-current-line ()
  "Visual mode and extend selection to the last non-blank char in the
current line. Change into `evil-normal-state' or `evil-motion-state' in
the process"
  (interactive)
  ;; if region is not active, change previous state either to normal/motion
  ;; state (not insert to prevent deleting text)
  (unless (ey/region-active-p)
    (let ((evil-move-cursor-back nil))
      (if (memq (evil-initial-state major-mode) '(normal motion))
          (evil-change-to-initial-state)
        (evil-normal-state 1))
      ;; (evil-visual-char) ; old behavior where visual gradually incrses
      ))
  (evil-visual-char)
  (doom/forward-to-last-non-comment-or-eol)
  (if (or (looking-at "[ \t\n]") (eobp))
      (evil-backward-char)))

;; we want to go back 1
;; when char-after == 32 or char-after ==
(defun ey/visual-to-first-non-blank-in-current-line ()
  "Visual mode and extend selection to the first non-blank char in the current line."
  (interactive)
  (let ((visual-start (or (mark) (point)))  ; Get the current visual start (or point if not in visual mode)
        (current-point (point)))
    ;; Ensure we're in visual mode
    (unless (ey/region-active-p)
      (let ((evil-move-cursor-back nil))
        (if (memq (evil-initial-state major-mode) '(normal motion))
            (evil-change-to-initial-state)
          (evil-normal-state 1)))
      (evil-visual-char))
    ;; Move to the first non-blank character
    (doom/backward-to-bol-or-indent)))

(defun ey/toggle-compilation-jump-to-error ()
  "Cycle between compilation-mode settings"
  (interactive)
  (cond ((eq compilation-auto-jump-to-first-error t)
         (progn (setq compilation-scroll-output 'first-error
                        compilation-auto-jump-to-first-error nil)
                (message "Compilation-mode just stop on first error")))
        ((eq compilation-scroll-output 'first-error)
         (progn (setq compilation-scroll-output t
                        compilation-auto-jump-to-first-error nil)
                (message "Compilation-mode scroll output continuously")))
        ((eq compilation-scroll-output t)
         (progn (setq compilation-scroll-output nil
                        compilation-auto-jump-to-first-error nil)
                (message "Compilation-mode do nothing")))
        ((eq compilation-scroll-output nil)
         (progn (setq compilation-scroll-output nil
                        compilation-auto-jump-to-first-error t)
                (message "Compilation-mode auto-jump to first error")))))

;; Enhanced web-search
(defun ey/google-search (query)
  "Search Google for the QUERY. Use selected text as the default input if available."
  (interactive
   (let ((selected-text (if (use-region-p)
                            (buffer-substring-no-properties (ey/region-beginning) (ey/region-end)))))
     (list (read-string "gsearch: " selected-text))))
  (cond
   ((string-match-p "^https?://" query)
    (ey/open-url-in-min-browser query))
   ((equal query "")
    (ey/open-url-in-min-browser query))
   (t
    (ey/open-url-in-min-browser
     (concat "https://www.google.com/search?q=" (url-hexify-string query))))))

;; Org-download clipboard for wsl2
(defun ey/yank-image-from-win-clipboard-through-powershell ()
  "Yank an image from the Windows clipboard through PowerShell and insert
file link into the current line."
  (interactive)
  (let* ((powershell (cl-find-if #'file-exists-p '("/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
                                                   "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")))
         (image-filename (format "%s_%s"
                                 (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))
                                 (format-time-string "%Y%m%d_%H%M%S.png")))
         (image-filepath-temporary (concat "C:/Users/Public/" image-filename))
         (image-filepath-relative (concat "./images/" image-filename))
         (image-filepath-absolute (concat (expand-file-name default-directory) "images/" image-filename)))
    ;; The target directory should exist
    (unless (file-exists-p "./images/")
      (make-directory "./images/"))
    ;; Save the image from the clipboard to the temporary directory
    (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save('" image-filepath-temporary "')\""))
    ;; Wait till the shell command finishes
    (sit-for 1)
    ;; Check if the file was created successfully
    (let ((candidates `(,(concat "/mnt/c/Users/Public/" image-filename) ; check for wsl
                        ,(concat "C:/Users/Public/" image-filename))))
      (if-let (temp-file (cl-find-if #'file-exists-p candidates))
          (progn
            ;; Rename (move) the file to the current directory
            (rename-file temp-file image-filepath-absolute)
            ;; Insert the file link into the buffer
            (insert (concat "[[file:" image-filepath-relative "]]"))
            (message "Image inserted successfully."))
        (error "The image file was not created by PowerShell.")))))



(defun ey/magit-status-other-window ()
  (interactive)
  "TODO"
  (let ((toplevel (magit-toplevel default-directory)))
    (if (one-window-p)
        (split-window-right))
    (other-window 1)
    (magit-status toplevel)))

(after! magit
  ;; ;; FIXME: Internal magit commands get values from the current focused buffer
  ;; ;;        So if we do `other-window' early, magit will not find the relevant file
  ;; ;;            to open it's targeted column and line
  ;; ;;        We need to open `magit-status' early, and move it to the other window
  ;; ;;            without hurting the window configuration
  ;; (defun ey/magit-status-here-other-window ()
  ;;   (interactive)
  ;;   "TODO"
  ;;   (let* ((toplevel (magit-toplevel default-directory))
  ;;          (magit-buffer-file-name (buffer-file-name (current-buffer)))
  ;;          (magit-status-goto-file-position t))
  ;;     (if (one-window-p)
  ;;         (split-window-right))
  ;;     (other-window 1)
  ;;     (magit-status toplevel))))

  ;; TODO: ey/magit-status-here-other-window
  ;; -> magit-status-here
  ;; -> save the buffer-string
  ;; -> winner-undo
  ;; -> other-window/split-window
  ;; -> switch-to-buffer saved-buffer-string

  (defun +frame-contains-magit-status-window-p ()
    "Check if any open window buffer has `magit-status-mode`."
    (let ((found nil))
      (save-selected-window
        (cl-dolist (window (window-list))
          (select-window window)
          (when (eq major-mode 'magit-status-mode)
            (setq found t)
            (cl-return))))
      found))

  (defun ey/magit-status-here-other-window ()
    (interactive)
    "Open `magit-status-here' in another window"
    (let ((prev-buffer (current-buffer)))
      ;; If frame has a magit-status window, use that window
      (if (not (+frame-contains-magit-status-window-p))
          (progn
            (magit-status-here)
            (switch-to-buffer-other-window (current-buffer))
            (other-window 1)
            (switch-to-buffer prev-buffer)
            (other-window 1))
        (progn
          (magit-status-here))))))



(defun ey/find-file-under-selection-other-window ()
  "Open `find-file` with the current selection (if any) as the default filename."
  (interactive)
  (let* ((selection
          (if (ey/region-active-p)
              (buffer-substring-no-properties (ey/region-beginning) (ey/region-end))
            nil))
         (insert-default-directory (not selection))
         (file-location (minibuffer-with-setup-hook
                            (lambda ()
                              (when selection
                                (goto-char (point-max))))
                          (read-file-name "Find file: " nil nil nil selection))))
    (message "%s" file-location)
    (if (file-exists-p file-location)
        (find-file-other-window file-location)
      (user-error "Can't find file \"%s\" in path" file-location))))

(defun ey/consult-workspace-buffer-other-window ()
  "Variant of `consult-buffer', switching to a buffer in another window."
  (interactive)
  (let ((consult--buffer-display #'switch-to-buffer-other-window))
    (+vertico/switch-workspace-buffer)))

(defun ey/open-duplicate-window-and-search ()
  "Open a new window with the same buffer and prompt for search term
After search term is found, jump back"
  (interactive)
  (let* ((this-buffer (buffer-name)))
    (if (< (count-windows) 2)
        (progn ; split and search
          (if (> (frame-pixel-width) (/ (display-pixel-width) 2))
              (split-window-right)
            (split-window-below))
          (call-interactively #'+default/search-buffer-other-window))
      (progn
        (save-selected-window
          (other-window 1)
          (switch-to-buffer this-buffer))
        (call-interactively #'+default/search-buffer-other-window)))))

(defun ey/find-files-recursively ()
  "List all files under the current directory and its subdirs."
  (interactive)
  (find-grep-dired default-directory "*"))

(defun ey/find-all-dirs-and-files-recursively ()
  "List all files and dirs under the current directory and its subdirs."
  (interactive)
  ;; (find-dired default-directory (concat find-name-arg " " (shell-quote-argument "*")))
  ;; (find-dired-with-command default-directory "find . -name \\* -fls")
  ;; (find-dired-with-command default-directory "fd . -l")
  (find-name-dired default-directory "*"))

;; TODO: Add option to find hidden files using universal argument prefix
(defun ey/consult-fd-or-find (&optional proj-dir initial)
  "Runs consult-fd if fd version > 8.6.0 exists, consult-find otherwise.
See minad/consult#770."
  (interactive "P")
  (let* ((selection (if (use-region-p)
                        (buffer-substring-no-properties (ey/region-beginning) (ey/region-end))
                      nil))
         (initial-input (cond
                         (selection selection)
                         (initial initial)
                         (t "** ")))
         (consult-fd-args '((if (executable-find "fdfind" 'remote) "fdfind" "fd") "--color=never"
                            "--full-path --absolute-path" "--hidden --exclude .git" "--no-ignore"
                            (if (featurep :system 'windows) "--path-separator=/"))))
    (if
        (when-let* ((bin (if (ignore-errors (file-remote-p default-directory nil t))
                             (cl-find-if (doom-rpartial #'executable-find t)
                                         (list "fdfind" "fd"))
                           doom-fd-executable))
                    (version (with-memoization (get 'doom-fd-executable 'version)
                               (cadr (split-string (cdr (doom-call-process bin "--version"))
                                                   " " t))))
                    ((ignore-errors (version-to-list version))))
          (version< "8.6.0" version))
        (consult-fd default-directory initial-input)
      (consult-find default-directory initial-input))))



;;; emacs-lsp-booster
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ; for check lsp-server-present?
             (not (file-remote-p default-directory)) ; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))

(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)



(defun ey/consult-ripgrep-custom ()
  "Search using consult-ripgrep with live preview."
  (interactive)
  ;; Run consult-ripgrep with my customized flags
  (let* ((selected-text (when (use-region-p)
                          (buffer-substring-no-properties (ey/region-beginning) (ey/region-end))))
         (consult-ripgrep-args
          "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /\
   --smart-case --no-heading --with-filename --line-number --search-zip --hidden --no-ignore-vcs \
   --iglob=!**/.git/** --iglob=!**/node_modules/**"))
    (if selected-text
        (progn
          (deactivate-mark)
          (minibuffer-with-setup-hook
              (lambda () (insert selected-text))
            (consult-ripgrep default-directory)))
      (consult-ripgrep default-directory))))



(defun ey/set-doom-theme (theme)
  "Set `doom-theme` to the selected THEME."
  (if theme
      (setq doom-theme theme)
    (setq doom-theme nil)))

(defun ey/set-custom-faces (&optional theme) ; called on theme change
  (if (bound-and-true-p spacious-padding-mode)
      (spacious-padding-set-faces)) ; fix window-divider color
  (if (bound-and-true-p global-hide-mode-line-mode)
      (global-hide-mode-line-mode 1))
  ;; ;; fix mode-line being visible again
  ;; (set-face-attribute 'cursor nil :background "#FFFF00")
  ;; (after! solaire-mode
  ;;   (set-face-attribute 'solaire-default-face nil :background 'unspecified))
  ;; (after! org-faces
  ;;   (set-face-attribute 'org-block nil :foreground (face-attribute 'default :foreground))
  ;;   (set-face-attribute 'org-ellipsis nil :underline 'unspecified))
  (set-face-attribute 'org-ellipsis nil :underline 'unspecified)
  (after! hl-line
    (set-face-attribute 'hl-line nil :background 'unspecified)) ; works in disabling the bg of the current line-number
  (after! faces
    ;; (set-face-attribute 'line-number-current-line nil :inherit nil) ; FIXME: This doesn't evaluate automatically. I have to evaluate it
    ;; (set-face-attribute 'bold nil :weight 'normal)
    ;; ;; for package ef-themes:
    (set-face-attribute 'line-number-current-line nil :background 'unspecified))) ; FIXME: This doesn't evaluate automatically. I have to evaluate it

(defun ey/reload-theme (&optional _theme)
  "Reload the current Emacs theme."
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



(defun ey/org-agenda-goto-narrowed-subtree ()
  "Go to the heading in org-agenda and narrow to the subtree."
  (interactive)
  (org-agenda-goto)
  (org-narrow-to-subtree))

(after! consult
  ;; Started with a small function, accidentally ballooned it in the end. In any
  ;; case, use `M-x ey/toggle-positional-consult-imenu` to toggle between the
  ;; default behavior and a positional imenu search. And I couldn't get them to
  ;; keep the faces. Should be evaled from top to bottom

  (defvar ey/original-consult-imenu-config
    '((emacs-lisp-mode
       :toplevel "Functions"
       :types ((102 "Functions" font-lock-function-name-face)
               (109 "Macros" font-lock-function-name-face)
               (112 "Packages" font-lock-constant-face)
               (116 "Types" font-lock-type-face)
               (118 "Variables" font-lock-variable-name-face))))
    "Original value of `consult-imenu-config`.")

  (defvar ey/positional-consult-imenu-enabled nil
    "Indicates whether the custom `consult-imenu` is enabled.")

  (autoload 'consult-imenu--select
    (concat doom-local-dir "straight/repos/consult/consult-imenu.el")
    "Autoload consult-imenu--select from consult-imenu.el." nil)

  (autoload 'consult-imenu--items
    (concat doom-local-dir "straight/repos/consult/consult-imenu.el")
    "Autoload consult-imenu--items from consult-imenu.el." nil)

  (defun ey/positional-consult-imenu-maybe ()
    "Select item from flattened `imenu' using `completing-read' with preview.
The command supports preview and narrowing.  See the variable
`consult-imenu-config', which configures the narrowing.
The symbol at point is added to the future history.
See also `consult-imenu-multi'.

Sorts the items based on the line number markers."
    (interactive)
    (consult-imenu--select
     "Go to item: "
     ;; Sort the list of imenu ITEMS by the line numbers in their markers
     (sort
      (consult--slow-operation "Building Imenu..."
        (consult-imenu--items))
      (lambda (a b)
        (< (marker-position (cdr a))
           (marker-position (cdr b)))))))

  (defun ey/original-consult-imenu ()
    "Select item from flattened `imenu' using `completing-read' with preview.

The command supports preview and narrowing.  See the variable
`consult-imenu-config', which configures the narrowing.
The symbol at point is added to the future history.

See also `consult-imenu-multi'."
    (interactive)
    (consult-imenu--select
     "Go to item: "
     (consult--slow-operation "Building Imenu..."
       (consult-imenu--items))))

  (defun ey/toggle-positional-consult-imenu (&optional arg)
    "Toggle between the original and a custom-positional `consult-imenu' setup.
If ARG is nil, toggle the current state:
  - Enable `ey/positional-consult-imenu-maybe' if it is disabled.
  - Disable `ey/positional-consult-imenu-maybe' if it is enabled.
If ARG is non-nil:
  - Disable `ey/positional-consult-imenu-maybe' if ARG is zero or negative.
  - Enable `ey/positional-consult-imenu-maybe' if ARG is positive, t, or anything other
    than zero and negative."
    (interactive "P")
    (let ((enable (if arg
                      (> (prefix-numeric-value arg) 0)
                    (not ey/positional-consult-imenu-enabled))))
      (if enable
          (progn
            ;; Enable the positional setup
            (setq consult-imenu-config nil
                  ey/positional-consult-imenu-enabled t)
            (fset 'consult-imenu (symbol-function 'ey/positional-consult-imenu-maybe))
            (message "Positional-consult-imenu enabled"))
        (progn
          ;; Revert to the original setup
          (setq consult-imenu-config ey/original-consult-imenu-config
                ey/positional-consult-imenu-enabled nil)
          (fset 'consult-imenu (symbol-function 'ey/original-consult-imenu))
          (message "Positional-consult-imenu disabled"))))))

(defun hs-cycle (&optional level)
  (interactive "p")
  (let (message-log-max
        (inhibit-message t))
    (cond
     ((= level 1)
      (pcase last-command
        ('hs-cycle
         (hs-hide-level 1)
         (setq this-command 'hs-cycle-children))
        ('hs-cycle-children
         (hs-show-block)
         (hs-show-block)
         (setq this-command 'hs-cycle-subtree))
        ('hs-cycle-subtree
         (hs-hide-block))
        (_
         (if (not (hs-already-hidden-p))
             (hs-hide-block)
           (hs-hide-level 1)
           (setq this-command 'hs-cycle-children)))))
     (t
      (hs-hide-level level)
      (setq this-command 'hs-hide-level)))))

(defun hs-global-cycle ()
  (interactive)
  (pcase last-command
    ('hs-global-cycle
     (hs-show-all)
     (setq this-command 'hs-global-show))
    (_
     (hs-hide-all))))



(defun ey/gather-active-modes ()
  "Gather and return all active major and minor modes in the current buffer.
The result is a list where the first element is the major mode
and the rest are the active minor modes."
  (let ((major-mode-name (symbol-name major-mode))
        (active-minor-modes
         (cl-remove-duplicates
          (append

           ;; VARIABLE `local-minor-modes'
           (mapcar #'symbol-name
                   (cl-remove-if-not
                    (lambda (mode)
                      (and (boundp mode) (symbol-value mode)))
                    local-minor-modes))

           ;; VARIABLE `global-minor-modes'
           ;; (mapcar #'symbol-name
           ;;         (cl-remove-if-not
           ;;          (lambda (mode)
           ;;            (and (boundp mode) (symbol-value mode)))
           ;;          global-minor-modes))

           ;; VARIABLE `minor-mode-list' (allenabled minor-modes (global+local??)
           ;; (mapcar #'symbol-name
           ;;         (cl-remove-if-not
           ;;          (lambda (mode)
           ;;            (and (boundp mode) (symbol-value mode)))
           ;;          minor-mode-list))

           ;; VARIABLE `minor-mode-alist'
           ;; (cl-loop for (mode . state) in minor-mode-alist
           ;;          if (and state (boundp mode) (symbol-value mode))
           ;;          collect (symbol-name mode))
           )
          :test #'equal)))
    ;; (message "%s" (cons major-mode-name active-minor-modes)) ; print to minibf
    (cons major-mode-name active-minor-modes)))

(defun ey/change-mode-to-hook (mode)
  "Convert a mode name to its corresponding hook name."
  (if (string-suffix-p "-mode" mode)
      (concat mode "-hook")
    (concat mode "-mode-hook")))

(defun ey/gather-buffer-hooks ()
  "Gather the hooks for all active major and minor modes in the current buffer
and display them in a unique interactive buffer."
  (interactive)
  (let* ((modes (ey/gather-active-modes))
         (hooks (mapcar #'ey/change-mode-to-hook modes))
         (buffer-name (format "*Hooks in Buffer:<%s>*" (buffer-name)))
         (buffer (generate-new-buffer buffer-name)))
    ;; Populate the buffer
    (with-current-buffer buffer
      (read-only-mode -1)
      (erase-buffer)
      ;; (insert (format "Hooks for active modes in buffer '%s':\n\n" (buffer-name)))
      (dolist (hook hooks)
        ;; for every hook: make it clickable and go to it's describe-variable/helpful page
        (let ((start (point)))
          (insert (format "%s\n" hook))
          (make-button start (point)
                       'action (lambda (_btn)
                                 (let ((variable (intern hook)))
                                   (if (fboundp 'helpful-variable)
                                       (helpful-variable variable)
                                     (describe-variable variable))))
                       'follow-link t
                       'help-echo (format "Click to describe %s" hook))))
      (read-only-mode 1))
    ;; Displayz generated buffer
    (pop-to-buffer buffer)
    buffer))



(defun ey/set-doom-debug-log-level-to-0 ()
  "Revert `doom-log-level' to zero: No logging at all"
  (interactive)
  (setq doom-log-level 0
        doom-inhibit-log t))

;;; TODO: Assign a keybind to this
(if (modulep! :ui popup)
    (progn
      (defun ey/dired-popup ()
        "Open dired in a popup window for the current `default-directory`.
If the current buffer is a dired popup, delete the popup instead."
        (interactive)
        (if (and (derived-mode-p 'dired-mode)
                 (+popup-buffer-mode))
            (delete-window)
          (let ((buffer (dired-noselect default-directory))
                (alist '((side . left)
                         (size . 40)
                         (window-parameters
                          (ttl . nil)
                          (quit . nil)))))
            (+popup-buffer buffer alist)
            (pop-to-buffer buffer))))
      (defun ey/popup-as-side-bar ()
        (interactive)
        "Make buffer a persistent sidebar popup on the left"
        (let ((+popup-defaults
               ;; Read about these options in the docs for `set-popup-rule!'
               (append '(:side left
                         :width 0.2
                         :quit nil
                         :ttl nil)
                       +popup-defaults)))
          (+popup/buffer)))))

;; (defun ey/treemacs-toggle-preserve-workspace ()
;;   "Toggle the Treemacs pane without altering the workspace projects."
;;   (interactive)
;;   (if (treemacs-is-treemacs-window-selected?)
;;       (delete-window (treemacs-get-local-window))
;;     (treemacs)))



;; Original value: "Closed:    "
(defvar org-agenda-closed-prefix "   "
  "Prefix used for CLOSED items in the Org Agenda.")

;; Original value: "State:    "
(defvar org-agenda-state-prefix "   "
  "Prefix used for STATE items in the Org Agenda.")

(defvar org-agenda-clocked-prefix "   "
  "Prefix used for CLOCKED items in the Org Agenda.")

(after! org-agenda
  (defun org-agenda-get-progress ()
    "Return the logged TODO entries for agenda display."
    (with-no-warnings (defvar date))
    (let* ((props (list 'mouse-face 'highlight
                        'org-not-done-regexp org-not-done-regexp
                        'org-todo-regexp org-todo-regexp
                        'org-complex-heading-regexp org-complex-heading-regexp
                        'help-echo
                        (format "mouse-2 or RET jump to org file %s"
                                (abbreviate-file-name buffer-file-name))))
           (items (if (consp org-agenda-show-log-scoped)
                      org-agenda-show-log-scoped
                    (if (eq org-agenda-show-log-scoped 'clockcheck)
                        '(clock)
                      org-agenda-log-mode-items)))
           (parts
            (delq nil
                  (list
                   (when (memq 'closed items) (concat "\\<" org-closed-string))
                   (when (memq 'clock items) (concat "\\<" org-clock-string))
                   (when (memq 'state items)
                     (format "- +State \"%s\".*?" org-todo-regexp)))))
           (parts-re (if parts (mapconcat #'identity parts "\\|")
                       (error "`org-agenda-log-mode-items' is empty")))
           (regexp (concat
                    "\\(" parts-re "\\)"
                    " *\\["
                    (regexp-quote
                     (format-time-string
                      "%Y-%m-%d" ; We do not use `org-time-stamp-format' to not demand day name in timestamps.
                      (org-encode-time  ; DATE bound by calendar
                       0 0 0 (nth 1 date) (car date) (nth 2 date))))))
           (org-agenda-search-headline-for-time nil)
           marker hdmarker priority category level tags closedp type
           statep clockp state ee txt extra timestr rest clocked inherited-tags
           effort effort-minutes)
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (catch :skip
          (org-agenda-skip)
          (setq marker (org-agenda-new-marker (match-beginning 0))
                closedp (equal (match-string 1) org-closed-string)
                statep (equal (string-to-char (match-string 1)) ?-)
                clockp (not (or closedp statep))
                state (and statep (match-string 2))
                category (save-match-data (org-get-category (match-beginning 0)))
                timestr (buffer-substring (match-beginning 0) (line-end-position))
                effort (save-match-data (or (get-text-property (point) 'effort)
                                            (org-entry-get (point) org-effort-property))))
          (setq effort-minutes (when effort (save-match-data (org-duration-to-minutes effort))))
          (when (string-match org-ts-regexp-inactive timestr)
            ;; substring should only run to end of time stamp
            (setq rest (substring timestr (match-end 0))
                  timestr (substring timestr 0 (match-end 0)))
            (if (and (not closedp) (not statep)
                     (string-match "\\([0-9]\\{1,2\\}:[0-9]\\{2\\}\\)\\].*?\\([0-9]\\{1,2\\}:[0-9]\\{2\\}\\)"
                                   rest))
                (progn (setq timestr (concat (substring timestr 0 -1)
                                             "-" (match-string 1 rest) "]"))
                       (setq clocked (match-string 2 rest)))
              (setq clocked "-")))
          (save-excursion
            (setq extra
                  (cond
                   ((not org-agenda-log-mode-add-notes) nil)
                   (statep
                    (and (looking-at ".*\\\\\n[ \t]*\\([^-\n \t].*?\\)[ \t]*$")
                         (match-string 1)))
                   (clockp
                    (and (looking-at ".*\n[ \t]*-[ \t]+\\([^-\n \t].*?\\)[ \t]*$")
                         (match-string 1)))))
            (if (not (re-search-backward org-outline-regexp-bol nil t))
                (throw :skip nil)
              (goto-char (match-beginning 0))
              (setq hdmarker (org-agenda-new-marker)
                    inherited-tags
                    (or (eq org-agenda-show-inherited-tags 'always)
                        (and (listp org-agenda-show-inherited-tags)
                             (memq 'todo org-agenda-show-inherited-tags))
                        (and (eq org-agenda-show-inherited-tags t)
                             (or (eq org-agenda-use-tag-inheritance t)
                                 (memq 'todo org-agenda-use-tag-inheritance))))
                    tags (org-get-tags nil (not inherited-tags))
                    level (make-string (org-reduced-level (org-outline-level)) ? ))
              (looking-at "\\*+[ \t]+\\([^\r\n]+\\)") ; this is getting the heading
              (setq txt (match-string 1))
              (when extra
                (if (string-match "\\([ \t]+\\)\\(:[^ \n\t]*?:\\)[ \t]*$" txt)
                    (setq txt (concat (substring txt 0 (match-beginning 1))
                                      " - " extra " " (match-string 2 txt)))
                  (setq txt (concat txt " - " extra))))
              (setq txt (org-agenda-format-item
                         (cond
                          (closedp org-agenda-closed-prefix)
                          (statep (concat org-agenda-state-prefix "(" state ")"))
                          (t (concat org-agenda-clocked-prefix "(" clocked  ")")))
                         (org-add-props txt nil
                           'effort effort
                           'effort-minutes effort-minutes)
                         level category tags timestr)))
            (setq type (cond (closedp "closed")
                             (statep "state")
                             (t "clock")))
            (setq priority 100000)
            (org-add-props txt props
              'org-marker marker 'org-hd-marker hdmarker 'face 'org-agenda-done
              'urgency priority 'priority priority 'level level
              'effort effort 'effort-minutes effort-minutes
              'type type 'date date
              'undone-face 'org-warning 'done-face 'org-agenda-done)
            (push txt ee))
          (goto-char (line-end-position))))
      (nreverse ee))))



(defun ey/search-and-search (pattern1 pattern2)
  "Search files containing PATTERN1 and list the lines matching PATTERN2, via
ripgrep, recursively from the cwd."
  (interactive
   (list
    (read-string "Search the files that contain (PATTERN1): ")
    (read-string "Search for (PATTERN2): ")))
  (let ((command (format "rg -il --null '%s' | xargs -0 rg -Hin '%s'"
                         (shell-quote-argument pattern1)
                         (shell-quote-argument pattern2))))
    (with-temp-buffer
      (call-process "sh" nil t nil "-c" command)
      (let ((results (split-string (buffer-string) "\n" t)))
        (if results
            (let* ((choice (completing-read "Select a match: " results))
            ;; (let* ((choice (consult--read
            ;;                 results
            ;;                 :prompt "Select a match: "
            ;;                 :sort nil))
                   (file-and-line (split-string choice ":"))
                   (file (car file-and-line))
                   (line (string-to-number (cadr file-and-line))))
              (find-file file)
              (goto-line line))
          (message "No matches found"))))))

;; (defun ey/search-and-search ()
;;   "Async cross-search using consult--grep infrastructure."
;;   (interactive)
;;   (let ((pattern1 (read-string "Search the files that contain (PATTERN1): ")))
;;     (consult--grep
;;      (format "Files with '%s', search for: " pattern1)
;;      (lambda (_paths)  ; consult--grep passes paths, but we ignore them
;;        (lambda (pattern2)  ; This gets the live minibuffer input
;;          (when (not (string-empty-p pattern2))
;;            (list "sh" "-c"
;;                  (format "rg -l --null %s | xargs -0 rg -Hn %s"
;;                          (shell-quote-argument pattern1)
;;                          (shell-quote-argument pattern2))))))
;;      default-directory
;;      nil)))

;; pattern is based on these:
;; rg -l pattern1 | xargs rg pattern2
;; grep -rl pattern1 | xargs rg pattern2
;; search for pattern2 in the files that contain pattern1



;;; Makes it work for '#+begin_src jupyter-python'
(after! ob-python
  (defun org-babel-execute:jupyter-python (body params)
    "Execute BODY according to PARAMS.
BODY is the code to execute for the current Jupyter `:session' in
the PARAMS alist."
    (when org-babel-current-src-block-location
      (save-excursion
        (goto-char org-babel-current-src-block-location)
        (when (jupyter-org-request-at-point)
          (user-error "Source block currently being executed"))))
    (let* ((result-params (assq :result-params params))
           (async-p (jupyter-org-execute-async-p params)))
      (when (member "replace" result-params)
        (org-babel-jupyter-cleanup-file-links))
      (let* ((org-babel-jupyter-current-src-block-params params)
             (session (alist-get :session params))
             (buf (org-babel-jupyter-initiate-session session params))
             (jupyter-current-client (buffer-local-value 'jupyter-current-client buf))
             (lang (jupyter-kernel-language jupyter-current-client))
             (vars (org-babel-variable-assignments:jupyter params lang))
             (code (progn
                     (when-let* ((dir (alist-get :dir params)))
                       ;; `default-directory' is already set according
                       ;; to :dir when executing a source block.  Set
                       ;; :dir to the absolute path so that
                       ;; `org-babel-expand-body:jupyter' does not try
                       ;; to re-expand the path. See #302.
                       (setf (alist-get :dir params) default-directory))
                     (org-babel-expand-body:jupyter body params vars lang))))
        (pcase-let ((`(,req ,maybe-result)
                     (org-babel-jupyter--execute code async-p)))
          ;; KLUDGE: Remove the file result-parameter so that
          ;; `org-babel-insert-result' doesn't attempt to handle it while
          ;; async results are pending.  Do the same in the synchronous
          ;; case, but not if link or graphics are also result-parameters,
          ;; only in Org >= 9.2, since those in combination with file mean
          ;; to interpret the result as a file link, a useful meaning that
          ;; doesn't interfere with Jupyter style result insertion.
          ;;
          ;; Do this after sending the request since
          ;; `jupyter-generate-request' still needs access to the :file
          ;; parameter.
          (when (and (member "file" result-params)
                     (or async-p
                         (not (or (member "link" result-params)
                                  (member "graphics" result-params)))))
            (org-babel-jupyter--remove-file-param params))
          (prog1 maybe-result
            ;; KLUDGE: Add the "raw" result parameter for non-inline
            ;; synchronous results because an Org formatted string is
            ;; already returned in that case and
            ;; `org-babel-insert-result' should not process it.
            (unless (or async-p
                        (jupyter-org-request-inline-block-p req))
              (nconc (alist-get :result-params params) (list "raw")))))))))

(defun ey/compile (command &optional comint)
  "Exactly like `compile' with an initially empty prompt."
  (interactive
   (list
    (let ((command (eval compile-command)))
      (if (or compilation-read-command current-prefix-arg)
          (compilation-read-command "")
        command))
    (consp current-prefix-arg)))
  (unless (equal command (eval compile-command))
    (setq compile-command command))
  (save-some-buffers (not compilation-ask-about-save)
                     compilation-save-buffers-predicate)
  (setq-default compilation-directory default-directory)
  (compilation-start command comint))

(defun ey/keymap-symbol (keymap)
  "Return the symbol to which KEYMAP is bound, or nil if no such symbol exists."
  (catch 'gotit
    (mapatoms (lambda (sym)
                (and (boundp sym)
                     (eq (symbol-value sym) keymap)
                     (not (eq sym 'keymap))
                     (throw 'gotit sym))))))

(defun ey/get-local-keymap-name ()
  "Get the local keymap in echo-area"
  (interactive)
  (message "%s" (ey/keymap-symbol (current-local-map))))

;;; Add anaconda-mode-completion whenever `anaconda-mode' is active
(defun ey/add-anaconda-completion-to-local-capfs ()
  "Add Anaconda completion to `completion-at-point-functions' when
`anaconda-mode' is active or invoked."
  (when (and (bound-and-true-p anaconda-mode)
             (not (bound-and-true-p lsp-mode)))
    (unless (member #'anaconda-mode-complete completion-at-point-functions)
      (setq-local completion-at-point-functions
                  (append (list #'anaconda-mode-complete)
                          completion-at-point-functions)))))

;;; Make `consult-yank-pop' work in vterm
(defun vterm-consult-yank-pop-action (orig-fun &rest args)
  "Make `consult-yank-pop` work in `vterm-mode` by sending the string directly."
  (if (derived-mode-p 'vterm-mode)
      (let ((inhibit-read-only t)
            (yank-undo-function (lambda (_start _end) (vterm-undo))))
        (cl-letf (((symbol-function 'insert-for-yank)
                   (lambda (str) (vterm-send-string str t))))
          (apply orig-fun args)))
    (apply orig-fun args)))

;;; Remove workspace names when switching workspaces (Overrides some doom code here)
(defun ey/+workspace/switch-to (index)
  "Switch to a workspace at a given INDEX. A negative number will start from the
end of the workspace list."
  (interactive
   (list (or current-prefix-arg
             (completing-read "Switch to workspace: " (+workspace-list-names)))))
  (when (and (stringp index)
             (string-match-p "^[0-9]+$" index))
    (setq index (string-to-number index)))
  (condition-case-unless-debug ex
      (let ((names (+workspace-list-names))
            (old-name (+workspace-current-name)))
        (cond ((numberp index)
               (let ((dest (nth index names)))
                 (unless dest
                   (error "No WKSPC" (1+ index)))
                 (+workspace-switch dest)))
              ((stringp index)
               (+workspace-switch index t))
              (t
               (error "Not a valid index: %s" index))))))

(defun ey/workspace-behavior-advices ()
  "I want to override some of doom's +workspace functions"
  (advice-add '+workspace/switch-to :override #'ey/+workspace/switch-to))

(defun ey/start-tide-mode-interactively ()
  "Enable `tide-mode' for TS/JS"
  (interactive)
  (tide-setup))

(defun +default/find-files-cwd ()
  "Perform a recursive file search from the current working directory."
  (interactive)
  (let* ((dir default-directory)
         (projectile-enable-caching nil)
         (file (projectile-completing-read
                "Find file: " (projectile-project-files dir))))
    (when file
      (find-file (expand-file-name file dir))
      (run-hooks 'projectile-find-file-hook))))

(defun +default/find-files-other-cwd ()
  "Prompt for a directory and perform a recursive file search from there."
  (interactive)
  (let* ((dir (read-directory-name "Search directory: "))
         (projectile-enable-caching nil)
         (file (projectile-completing-read
                "Find file: " (projectile-project-files dir))))
    (when file
      (find-file (expand-file-name file dir))
      (run-hooks 'projectile-find-file-hook))))

(defun ey/toggle-center-buffer-content ()
  "Center the contents of the buffer"
  (interactive)
  (require 'visual-fill-column)
  (if visual-line-fill-column-mode
      (progn
        (setq-local visual-fill-column-center-text nil)
        (setq-local fill-column 80)
        (visual-line-fill-column-mode -1)
        (message "Centering buffer disabled"))
    (progn
      (setq-local visual-fill-column-center-text t)
      (setq-local fill-column 90)
      (visual-line-fill-column-mode 1)
      (message "Centering buffer enabled"))))

(defun ey/toggle-sane-line-numbers () ; TODO: I forgot what this was for, seems
                                      ; like line numbers don't pop on
                                      ; infocation
  "Toggle between topspace mode and line number mode"
  (interactive)
  (if (bound-and-true-p display-line-numbers-type)
      (progn
        (setq display-line-numbers-type nil)
        (global-topspace-mode 1)
        (message "Sane global-line-numbers-type disabled"))
    (progn
      (setq display-line-numbers-type t)
      (global-topspace-mode -1)
      (message "Sane global-line-numbers-type enabled"))))

(defun ey/startup-files-and-workspaces ()
  "Open My favourite startup files and workspaces" ; No longer using this!!
  (interactive)
  (find-file (concat doom-user-dir doom-module-config-file))
  (when (fboundp '+workspace/new-named)
    (+workspace/new-named "agenda"))
  (find-file (car org-agenda-files))
  (when (fboundp '+workspace/switch-to-0)
    (+workspace/switch-to-0)))

;;; Doom specific REAL-BUFFERS
(defvar all-buffers-be-real nil
  "Whether all buffers are marked as real (for +workspaces)")

(defun +any-buffer-xcept-doom-fallback-p (&optional buf)
  "If BUF is has '*doom*' in it, return nil, else return t"
  (if (string-match-p "^\\*doom\\*" (buffer-name buf)) nil t))

(defun ey/toggle-mark-all-buffers-as-real ()
  "Toggle Marking all buffers as real buffers (for them to be associated
with doom's workspaces)"
  (interactive)
  ;; All major modes should return true
  (if all-buffers-be-real
      (progn
        (setq all-buffers-be-real nil)
        (remove-hook 'doom-real-buffer-functions #'+any-buffer-xcept-doom-fallback-p)
        (message "All buffers real marking Disabled"))
    (progn
      (setq all-buffers-be-real t)
      (add-hook 'doom-real-buffer-functions #'+any-buffer-xcept-doom-fallback-p)
      (message "All buffers marked real"))))

(after! doom-keybinds
  (defun doom/escape (&optional interactive) ; I don't remember what this is for
    "Run `doom-escape-hook'."
    (interactive (list 'interactive))
    (let ((inhibit-quit t))
      (cond ((minibuffer-window-active-p (minibuffer-window))
             ;; quit the minibuffer if open.
             (when (and interactive (minibufferp))
               (setq this-command 'abort-recursive-edit)
               (abort-recursive-edit)))
            ;; Run all escape hooks. If any returns non-nil, then stop there.
            ((run-hook-with-args-until-success 'doom-escape-hook))
            ;; don't abort macros
            ((or defining-kbd-macro executing-kbd-macro) nil)
            ;; Back to the default
            ((unwind-protect (keyboard-quit)
               (when interactive
                 (setq this-command 'keyboard-quit))))))))



(defun ey/window-search ()
  "Interactive search, limited to the visible portion of the buffer."
  (interactive)
  (save-restriction
    (narrow-to-region (window-start) (window-end))
    (let ((search-invisible nil)
          (org-appear-mode nil)
          (isearch-wrap-pause 'no-ding)
          (isearch-repeat-on-direction-change t)
          (isearch-lazy-count t)
          (search-whitespace-regexp ".*?"))
      (isearch-forward))))

(defun endless/goto-match-beginning () ; TODO: Update this command from the article
  "go to the start of current isearch match.
use in `isearch-mode-end-hook'."
  (when (and (not (eq this-command 'isearch-exit))
             isearch-forward
             (number-or-marker-p isearch-other-end)
             (not mark-active)
             (not isearch-mode-end-hook-quit))
    (goto-char isearch-other-end)))

;; keep cursor at start of search result.
(add-hook 'isearch-update-post-hook #'endless/goto-match-beginning)

;;; Trying to recenter isearch ; I think not working, so commented
;; (defun ey/recenter-a (&rest args)
;;   (interactive)
;;   (recenter))
;;
;; (add-hook 'isearch-update-post-hook #'ey/recenter-a)
;; (remove-hook 'isearch-update-post-hook #'ey/recenter-a)
;;
;; (defadvice! +isearch-recenter-a (&rest args)
;;   :after 'isearch-exit
;;   (ey/recenter-a))
;;
;; (advice-add 'isearch-exit :after #'ey/recenter-a) ; FIXME: not working
;; (advice-remove 'isearch-done #'+isearch-recenter-a)
;; (advice-remove 'isearch-exit #'+isearch-recenter-a)



(defvar streamer-mode nil
  "Whether streamer mode is on")

(defun ey/streamer-mode () ; TODO: make this a global minor mode
                           ; TODO: set vital variables in here!
  "Before streaming, to privatize the display"
  (interactive)
  (if (not streamer-mode)
      (progn
        (global-blamer-mode -1)
        (setq streamer-mode t)
        (message "Streamer Mode enabled"))
    (progn
      (global-blamer-mode 1)
      (setq streamer-mode nil)
      (message "Streamer Mode disabled"))))

(defun +tab-bar-new-named-tab ()
  "Create a new named tab bar"
  (interactive)
  (call-interactively #'tab-bar-new-tab)
  (call-interactively #'tab-bar-rename-tab))

(defun +tab-bar-show-tabs ()
  (interactive)
  (tab-bar-switch-to-tab (cdr (cadr (tab-bar--current-tab-find)))))
(defun +vterm-here-or-other-window-p ()
  "Return t if `other-window' major mode is `vterm-mode'"
  (save-selected-window
    (when (not (one-window-p))
      (other-window 1))
    (if (or (equal major-mode 'vterm-mode)
            (derived-mode-p 'vterm-mode))
        t
      nil)))



(defun +default/search-buffer-other-window ()
  (interactive)
  (let (start end multiline-p string-in-region vterm-here-or-other-window-p)
    (save-restriction
      (when (ey/region-active-p)
        (setq start (ey/region-beginning)
              end   (ey/region-end)
              vterm-here-or-other-window-p (+vterm-here-or-other-window-p)
              multiline-p (/= (line-number-at-pos start)
                              (line-number-at-pos end))))
      (deactivate-mark)
      (when (and multiline-p (one-window-p))
        (narrow-to-region start end))
      (if (and start end (not multiline-p))
          (progn
            (setq string-in-region (buffer-substring-no-properties start end))
            (if (not (one-window-p))
                (other-window 1))
            (if vterm-here-or-other-window-p
                (vterm-copy-mode 1))
            (consult-line
             (replace-regexp-in-string
              " " "\\\\ "
              (doom-pcre-quote string-in-region)))
            (if vterm-here-or-other-window-p
                (cl-letf (((symbol-function 'vterm-reset-cursor-point) #'ignore))
                  (vterm-copy-mode -1))))
        (progn
          (if (not (one-window-p))
              (other-window 1))
          (if vterm-here-or-other-window-p
              (vterm-copy-mode 1))
          (call-interactively #'consult-line)
          (if vterm-here-or-other-window-p
              (cl-letf (((symbol-function 'vterm-reset-cursor-point) #'ignore))
                (vterm-copy-mode -1))))))))



(defvar +mode-line-format nil
  "Alternate to `mode-line-format' when it's nil")

(defun +mode-line--formatted? (expr)
  "Return `format-mode-line' of EXPR, or nil if the result is empty."
  (when-let ((str (format-mode-line expr)))
    (unless (string-empty-p str)
      str)))

(defun ey/show-modeline-in-echo-area ()
  "Show the current modeline in the echo area.
Try, in order:
 - the visible `mode-line-format'
 - `doom-modeline-format--main' if `doom-modeline-mode' is on
 - the original `mode-line-format' from doom-modeline
 - the original `mode-line-format' from helpful"
  (interactive)
  (let* ((candidates
          (list
           'mode-line-format ; if mode line is not hidden
           '+mode-line-format ; use when mode-line is hidden
           (and (bound-and-true-p doom-modeline-mode) ; doom mode line
                (doom-modeline-format--main))
           (and (fboundp 'doom-modeline--original-value)
                (doom-modeline--original-value 'mode-line-format)) ; original mode line
           (and (fboundp 'helpful--original-value)
                (helpful--original-value 'mode-line-format)))) ; original mode line
         (str (cl-some #'+mode-line--formatted? candidates)))
    (let ((message-log-max)) ; suppress *Messages*
      (message "%s"
               (if str
                   (substring-no-properties str) ; strip faces
                 "No Modeline Info")))))

;; (defun ey/show-modeline-in-echo-area ()
;;   "Show the current modeline in the echo area."
;;   (interactive)
;;   (let* ((str (or
;;                (let ((formatted (format-mode-line 'mode-line-format))) ; when mode-line is visible
;;                  (when (not (string-empty-p formatted)) formatted))
;;                (let ((formatted (if (bound-and-true-p doom-modeline-mode) ; when using doom-modeline
;;                                     (format-mode-line (doom-modeline-format--main))
;;                                   "")))
;;                  (when (not (string-empty-p formatted)) formatted))
;;                (if (fboundp 'doom-modeline--original-value) ; to find original value
;;                    (let ((formatted (format-mode-line (doom-modeline--original-value 'mode-line-format))))
;;                      (when (not (string-empty-p formatted)) formatted)))
;;                (if (fboundp 'helpful--original-value) ; to find original value
;;                    (let ((formatted (format-mode-line (helpful--original-value 'mode-line-format))))
;;                      (when (not (string-empty-p formatted)) formatted)))))
;;          (message-log-max)) ; don't write to *Messages* buffer
;;     (if str
;;         (message "%s" (substring-no-properties str)) ; strip the faces
;;       (message "No Modeline Info"))))



;;; Manual Garbage Collection

(defvar gc-memory-limit (* (memory-limit) 1024)
  "Maximum amount of memory before garbage-collecting")
;; (defvar gc-memory-limit most-positive-fixnum)

(defun gc-on-minibuffer-setup ()
  (setq gc-cons-threshold gc-memory-limit))

(defun gc-on-minibuffer-exit ()
  (setq gc-cons-threshold gc-memory-limit))

(add-hook 'minibuffer-setup-hook #'gc-on-minibuffer-setup)
(add-hook 'minibuffer-exit-hook #'gc-on-minibuffer-exit)

(setq gc-cons-threshold gc-memory-limit)

(defvar gc-garbage-collection-timer nil
  "Timer object for holding a garbage collection timer")

(defun start-garbage-collection-timer ()
  (if (not gc-garbage-collection-timer)
      (setq gc-garbage-collection-timer
            (run-with-idle-timer 1.2 t 'garbage-collect))))

(defun end-garbage-collection-timer ()
  (if gc-garbage-collection-timer
      (progn (cancel-timer gc-garbage-collection-timer)
             (setq gc-garbage-collection-timer nil))))

(start-garbage-collection-timer)



(defun ey/xset-set-keyboard-rate-&-speed ()
  "Shell alias to my keyboard rate command"
  (interactive)
  (shell-command-to-string "xset r rate 200 30"))

(defun ey/windows-terminal-open-profile ()
  "Open a shell profile in Windows Terminal."
  (interactive)
  (let* ((commands '("wt.exe -w 0 -p Arch"
                     "wt.exe -w 0 -p PowerShell"
                     "wt.exe -w 0 -p Windows PowerShell"
                     "wt.exe -w 0 -p Command Prompt"
                     "wt.exe -w 0 -p Ubuntu"
                     "wt.exe -w _quake"))
         (choice (completing-read "Windows Terminal Profile: " commands)))
    (start-process-shell-command "Windows Terminal Preview" nil choice)))

(defun doom/backward-to-bol-or-indent (&optional point)
  "Jump between the indentation column (first non-whitespace character) and
the beginning of the line."
  (interactive "^d")
  (if (and (eq major-mode 'org-mode)      ; org-mode
           (or (not (org-in-src-block-p)) ; not in src-block
               (org-at-heading-p)         ; at heading
               (save-excursion            ; at heading check 2
                 (org-beginning-of-line)
                 (org-at-heading-p))))
      (call-interactively #'org-beginning-of-line)
  (let ((pt (or point (point))))
    (cl-destructuring-bind (bol bot _eot _eol)
        (doom--bol-bot-eot-eol pt)
      (cond ((> pt bot)
             (goto-char bot))
            ((= pt bol)
             (or (and doom--last-backward-pt
                      (= (line-number-at-pos doom--last-backward-pt)
                         (line-number-at-pos pt)))
                 (setq doom--last-backward-pt nil))
             (goto-char (or doom--last-backward-pt bot))
             (setq doom--last-backward-pt nil))
            ((<= pt bot)
             (setq doom--last-backward-pt pt)
             (goto-char bol)))))))

(defun my/eww-to-org (&optional dest)
  "Render the current eww buffer using org markup.
  If DEST, a buffer, is provided, insert the markup there."
  (interactive)
  (unless (org-region-active-p)
    (let ((shr-width 80)) (eww-readable)))
  (let* ((start (if (org-region-active-p) (ey/region-beginning) (point-min)))
         (end (if (org-region-active-p) (ey/region-end) (point-max)))
         (buff (or dest (generate-new-buffer "*eww-to-org*")))
         (link (eww-current-url))
         (title (or (plist-get eww-data :title) "")))
    (with-current-buffer buff
      (insert "#+title: " title "\n#+link: " link "\n\n")
      (org-mode))
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (let* ((p (point))
               (props (text-properties-at p))
               (k (seq-find (lambda (x) (plist-get props x))
                            '(shr-url image-url outline-level face)))
               (prop (and k (list k (plist-get props k))))
               (next (if prop
                         (next-single-property-change p (car prop) nil end)
                       (next-property-change p nil end)))
               (txt (buffer-substring (point) next))
               (txt (replace-regexp-in-string "\\*" "·" txt)))
          (with-current-buffer buff
            (insert
             (pcase prop
               ((and (or `(shr-url ,url) `(image-url ,url))
                     (guard (string-match-p "^http" url)))
                (let ((tt (replace-regexp-in-string "\n\\([^$]\\)" " \\1" txt)))
                  (org-link-make-string url tt)))
               (`(outline-level ,n)
                (concat (make-string (- (* 2 n) 1) ?*) " " txt "\n"))
               ('(face italic) (format "/%s/ " (string-trim txt)))
               ('(face bold) (format "*%s* " (string-trim txt)))
               (_ txt))))
          (goto-char next))))
    (pop-to-buffer buff)
    (goto-char (point-min))))



(defun buffer-faces--build-faces (&optional buffer)
  (let (faces
        (inhibit-point-motion-hooks t))
    (save-excursion
      (with-current-buffer (or buffer (current-buffer))
        (goto-char (point-min))
        (while (/= (point) (point-max))
          (cl-pushnew (get-text-property (point) 'face) faces)
          (goto-char (next-property-change (point) nil (point-max))))))
    (cl-delete-if #'null faces)))

(defun buffer-faces--build-buffer (faces)
  (with-current-buffer (get-buffer-create "*faces*")
    (with-silent-modifications
     (unless (eq major-mode 'special-mode)
       (special-mode))
     (delete-region (point-min) (point-max))
     (cl-loop for face in (sort faces 'eq) do
              (insert (propertize (format "%s\n" face) 'face face))))
    (goto-char (point-min))
    (current-buffer)))

(defun show-buffer-faces ()
  "Show a buffer containing each face used in the current buffer."
  (interactive)
  (require 'cl-lib)
  (pop-to-buffer
   (buffer-faces--build-buffer (buffer-faces--build-faces))))



(defun ey/turn-on-gptel-mode-in-special-dir--h (&rest _)
  "Meant to be used in a hook, e.g. `org-mode-hook'"
  (let ((buf (or (buffer-file-name (buffer-base-buffer)) "")))
    (if (and (string-match-p "gpt"   buf)
             (string-match-p "chats" buf))
        (gptel-mode 1))))

(defun sudo-shell-command (command)
  (interactive "MShell command (root): ")
  (with-temp-buffer
    (cd "/sudo::/")
    (async-shell-command command)))



(defun ey/vdiff-reopen-file-visiting-buffers--a (orig-fn &rest args)
  "Save visible file-visiting buffers, call ORIG-FN (intended to be
`vdiff-quit'), then reopen those files."
  (let ((file-visiting-buffer-list (list)))
    (dolist (window (doom-visible-windows))
      (let ((buffer (window-buffer window)))
        (if (not (doom-non-file-visiting-buffer-p buffer))
            (add-to-list 'file-visiting-buffer-list (buffer-file-name buffer)))))
    (apply orig-fn args)
    (dolist (file file-visiting-buffer-list)
      (find-file file))))

(advice-add 'vdiff-quit :around #'ey/vdiff-reopen-file-visiting-buffers--a)

;; (defun shut-up--advice (fn &rest args)
;;   (let ((inhibit-message t)
;;         (message-log-max))
;;     (apply fn args)))
;; (advice-add #'repeat-mode :around #'shut-up--advice)

(defun eval-expression (exp &optional insert-value no-truncate char-print-limit)
  "Evaluate EXP and print value in the echo area.
When called interactively, read an Emacs Lisp expression and
evaluate it.  Value is also consed on to front of the variable
`values'.  Optional argument INSERT-VALUE non-nil (interactively,
with a non `-' prefix argument) means insert the result into the
current buffer instead of printing it in the echo area.

Normally, this function truncates long output according to the
value of the variables `eval-expression-print-length' and
`eval-expression-print-level'.  When NO-TRUNCATE is
non-nil (interactively, with a prefix argument of zero), however,
there is no such truncation.

If the resulting value is an integer, and CHAR-PRINT-LIMIT is
non-nil (interactively, unless given a non-zero prefix argument)
it will be printed in several additional formats (octal,
hexadecimal, and character).  The character format is used only
if the value is below CHAR-PRINT-LIMIT (interactively, if the
prefix argument is -1 or the value doesn't exceed
`eval-expression-print-maximum-character').

Runs the hook `eval-expression-minibuffer-setup-hook' on entering the
minibuffer.

If `eval-expression-debug-on-error' is non-nil, which is the default,
this command arranges for all errors to enter the debugger."
  (interactive
   (let ((selection
          (if (ey/region-active-p)
              (buffer-substring-no-properties (ey/region-beginning) (ey/region-end))
            nil)))
   (cons (read--expression "Eval: " selection)
         (eval-expression-get-print-arguments current-prefix-arg))))

  (let* (result
         (runfun
          (lambda ()
            (setq result
                  (values--store-value
                   (eval (let ((lexical-binding t)) (macroexpand-all exp))
                         t))))))
    (if (null eval-expression-debug-on-error)
        (funcall runfun)
      (handler-bind ((error #'eval-expression--debug))
        (funcall runfun)))

    (let ((print-length (unless no-truncate eval-expression-print-length))
          (print-level  (unless no-truncate eval-expression-print-level))
          (eval-expression-print-maximum-character char-print-limit)
          (deactivate-mark))
      (let ((out (if insert-value (current-buffer) t)))
        (prog1
            (prin1 result out)
          (let ((str (and char-print-limit
                          (eval-expression-print-format result))))
            (when str (princ str out))))))))

(after! pp
  (defun pp-eval-expression (expression)
  "Evaluate EXPRESSION and pretty-print its value.
Also add the value to the front of the list in the variable `values'."
  (interactive
   (let ((selection
          (if (ey/region-active-p)
              (buffer-substring-no-properties (ey/region-beginning) (ey/region-end))
            nil)))
     (list (read--expression "Eval: " selection))))
  (message "Evaluating...")
  (let ((result (eval expression lexical-binding)))
    (values--store-value result)
    (pp-display-expression result "*Pp Eval Output*" pp-use-max-width))))



;;; Focused Window Automatic Resize; Ref: https://www.reddit.com/r/emacs/comments/1mf3cmk/autoresizing_on_focused_windows
;; The desired ratio of the focused window's size.
(setq auto-resize-ratio 0.6)
;; (setq window-min-height 10)
;; (setq window-min-width 10)

(defun win/auto-resize (&rest args)
  (cond ((string-match "MiniBuf" (buffer-name (window-buffer (selected-window)))))
        (t (let* ((height (floor (* auto-resize-ratio (frame-height))))
                  (width (floor (* auto-resize-ratio (frame-width))))
                  ;; INFO We need to calculate by how much we should enlarge
                  ;; focused window because Emacs does not allow setting the
                  ;; window dimensions directly.
                  (h-diff (max 0 (- height (window-height))))
                  (w-diff (max 0 (- width (window-width)))))
             (enlarge-window h-diff)
             (enlarge-window w-diff t)))))


(define-minor-mode win-auto-resize-mode
  "Remap the face variables so they are not too shiny."
  :global t
  :init-value nil
  (if win-auto-resize-mode
      (progn
        (advice-add 'evil-window-up    :after 'win/auto-resize)
        (advice-add 'evil-window-down  :after 'win/auto-resize)
        (advice-add 'evil-window-right :after 'win/auto-resize)
        (advice-add 'evil-window-left  :after 'win/auto-resize)
        (advice-add 'select-window    'win/auto-resize))
    (advice-remove 'evil-window-up    'win/auto-resize)
    (advice-remove 'evil-window-down  'win/auto-resize)
    (advice-remove 'evil-window-right 'win/auto-resize)
    (advice-remove 'evil-window-left  'win/auto-resizebp)
    (advice-remove 'select-window     'win/auto-resize)))



(defun ey/set-frame-font (font &optional keep-size frames)
  "This is a customized variant of `set-frame-font', which covers more
faces.

Set the default font to FONT.
When called interactively, prompt for the name of a font, and use that
font on the selected frame. When called from Lisp, FONT should be a font
name (a string), a font object, font entity, or font spec.

If KEEP-SIZE is nil, keep the number of frame lines and columns fixed.
If KEEP-SIZE is non-nil (or with a prefix argument), try to keep the
current frame size fixed (in pixels) by adjusting the number of lines
and columns.

If FRAMES is nil, apply the font to the selected frame only. If FRAMES
is non-nil, it should be a list of frames to act upon, or t meaning all
existing graphical frames. Also, if FRAMES is non-nil, alter the user's
Customization settings as though the font-related attributes of the
`default' face had been \"set in this session\", so that the font is
applied to future frames.
"
  (interactive
   (let* ((completion-ignore-case t)
          (default (frame-parameter nil 'font))
          (font (completing-read (format-prompt "Font name" default)
                                 ;; x-list-fonts will fail with an error
                                 ;; if this frame doesn't support fonts.
                                 (x-list-fonts "*" nil (selected-frame))
                                 nil nil nil nil default)))
     (list font current-prefix-arg nil)))
  (when (or (stringp font) (fontp font))
    (let* ((this-frame (selected-frame))
           ;; FRAMES nil means affect the selected frame.
           (frame-list (cond ((null frames)
                              (list this-frame))
                             ((eq frames t)
                              (frame-list))
                             (t frames)))
           height width)
      (dolist (f frame-list)
        (when (display-multi-font-p f)
          (if keep-size
              (setq height (* (frame-parameter f 'height)
                              (frame-char-height f))
                    width  (* (frame-parameter f 'width)
                              (frame-char-width f))))
          ;; When set-face-attribute is called for :font, Emacs
          ;; guesses the best font according to other face attributes
          ;; (:width, :weight, etc.) so reset them too (Bug#2476).
          (set-face-attribute 'default f
                              :width 'normal :weight 'normal
                              :slant 'normal :font font)
          (set-face-attribute 'variable-pitch f
                              :width 'normal :weight 'normal
                              :slant 'normal :font font)
          (set-face-attribute 'fixed-pitch f ; this is the one for keybinds
                              :width 'normal :weight 'normal
                              :slant 'normal :font font)
          (set-face-attribute 'fixed-pitch-serif f
                              :width 'normal :weight 'normal
                              :slant 'normal :font font)
          (if keep-size
              (modify-frame-parameters
               f
               (list (cons 'height (round height (frame-char-height f)))
                     (cons 'width  (round width  (frame-char-width f)))))))))
    (run-hooks 'after-setting-font-hook 'after-setting-font-hooks)))



(after! face-remap
  ;; Patch this function to cover more fonts
  (defun global-text-scale-adjust (increment)
  "Change (a.k.a. \"adjust\") the font size of all faces by INCREMENT.

Interactively, INCREMENT is the prefix numeric argument, and defaults
to 1.  Positive values of INCREMENT increase the font size, negative
values decrease it.

When you invoke this command, it performs the initial change of the
font size, and after that allows further changes by typing one of the
following keys immediately after invoking the command:

   \\`+', \\`='   Globally increase the height of the default face
   \\`-'      Globally decrease the height of the default face
   \\`0'      Globally reset the height of the default face

(The change of the font size produced by these keys depends on the
final component of the key sequence, with all modifiers removed.)

Buffer-local face adjustments have higher priority than global
face adjustments.

The variable `global-text-scale-adjust-resizes-frames' controls
whether the frames are resized to keep the same number of lines
and characters per line when the font size is adjusted.

See also the related command `text-scale-adjust'.  Unlike that
command, which scales the font size with a factor,
`global-text-scale-adjust' scales the font size with an
increment."
  (interactive "p")
  (when (display-graphic-p)
    (unless global-text-scale-adjust--default-height
      (setq global-text-scale-adjust--default-height
            (face-attribute 'default :height)))
    (let* ((key (event-basic-type last-command-event))
           (echo-keystrokes nil)
           (cur-def (face-attribute 'default :height))
           (inc
            (pcase key
              (?- (* (- increment)
                     global-text-scale-adjust--increment-factor))
              (?0 (- global-text-scale-adjust--default-height cur-def))
              (_ (* increment
                    global-text-scale-adjust--increment-factor))))
           (new (+ cur-def inc)))
      (when (< (car global-text-scale-adjust-limits)
               new
               (cdr global-text-scale-adjust-limits))
        (let ((frame-inhibit-implied-resize
               (not global-text-scale-adjust-resizes-frames)))
          (set-face-attribute 'default nil :height new)
          (set-face-attribute 'variable-pitch nil :height new)
          (set-face-attribute 'fixed-pitch nil :height new)
          (set-face-attribute 'fixed-pitch-serif nil :height new)
          (redisplay 'force)
          (when (and (not (and (characterp key) (= key ?0)))
                     (= cur-def (face-attribute 'default :height)))
            (setq global-text-scale-adjust--increment-factor
                  (1+ global-text-scale-adjust--increment-factor))
            (global-text-scale-adjust increment))))
      (when (characterp key)
        (set-transient-map
         (let ((map (make-sparse-keymap)))
           (dolist (mod '(() (control meta)))
             (dolist (key '(?+ ?= ?- ?0))
               (define-key map (vector (append mod (list key)))
                 'global-text-scale-adjust)))
           map)
       nil nil
       "Use %k for further adjustment"))))))
