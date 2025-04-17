;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-



(setopt user-full-name "Eyoel Tesfu")
(setopt user-mail-address "eyoelytesfu@gmail.com")

(after! package
  (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/")))

;;; Better defaults
(mouse-avoidance-mode 'banish)
(setopt bookmark-default-file (concat doom-user-dir "bookmarks"))
(setopt bookmark-fringe-mark nil)
(setopt history-delete-duplicates t)
(setopt bookmark-save-flag 1)
(setopt make-pointer-invisible t)
(setopt line-spacing nil)
(setopt read-process-output-max (* 1024 1024)) ; 1mb
(setopt display-line-numbers-type nil)
(setopt display-time-day-and-date t)
(setq-default display-line-numbers-width 4)  ; min default width
(setopt display-line-numbers-width-start nil)  ; automatically calculate the `display-line-numbers-width' on buffer start
                                        ; width (empty space) grows to the left of the numbers
(setq-default cursor-in-non-selected-windows nil)
(setopt insert-default-directory t)
(setopt auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))
(setopt comment-empty-lines t)
(setq-default truncate-lines t)

(setopt load-prefer-newer t)
(setopt scroll-conservatively 0)
(setopt scroll-step 0)
(setopt scroll-preserve-screen-position 'always)
(setopt scroll-margin 0)
(setopt jit-lock-defer-time nil) ; don't defer fontification
;; (display-time-mode 1)
(global-subword-mode 1)
(pixel-scroll-precision-mode 1)
(repeat-mode 1)

(setopt doom-leader-alt-key-states '(normal visual motion insert emacs))

(setopt auto-save-default nil)

(setopt auto-save-visited-interval 10)
(auto-save-visited-mode 1)

(setopt find-function-C-source-directory "/mnt/c/Users/Eyu/Projects/probe/emacs/src")

(setopt tab-first-completion nil)



(setq
 doom-theme 'eyth-doom-vibrant
 doom-font (font-spec
            :family "JetBrainsMono Nerd Font"
            :size 19
            :weight 'regular)

 doom-variable-pitch-font (font-spec
                           :family (font-get doom-font :family)
                           :size (font-get doom-font :size)
                           :weight (font-get doom-font :weight))

 ;;; sans-serif font to use wherever the `fixed-pitch-serif' face is used
 doom-serif-font (font-spec
                  :family (font-get doom-variable-pitch-font :family)
                  :size (font-get doom-variable-pitch-font :size)
                  :weight (font-get doom-variable-pitch-font :weight))

 nerd-icons-font-names '("NFM.ttf"
                         ;; "Symbols Nerd Font Mono.ttf"
                         ))



(setq projectile-project-search-path '("/mnt/c/Users/Eyu/Projects/"
                                       "/mnt/c/Users/Eyu/AndroidStudioProjects/"
                                       "/mnt/c/Users/Eyu/RustroverProjects/"))

(after! doom-themes
  (setq doom-themes-enable-bold nil   ; if nil, bold is universally disabled
        doom-themes-enable-italic nil ; if nil, italics is universally disabled
        doom-font-increment 1))



(setq global-text-scale-adjust--increment-factor 1 ; default = 5
      text-scale-mode-step 1.04)



(use-package! page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'emacs-news-mode)
  (global-page-break-lines-mode 1))



;; Search accurately for # and * symbols
(use-package! evil
  :init
  (setq evil-symbol-word-search t
        evil-ex-search-case 'insensitive ; was 'smart
        +evil-want-o/O-to-continue-comments nil
        ;; evil-want-C-i-jump t
        evil-want-C-u-delete nil
        evil-want-minibuffer t
        evil-respect-visual-line-mode nil
        evil-kill-on-visual-paste nil
        evil-move-cursor-back t
        evil-want-fine-undo t))



