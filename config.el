;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

; Place your private configuration here! Remember, you do not need to run 'doom
; sync' after modifying this file!

; Unmap annoying maps
; (map! "C-_" nil)

(after! 'package
  (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/")))

; Cuz some version mismatch
; (straight-use-package 'org)

; Consult is my new favorite package

(setq display-line-numbers-type 'relative)

(setq
 ; doom-theme 'doom-spacegrey
 ; doom-theme 'kanagawa
 ; doom-theme 'eyth-kanagawa
 ; doom-theme 'doom-molokai
 ; doom-theme 'doom-oceanic-next
 ; doom-theme 'doom-tomorrow-night
 ; doom-theme 'doom-monokai-spectrum
 ; doom-theme 'doom-old-hope
 ; doom-theme 'leuven-dark
 ; doom-theme 'ef-bio
 doom-theme nil

 ; best terminal themes
 ; 'doom-gruvbox
 ; 'doom-material
 ; 'ef-dark
 ; 'doom-pine
 doom-font (font-spec
            ; Fav fonts: ComicShanns, Jetbrains, Iosevka, SF Mono, Victor Mono

            :family "Iosevka Nerd Font"
            :size 22
            :weight 'regular

            ; :family "ComicShannsMono Nerd Font"
            ; :size 21

            ; :family "Iosevka Nerd Font"
            ; :size 26
            ; :weight 'regular

            ; :family "Iosevka Comfy Fixed"
            ; :size 25
            ; :weight 'regular

            ; :family "Iosevka Nerd Font"
            ; :size 30
            ; :weight 'light

            ; :family "JetBrainsMono Nerd Font"
            ; :size 22
            ; :weight 'light

            ; :family "RobotoMono Nerd Font"
            ; :size 20
            ; :weight 'light

            ; :family "SFMono Nerd Font Mono"
            ; :size 23
            ; ;; :weight 'bold
            ; :weight 'semi-bold

            ; :family "DeJaVu SansM Nerd Font Mono"
            ; :size 20
            ; :weight 'light

            ; :family "VictorMono Nerd Font"
            ; :size 22
            ; :weight 'bold

            )

 doom-variable-pitch-font (font-spec
                           :family (font-get doom-font :family)
                           :size (font-get doom-font :size)
                           :weight (font-get doom-font :weight)
                           )

 ; doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
 ; doom-variable-pitch-font (font-spec :family "ETBookOT" :size 13)
 ; doom-variable-pitch-font (font-spec :family "Alegreya" :size 18)

 nerd-icons-font-names '(
                         "NFM.ttf"
                         ; "Symbols Nerd Font Mono.ttf"
                         )
 )

(setq projectile-project-search-path '(
                                       "/mnt/c/Users/Eyu/Projects/"
                                       "/mnt/c/Users/Eyu/AndroidStudioProjects/"
                                       "/mnt/c/Users/Eyu/RustroverProjects/"
                                       ))

(after! doom-themes
  (setq doom-themes-enable-bold nil   ; if nil, bold is universally disabled
        doom-themes-enable-italic nil ; if nil, italics is universally disabled
        doom-font-increment 1
        ))

(setq global-text-scale-adjust--increment-factor 1 ; default = 5
      text-scale-mode-step 1.04)

; (setq-default fringe-mode 1) ; Wrong (?)
(fringe-mode 0)
(set-fringe-mode 0) ; Is this needed??
; (setq-default left-fringe-width 4)

; Search accurately for # and * symbols
(setq evil-symbol-word-search t
      evil-ex-search-case 'insensitive ; was 'smart
      +evil-want-o/O-to-continue-comments nil
      ; evil-want-C-i-jump t
      )

; Disable the evil-mode line indicator in the ex section
(setq evil-insert-state-message   nil
      evil-replace-state-message  nil
      evil-visual-state-message   nil
      evil-normal-state-message   nil
      evil-motion-state-message   nil
      evil-operator-state-message nil)

; If you want "tabs" mode instead of "space": Use M-x indent-tabs-mode

; Set the default frame size
(after! frame
  (setq frame-inhibit-implied-resize t)
  (setq default-frame-alist
          '(
          ; (width . 180)   ; Width set to 184 columns
          ; (height . 48)   ; Height set to 57 lines (49 is old)
          ; (top . 55)
          (top . 0)
          (left . 0)
          (vertical-scroll-bars . nil)
          (horizontal-scroll-bars . nil)
          (internal-border-width . 20)
          ; (tool-bar-lines . 0)
          ; (undecorated . t) ; remove title bar

          ; (fullscreen . fullwidth) ; start emacs in full screen
          ; (fullscreen . fullboth) ; Window frame (outside of view)

          ; (alpha . 50)
          )))

; Keep buffers in sync with files, execute after idle 5 secs
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

; put all backup files into ~/MyEmacsBackups
(setq backup-by-copying t)
; (setq backup-directory-alist `((".*" . "/home/eyu/.local/share/Trash/files")))
; (setq auto-save-file-name-transforms `((".*" "/home/eyu/.local/share/Trash/files" t)))

(make-directory "~/.emacs_backups/" t)
(make-directory "~/.emacs_autosave/" t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs_autosave/" t)))
(setq backup-directory-alist '(("." . "~/.emacs_backups/")))


; Dired Customizations
(setq dired-kill-when-opening-new-dired-buffer t)

(defun remove-from-list (list elements-to-remove)
  "Remove ELEMENTS-TO-REMOVE from LIST."
  (seq-filter (lambda (item)
                (not (member item elements-to-remove)))
              list))

; Disable Dirvish Override Dired Mode by default
(after! dirvish
  (setq dirvish-override-dired-mode t)
  (setq dirvish-subtree-always-show-state nil)
  (setq dirvish-attributes (remove-from-list dirvish-attributes '(subtree-state vc-state)))
  ; (remove-hook! 'dired-mode-hook #'dired-omit-mode)

  (map! :map dirvish-mode-map
        :gm [left]  nil
        :gm [right] nil
        )
  )

; Line and Line number Highlighting
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

; Turn off spell checker globally when first loading doom
; (remove-hook 'doom-first-buffer-hook #'spell-fu-global-mode) ;? Works or not? If not, remove line
(remove-hook 'text-mode-hook         #'spell-fu-mode)

(remove-hook 'org-mode-hook          #'flyspell-mode)
(remove-hook 'markdown-mode-hook     #'flyspell-mode)
(remove-hook 'TeX-mode-hook          #'flyspell-mode)
(remove-hook 'rst-mode-hook          #'flyspell-mode)
(remove-hook 'mu4e-compose-mode-hook #'flyspell-mode)
(remove-hook 'message-mode-hook      #'flyspell-mode)
(remove-hook 'git-commit-mode-hook   #'flyspell-mode)

; Turn off highlighting the whole line the cursor is at
(after! hl-line
  ; (set-face-attribute 'line-number-current-line nil :inherit nil)
  )

; Custom font and background colors
(custom-set-faces!
  ; use "foreground" for every of the set faces
  ;'(default :inherit tree-sitter-hl-face:variable) ; #FBF1C7 #EBDBB2
  '(tree-sitter-hl-face:variable :inherit default)
  ;'(font-lock-string-face) ; Strings
  ;'(font-lock-variable-name-face) ; names #83A598 #FCFCFF
  ;'(font-lock-keyword-face) ; Language Keywords
  ;'(font-lock-comment-face; Comments #555555
  ;'(font-lock-type-face) ; Data-types #AF3A03
  ;'(font-lock-constant-face) ; Constants
  ;'(font-lock-function-name-face) ; Function and Methods
  ;'(region) ; Text selection (highlighted text)
  ;'(line-number ) ; Line Number
  ;'(line-number-current-line) ; Current line number
  ;'(mode-line) ; Active mode line
  ;'(mode-line-inactive) ; Inactive mode line
  '(org-headline-done :foreground "#5B6268")
  ;'(org-done :inherit org-headline-done :weight bold)
  '(italic :slant normal) ; Disable italics
  ;'(italic nil) ; Enable italics
  )

; (setq pop-up-frames nil)
; (setq pop-up-windows nil)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ; or :after org
;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;         a hookable mode anymore, you're advised to pick something yourself
;         if you don't care about startup time, use
;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(setq org-agenda-custom-commands
      '(
        ("n" "What I need to Do NEXT"
         ((agenda ""(
                     (org-agenda-start-day "+0d")
                     (org-agenda-start-on-weekday 1)
                     (org-agenda-span 7)
                     (org-agenda-show-current-time-in-grid t)
                     ; (org-agenda-timegrid-use-ampm t)
                     ; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                     (org-agenda-start-with-log-mode 1)
                     (org-agenda-skip-deadline-if-done t)
                     (org-agenda-skip-scheduled-if-done t) ; default nil
                     (org-agenda-show-log t)
                     ; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                     ))
          (tags-todo "EVERYDAY")
          (tags-todo "URGENT")
          (tags-todo "IMPORTANT")
          (tags-todo "PROMISE")
          (tags-todo "MILD")
          (tags-todo "MISC")
          ; (tags-todo "-{.*}") ; untagged

          ; Most important tags (and views) I can think of (I usually deadline/schedule those I really want to do anyways)
          ; -> MUST_BE_DONE_SOON
          ; -> MUST_BE_DONE_EVERYDAY
          ; -> MAY_BE_DONE_ON_IDLE_TIME
          ; * Unscheduled AND Undeadlined view
          ; * Untagged view

          ; (tags-todo "@ACTIONABLE")
          ; (tags-todo "@2MIN_ACTION")
          ; (tags-todo "@MAYBE_SOMEDAY_ACTIONABLE")
          ; (tags-todo "WORK_ON_PC")
          ; (tags-todo "HOME_TASK")

          ; (tags-todo "@NextAction")
          ; (tags-todo "@SomedayMaybe")
          ; (tags-todo "@ContextHome")
          ; (tags-todo "@ContextComputer")
          ; (tags-todo "@ReferenceJustInCase")
          ; (tags-todo "@Routine")
          ; (tags-todo "@Review")
          )
         nil)
        ("x" "What I need to Do NEXT TODAY"
         ((agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-span 7)
                      (org-agenda-show-current-time-in-grid t)
                      (org-agenda-timegrid-use-ampm t)
                      ; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-skip-scheduled-if-done t) ; default nil
                      (org-agenda-start-with-log-mode 0)
                      ; (org-agenda-show-log nil)
                      ; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                      ))
          (tags-todo "EVERYDAY")
          )
         nil)
        ("u" "Untagged"
         ((tags-todo "-{.*}"))
         )
        ))

(setq org-agenda-prefix-format

      ; What works = (%) + (s/T/t/b) (scheduled/deadline string | TAGS | time | title of higher level)
      ; (%) + (c/e/l/i) = (category from file name | effort required | level of item | icon )
      ; Choose one from the below

      ; '((agenda . "     %i  %s ")
      ;   (todo . " %i %-12:c")
      ;   (tags . " %i %-12:c")
      ;   (search . " %i %-12:c")))

      ; '((agenda . " %i %-12:c%?-12t% s")
      ;   (todo . " %i %-12:c")
      ;   (tags . " %i %-12:c")
      ;   (search . " %i %-12:c")))

      ; '((agenda . "        %s   ")
      ;   (todo . " %i %-12:c")
      ;   (tags .   "      %i ")
      ;   (search . " %i %-12:c")))

      '((agenda . "        %s ")
         (todo .  "        %s ")
         (tags .  "      %i    ")
         (search ." %i %-12:c ")))

      ; '((agenda . " %-6e| ") ; New Format
      ;   (todo . " %-6e| ")
      ;   (tags . " %-6e| ")
      ;   (search . " %-6e| ")))

; Time stamp done todos
(setq org-log-done 'time)

(setq
 org-agenda-tags-column 0
 org-agenda-deadline-leaders '(" D" "%2d" "%2d")
 ; org-agenda-scheduled-leaders '("|" "p")
 org-agenda-scheduled-leaders '(" |" "%2d")
 org-tag-faces
 '(
   ("EVERYDAY" :foreground "blue")
 ;   ("IMPORTANT" :foreground "purple")
 ;   ("URGENT" :foreground "red")
 ;   ("PROMISE" :foreground "cyan")
 ;   ("MILD" :foreground "green")
 ;   ("MISC" :foreground "yellow")
   )
 ; org-agenda-todo-keyword-format "%-1s"
 )

; Org Agenda View customizations
(setq org-agenda-span 7 ; default 10
      org-agenda-start-on-weekday 1
      ; org-agenda-start-day "+0d" ; default "-3d"
      org-agenda-skip-timestamp-if-done nil ; default nil (Closed and Clocked timestamps)
      org-agenda-skip-deadline-if-done t ; default nil
      org-agenda-skip-scheduled-if-done t ; default nil
      org-agenda-skip-scheduled-if-deadline-is-shown t ; default nil
      org-agenda-skip-timestamp-if-deadline-is-shown t ;default nil
      ; org-agenda-start-with-log-mode 1
      org-agenda-skip-scheduled-delay-if-deadline t
      org-deadline-warning-days 3 ; Warn me when there are %d days away
      org-scheduled-past-days 100 ; make it 0 if you dont want to see scheduled points past the scheduled date
      org-agenda-use-time-grid t
      org-hide-emphasis-markers t
      org-agenda-sorting-strategy '(
                                    ; (agenda habit-down time-up urgency-down priority-down)
                                    ; (todo urgency-down priority-down time-down)
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

        ; ("t" "todo" entry (file+headline "todo.org" "Inbox")
        ;  "* [ ] %?\n%i\n%a"
        ;  :prepend t)
        ; ("d" "deadline" entry (file+headline "todo.org" "Inbox")
        ;  "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
        ;  :prepend t)
        ; ("s" "schedule" entry (file+headline "todo.org" "Inbox")
        ;  "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
        ;  :prepend t)
        ; ("c" "check out later" entry (file+headline "todo.org" "Check out later")
        ;  "* [ ] %?\n%i\n%a"
        ;  :prepend t)
        ; ("l" "ledger" plain (file "ledger/personal.gpg")
        ;  "%(+beancount/clone-transaction)")

        )

      )