(map!
 :nvm "<up>"   #'evil-previous-visual-line
 :o   "<up>"   #'evil-previous-line
 :nvm "<down>" #'evil-next-visual-line
 :o   "<down>" #'evil-next-line
 :nvm "<home>" #'evil-beginning-of-visual-line
 :nvm "<end>"  #'evil-end-of-visual-line)



(defun ey/evil-do-insert-state--advice (&rest _)
  (if (not (evil-insert-state-p))
      (evil-insert-state)))

(defun doom/delete-forward-word (arg)
  "Like `kill-word', but doesn't affect the kill-ring."
  (interactive "p")
  (let ((kill-ring nil) (kill-ring-yank-pointer nil))
    (ignore-errors (kill-word arg))))

(map! "C-<backspace>" #'doom/delete-backward-word
      "<backspace>" #'evil-delete-backward-char-and-join
      "C-S-<backspace>" #'doom/delete-forward-word)

(advice-add 'doom/delete-forward-word :after #'ey/evil-do-insert-state--advice)
(advice-add 'doom/delete-backward-word :after #'ey/evil-do-insert-state--advice)
(advice-add 'evil-delete-backward-char-and-join :before #'ey/evil-do-insert-state--advice)



;;; Disable the evil-mode line indicator in the ex section
(setq evil-echo-state nil)

(defun ey/add-stuff-to-default-buffer-alist ()
  "Add values to `default-frame-alist'"
  (add-to-list 'default-frame-alist '(width . (text-pixels . 2200)))
  (add-to-list 'default-frame-alist '(height . (text-pixels . 1500)))
  (add-to-list 'default-frame-alist '(top . 0))
  (add-to-list 'default-frame-alist '(left . 0))
  (add-to-list 'default-frame-alist '(internal-border-width . 20))
  (add-to-list 'default-frame-alist '(undecorated . t))
  (add-to-list 'default-frame-alist '(tool-bar-lines . 0))
  (add-to-list 'default-frame-alist '(alpha . 90)))



;; Put all backup files into a separate place
(setq backup-by-copying t)
(make-directory "~/.emacs_backups/" t)
(make-directory "~/.emacs_autosave/" t)
(setq backup-directory-alist '(("." . "~/.emacs_backups/")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs_autosave/" t)))
(setq vc-make-backup-files t)

(setq trash-directory "~/.local/share/trash/")
(setq delete-by-moving-to-trash (not noninteractive))

(setq eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)
;; (setq eldoc-documentation-strategy 'eldoc-documentation-default)



;;; Dirvish Dired Mode
(after! dirvish
  (setq dirvish-reuse-session t) ; MAY BREAK???
  (setq dirvish-subtree-always-show-state nil)
  ;; (setq dirvish-override-dired-mode t)
  (setq dirvish-attributes '(file-size nerd-icons))
  ;; (setq dirvish-attributes (remove-from-list dirvish-attributes '(subtree-state vc-state)))
  (setq dirvish-mode-line-format
            '(:left (sort file-time symlink) :right (omit yank index))
            ;; '(:left (sort omit symlink) :right (index)) ; default
  )
  (setq dirvish-use-header-line nil
        dirvish-use-mode-line t)

  (map! :map dirvish-mode-map
        :gm [left]  nil
        :gm [right] nil
        :gm "g <left>" #'dirvish-subtree-up
        :n  "z" nil))

;;; Dired Customizations
(after! dired
  (setq dired-free-space 'first)
  (setq dired-kill-when-opening-new-dired-buffer t))

(after! diredfl
  (remove-hook 'dired-mode-hook #'diredfl-mode)
  (remove-hook 'dirvish-directory-view-mode-hook #'diredfl-mode))

(after! dired-x ; provides dired omit mode
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))



;;; Turn off highlighting the whole line the cursor is at
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

;;; Turn off automatic spell checker
(remove-hook 'text-mode-hook         #'spell-fu-mode)

(remove-hook 'org-mode-hook          #'flyspell-mode)
(remove-hook 'markdown-mode-hook     #'flyspell-mode)
(remove-hook 'TeX-mode-hook          #'flyspell-mode)
(remove-hook 'rst-mode-hook          #'flyspell-mode)
(remove-hook 'mu4e-compose-mode-hook #'flyspell-mode)
(remove-hook 'message-mode-hook      #'flyspell-mode)
(remove-hook 'git-commit-mode-hook   #'flyspell-mode)

;; Custom font and background colors
(custom-set-faces!
  ;; '(default :inherit tree-sitter-hl-face:variable) ; #FBF1C7 #EBDBB2
  ;; '(tree-sitter-hl-face:variable :inherit default) ; Variable Initialization Faces
  ;; '(org-block :foreground (face-attribute 'default :foreground))
  ;; '(org-ellipsis :underline nil)
  ;; '(cursor :background nil :foreground nil)
  ;; '(font-lock-string-face) ; Strings
  ;; '(font-lock-variable-name-face) ; names #83A598 #FCFCFF
  ;; '(font-lock-keyword-face) ; Language Keywords
  ;; '(font-lock-comment-face; Comments #555555
  ;; '(font-lock-type-face) ; Data-types #AF3A03
  ;; '(font-lock-constant-face) ; Constants
  ;; '(font-lock-function-name-face) ; Function and Methods
  ;; '(region) ; Text selection (highlighted text)
  ;; '(line-number ) ; Line Number
  ;; '(line-number-current-line) ; Current line number
  ;; '(mode-line) ; Active mode line
  ;; '(mode-line-inactive) ; Inactive mode line
  '(org-headline-done :foreground "#5B6268")
  ;; '(org-done :inherit org-headline-done :weight bold)
  '(italic :slant normal) ; Disable italics
  ;; '(italic nil) ; Enable italics
  )

;; (setq pop-up-frames nil)
;; (setq pop-up-windows nil)



(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))



(setq org-agenda-custom-commands
      '(
        ("n" "What I need to Do NEXT"
         ((agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-span 7)
                      (org-agenda-show-current-time-in-grid t)
                      ;; (org-agenda-timegrid-use-ampm t)
                      ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                      (org-agenda-start-with-log-mode 1)
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-skip-scheduled-if-done t) ; default nil
                      (org-agenda-show-log t)
                      ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                      ))
          (tags-todo "EVERYDAY")
          (tags-todo "URGENT")
          (tags-todo "IMPORTANT")
          (tags-todo "PROMISE")
          (tags-todo "MILD")
          (tags-todo "MISC")
          ;; (tags-todo "-{.*}") ; untagged

          ;; Most important tags (and views) I can think of (I usually deadline/schedule those I really want to do anyways)
          ;; -> MUST_BE_DONE_SOON
          ;; -> MUST_BE_DONE_EVERYDAY
          ;; -> MAY_BE_DONE_ON_IDLE_TIME
          ;; * Unscheduled AND Undeadlined view
          ;; * Untagged view

          ;; (tags-todo "@ACTIONABLE")
          ;; (tags-todo "@2MIN_ACTION")
          ;; (tags-todo "@MAYBE_SOMEDAY_ACTIONABLE")
          ;; (tags-todo "WORK_ON_PC")
          ;; (tags-todo "HOME_TASK")

          ;; (tags-todo "@NextAction")
          ;; (tags-todo "@SomedayMaybe")
          ;; (tags-todo "@ContextHome")
          ;; (tags-todo "@ContextComputer")
          ;; (tags-todo "@ReferenceJustInCase")
          ;; (tags-todo "@Routine")
          ;; (tags-todo "@Review")
          )
         nil)
        ("d" "What I need to Do NEXT TODAY, also DONE's"
         ((agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-span 7)
                      (org-agenda-show-current-time-in-grid t)
                      (org-agenda-timegrid-use-ampm t)
                      ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-skip-scheduled-if-done t) ; default nil
                      (org-agenda-start-with-log-mode 1)
                      (org-agenda-log-mode-items '(state closed clock))
                      (org-agenda-show-log t)
                      ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                      ))
          (tags-todo "EVERYDAY")
          )
         nil)
        ("x" "What I need to Do NEXT TODAY"
         ((agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-span 7)
                      (org-agenda-show-current-time-in-grid t)
                      (org-agenda-timegrid-use-ampm t)
                      ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-skip-scheduled-if-done t) ; default nil
                      (org-agenda-start-with-log-mode 0)
                      ;; (org-agenda-show-log nil)
                      ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                      ))
          (tags-todo "EVERYDAY")
          )
         nil)
        ("u" "Untagged"
         ((tags-todo "-{.*}"))
         )
        ))



(setq org-agenda-prefix-format

      ;; What works = (%) + (s/T/t/b) (scheduled/deadline string | TAGS | time | title of higher level)
      ;; (%) + (c/e/l/i) = (category from file name | effort required | level of item | icon )
      ;; Choose one from the below

      ;; '((agenda . "     %i  %s ")
      ;;   (todo . " %i %-12:c")
      ;;   (tags . " %i %-12:c")
      ;;   (search . " %i %-12:c")))

      ;; '((agenda . " %i %-12:c%?-12t% s")
      ;;   (todo . " %i %-12:c")
      ;;   (tags . " %i %-12:c")
      ;;   (search . " %i %-12:c")))

      ;; '((agenda . "        %s   ")
      ;;   (todo . " %i %-12:c")
      ;;   (tags .   "      %i ")
      ;;   (search . " %i %-12:c")))

      '((agenda . "        %s ")
         (todo .  "        %s ")        ; CURRENT DEFAULT
         (tags .  "      %i    ")
         (search ." %i %-12:c ")))

      ;; '((agenda . " %-6e| ")
      ;;   (todo . " %-6e| ")
      ;;   (tags . " %-6e| ")
      ;;   (search . " %-6e| ")))



;;; Time stamp done todos
(setq org-log-done 'time)

(setq
 org-agenda-tags-column 0
 org-agenda-deadline-leaders '(" D" "%2d" "%2d")
 ;; org-agenda-scheduled-leaders '("|" "p")
 org-agenda-scheduled-leaders '(" |" "%2d")
 org-tag-faces
 '(
   ("EVERYDAY" :foreground "blue")
 ;;   ("IMPORTANT" :foreground "purple")
 ;;   ("URGENT" :foreground "red")
 ;;   ("PROMISE" :foreground "cyan")
 ;;   ("MILD" :foreground "green")
 ;;   ("MISC" :foreground "yellow")
   )
 ;; org-agenda-todo-keyword-format "%-1s"
 )