; Org-Journal
(setq org-journal-dir "/mnt/c/Users/Eyu/AllMyFilesArch/journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-file-format "%Y.org"
      org-journal-file-type 'yearly
      org-journal-created-property-timestamp-format "%Y%m%d")

; Jinx Mode, if (package! jinx) in package.el
; (add-hook 'emacs-startup-hook #'global-jinx-mode)
; (setq ispell-program-name "aspell")
; (setq ispell-dictionary "en_US")  ; Set the default dictionary

; HOW TO MANUALLY OPEN LSPs
; - Remove lang "+lsp" in init.el (otherwise the config of the lsp for that language is going to be automatically defined by doom)
; - Install emacs lsp package for that language though package.el
; - No default configs are defined (only the package is downloaded)
; - Manually download an lsp through the OS package manager and add to PATH var
; - M-x lsp will jump start the lsp

(after! lsp-mode
  (setq
   lsp-enable-symbol-highlighting nil
   lsp-enable-suggest-server-download nil
   lsp-use-plists t
   read-process-output-max (* 1024 1024) ; 1mb
   )
  (map! :leader
        :desc "lsp symbol highlight"
        "t h" #'lsp-toggle-symbol-highlight)
  )

;; Remove opening automatic tide server when opening rjsx/tsx/web-mode file
(remove-hook! '(typescript-mode-local-vars-hook
                typescript-tsx-mode-local-vars-hook
                web-mode-local-vars-hook
                rjsx-mode-local-vars-hook)
  '+javascript-init-lsp-or-tide-maybe-h) ; initialize tide-mode using `tide-setup'

; C/C++ Lsp; I want to manually invoke the lsp if I want to
(remove-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

(remove-hook 'c-mode-local-vars-hook #'lsp!)
(remove-hook 'c++-mode-local-vars-hook #'lsp!)
(remove-hook 'objc-mode-local-vars-hook #'lsp!)
(remove-hook 'cmake-mode-local-vars-hook #'lsp!)
(remove-hook 'cuda-mode-local-vars-hook #'lsp!)

(use-package! lsp-java
  :defer t
  :preface
  (setq lsp-java-workspace-dir (concat doom-data-dir "java-workspace"))
  ; (add-hook 'java-mode-local-vars-hook #'lsp! 'append)
  :config
  ; Ensure the directories are correctly concatenated
  (setq lsp-jt-root (concat lsp-java-server-install-dir "java-test/server/")
        dap-java-test-runner (concat lsp-java-server-install-dir "test-runner/junit-platform-console-standalone.jar"))
  ; Additional settings
  (setq lsp-java-references-code-lens-enabled t
        lsp-java-progress-reports-enabled t
        lsp-java-import-gradle-enabled t
        lsp-java-import-maven-enabled t)
  )

(use-package! dap-java
  ; :when (modulep! :tools debugger +lsp)
  :commands dap-java-run-test-class dap-java-debug-test-class
  :init
  (map! :after cc-mode ; where `java-mode' is defined
        :map java-mode-map
        :localleader
        (:prefix ("t" . "Test")
         :desc "Run test class or method"   "t" #'+java/run-test
         :desc "Run all tests in class"     "a" #'dap-java-run-test-class
         :desc "Debug test class or method" "d" #'+java/debug-test
         :desc "Debug all tests in class"   "D" #'dap-java-debug-test-class))
  )

(after! lsp-ui
  (setq
   lsp-ui-sideline-enable nil  ; no more useful than flycheck
   lsp-ui-doc-enable nil       ; redundant with K
   )
  )

; Remove scroll bar
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq scroll-margin 0)

; Make company mode completion faster
(setq company-idle-delay nil) ; default was 0.2 ; value of nil means no idle completion
(setq company-tooltip-idle-delay 0.5) ; default was 0.5

; Corfu completion
(after! corfu
  :config
  (setq
   corfu-preselect 'first
   corfu-auto nil
   corfu-preview-current t
   corfu-quit-at-boundary 'separator
   +corfu-want-tab-prefer-expand-snippets t
   +corfu-want-tab-prefer-navigating-snippets t
   corfu-on-exact-match 'show
   global-corfu-modes '((not erc-mode circe-mode help-mode gud-mode vterm-mode)
                        t)
   )
  ; ; Keybindings for Corfu in Doom Emacs
  ; (map!
  ;  :map corfu-mode-map ; corfu active mode
  ;  :i "C-SPC"   #'corfu-complete
  ;  :i "RET" nil
  ;  :i "TAB" nil
  ;  :map corfu-map ; popup
  ;  :i "RET"     #'corf
  ;  :i "C-SPC"   #'corfu-complete
  ;  :i "TAB"     #'corfu-next
  ;  :i "M-SPC"   #'corfu-insert-separator
  ;  )
  )

(map! :map org-mode-map
      :i "<tab>" nil
      )

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+vertico/switch-workspace-buffer))

; Key Bindings
; expand-region
; (after! expand-region
;   (map! :nvi "C-=" #'er/expand-region)
;   (map! :nvi "C--" #'er/contract-region)
;   (setq expand-region-smart-cursor nil
;         expand-region-subword-enabled nil))

; Window Selection mapping
(map! :leader
 :nm "<left>"      #'evil-window-left
 :nm "<right>"     #'evil-window-right
 :nm "<up>"        #'evil-window-up
 :nm "<down>"      #'evil-window-down

 ; Workspace Switcher, esp useful in tty mode
 :nm "TAB <left>"  #'+workspace/switch-left
 :nm "TAB <right>" #'+workspace/switch-right

 ; Workspace Swapper
 :nm "TAB S-<left>" #'+workspace/swap-left
 :nm "TAB S-<right>" #'+workspace/swap-right

 :nm "1"           #'+workspace/switch-to-0
 :nm "2"           #'+workspace/switch-to-1
 :nm "3"           #'+workspace/switch-to-2
 :nm "4"           #'+workspace/switch-to-3
 :nm "5"           #'+workspace/switch-to-4
 :nm "6"           #'+workspace/switch-to-5
)

(map!
 :nm "M-1"             #'+workspace/switch-to-0
 :nm "M-2"             #'+workspace/switch-to-1
 :nm "M-3"             #'+workspace/switch-to-2
 :nm "M-4"             #'+workspace/switch-to-3
 :nm "M-5"             #'+workspace/switch-to-4
 :nm "M-6"             #'+workspace/switch-to-5
 :nm "M-7"             #'+workspace/switch-to-6
 :nm "M-8"             #'+workspace/switch-to-7
 :nm "M-9"             #'+workspace/switch-to-8
 :nm "M-0"             #'+workspace/switch-to-final
 )

; Buffer Selection mapping
; Remap SPC ` to Ctrl-Tab for switching buffers
(map! :nvi "C-<tab>" #'evil-switch-to-windows-last-buffer)

; remove C-h to give space for 'embark-prefix-help-command'
(map!
 :map doom-leader-map
 "w C-h" nil
 :map evil-motion-state-map
 "C-w C-h" nil
 :map evil-window-map
 "C-h" nil
 :map general-override-mode-map
 ; :ei "M-SPC w C-h" nil
 :nvm "SPC w C-h" nil

 :map magit-mode-map
 :nv "C-w C-h" nil
 )

; S-<arrows> to move windows around
(map! :map doom-leader-map
      "w S-<up>"    #'+evil/window-move-up
      "w S-<down>"  #'+evil/window-move-down
      "w S-<left>"  #'+evil/window-move-left
      "w S-<right>" #'+evil/window-move-right
      )

(map! :leader
      "`" #'+popup/toggle ; Global leader binding
      ; :map vterm-mode-map
      ; :neovim "`" #'+popup/toggle
      )

(map! :leader
      :map general-override-mode-map
      :nvm "w t" #'transpose-frame)

;; (map!
;;  :map doom-leader-map
;;  :nvm "w t" #'transpose-frame)

(map! :nvi "M-U" #'downcase-word)

(map! :leader
      :desc "Resume last search"    "'" #'vertico-repeat-select)

; (after! undo-tree
;   (map!
;    :map undo-tree-mode-map
;    "C-_" nil
;    "C-/" nil
;    "<undo>" nil
;    :map undo-tree-map
;    "C-_" nil
;    "C-/" nil
;    "<undo>" nil
;    ))

; (undefine-key! undo-tree-map "C-_")
; (undefine-key! undo-tree-mode-map "C-_")

; Org nice alignment insertion underneath
; (after! org
;   :hook org-mode-hook
;   (map! :nvi "C-j" #'+org/insert-item-below))

; Org files
(setq org-directory "/mnt/c/Users/Eyu/AllMyFilesArch/")
(setq org-id-locations-file "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/.orgids")
(setq org-roam-directory "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/")
(setq org-agenda-files '("/mnt/c/Users/Eyu/AllMyFilesArch/org/agenda.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20240822232750-being_both_productive_and_having_fun_in_programming.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20240904214224-checklist_for_leetcode_topic_mastery.org"
                         "/mnt/c/Users/Eyu/AllMyFilesArch/org/roam/20241014000641-job_application_tracking.org"
                         "/home/eyu/current.org"))
(setq org-edit-src-content-indentation 0)
(setq org-archive-location ".archive/%s::")

; (after! org
  ; (setq org-startup-folded 'show2levels)
(map!
 :map evil-org-mode-map
 :mnv "g l" nil ; I want evil-lion-left to work
 :map org-mode-map
 :mnv "g l" nil ; I want evil-lion-left to work
 )
  ; )

; ENABLE GLOBAL TREE-SITTER AND HIGHLIGHTING
(add-hook 'doom-first-buffer-hook #'global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

; (setq +tree-sitter-hl-enabled-modes nil)

; (add-hook 'python-mode-local-vars-hook #'tree-sitter! 'append)
; (add-hook 'rustic-mode-local-vars-hook #'tree-sitter! 'append)
; (add-hook 'sh-mode-local-vars-hook     #'tree-sitter! 'append)
; (add-hook 'css-mode-local-vars-hook    #'tree-sitter! 'append)
; (add-hook 'yaml-mode-local-vars-hook   #'tree-sitter! 'append)
; (add-hook 'csharp-mode-local-vars-hook #'tree-sitter! 'append)
; (add-hook 'java-mode-local-vars-hook   #'tree-sitter! 'append)
; (add-hook 'lua-mode-local-vars-hook    #'tree-sitter! 'append)

; (add-hook! 'fennel-mode-local-vars-hook 'tree-sitter! 'append)
; (add-hook! '(c-mode-local-vars-hook c++-mode-local-vars-hook) :append #'tree-sitter!)

; (add-hook! '(json-mode-local-vars-hook
;              jsonc-mode-local-vars-hook)
;            :append #'tree-sitter!)

; (add-hook! '(js2-mode-local-vars-hook
;              typescript-mode-local-vars-hook
;              typescript-tsx-mode-local-vars-hook
;              rjsx-mode-local-vars-hook)
;            :append #'tree-sitter!)

; (when (fboundp #'csharp-tree-sitter-mode)
;   (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

; Which-key configuration
(after! which-key
  (setq which-key-allow-imprecise-window-fit nil  ; Ensures that which-key suggestions are fully visible
        which-key-side-window-max-height 0.99))  ; Maximizes the height of the which-key window to 99%


; GARBAGE COLLECTION
; (setq gc-cons-threshold (* 511 1024 1024))
; (setq gc-cons-percentage 0.6)
; (run-with-idle-timer 15 t #'garbage-collect)
; (setq garbage-collection-messages nil)

(after! gcmh
  ; 32mb, or 64mb, or *maybe* 128mb, BUT NOT 512mb (the default value = 33554432)
  (setq gcmh-high-cons-threshold  (* 64 1024 1024)))
(setq inhibit-compacting-font-caches nil)

; Debuggers
(after! dap-mode
  ; (add-to-list '+debugger--dap-alist '((:lang python) :after python :require dap-python))
  ; (add-to-list '+debugger--dap-alist '((:lang cc)     :after (c-mode c++-mode)   :require (dap-lldb dap-gdb-lldb))) ;:TODO the :after here may be bad
  (require 'dap-python)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  (setq dap-python-debugger 'debugpy)
  )

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(defun ey/visual-to-last-non-blank-in-current-line ()
  "Visual mode and extend selection to the last non-blank char in the current line."
  (interactive)
  (evil-visual-char)
  (evil-last-non-blank)
  )

(defun ey/visual-to-first-non-blank-in-current-line ()
  "Visual mode and extend selection to the 1st non-blank char in the current line."
  (interactive)
  (evil-visual-char)
  (evil-first-non-blank)
  )

(map!
 :nvim "C-S-a" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-e" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-i" #'ey/visual-to-first-non-blank-in-current-line

 :map vterm-mode-map
 :nvm "C-a" #'doom/backward-to-bol-or-indent
 )

; (defun my/expand-region-keep-cursor ()
;   "Expand the region but keep the cursor (point) at its original position."
;   (interactive)
;   (let ((original-pos (point)))  ; Remember the original cursor position
;     (call-interactively 'er/expand-region)  ; Expand the region
;     (when (> original-pos (region-beginning))
;       (goto-char original-pos))))  ; Restore the cursor position if needed

; Persp mode
(after! persp-mode
  (setq persp-auto-save-opt 0      ; 0 means no save, 1 means save on Emacs kill
        persp-auto-save-num-of-backups 7
        ))

; TAB-JUMP-OUT-MODE
(setq tab-jump-out-global-mode nil)
; (add-hook 'prog-mode-hook #'tab-jump-out-mode)
; (add-hook 'org-mode-hook #'tab-jump-out-mode)
; (add-hook 'after-change-major-mode-hook #'tab-jump-out-mode)

; ; Schedule :EVERYDAY: tasks to the current day automatically
; (defun my/org-schedule-everyday-tasks ()
;   "Schedule all TODO entries tagged with EVERYDAY for today if not already
;    scheduled."
;   (interactive)
;   (let ((org-agenda-files (org-agenda-files))
;         (today (format-time-string "%Y-%m-%d")))
;     (dolist (file org-agenda-files)
;       (with-current-buffer (find-file-noselect file)
;         (org-mode)  ; Ensure org-mode is active in the buffer
;         (goto-char (point-min))
;         (while (re-search-forward "^\\*+ \\(TODO\\|PROJ\\|NEXT\\|DONE\\|CANCELLED\\|HOLD\\|WAITING\\) .* :EVERYDAY:" nil t)
;           (let ((scheduled (org-get-scheduled-time (point))))
;             (when (or (not scheduled)
;                       (not (equal (org-format-time-string "%Y-%m-%d" scheduled) today)))
;               (org-schedule nil today))))))))

; (defun my/schedule-everyday-tasks-daily ()
;   "Add a daily hook to schedule EVERYDAY tasks."
;   (run-at-time "00:01" (* 24 60 60) 'my/org-schedule-everyday-tasks))

; (my/schedule-everyday-tasks-daily)

; Set Clipboards
(setq save-interprogram-paste-before-kill t

      select-active-regions nil
      select-enable-clipboard t
      select-enable-primary nil
      ; interprogram-cut-function #'gui-select-text
      ; interprogram-paste-function #'gui-sele
      )


; Set evil mode in minibuffers
(setq evil-want-minibuffer t)

; (doom-require 'bookmark+)

; (use-package! bookmark+
;   :demand t
;   )
  ; (load "/home/eyu/.config/emacs/.local/straight/repos/bookmark-plus/bookmark+-mac.el")
; (require 'bookmark+-mac nil t)

(setq evil-insert-state-cursor '(hollow))

; Set insert evil mode to box
; (if (display-graphic-p)
;     ; (setq evil-insert-state-cursor '(box))
;     (setq evil-insert-state-cursor '(hollow))
;   (setq evil-insert-state-cursor '(hbar))
;   )

; (setq evil-insert-state-cursor '(box +evil-emacs-cursor-fn))
; (setq evil-normal-state-cursor '(box))

; Number of blinks, infinite blinks for blink cursor mode when -1
(setq blink-cursor-blinks -1 ; my default -1
      blink-cursor-delay 0.0001 ; my default 0.001
      blink-cursor-interval 0.7) ; my default 0.7

; Ensure blinking is disabled globally by default
(blink-cursor-mode 0)

; (setq-default cursor-in-non-selected-windows nil)

; (defun eyth/toggle-cursor-blink ()
;   "Toggle cursor blinking based on the current Evil mode."
;   (if (evil-insert-state-p)
;       (blink-cursor-mode 1)  ; Enable blinking in insert mode
;     (blink-cursor-mode -1))) ; Disable blinking in other modes

; (remove-hook 'evil-insert-state-entry-hook 'eyth/toggle-cursor-blink)
; (remove-hook 'evil-insert-state-exit-hook 'eyth/toggle-cursor-blink)

; Open Vterm popups from the right
(after! vterm
  ; (add-hook 'vterm-mode-hook #'compilation-shell-minor-mode)
  ; (remove-hook 'vterm-mode-hook #'compilation-minor-mode)
  (remove-hook! 'vterm-mode-hook #'hide-mode-line-mode)
  ; (setq vterm-buffer-name-string "vterm %s")
  (setq vterm-buffer-name-string nil)
  (set-popup-rule! "*doom:vterm-popup:"
    :size 0.5
    :vslot -4
    :select t
    :quit nil
    :ttl nil
    ; :side (ey/vterm-popup-side)
    :side 'bottom
    :modeline t
    )
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
   :nv "C-<right>" #'right-word


   )
  )

(after! compile
  ; (setq compilation-scroll-output 'first-error)
  (setq compilation-scroll-output 't)
  )

(map! :map compilation-shell-minor-mode-map
      :ni "M-RET"           #'compile-goto-error

      ; :ni "S-<iso-lefttab>" #'compilation-previous-error
      ; :ni "<tab>"           #'compilation-next-error

      :ni "M-<up>"          #'compilation-previous-error
      :ni "M-<down>"        #'compilation-next-error

      :ni "M-<right>"       #'compilation-next-file
      :ni "M-<left>"        #'compilation-previous-file
      )

(set-popup-rule! "*compilation*"
    :size 0.5
    :vslot -4
    :select t
    :quit nil
    :ttl nil
    :side 'bottom
    :modeline t
    )

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
   doom-modeline-time-analogue-clock t
   doom-modeline-time-live-icon t
   doom-modeline-time-icon nil          ; the small analogue icon
   ))

; Modeline in popups
; (plist-put +popup-defaults :modeline t)
; Completely disable management of the mode-line in popups:
(remove-hook '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)

; Open links in predefined browser
(defun open-url-in-min-browser (url &rest _args)
  (let ((min-browser-path "/mnt/c/Users/Eyu/AppData/Local/min/min.exe"))
    (start-process "min-browser" nil min-browser-path url)))

; (setq browse-url-browser-function 'open-url-in-min-browser)
(setq browse-url-browser-function 'browse-url-default-browser)

; Quick Google searches
; (defun google-search (query)
;   "Search Google for the QUERY."
;   (interactive "sGoogle search: ")
;   (browse-url (concat "https://www.google.com/search?q=" (url-hexify-string query))))

; (global-set-key (kbd "C-q") #'google-search)

; default google search
; (defun google-search (query)
;   "Search Google for the QUERY. Use selected text as the default input if available."
;   (interactive
;    (let ((selected-text (when (use-region-p)
;                           (buffer-substring-no-properties (region-beginning) (region-end)))))
;      (list (read-string "Google search: " selected-text))))
;   (browse-url (concat "https://www.google.com/search?q=" (url-hexify-string query)))
;   )

; enhanced search
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
    (open-url-in-min-browser (concat "https://www.google.com/search?q=" (url-hexify-string query))))
   ))

(map!
 :neovimrg "C-q" #'google-search)

(map!
 :n "z i" #'hs-hide-all
 :n "z u" #'hs-show-all
 :n "z p" #'hs-toggle-hiding)

; Org-download clipboard for wsl2
(defun ey/yank-image-from-win-clipboard-through-powershell ()
  "Yank an image from the Windows clipboard through PowerShell in WSL2 and
insert it into the current buffer."
  (interactive)
  (let* ((powershell "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
         (file-name (format-time-string "screenshot_%Y%m%d_%H%M%S.png"))
         (file-path-powershell (concat "C:/Users/Public/" file-name))
         (file-path-wsl (concat "./images/" file-name))
         (file-path-wsl-absolute (concat (expand-file-name default-directory) "images/" file-name)))
    ; Ensure the target directory exists
    (unless (file-exists-p "./images/")
      (make-directory "./images/"))
    ; Save the image from the clipboard to the temporary directory
    (shell-command (concat powershell " -command \"(Get-Clipboard -Format Image).Save('" file-path-powershell "')\""))
    ; Wait a moment to ensure the file is created
    (sit-for 1)
    ; Check if the file was created successfully
    (if (file-exists-p (concat "/mnt/c/Users/Public/" file-name))
        (progn
          ; Rename (move) the file to the current directory
          (rename-file (concat "/mnt/c/Users/Public/" file-name) file-path-wsl-absolute)
          ; Insert the file link into the buffer
          (insert (concat "[[file:" file-path-wsl "]]"))
          (message "Insert DONE."))
      (message "Error: The file was not created by PowerShell."))))
(map! :leader
      :desc "Insert image"
      "i i" #'ey/yank-image-from-win-clipboard-through-powershell)

(after! unicode-fonts
  (push "Symbola" (cadr (assoc "Miscellaneous Symbols" unicode-fonts-block-font-mapping))))

; USE THESE WHEN WSL CLIPBOARD IS NOT WORKING, they are kinda slow
; (defun wsl-paste ()
;   "Paste text from Windows clipboard using PowerShell."
;   (let ((coding-system-for-read 'dos))
;     (string-trim
;      (shell-command-to-string "powershell.exe Get-Clipboard"))))

; (defun wsl-copy (text &optional push)
;   "Copy TEXT to Windows clipboard using PowerShell."
;   (let ((process-connection-type nil))
;     (let ((proc (start-process "clip.exe" "*Messages*" "clip.exe")))
;       (process-send-string proc text)
;       (process-send-eof proc))))

; (setq interprogram-cut-function 'wsl-copy)
; (setq interprogram-paste-function 'wsl-paste)

; Rustic compilation mode popup
(after! rustic
  (set-popup-rule!
   "^\\*rustic-compilation"
   :side 'bottom
   :size 0.5
   :select t
   :vslot -1
   :quit t
   :ttl nil)
  (set-popup-rule!
   "^\\*cargo-run*"
   :side 'bottom
   :size 0.5
   :select t
   :vslot -1
   :quit t
   :ttl nil)
  )

; TTY mode
(when (not (display-graphic-p))
  ;   (blink-cursor-mode 0)
  ;   (after! evil
  ;     (map! :map evil-insert-state-map
  ;           "C-@" #'corfu-first
  ;           :map evil-replace-state-map
  ;           "C-@" #'corfu-first
  ;           ))
  ; (add-hook 'diff-hl-mode-on-hook ; Add version control diff-hl in tty mode
  ;           (lambda()
  ;             (unless (display-graphic-p)
  ;               (diff-hl-margin-local-mode)))
  ;           )
  )

; (diff-hl-margin-local-mode 0)

; Remove automatic diff-hl mode
; (remove-hook! vc-dir-mode #'turn-on-diff-hl-mode)
; (remove-hook! 'doom-first-file-hook #'global-diff-hl-mode)
(remove-hook! '+popup-buffer-mode-hook #'+popup-adjust-margins-h)
(add-hook! '+popup-buffer-mode-hook #'+popup-adjust-fringes-h)
; +popup-adjust-margins-h is the function that turns off diff-hl vc-gutter in tty doom emacs mode

(global-subword-mode 1)

; Read Escape seq from Alacritty (C-i)
(defun ey/set-input-decoder-mappings ()
  (define-key input-decode-map "\C-@"      (kbd "C-SPC"))
 ;(define-key input-decode-map "SPC-`"     (kbd "C-`"  ))
  (define-key input-decode-map "\e[105;5u" (kbd "<C-i>"))
  (define-key input-decode-map "\e[105;6u" (kbd "C-S-a"))
  (define-key input-decode-map "\e[100;6u" (kbd "C-S-d"))
  (define-key input-decode-map "\e[73;6u"  (kbd "C-S-i"))
  (define-key input-decode-map "\e[96;5u"  (kbd "C-`"  ))
  )

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (ey/set-input-decoder-mappings))))
  (ey/set-input-decoder-mappings))

; (desktop-save-mode 1) ;: Enable desktop saving state here
; (setq desktop-restore-eager 1
;       desktop-restore-forces-onscreen 'all
;       desktop-restore-frames t)
; (setq desktop-restore-eager 10) ; Number of buffers to restore immediately
; (setq desktop-save 'if-exists) ; Save desktop without asking if it already exists
(setq treemacs-persist-file nil)

(use-package! drag-stuff
  :defer t
  :init
  (map! "<M-up>"    #'drag-stuff-up
        "<M-down>"  #'drag-stuff-down
        "<M-left>"  #'drag-stuff-left
        "<M-right>" #'drag-stuff-right))

(after! magit
  (map! :map magit-section-mode-map
        :n "C-<tab>" #'evil-switch-to-windows-last-buffer
        :n "S-<iso-lefttab>" #'magit-section-cycle
        :n "C-S-<iso-lefttab>" #'magit-section-cycle-global
        ))

(setq-default left-margin-width 1
              right-margin-width 0)
; (set-window-buffer nil (current-buffer))

(defun ey/find-file-under-selection ()
  "Open `find-file` with the current selection (if any) as the default filename."
  (interactive)
  (let ((selection (if (use-region-p)
                       (buffer-substring-no-properties (region-beginning) (region-end))
                     nil)))
    (find-file (read-file-name "Find file: " selection))))
(map! :leader
      :desc "Find file under selected text"
      "f o" #'ey/find-file-under-selection
      ; "o f" #'ey/find-file-under-selection ; Makes opening new frame implausible
      )

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
  (find-name-dired default-directory "*"))
(map! :leader
      :desc "Find all files"
      "l f" #'ey/find-files-recursively
      :desc "Find all files and folders"
      "l a" #'ey/find-all-dirs-and-files-recursively)

(map! "C-S-d" #'duplicate-dwim)

(defun ey/consult-fd-or-find (&optional dir initial)
  "Runs consult-fd if fd version > 8.6.0 exists, consult-find otherwise.
See minad/consult#770."
  (interactive "P")
  (let ((initial-input (or initial "** ")))  ; Set default initial input here
    (if (when-let* ((bin (if (ignore-errors (file-remote-p default-directory nil t))
                             (cl-find-if (doom-rpartial #'executable-find t)
                                         (list "fdfind" "fd"))
                           doom-fd-executable))
                    (version (with-memoization (get 'doom-fd-executable 'version)
                               (cadr (split-string (cdr (doom-call-process bin "--version"))
                                                   " " t))))
                    ((ignore-errors (version-to-list version))))
          (version< "8.6.0" version))
        (consult-fd dir initial-input)
      (consult-find dir initial-input))))

(map! :leader
      :desc "Consult fd"
      "f d" #'ey/consult-fd-or-find)


; emacs-lsp-booster
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

; (set-background-color "#181818")

(defun ey/consult-ripgrep-with-live-preview ()
  "Search using consult-ripgrep with live preview in the buffer above the minibuffer."
  (interactive)
  ; Run consult-ripgrep with live preview enabled
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

(after! better-jumper
  (setq better-jumper-context 'window)
  ; (setq better-jumper-use-savehist t)
  ; (setq better-jumper-savehist t) ; Gives sequence-p ERROR
  ; (remove-hook! 'better-jumper-pre-jump-hook #'better-jumper-set-jump)
  )

; add jumper position after search
(defun +default/search-buffer ()
  "Conduct a text search on the current buffer."
  (interactive)
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

; Keycast mode
(defun turn-on-keycast ()
  (interactive)
  (add-to-list 'global-mode-string '("" mode-line-keycast " "))
)

(defun turn-off-keycast ()
  (interactive)
  (setq global-mode-string (delete '("" mode-line-keycast " ") global-mode-string))
)

(after! keycast
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line."
    :global t
    (if keycast-mode
        (add-hook 'pre-command-hook 'keycast--update t)
      (remove-hook 'pre-command-hook 'keycast--update))))

(setq line-spacing nil)

(add-hook! prog-mode-hook #'hs-minor-mode)

; (map!
;  :map global-map
;  :nv "C-i" #'better-jumper-jump-forward
;  :map c-mode-base-map
;  :nv "C-i" #'better-jumper-jump-forward
;  )

(after! go-mode
  (remove-hook!  'go-mode-hook #'go-eldoc-setup))

(setq doom-leader-alt-key-states '(normal visual motion insert emacs))

; Safe local variables
; (put '+word-wrap-mode 'safe-local-variable #'booleanp)

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


(defun ey/set-doom-theme (theme)
  "Set `doom-theme` to the selected THEME."
  (setq doom-theme theme))

(advice-add 'consult-theme :after #'ey/set-doom-theme)

; ?? The `margin' mode function seems to be the one that incites the hook to have the immediate changes seen
(advice-add 'diff-hl-mode :after #'diff-hl-margin-mode)

(display-time-mode 1)