;;; Org Agenda View customizations
(setq org-agenda-span 7 ; default 10
      org-agenda-start-on-weekday 1
      ;; org-agenda-start-day "+0d" ; default "-3d"
      org-agenda-skip-timestamp-if-done nil ; default nil (Closed and Clocked timestamps)
      org-agenda-skip-deadline-if-done t ; default nil
      org-agenda-skip-scheduled-if-done t ; default nil
      org-agenda-skip-scheduled-if-deadline-is-shown t ; default nil
      org-agenda-skip-timestamp-if-deadline-is-shown t ; default nil
      ;; org-agenda-start-with-log-mode 1
      org-agenda-skip-scheduled-delay-if-deadline t
      org-deadline-warning-days 0 ; Warn me when there are %d days away
      org-scheduled-past-days 10000 ; make it 0 if you dont want to see scheduled points past the scheduled date
      org-deadline-past-days 10000
      org-agenda-use-time-grid t
      org-agenda-time-grid
      '((daily today)
        (0000 0100 0200 0300 0400
              0500 0600 0700 0800
              0900 1000 1100 1200
              1300 1400 1500 1600
              1700 1800 1900 2000
              2100 2200 2300 2400)
        " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"
        )
      org-agenda-current-time-string "← now ───────────────────────────────────────────────"
      org-hide-emphasis-markers t
      org-agenda-sorting-strategy '(
                                    ;; (agenda habit-down time-up urgency-down priority-down)
                                    ;; (todo urgency-down priority-down time-down)
                                    (tags urgency-down priority-down)
                                    (search category-keep))
      )



(setq org-capture-templates
      '(

        ("t" "Personal todo" entry
         (file+headline +org-capture-todo-file "Inbox")
         "* [ ] %?\n%i\n%a" :prepend t)
        ("n" "Personal notes" entry
         (file+headline +org-capture-notes-file "Inbox")
         "* %u %?\n%i\n%a" :prepend t)
        ("j" "Journal" entry
         (file+olp+datetree +org-capture-journal-file)
         "* %U %?\n%i\n%a" :prepend t)

        ("T" "Todo" entry (file "/mnt/c/Users/Eyu/AllMyFilesArch/org/log.org") "* TODO %?\n  SCHEDULED: %t\n  %i\n  %U\n" :prepend t)
        ("d" "Done" entry (file "/mnt/c/Users/Eyu/AllMyFilesArch/org/log.org") "* DONE %?\n  SCHEDULED: %t\n  %i\n  CLOSED: %U\n  %U\n" :prepend t)
        ("N" "Note" entry (file "/mnt/c/Users/Eyu/AllMyFilesArch/org/notes.org") "* %?\n  %i\n  %U\n" :prepend t)

        ("p" "Templates for projects")
        ("pt" "Project-local todo" entry
         (file+headline +org-capture-project-todo-file "Inbox")
         "* TODO %?\n%i\n%a" :prepend t)
        ("pn" "Project-local notes" entry
         (file+headline +org-capture-project-notes-file "Inbox")
         "* %U %?\n%i\n%a" :prepend t)
        ("pc" "Project-local changelog" entry
         (file+headline +org-capture-project-changelog-file "Unreleased")
         "* %U %?\n%i\n%a" :prepend t)
        ("o" "Centralized templates for projects")
        ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
        ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
        ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)

        ;; ("t" "todo" entry (file+headline "todo.org" "Inbox")
        ;;  "* [ ] %?\n%i\n%a"
        ;;  :prepend t)
        ;; ("d" "deadline" entry (file+headline "todo.org" "Inbox")
        ;;  "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
        ;;  :prepend t)
        ;; ("s" "schedule" entry (file+headline "todo.org" "Inbox")
        ;;  "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
        ;;  :prepend t)
        ;; ("c" "check out later" entry (file+headline "todo.org" "Check out later")
        ;;  "* [ ] %?\n%i\n%a"
        ;;  :prepend t)
        ;; ("l" "ledger" plain (file "ledger/personal.gpg")
        ;;  "%(+beancount/clone-transaction)")

        ))



;;; Org-Journal
(setq org-journal-dir "/mnt/c/Users/Eyu/AllMyFilesArch/journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-file-format "%Y.org"
      org-journal-file-type 'yearly
      org-journal-created-property-timestamp-format "%Y%m%d")



;;; HOW TO MANUALLY OPEN LSPs
;; - Remove lang "+lsp" in init.el (otherwise the config of the lsp for that language is going to be automatically defined by doom)
;; - Install emacs lsp package for that language though package.el
;; - No default configs are defined (only the package is downloaded)
;; - Manually download an lsp through the OS package manager and add to PATH var
;; - M-x lsp to jump start

(after! lsp-mode
  (setq
   lsp-enable-symbol-highlighting nil
   ;; lsp-enable-suggest-server-download t
   lsp-modeline-diagnostics-scope :file
   lsp-use-plists t)
  (map! :leader
        :desc "lsp symbol highlight"
        "t h" #'lsp-toggle-symbol-highlight))

;;; Remove opening automatic tide server when opening rjsx/tsx/web-mode files
(remove-hook! '(typescript-mode-local-vars-hook
                typescript-tsx-mode-local-vars-hook
                web-mode-local-vars-hook
                rjsx-mode-local-vars-hook)
  '+javascript-init-lsp-or-tide-maybe-h) ; initialize tide-mode using `tide-setup'

;; C/C++ Lsp; I want to manually invoke the lsp if I want to
(remove-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

(remove-hook 'c-mode-local-vars-hook #'lsp!)
(remove-hook 'c++-mode-local-vars-hook #'lsp!)
(remove-hook 'objc-mode-local-vars-hook #'lsp!)
(remove-hook 'cmake-mode-local-vars-hook #'lsp!)
(remove-hook 'cuda-mode-local-vars-hook #'lsp!)

(map! :map c-mode-base-map "TAB" nil) ; I want to jump between bracket characters

(use-package! lsp-pyright ; TODO: Test if working
  :defer t
  :init
  (when (executable-find "basedpyright")
    (setq lsp-pyright-langserver-command "basedpyright")))

(use-package! lsp-java
  :defer t
  :preface
  (setq lsp-java-workspace-dir (concat doom-data-dir "java-workspace"))
  ;; (add-hook 'java-mode-local-vars-hook #'lsp! 'append)
  :config
  ;; Ensure the directories are correctly concatenated
  (setq lsp-jt-root (concat lsp-java-server-install-dir "java-test/server/")
        dap-java-test-runner (concat lsp-java-server-install-dir "test-runner/junit-platform-console-standalone.jar"))
  ;; Additional settings
  (setq lsp-java-references-code-lens-enabled t
        lsp-java-progress-reports-enabled t
        lsp-java-import-gradle-enabled t
        lsp-java-import-maven-enabled t))

(use-package! dap-java
  ;; :when (modulep! :tools debugger +lsp)
  :commands dap-java-run-test-class dap-java-debug-test-class
  :init
  (map! :after cc-mode ; where `java-mode' is defined
        :map java-mode-map
        :localleader
        (:prefix ("t" . "Test")
         :desc "Run test class or method"   "t" #'+java/run-test
         :desc "Run all tests in class"     "a" #'dap-java-run-test-class
         :desc "Debug test class or method" "d" #'+java/debug-test
         :desc "Debug all tests in class"   "D" #'dap-java-debug-test-class)))

(after! lsp-ui
  (setq
   lsp-ui-sideline-enable nil             ; no more useful than flycheck
   lsp-ui-doc-enable nil                  ; redundant with K
   lsp-ui-sideline-show-code-actions t    ; default: nil
   ;; lsp-signature-auto-activate
   lsp-signature-render-documentation t)) ; default: t



;;; Make company mode completion faster
(after! company
  (setq company-idle-delay nil) ; default was 0.2 ; value of nil means no idle completion
  (setq company-tooltip-idle-delay 0.5)) ; default was 0.5

;;; Corfu completion
(after! corfu
  (setq
   corfu-preselect 'first
   corfu-auto nil
   corfu-preview-current nil
   corfu-quit-at-boundary 'separator
   +corfu-want-tab-prefer-expand-snippets t
   +corfu-want-tab-prefer-navigating-snippets t
   +corfu-want-tab-prefer-navigating-org-tables t
   corfu-on-exact-match 'insert
   corfu-auto-delay 0.24
   corfu-quit-no-match nil
   corfu-min-width 30
   global-corfu-modes '((not erc-mode circe-mode help-mode gud-mode vterm-mode)
                        t)))

(add-hook! 'org-load-hook :append
  (defun +org-fix-keybindings ()
    (map! :map org-mode-map
          :ie [tab] nil)
    ;; (yas-minor-mode +1)
    ))

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(map!
 :i "C-u" #'evil-scroll-up
 :i "C-d" #'evil-scroll-down
 :nvi "C-t" #'+workspace/display)

(map!
 "S-<up>" #'scroll-down-line
 "S-<down>" #'scroll-up-line
 "S-<left>" #'evil-scroll-left
 "S-<right>" #'evil-scroll-right)

;;; Window Selection mapping
(map! :leader
 :nm "<left>"        #'evil-window-left
 :nm "<right>"       #'evil-window-right
 :nm "<up>"          #'evil-window-up
 :nm "<down>"        #'evil-window-down

 :nm "w M"           #'doom/window-maximize-buffer

 ;; Workspace Switcher, esp useful in tty mode
 :nm "TAB <left>"    #'+workspace/switch-left
 :nm "TAB <right>"   #'+workspace/switch-right

 ;; Workspace Swapper
 :nm "TAB S-<left>"  #'+workspace/swap-left
 :nm "TAB S-<right>" #'+workspace/swap-right

 :nm "1"             #'+workspace/switch-to-0
 :nm "2"             #'+workspace/switch-to-1
 :nm "3"             #'+workspace/switch-to-2
 :nm "4"             #'+workspace/switch-to-3
 :nm "5"             #'+workspace/switch-to-4
 :nm "6"             #'+workspace/switch-to-5)

(map!
 :nm "M-1"           #'+workspace/switch-to-0
 :nm "M-2"           #'+workspace/switch-to-1
 :nm "M-3"           #'+workspace/switch-to-2
 :nm "M-4"           #'+workspace/switch-to-3
 :nm "M-5"           #'+workspace/switch-to-4
 :nm "M-6"           #'+workspace/switch-to-5
 :nm "M-7"           #'+workspace/switch-to-6
 :nm "M-8"           #'+workspace/switch-to-7
 :nm "M-9"           #'+workspace/switch-to-8
 :nm "M-0"           #'+workspace/switch-to-final)

;;; Buffer Selection mapping
;; Remap SPC ` to Ctrl-Tab for switching buffers
(map! :nvi "C-<tab>" #'evil-switch-to-windows-last-buffer)

(map! :map embark-buffer-map "s" #'save-buffer)

;; remove C-h to give space for 'embark-prefix-help-command'
(map!
 :map doom-leader-map
 "w C-h" nil
 "b K" #'kill-buffer-and-window :desc "Kill buffer and window"
 "b Q" #'doom/kill-all-buffers :desc "Kill all buffers"
 :map evil-motion-state-map
 "C-w C-h" nil
 :map evil-window-map
 "C-h" nil
 :map general-override-mode-map
 ;; :ei "M-SPC w C-h" nil
 :nvm "SPC w C-h" nil

 :map magit-mode-map
 :nv "C-w C-h" nil)

;; S-<arrows> to move windows around
(map! :map doom-leader-map
      "w S-<up>"      #'+evil/window-move-up
      "w S-<down>"    #'+evil/window-move-down
      "w S-<left>"    #'+evil/window-move-left
      "w S-<right>"   #'+evil/window-move-right
      "w C-S-<left>"  #'winner-undo
      "w C-S-<right>" #'winner-redo)

(map! :leader
      "`" #'+popup/toggle) ; Global leader binding

(map! :leader
      :map general-override-mode-map
      :nvm "w t" #'transpose-frame)

(map! :nvi "M-u" #'downcase-word)
(map! :nvi "M-U" #'upcase-word)

(map! :leader
      :desc "Resume last search"    "'" #'vertico-repeat-select)



;;; Org files
(setq org-directory "/mnt/c/Users/Eyu/AllMyFilesArch/")
(setq org-id-locations-file "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/.orgids")
(setq org-roam-directory "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/")
(setq org-agenda-files '("/mnt/c/Users/Eyu/AllMyFilesArch/org/agenda2.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20240822232750-being_both_productive_and_having_fun_in_programming.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20240904214224-checklist_for_leetcode_topic_mastery.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20241014000641-job_application_tracking.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/current.org"))
(setq org-edit-src-content-indentation 0)
(setq org-archive-location ".archive/%s::")



(after! evil-org
  (map!
   :map evil-org-mode-map
   :mnv "g l" nil ; I want evil-lion-left to work
   :i "C-h" nil)) ; Disable annoying org-beginning-of-line ; TODO: Working?

(after! org
  (setq org-startup-folded 'fold)
  ;; (setq org-ellipsis " ▾")
  ;; (setq org-log-into-drawer t)

  (map!
   :map org-mode-map
   :mnv "g l" nil)) ; I want evil-lion-left to work

(after! org-cycle
  ;; (setq org-cycle-emulate-tab nil)
  )



;;; ENABLE GLOBAL TREE-SITTER AND HIGHLIGHTING
(add-hook 'doom-first-buffer-hook #'global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)



; Which-key configuration
(after! which-key
  (setq which-key-allow-imprecise-window-fit nil ; Ensures that which-key suggestions are fully visible
        which-key-side-window-max-height 0.99)) ; Maximizes the height of the which-key window to 99%

(defun ey/disable-which-key ()
  (which-key-mode -1) ; Use `(kbd "C-h")' instead
  (setq echo-keystrokes 0)) ; echoing keybinds in minibuffer area

(add-hook 'doom-first-file-hook #'ey/disable-which-key)



(after! gcmh
  ;; 32mb, or 64mb, or *maybe* 128mb, BUT NOT 512mb (the default value = 33554432)
  ;; (setq gcmh-high-cons-threshold  (* 64 1024 1024)))
  (setq gcmh-high-cons-threshold  (* 100 1024 1024))) ; default value = 33554432
(setq inhibit-compacting-font-caches nil)



;; Debuggers
(after! dap-mode
  ;; (add-to-list '+debugger--dap-alist '((:lang python) :after python :require dap-python))
  ;; (add-to-list '+debugger--dap-alist '((:lang cc)     :after (c-mode c++-mode)   :require (dap-lldb dap-gdb-lldb))) ; TODO: the :after here may be bad
  (require 'dap-python)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  (setq dap-python-debugger 'debugpy))

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i --simple-prompt")

(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

;; Remove automatic anaconda mode initiation `anaconda-mode'
(remove-hook 'python-mode-local-vars-hook '+python-init-anaconda-mode-maybe-h)



(defun ey/visual-to-last-non-blank-in-current-line ()
  "Visual mode and extend selection to the last non-blank char in the current line."
  (interactive)
  (unless (region-active-p)
    (let ((evil-move-cursor-back nil))
      (evil-normal-state 1)))
  (evil-visual-char)
  (doom/forward-to-last-non-comment-or-eol)
  (if (or (looking-at "[ \t\n]") (eobp))
      (evil-backward-char)))

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
    (doom/backward-to-bol-or-indent)))

(map!
 :nvim "C-S-a" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-e" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-i" #'ey/visual-to-first-non-blank-in-current-line

 :map vterm-mode-map
 :nvm "C-a" #'doom/backward-to-bol-or-indent)



;; Persp mode
(after! persp-mode
  (setq persp-auto-save-opt 0      ; 0 means no save, 1 means save on Emacs kill
        persp-auto-save-num-of-backups 7))



;; TAB-JUMP-OUT-MODE
(setq tab-jump-out-global-mode nil)



;; Set Clipboards
(setq save-interprogram-paste-before-kill t

      ;; interprogram-cut-function #'gui-select-text
      ;; interprogram-paste-function #'gui-sele
      select-active-regions nil
      select-enable-clipboard t
      select-enable-primary nil)



;; (setq evil-insert-state-cursor '(hollow))
(setq evil-insert-state-cursor '(box))

;; Number of blinks, infinite blinks for blink cursor mode when -1
(setq blink-cursor-blinks -1 ; my default -1
      blink-cursor-delay 0.2
      blink-cursor-interval 0.7) ; my default 0.7

;; Ensure blinking is disabled globally by default
(blink-cursor-mode -1)



;; Open Vterm popups from the right
(after! vterm
  ;; (add-hook 'vterm-mode-hook #'compilation-shell-minor-mode)
  ;; (remove-hook 'vterm-mode-hook #'compilation-minor-mode)
  (remove-hook! 'vterm-mode-hook #'hide-mode-line-mode)
  ;; (setq vterm-buffer-name-string "vterm %s")
  (setq vterm-buffer-name-string nil)
  (setq vterm-always-compile-module t)
  (setq vterm-max-scrollback 100000)

  (set-popup-rule! "*doom:vterm-popup:"
    :size 0.5
    :vslot -4
    :select t
    :quit nil
    :ttl nil
    ;; :side (ey/vterm-popup-side)
    :side 'bottom
    :modeline t)

  (map!
   :map vterm-mode-map
   :nvi "M-1"      #'+workspace/switch-to-0
   :nvi "M-2"      #'+workspace/switch-to-1
   :nvi "M-3"      #'+workspace/switch-to-2
   :nvi "M-4"      #'+workspace/switch-to-3
   :nvi "M-5"      #'+workspace/switch-to-4
   :nvi "M-6"      #'+workspace/switch-to-5
   :nvi "M-7"      #'+workspace/switch-to-6
   :nvi "M-8"      #'+workspace/switch-to-7
   :nvi "M-9"      #'+workspace/switch-to-8
   :nvi "M-0"      #'+workspace/switch-to-final

   :nv "C-<up>"    #'backward-paragraph
   :nv "C-<down>"  #'forward-paragraph
   :nv "C-<left>"  #'left-word
   :nv "C-<right>" #'right-word))



(after! compile
  (setq compilation-scroll-output nil)
  (setq compilation-auto-jump-to-first-error nil)
  (map! "<f6>"         #'recompile
        "C-M-<return>" #'recompile))



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
           (msg (format " in %.2f seconds\n" elapsed))
           (start (- (point-max) 1)))
      (with-current-buffer buffer
        (goto-char start)
        (insert (propertize msg 'face face))
        (add-face-text-property start (point) face)))))

(add-hook 'compilation-start-hook 'ey/compile-start-timer)
(add-hook 'compilation-finish-functions 'ey/compile-show-time)

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



(map! :map compilation-shell-minor-mode-map
      :ni "M-RET"           #'compile-goto-error

      ;; :ni "S-<iso-lefttab>" #'compilation-previous-error
      ;; :ni "<tab>"           #'compilation-next-error

      :ni "M-<up>"          #'compilation-previous-error
      :ni "M-<down>"        #'compilation-next-error

      :ni "M-<right>"       #'compilation-next-file
      :ni "M-<left>"        #'compilation-previous-file)



(set-popup-rule! "^\\*compilation\\*.*"
  :size 0.5
  :vslot -4
  :select t
  :quit nil
  :ttl nil
  :side 'bottom
  :modeline t)

(set-popup-rule! "^\\*helpful .*"
  :size 0.5
  :vslot -4
  :select t
  :quit nil
  :ttl 0
  :side 'bottom
  :modeline t)

;; Rustic compilation mode popup
(set-popup-rule!
  "^\\*rustic-compilation\\*$"
  :side 'bottom
  :size 0.5
  :select t
  ;; :vslot -1
  :vslot -4
  :quit nil
  :modeline t
  :ttl nil)

(set-popup-rule!
  "^\\*cargo-run\\*$"
  :side 'right
  :size 0.5
  :select t
  :vslot -4
  ;; :vslot -1
  :quit nil
  :modeline t
  :ttl nil)



;;; doom modeline
(after! doom-modeline
  (setq
   doom-modeline-buffer-encoding nil
   doom-modeline-modal t
   doom-modeline-enable-word-count nil
   doom-modeline-persp-name nil
   doom-modeline-minor-modes nil
   doom-modeline-env-version t
   doom-modeline-buffer-name t
   doom-modeline-indent-info nil
   ;; doom-modeline-buffer-file-name-style 'relative-from-project ;doom default
   ;; doom-modeline-buffer-file-name-style 'buffer-name
   doom-modeline-buffer-file-name-style 'file-name-with-project
   ;; doom-modeline-time-analogue-clock t
   doom-modeline-time-live-icon nil
   doom-modeline-time-icon nil          ; the small analogue icon
   doom-modeline-major-mode-icon nil
   ;; (doom-modeline-def-modeline 'main
   ;;   '(matches bar modals workspace-name window-number persp-name selection-info buffer-info remote-host debug vcs matches)
   ;;   '(github mu4e grip gnus check misc-info repl lsp " "))) ; TODO: Experiment with this later
   doom-modeline-vcs-max-length 60))



;;; Modeline in popups
(plist-put +popup-defaults :modeline t)
;; Completely disable management of the mode-line in popups:
(remove-hook '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)



(defun open-url-in-min-browser (url &rest _args)
  "Open URL in min-browser using xdg-open while temporarily unsetting DISPLAY."
  (let ((min-browser-path "/mnt/c/Users/Eyu/AppData/Local/min/min.exe")
        (process-environment (copy-sequence process-environment))) ; Create a copy of the environment
    (setenv "DISPLAY" nil) ; Temporarily unset DISPLAY
    (start-process "xdg-open" nil "xdg-open" url)))

;; (setq browse-url-browser-function 'open-url-in-min-browser)
(setq browse-url-browser-function 'browse-url-default-browser)



;; Enhanced web-search
(defun google-search (query)
  "Search Google for the QUERY. Use selected text as the default input if available."
  (interactive
   (let ((selected-text (if (use-region-p)
                            (buffer-substring-no-properties (region-beginning) (region-end)))))
     (list (read-string "Google search: " selected-text))))
  (cond
   ((string-match-p "^https?://" query)
    (open-url-in-min-browser query))
   ((equal query "")
    (open-url-in-min-browser query))
   (t
    (open-url-in-min-browser
     (concat "https://www.google.com/search?q=" (url-hexify-string query))))))

(map!
 :neovimrg "C-q" #'google-search)
 ;; :neovimrg "C-'" #'



(add-hook! prog-mode-hook #'hs-minor-mode)

(map!
 :n "z i" #'hs-hide-all
 :n "z u" #'hs-show-all
 :n "z p" #'hs-toggle-hiding)



;; Org-download clipboard for wsl2
(defun ey/yank-image-from-win-clipboard-through-powershell ()
  "Yank an image from the Windows clipboard through PowerShell in WSL2 and
insert it into the current buffer."
  (interactive)
  (let* ((powershell "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
         (file-name (format-time-string "screenshot_%Y%m%d_%H%M%S.png"))
         (file-path-powershell (concat "C:/Users/Public/" file-name))
         (file-path-wsl (concat "./images/" file-name))
         (file-path-wsl-absolute (concat (expand-file-name default-directory) "images/" file-name)))
    ;; Ensure the target directory exists
    (unless (file-exists-p "./images/")
      (make-directory "./images/"))
    ;; Save the image from the clipboard to the temporary directory
    (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save('" file-path-powershell "')\""))
    ;; Wait a moment to ensure the file is created
    (sit-for 1)
    ;; Check if the file was created successfully
    (if (file-exists-p (concat "/mnt/c/Users/Public/" file-name))
        (progn
          ;; Rename (move) the file to the current directory
          (rename-file (concat "/mnt/c/Users/Public/" file-name) file-path-wsl-absolute)
          ;; Insert the file link into the buffer
          (insert (concat "[[file:" file-path-wsl "]]"))
          (message "Insert DONE."))
      (message "Error: The file was not created by PowerShell."))))

(map! :leader
      :desc "Insert image"
      "i i" #'ey/yank-image-from-win-clipboard-through-powershell)



(after! unicode-fonts
  (push "Symbola" (cadr (assoc "Miscellaneous Symbols" unicode-fonts-block-font-mapping))))



;;; Popup disables diff-hl-mode, so remove it
(add-hook! '+popup-buffer-mode-hook #'+popup-adjust-fringes-h)
;; (remove-hook! '+popup-buffer-mode-hook #'+popup-adjust-fringes-h)
;; +popup-adjust-margins-h is the function that turns off diff-hl vc-gutter in doom emacs, when popup gets closed
;; (add-hook! '+popup-buffer-mode-hook #'+popup-adjust-margins-h)
(remove-hook! '+popup-buffer-mode-hook #'+popup-adjust-margins-h)



;; Read and translate Terminal Sequences
(defun ey/set-input-decoder-mappings ()
  "Set my bindings for Emacs in Terminal"
  (define-key input-decode-map "\C-@"      (kbd "C-SPC"))
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
  (define-key input-decode-map "\e[134;5u" (kbd "C-S-e")))

(defun ey/apply-custom-behav-to-client (frame)
  "Add functions to be evaluated on a new frame when using emacsclient"
  (with-selected-frame frame
    (ey/set-input-decoder-mappings)
    (ey/add-stuff-to-default-buffer-alist)))

(if (daemonp)
    (add-hook 'after-make-frame-functions #'ey/apply-custom-behav-to-client)
  (ey/set-input-decoder-mappings)
  (ey/add-stuff-to-default-buffer-alist))



(setq treemacs-persist-file nil)

(use-package! drag-stuff
  :defer t
  :init
  (map! "<M-up>"    #'drag-stuff-up
        "<M-down>"  #'drag-stuff-down
        "<M-left>"  #'drag-stuff-left
        "<M-right>" #'drag-stuff-right))



(after! magit
  (setq magit-diff-refine-hunk t)
  (setq magit-log-section-commit-count 20)
  (map! :map magit-section-mode-map
        :n "C-<tab>" #'evil-switch-to-windows-last-buffer
        :n "S-<iso-lefttab>" #'magit-section-cycle
        :n "C-S-<iso-lefttab>" #'magit-section-cycle-global
        :map magit-status-mode-map
        :n "M-RET"   #'magit-diff-visit-worktree-file-other-window
        :n "S-<return>"   #'magit-diff-visit-worktree-file-other-window))

(setq code-review-auth-login-marker 'forge)



(defun ey/find-file-under-selection ()
  "Open `find-file` with the current selection (if any) as the default filename."
  (interactive)
  (let* ((selection (if (use-region-p)
                        (buffer-substring-no-properties (region-beginning) (region-end))
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

(map! :leader
      :desc "Find file under selected text"
      "f o" #'ey/find-file-under-selection)



(defun ey/open-duplicate-window-and-search ()
  "Open a new window with the same buffer and prompt for search term
After search term is found, jump back"
  (interactive)
  (if (> (frame-pixel-width) (/ (display-pixel-width) 2))
      (split-window-right)
    (split-window-below))
  (other-window 1)
  (switch-to-buffer (buffer-name))
  (call-interactively '+default/search-buffer)
  (other-window -1))

(map! :leader
      :desc "Search on other window"
      "s w" #'ey/open-duplicate-window-and-search)



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

(map! :leader
      :desc "Find all files"
      "l f" #'ey/find-files-recursively
      :desc "Find all files and folders"
      "l a" #'ey/find-all-dirs-and-files-recursively)



(setq duplicate-line-final-position 1)
(map! "C-S-d" #'duplicate-dwim)



;; TODO: Add option to find hidden files using universal argument prefix
(defun ey/consult-fd-or-find (&optional proj-dir initial)
  "Runs consult-fd if fd version > 8.6.0 exists, consult-find otherwise.
See minad/consult#770."
  (interactive "P")
  (let* ((selection (if (use-region-p)
                        (buffer-substring-no-properties (region-beginning) (region-end))
                      nil))
         (initial-input (cond
                         (selection selection)
                         (initial initial)
                         (t "** "))))
    (if (when-let* ((bin (if (ignore-errors (file-remote-p default-directory nil t))
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

(map! :leader
      :desc "Consult fd"
      "f d" #'ey/consult-fd-or-find)



;; emacs-lsp-booster
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



(defun ey/consult-ripgrep-with-live-preview ()
  "Search using consult-ripgrep with live preview."
  (interactive)
  ;; Run consult-ripgrep with live preview enabled
  (let ((selected-text (when (use-region-p)
                         (buffer-substring-no-properties (region-beginning) (region-end)))))
    (if selected-text
        (progn
          (deactivate-mark)
          (minibuffer-with-setup-hook
              (lambda () (insert selected-text))
            (consult-ripgrep default-directory)))
      (consult-ripgrep default-directory))))

(map! :leader "r g" #'ey/consult-ripgrep-with-live-preview)
(map! :leader "r f" #'consult-line)



(after! better-jumper
  ;; (setq better-jumper-use-savehist nil)
  ;; (setq better-jumper-savehist t) ; Gives sequence-p ERROR
  ;; (remove-hook! 'better-jumper-pre-jump-hook #'better-jumper-set-jump)
  (setq better-jumper-context 'window))



;; add jumper position after search
(defun +default/search-buffer ()
  "Conduct a text search on the current buffer."
  (interactive)
  (better-jumper-set-jump)
  (let (start end multiline-p)
    (save-restriction
      (when (region-active-p)
        (setq start (region-beginning)
              end   (region-end)
              multiline-p (/= (line-number-at-pos start)
                              (line-number-at-pos end)))
        (deactivate-mark)
        (when multiline-p
          (narrow-to-region start end)))
      (cond ((or (modulep! :completion helm)
                 (modulep! :completion ivy))
             (call-interactively
              (if (and start end (not multiline-p))
                  #'swiper-isearch-thing-at-point
                #'swiper-isearch)))
            ((modulep! :completion vertico)
             (if (and start end (not multiline-p))
                 (consult-line
                  (replace-regexp-in-string
                   " " "\\\\ "
                   (doom-pcre-quote
                    (buffer-substring-no-properties start end))))
               (call-interactively #'consult-line))))
      (better-jumper-set-jump))))



;;; Keycast Mode
(use-package! keycast
  :commands keycast-mode
  :config
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (progn
          (add-hook 'pre-command-hook 'keycast--update t)
          (add-to-list 'global-mode-string '("" mode-line-keycast " ")))
      (remove-hook 'pre-command-hook 'keycast--update)
      (setq global-mode-string (remove '("" mode-line-keycast " ") global-mode-string))))
  (dolist (input '(self-insert-command org-self-insert-command))
    (add-to-list 'keycast-substitute-alist `(,input "." "Typing…")))
  (dolist (event '( mouse-event-p mouse-movement-p mwheel-scroll handle-select-window
                    mouse-set-point mouse-drag-region))
    (add-to-list 'keycast-substitute-alist `(,event nil))))



(after! go-mode
  (remove-hook!  'go-mode-hook #'go-eldoc-setup))



;; Safe local variables
;; (put '+word-wrap-mode 'safe-local-variable #'booleanp)



(defun ey/set-doom-theme (theme)
  "Set `doom-theme` to the selected THEME."
  (setq doom-theme theme))

(defun ey/set-custom-faces (&optional theme)
  (after! org-faces
    (set-face-attribute 'org-ellipsis nil :underline nil)
    ;; (set-face-attribute 'org-block nil :foreground (face-attribute 'default :foreground))
    )
  (after! hl-line
    (set-face-attribute 'hl-line nil :background nil)
    )
  (after! faces
    (set-face-attribute 'line-number-current-line nil :background nil) ; FIXME: This doesn't evaluate automatically. I have to evaluate it
    ;; (set-face-attribute 'line-number-current-line nil :inherit nil) ; FIXME: This doesn't evaluate automatically. I have to evaluate it
    (set-face-attribute 'bold nil :weight 'normal))) ; for package ef-themes

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

;;; Fixes Bug where `doom-theme' doesn't get updated after interactively changing themes
(advice-add 'consult-theme :after #'ey/set-doom-theme)
(advice-add 'consult-theme :after #'ey/set-custom-faces)
;; (advice-add 'consult-theme :after #'ey/reload-theme)



;; ?? The `margin' mode function seems to be the one that incites the hook to have the immediate diff-hl changes seen
(diff-hl-margin-mode 1) ; TODO: make sure this doesn't cause problems



(map! :map doom-leader-map
      :desc "Insert nerd icon"
      "i n" #'nerd-icons-insert)



(defun ey/org-agenda-goto-subtree ()
  "Go to the heading in org-agenda and narrow to the subtree."
  (interactive)
  (org-agenda-goto)
  (org-narrow-to-subtree))

(map!
 :map org-agenda-keymap
 :m "C-<return>" #'ey/org-agenda-goto-subtree
 :map org-agenda-mode-map
 :m "C-<return>" #'ey/org-agenda-goto-subtree)



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

(defun ey/positional-consult-imenu ()
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
  "Toggle between the original and a custom-positional `consult-imenu` setup.
If ARG is nil, toggle the current state:
  - Enable positional `consult-imenu` if it is disabled.
  - Disable positional `consult-imenu` if it is enabled.

If ARG is non-nil:
  - Disable positional `consult-imenu` if ARG is zero or negative.
  - Enable positional `consult-imenu` if ARG is positive, t, or anything other
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
          (fset 'consult-imenu (symbol-function 'ey/positional-consult-imenu))
          (message "Positional-consult-imenu enabled"))
      (progn
        ;; Revert to the original setup
        (setq consult-imenu-config ey/original-consult-imenu-config
              ey/positional-consult-imenu-enabled nil)
        (fset 'consult-imenu (symbol-function 'ey/original-consult-imenu))
        (message "Positional-consult-imenu disabled")))))

;; I couldn't preserve the font faces as they'd need more internal function changes

(ey/toggle-positional-consult-imenu 1)



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



(elfeed-org)
(setq rmh-elfeed-org-files (list
                            (concat org-directory "org/elfeed.org")))



(if (modulep! :completion vertico)
    (use-package! vertico-posframe
      :init (remove-hook 'vertico-mode-hook 'vertico-posframe-mode)))

(after! vertico
  ;; (setq vertico-count 4)
  (setq vertico-count 17)) ; default



(defun ey/set-doom-log-level-to-0 ()
  "Revert `doom-log-level' to zero: No logging at all"
  (setq doom-log-level 0))



;;; TODO: Assign a keybind to this
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
    (+popup/buffer)))



(defun ey/treemacs-toggle-preserve-workspace ()
  "Toggle the Treemacs pane without altering the workspace projects."
  (interactive)
  (if (treemacs-is-treemacs-window-selected?)
      (delete-window (treemacs-get-local-window))
    (treemacs)))

(map! :leader "o p" #'treemacs)



;; Original value: "Closed:    "
(defvar org-agenda-closed-prefix "  "
  "Prefix used for CLOSED items in the Org Agenda.")

;; Original value: "State:    "
(defvar org-agenda-state-prefix "  "
  "Prefix used for CLOSED items in the Org Agenda.")

(defvar org-agenda-clocked-prefix "Clocked:   "
  "Prefix used for CLOSED items in the Org Agenda.")

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
              (looking-at "\\*+[ \t]+\\([^\r\n]+\\)")
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
  "Search files containing PATTERN1 and find lines matching PATTERN2, via
ripgrep, recursively."
  (interactive
   (list
    (read-string "Search the files that contain (PATTERN1): ")
    (read-string "Search for (PATTERN2): ")))
  (let ((command (format "rg -l --null '%s' | xargs -0 rg -Hn '%s'"
                         (shell-quote-argument pattern1)
                         (shell-quote-argument pattern2))))
    (with-temp-buffer
      (call-process "sh" nil t nil "-c" command)
      (let ((results (split-string (buffer-string) "\n" t)))
        (if results
            (let* ((choice (completing-read "Select a match: " results))
                   (file-and-line (split-string choice ":"))
                   (file (car file-and-line))
                   (line (string-to-number (cadr file-and-line))))
              (find-file file)
              (goto-line line))
          (message "No matches found"))))))

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



(use-package! dumb-jump
  :init
  (setq xref-show-definitions-function #'consult-xref)
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
;; (setq dumb-jump-selector 'completing-read)
;; (setq dumb-jump-selector 'popup)



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

(after! evil-maps
  (map!
   :map evil-normal-state-map "C-p" #'ey/compile
   :map comint-mode-map :n "C-p" #'ey/compile
   :map evil-insert-state-map "C-p" #'ey/compile))



(defun ey/counsel-find-file-recursively (&optional ARG)
  "Find a file recursively under the current directory or project's root.
By default, it searches for non-hidden files.
With a universal argument, it includes hidden files and files in hidden directories."
  (interactive "P")
  (let* ((hidden-search (and ARG t))
         (default-directory (or
                             (and (doom-project-p) (doom-project-root))
                             default-directory)) ; Use project root if available
                                                 ; remove this 'let' to remove projectile functionality
         (command (cond
                   ((executable-find "fd")
                    (if hidden-search
                        "fd -H -d 99 -t f"
                      "fd -d 99 -t f"))
                   ((executable-find "find")
                    (if hidden-search
                        "find . -type f"
                      "find . -type f \\( ! -path '*/.*' \\)"))
                   (t
                    (error "Neither 'fd' nor 'find' command is available")))))
    (ivy-read "Find file recursively: "
              (split-string (shell-command-to-string command) "\n" t)
              :action (lambda (path)
                        (find-file (expand-file-name path)))
              :caller 'ey/counsel-find-file-recursively)))



(defun keymap-symbol (keymap)
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
  (message "%s" (keymap-symbol (current-local-map))))

(map! "C-," #'ey/get-local-keymap-name)



(map! :map minibuffer-local-shell-command-map
      "C-SPC" #'completion-at-point
      "TAB" #'completion-at-point)



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

(after! anaconda-mode
  (add-hook 'anaconda-mode-hook #'ey/add-anaconda-completion-to-local-capfs))



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

(advice-add '+default/yank-pop :around #'vterm-consult-yank-pop-action)



;;; Remove workspace names when switching workspaces (Overrides some doom code here)
(defun ey/define-workspace-functions ()
  (defun +workspace/switch-to (index)
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
                 (error "Not a valid index: %s" index)))))))

(add-hook 'doom-first-file-hook #'ey/define-workspace-functions)



(after! evil-snipe
  (setq evil-snipe-scope 'whole-buffer)
  (setq evil-snipe-repeat-scope 'whole-buffer))



;;; Setup the doom dashboard
(defun ey/doom-dashboard-draw-emacs-ascii-banner-fn ()
  (let* ((banner
          '(

            "████████╗██╗  ██╗███████╗    ██╗  ██╗ ██████╗ ██╗  ██╗   ██╗"
            "╚══██╔══╝██║  ██║██╔════╝    ██║  ██║██╔═══██╗██║  ╚██╗ ██╔╝"
            "   ██║   ███████║█████╗      ███████║██║   ██║██║   ╚████╔╝ "
            "   ██║   ██╔══██║██╔══╝      ██╔══██║██║   ██║██║    ╚██╔╝  "
            "   ██║   ██║  ██║███████╗    ██║  ██║╚██████╔╝███████╗██║   "
            "   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝   "
            "                                                            "
            "        ███████╗███╗   ███╗ █████╗  ██████╗███████╗         "
            "        ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝         "
            "        █████╗  ██╔████╔██║███████║██║     ███████╗         "
            "        ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║         "
            "        ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║         "
            "        ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝         "
            "                                                            "

            ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'ey/doom-dashboard-draw-emacs-ascii-banner-fn)

(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-loaded
        doom-dashboard-widget-footer))



(use-package! spacious-padding
  :config
  (setq spacious-padding-widths
        '(:internal-border-width 20
          :mode-line-width 6
          :right-divider-width 30
          :fringe-width 10))
  (setq spacious-padding-subtle-mode-line
      '(:mode-line-active error :mode-line-inactive shadow))
  (spacious-padding-mode 1))



(use-package! stillness-mode
  :config
  (stillness-mode 1))



(defun ey/evil-do-normal-state-w/o-cursor-jumpback (&rest _)
  (let ((evil-move-cursor-back nil))
    (if (not(evil-visual-state-p))
        (evil-normal-state))))

(advice-add 'mark-sexp :after #'ey/evil-do-normal-state-w/o-cursor-jumpback)


(after! visual-fill-column
  (setq visual-fill-column-enable-sensible-window-split t))

(defun ey/toggle-center-buffer-content ()
  "Center the contents of the buffer"
  (interactive)
  (require 'visual-fill-column)
  (if visual-line-fill-column-mode
      (progn
        (setq-local visual-fill-column-center-text nil)
        (visual-line-fill-column-mode -1))
    (progn
      (setq-local visual-fill-column-center-text t)
      (visual-line-fill-column-mode 1))))

(map! :leader "t C" #'ey/toggle-center-buffer-content)




(defvar streamer-mode nil
  "Whether streamer mode is on")

(defun ey/streamer-mode ()
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
