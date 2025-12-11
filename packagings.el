;;; $DOOMDIR/packagings.el -*- lexical-binding: t; -*-



(after! doom-themes
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
        doom-themes-enable-italic nil  ; if nil, italics is universally disabled
        doom-gruvbox-dark-variant "hard"))



(after! tree-sitter
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))



(after! recentf
  (add-to-list 'recentf-exclude "^/\\(?:ssh\\|su\\|sudo\\)?:")
  (setq recentf-max-saved-items 1000))



(after! hl-todo
  (setq hl-todo-require-punctuation t))



(after! unicode-fonts
  (push "Symbola" (cadr (assoc "Miscellaneous Symbols" unicode-fonts-block-font-mapping))))



(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "*node_modules")
  (setq projectile-auto-discover nil))



(use-package! page-break-lines
  :hook (emacs-lisp-mode . page-break-lines-mode)
  :hook (emacs-news-mode . page-break-lines-mode)
  :hook (c-mode . page-break-lines-mode)
  :hook (gfm-mode . page-break-lines-mode)
  :hook (markdown-mode . page-break-lines-mode))



(use-package! trashed :defer t)



;; Search accurately for # and * symbols
(use-package! evil
  :init
  (setq evil-symbol-word-search t
        evil-ex-search-case 'insensitive ; was 'smart
        +evil-want-o/O-to-continue-comments nil
        ;; evil-want-C-i-jump t
        evil-want-C-u-delete nil
        evil-want-minibuffer t
        evil-ex-substitute-global t
        evil-respect-visual-line-mode t
        evil-echo-state nil ; Disable the evil-mode line indicator in the ex section
        evil-kill-on-visual-paste nil
        evil-move-cursor-back t
        evil-want-fine-undo t)
  :config
  (setq evil-insert-state-cursor '(box)
        evil-motion-state-cursor '(box)
        evil-visual-state-cursor '(box)
        evil-split-window-below t
        evil-vsplit-window-right t)
  (evil-set-initial-state 'shell-command-mode 'normal) ; for `async-shell-command'
  (evil-set-initial-state 'comint-mode 'normal))

(after! evil-integration
  (setq avy-all-windows t))

(after! evil-visualstar
  (global-evil-visualstar-mode -1)
  (setq evil-visualstar/persistent t))



;;; Dirvish Dired Mode
(after! dirvish
  ;; (setq dirvish-reuse-session 'open) ; MAY BREAK???
  (setq dirvish-override-dired-mode t)
  (setq dirvish-attributes '(file-size nerd-icons))
  (setq dirvish-mode-line-format
        '(:left (sort file-time symlink) :right (omit yank index)))
  (setq dirvish-use-header-line nil
        dirvish-use-mode-line nil))

(after! dirvish-subtree
  (setq dirvish-subtree-always-show-state nil)
  (setq dirvish-subtree-prefix "   ")
  (defcustom +dirvish-enable-subtree--view-file nil
    "Non-nil means fall back to `dirvish-subtree--view-file' on file errors."
    :type 'boolean
    :group 'dirvish)

  (defun dirvish-subtree-toggle ()
    "Insert subtree at point or remove it if it was not present."
    (interactive)
    (if (dirvish-subtree--expanded-p)
        (progn (dired-next-line 1) (dirvish-subtree-remove))
      (condition-case err (dirvish-subtree--insert)
        (file-error
         (if +dirvish-enable-subtree--view-file
             (dirvish-subtree--view-file)
           (signal (car err) (cdr err)))) ; re-signal original error if view-file is disabled
        (error (message "%s" (cdr err)))))))

;;; Dired Customizations
(after! dired
  ;; (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (setq dired-free-space 'first)
  (setq dired-kill-when-opening-new-dired-buffer t)
  (dired-async-mode 1))

(after! diredfl
  (remove-hook 'dired-mode-hook #'diredfl-mode)
  (remove-hook 'dirvish-directory-view-mode-hook #'diredfl-mode))

(after! dired-x ; provides dired omit mode
  (remove-hook! 'dired-mode-hook #'dired-omit-mode))

(use-package! dired-du
  :after dired
  :init
  (setq dired-du-bind-human-toggle nil
        dired-du-bind-mode nil
        dired-du-bind-count-sizes nil)
  :config
  ;; (add-hook 'dired-mode-hook #'dired-du-mode))
  (setq dired-du-size-format t))



(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :commands org-roam-ui-open
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))



(after! org
  (setq org-clock-clocktable-default-properties (list :maxlevel 6)
        org-duration-format (quote h:mm)
        org-agenda-custom-commands
        '(("A" "show only" todo "ACTV" nil nil)
          ("Z" "All Tags"
           (;; (agenda "" (
            ;;             (org-agenda-start-day "+0d")
            ;;             (org-agenda-start-on-weekday 1)
            ;;             (org-agenda-span 7)
            ;;             (org-agenda-show-current-time-in-grid t)
            ;;             ;; (org-agenda-timegrid-use-ampm t)
            ;;             ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
            ;;             (org-agenda-start-with-log-mode 1)
            ;;             (org-agenda-skip-deadline-if-done t)
            ;;             (org-agenda-skip-scheduled-if-done t) ; default nil
            ;;             ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
            ;;             (org-agenda-show-log t)))
            (tags-todo "EVERYDAY")
            (tags-todo "URGENT")
            (tags-todo "IMPORTANT")
            (tags-todo "PROMISE")
            (tags-todo "MILD")
            (tags-todo "MISC")
            (tags-todo "-{.*}")
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
          ("d" "show DONEs only"
           agenda "" (
                      (org-agenda-start-day "+0d")
                      (org-agenda-start-on-weekday 1)
                      (org-agenda-span 7)
                      (org-agenda-show-current-time-in-grid t)
                      (org-agenda-timegrid-use-ampm t)
                      (org-agenda-include-inactive-timestamps nil)
                      ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                      (org-agenda-start-with-log-mode 'only)
                      (org-agenda-log-mode-items '(closed state clock))
                      ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                      ;; (org-agenda-show-log t) ; REVIEW: don't use this, it messes things up
                      )
           nil)
          ("n" "What I need to Do NEXT this week"
           ((agenda "" ((org-agenda-start-day "+0d")
                        (org-agenda-start-on-weekday 1)
                        (org-agenda-span 7)
                        (org-agenda-show-current-time-in-grid t)
                        (org-agenda-timegrid-use-ampm t)
                        ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
                        (org-agenda-skip-deadline-if-done t)
                        (org-agenda-skip-scheduled-if-done t) ; default nil
                        ;; (org-agenda-show-log nil)
                        ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
                        (org-agenda-start-with-log-mode nil)))
            (tags-todo "EVERYDAY"))
           nil)
          ;; ("x" "What I need to Do NEXT this week"
          ;;  ((agenda "" ((org-agenda-start-day "+0d")
          ;;               (org-agenda-start-on-weekday 1)
          ;;               (org-agenda-span 7)
          ;;               (org-agenda-show-current-time-in-grid t)
          ;;               (org-agenda-timegrid-use-ampm t)
          ;;               ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("DONE")))
          ;;               (org-agenda-skip-deadline-if-done t)
          ;;               (org-agenda-skip-scheduled-if-done t) ; default nil
          ;;               ;; (org-agenda-show-log nil)
          ;;               ;; (org-agenda-sorting-strategy '(todo-state-up priority-down))
          ;;               (org-agenda-start-with-log-mode nil)))
          ;;   (tags-todo "EVERYDAY"))
          ;;  nil)
          ("x" "show TODOs DONEs together XX!"
           ((agenda "" (
                        (org-agenda-start-day "+0d")
                        (org-agenda-start-on-weekday 1)
                        (org-agenda-span 7)
                        (org-agenda-show-current-time-in-grid t)
                        (org-agenda-timegrid-use-ampm t)
                        (org-agenda-include-inactive-timestamps nil)
                        (org-agenda-start-with-log-mode '(closed clock state))
                        (org-agenda-show-log t)))
            (tags-todo "EVERYDAY"))
           nil)
          ("u" "Untagged"
           ((tags-todo "-{.*}")))))

  (setq org-agenda-prefix-format

        ;; What works:
        ;; (%) + (s/T/t/b) = (scheduled or deadline string | TAGS | time | title of higher level)
        ;; (%) + (c/e/l/i) = (category from file name | effort required | level of item | icon )

        '((agenda . "        %s ")
          (todo  .  "        %s ")
          (tags  .  "      %i   ")
          (search  ." %i %-12:c ")))

  (setq org-agenda-tags-column 'auto
        org-agenda-deadline-leaders '("  D" "%3d" "%3d")
        ;; org-agenda-scheduled-leaders '("|" "p")
        org-agenda-scheduled-leaders '("  |" "%3d")
        org-agenda-timerange-leaders '("   " "(%d/%d): ")
        ;; org-agenda-todo-keyword-format "%-1s"
        org-tag-faces
        '(;;   ("IMPORTANT" :foreground "purple")
          ;;   ("URGENT" :foreground "red")
          ;;   ("PROMISE" :foreground "cyan")
          ;;   ("MILD" :foreground "green")
          ;;   ("MISC" :foreground "yellow")
          ("EVERYDAY" :foreground "#7b68ee")))

  ;; Org Agenda View customizations
  (setq org-agenda-span 7 ; default 10
        org-agenda-start-on-weekday 1
        ;; org-agenda-start-day "+0d" ; default "-3d"
        org-agenda-todo-ignore-timestamp nil
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
        org-agenda-time-grid '((daily today)
                               (0000 0100 0200 0300 0400
                                     0500 0600 0700 0800
                                     0900 1000 1100 1200
                                     1300 1400 1500 1600
                                     1700 1800 1900 2000
                                     2100 2200 2300 2400)
                               " ┄┄┄┄┄ " "---------------")
        org-agenda-current-time-string "← now ───────────────────────────────────────────────"
        org-hide-emphasis-markers t
        org-agenda-sorting-strategy '((tags urgency-down priority-down) ; FIXME: it is giving me warning for this one
                                      ;; (agenda habit-down time-up urgency-down priority-down)
                                      ;; (todo urgency-down priority-down time-down)
                                      (search category-keep)))

  (setq org-capture-templates
        '(("t" "Add TODO" entry
           (file+headline +org-capture-todo-file "Incoming")
           "*** TODO %?: " :prepend t)))

  (setq org-src-preserve-indentation nil)
  (setq org-edit-src-content-indentation 0)
  ;; (setq org-src-preserve-indentation t)
  ;; (setq org-edit-src-content-indentation 0)
  (setq org-archive-location ".archive/%s::")

  ;; Time stamp done todos
  (setq org-log-done 'time)
  (setq org-refile-targets '((nil :maxlevel . 2)
                             (org-agenda-files :maxlevel . 2)))
  (setq org-startup-folded 'fold)
  (setq org-confirm-babel-evaluate t)
  ;; (setq org-ellipsis " ▾")
  ;; (setq org-log-into-drawer t)
  ;; (setq org-tags-column -80)
  (setq org-auto-align-tags t)
  (map! :map embark-org-src-block-map
        "C-'" #'org-edit-special
        :map org-mode-map
        "C-c C-'" #'org-edit-special
        :mnv "g l" nil ; I want evil-lion-left to work
        "C-," nil)

  (advice-add 'org-mark-subtree :after #'ey/evil-do-normal-state-w/o-cursor-jumpback)
  (advice-remove 'org-mark-subtree #'ey/evil-do-insert-state--advice)
  (setq org-todo-keywords
        '((sequence ;; TODO:
           "TODO(t)"  ; A task that needs doing & is ready to do
           "ACTV(a)"  ; A task which I am now working actively on
           "ALMS(s)"  ; A task that is almost done (finalizing/commiting is left)
           "PROJ(p)"  ; A project, which usually contains other tasks
           "LOOP(r)"  ; A recurring task
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "IDEA(i)"  ; An unconfirmed and unapproved task or notion
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)") ; Task was cancelled, aborted, or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")  ; Task was completed
          (sequence
           "|"
           "OKAY(o)"
           "YES(y)"
           "NO(n)"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("ALMS" . +org-todo-active)
          ("ACTV" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("NO"   . +org-todo-cancel)
          ("KILL" . +org-todo-cancel))))

;;; Org-Journal
(after! org-journal
  (setq org-journal-date-prefix "* "
        org-journal-time-prefix "** "
        org-journal-file-format "%Y.org.gpg"
        org-journal-file-type 'yearly
        org-journal-created-property-timestamp-format "%Y%m%d"))

;; (after! org-cycle
;;   (setq org-cycle-emulate-tab nil))

(use-package! org-appear ; better markup edit
  :defer t
  :config
  (setq org-appear-autoemphasis t
        org-appear-autoentities t
        org-appear-autokeywords t
        org-appear-inside-latex t
        org-appear-autolinks t
        org-appear-autosubmarkers t))

(after! org-noter
  (setq org-noter-always-create-frame nil))



;;; HOW TO MANUALLY OPEN LSPs
;; - Remove lang "+lsp" in init.el (otherwise the config of the lsp for that language is going to be automatically defined by doom)
;; - Install emacs lsp package for that language though package.el
;; - No default configs are defined (only the package is downloaded)
;; - Manually download an lsp through the OS package manager and add to PATH var
;; - M-x lsp to jump start

(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; lsp-enable-suggest-server-download t
        lsp-eldoc-enable-hover nil ; Performance!
        lsp-modeline-diagnostics-scope :file
        lsp-signature-render-documentation nil ; don't show verbose documentation in eldoc
        lsp-use-plists t))

(use-package! lsp-pyright ; TODO: Test if working
  :defer t
  :after lsp-mode
  :init
  (when (executable-find "pyright")
    (setq lsp-pyright-langserver-command "pyright")))

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

(use-package! dap-java ; TODO: do I even need this??
  ;; :when (modulep! :tools debugger +lsp)
  :commands dap-java-run-test-class dap-java-debug-test-class)

(after! dap-mode
  (delete 'tooltip dap-auto-configure-features)) ; auto tooltip destroys corfu
                                                 ; popups in lsp buffers when
                                                 ; mouse is moved

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil             ; no more useful than flycheck
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
  (setq corfu-preselect 'first
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
        tab-always-indent t
        global-corfu-modes '((not erc-mode circe-mode help-mode gud-mode vterm-mode) t)))



(after! embark
  (setq embark-quit-after-action t)) ; messes up windows when quitting minibuffer later



(after! gcmh
  ;; 32mb, or 64mb, or *maybe* 128mb, BUT NOT 512mb (the default value = 33554432)
  ;; (setq gcmh-high-cons-threshold  (* 64 1024 1024)))
  (setq gcmh-high-cons-threshold  (* 100 1024 1024))
  ;; (setq gcmh-high-cons-threshold  1073741824)
  ) ; default value = 33554432
(setq inhibit-compacting-font-caches nil)



;; Debuggers
(after! dap-mode
  ;; (add-to-list '+debugger--dap-alist '((:lang python) :after python :require dap-python))
  ;; (add-to-list '+debugger--dap-alist '((:lang cc)     :after (c-mode c++-mode)   :require (dap-lldb dap-gdb-lldb))) ; TODO: the :after here may be bad
  (require 'dap-python)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  (setq dap-python-debugger 'debugpy))



(setq +workspaces-on-switch-project-behavior nil)
;; Persp mode
(after! persp-mode
  (setq persp-auto-save-opt 0      ; 0 means no save, 1 means save on Emacs kill
        persp-autokill-buffer-on-remove 'kill-weak
        persp-auto-save-num-of-backups 7)
  ;; (setq +workspaces-on-switch-project-behavior nil)
  ;; (setq projectile-switch-project-action #'+workspaces-switch-to-project-h)

  ;; add to files
  ;; (add-hook 'persp-before-save-state-to-file-functions
  ;;           (defun +workspaces-save-tab-bar-data-to-file-h (&rest _)
  ;;             (when (get-current-persp)
  ;;               (set-persp-parameter 'tab-bar-tabs (frameset-filter-tabs (tab-bar-tabs) nil nil t)))))

  ;; FIXME: these functions are supposed to help with compatibility between `persp-mode' and `tab-bar-mode'
  ;; (add-hook 'persp-before-deactivate-functions
  ;;           (defun +workspaces-save-tab-bar-data-h (&rest _)
  ;;             (when (get-current-persp)
  ;;               (set-persp-parameter
  ;;                'tab-bar-tabs (tab-bar-tabs)))))
  ;;
  ;; (add-hook 'persp-activated-functions
  ;;           (defun +workspaces-load-tab-bar-data-h (&rest _)
  ;;             (tab-bar-tabs-set (persp-parameter 'tab-bar-tabs))
  ;;             (tab-bar--update-tab-bar-lines t)))
  (setq projectile-switch-project-action #'projectile-find-file))



(setq vterm-always-compile-module t)
;; Open Vterm popups from the right
(after! vterm
  (remove-hook! 'vterm-mode-hook #'hide-mode-line-mode)
  ;; (setq vterm-buffer-name-string "vterm %s")
  ;; (evil-set-initial-state 'vterm-mode 'normal) ; `evil-state-properties'
  (setq vterm-timer-delay 0.01)
  (setq vterm-max-scrollback 100000)

  (if (modulep! :ui popup)
      (set-popup-rule! "*doom:vterm-popup:"
                       :size 0.5
                       :vslot -4
                       :select t
                       :quit nil
                       :ttl nil
                       :side 'bottom
                       :modeline t)))



(after! compile
  (setq compilation-scroll-output 'first-error)
  (setq compilation-auto-jump-to-first-error nil)
  (setq compilation-skip-threshold 2)
  (setq compilation-context-lines t))



(if (modulep! :ui popup)
    (progn
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
      (set-popup-rule! "^\\*rustic-compilation\\*$"
                       :side 'bottom
                       :size 0.5
                       :select t
                       ;; :vslot -1
                       :vslot -4
                       :quit nil
                       :modeline t
                       :ttl nil)

      (set-popup-rule! "^\\*cargo-run\\*$"
                       :side 'right
                       :size 0.5
                       :select t
                       :vslot -4
                       ;; :vslot -1
                       :quit nil
                       :modeline t
                       :ttl nil)
      ;; Modeline in popups
      (plist-put +popup-defaults :modeline t)
      ;; Completely disable management of the mode-line in popups:
      (remove-hook '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)

      ;; Popup disables diff-hl-mode, so remove it
      ;; (add-hook! '+popup-buffer-mode-hook #'+popup-adjust-fringes-h)
      ;; (remove-hook! '+popup-buffer-mode-hook #'+popup-adjust-fringes-h)
      ;; +popup-adjust-margins-h is the function that turns off diff-hl vc-gutter in doom emacs, when popup gets closed
      ;; (add-hook! '+popup-buffer-mode-hook #'+popup-adjust-margins-h)
      (remove-hook! '+popup-buffer-mode-hook #'+popup-adjust-margins-h))) ; TODO: submit-issue



;;; doom modeline
(after! doom-modeline
  (setq doom-modeline-buffer-encoding nil
        doom-modeline-modal t
        doom-modeline-enable-word-count nil
        doom-modeline-persp-name nil
        doom-modeline-minor-modes nil
        doom-modeline-env-version t
        doom-modeline-buffer-name t
        doom-modeline-indent-info nil
        doom-modeline-buffer-file-name-style 'relative-from-project ;doom default
        ;; doom-modeline-buffer-file-name-style 'buffer-name
        ;; doom-modeline-buffer-file-name-style 'truncate-with-project
        ;; doom-modeline-time-analogue-clock t
        doom-modeline-time-live-icon nil
        doom-modeline-time-icon nil          ; the small analogue icon
        doom-modeline-major-mode-icon nil
        display-time-default-load-average nil
        ;; (doom-modeline-def-modeline 'main
        ;;   '(matches bar modals workspace-name window-number persp-name selection-info buffer-info remote-host debug vcs matches)
        ;;   '(github mu4e grip gnus check misc-info repl lsp " "))) ; TODO: Experiment with this later
        doom-modeline-vcs-max-length 60)
  (setq doom-modeline-bar-width 0)) ;; we don't want the bar



;; (after! evil-mc ; FIXME: not working!!
;;   (add-to-list 'evil-mc-custom-known-commands
;;                '(ey/visual-to-last-non-blank-in-current-line
;;                  (:default . evil-mc-execute-default-call)
;;                  (visual . evil-mc-execute-visual-call)))
;;
;;   (add-to-list 'evil-mc-custom-known-commands
;;                '(ey/visual-to-first-non-blank-in-current-line
;;                  (:default . evil-mc-execute-default-call)
;;                  (visual . evil-mc-execute-visual-call)))
;;   )



(after! treemacs
  ;; (setq treemacs-persist-file nil) ; FIXME: this (when commented) may cause some issues. I want it as nil
  (setq treemacs-is-never-other-window (modulep! :ui popup)))

(use-package! drag-stuff
  :defer t)



(after! magit
  (setq magit-diff-refine-hunk t)
  (setq magit-log-section-commit-count 10))

(use-package! magit-todos
  :after magit
  ;; :config
  ;; (setq magit-todos-keyword-suffix "\\(?:([^)]+)\\)?:?") ; make colon optional
  ;; (define-key magit-todos-section-map "j" nil)
  )

(use-package! vdiff
  :defer t
  :config
  (setq vdiff-auto-refine t)
  (setq vdiff-disable-folding t))

(use-package! vdiff-magit ; funny thing, this snippet means nil
  :defer t)

(after! magit
  (transient-append-suffix 'magit-dispatch "Q"
    '(transient-suffix :key "v" :description "vdiff" :command vdiff-magit)))

(after! code-review (setq code-review-auth-login-marker 'forge))



(after! better-jumper
  ;; (setq better-jumper-use-savehist nil)
  ;; (setq better-jumper-savehist t) ; Gives sequence-p ERROR
  ;; (remove-hook! 'better-jumper-pre-jump-hook #'better-jumper-set-jump)
  (setq better-jumper-context 'window))



;;; Keycast Mode ; FIXME: the one in doom-modeline doesn't work
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



(after! diff-hl
  (setq diff-hl-disable-on-remote t)
  (setq diff-hl-margin-left-margin-width 1) ; TODO: PR this??
  (remove-hook 'dired-mode-hook #'+vc-gutter-enable-maybe-h)) ; remove diff-hl in dired buffers



(after! consult
  (consult-customize ey/consult-ripgrep-custom ; Performance!!
                     +vertico/switch-workspace-buffer
                     +default/search-project
                     :preview-key "C-SPC"))



(use-package! elfeed
  :defer t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files
        (list (concat org-directory "org/elfeed.org"))))

(setq elfeed-goodies/feed-source-column-width 22)
(setq elfeed-goodies/tag-column-width 30)



(if (modulep! :completion vertico)
    (use-package! vertico-posframe
      :defer t
      :init (remove-hook 'vertico-mode-hook 'vertico-posframe-mode)
      :config
      (setq vertico-posframe-min-width (frame-pixel-width)
            vertico-posframe-border-width 1
            vertico-posframe-poshandler #'posframe-poshandler-frame-center)))

;; vertico-flat-mode           Flat, horizontal display for Vertico.
;; vertico-grid-mode           Grid display for Vertico.
;; vertico-mouse-mode          Mouse support for Vertico.
;; vertico-buffer-mode         Display Vertico like a regular buffer in a large window.
;; vertico-indexed-mode        Prefix candidates with indices.
;; vertico-reverse-mode        Reverse the Vertico display.
;; vertico-posframe-mode       Display Vertico in posframe instead of the minibuffer.
;; vertico-unobtrusive-mode    Unobtrusive display for Vertico.

(after! vertico
  ;; (setq vertico-count 4
  (setq vertico-count 10
        ;; (setq vertico-count 17 ; doom default
        vertico-flat-max-lines 3
        vertico-flat-annotate nil
        vertico-multiform-commands
        `((execute-extended-command
           (+vertico-transform-functions . +vertico-highlight-enabled-mode)
           ;; posframe
           ;; (vertico-posframe-poshandler . posframe-poshandler-frame-bottom-center)
           ;; (vertico-posframe-min-width . ,(frame-pixel-width))
           ;; (vertico-posframe-border-width . 0)
           )
          ;; (consult-imenu buffer)
          ;; (consult-imenu-multi buffer)
          ;; (consult-outline buffer)
          ;; (consult-eglot-symbols buffer)
          ;; (consult-line buffer)
          ;; (find-file posframe ; `find-file' to use postframes
          ;;            (vertico-posframe-poshandler . posframe-poshandler-frame-bottom-center)
          ;;            (vertico-posframe-min-width . ,(- (frame-pixel-width) 1000))
          ;;            (vertico-posframe-border-width . 1))
          ;; (+default/search-buffer buffer)
          ;; (+default/search-other-window buffer)
          ;; (consult-buffer buffer)
          ;; (+vertico/switch-workspace-buffer flat)
          (consult-bookmark buffer))
        vertico-multiform-categories
        '((file (+vertico-transform-functions . +vertico-highlight-directory))
          (jinx buffer))))



(use-package! dumb-jump
  :defer t
  :init
  (setq xref-show-definitions-function #'consult-xref)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
;; (setq dumb-jump-selector 'completing-read)
;; (setq dumb-jump-selector 'popup)



(after! evil-snipe
  (setq evil-snipe-scope 'whole-buffer)
  (setq evil-snipe-repeat-scope nil)) ; 'whole-buffer



;;; Doom Dashboard
(defun ey/doom-dashboard-draw-emacs-ascii-banner-fn ()
  (let* ((banner
          '(
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

(defun doom-display-benchmark-h (&optional return-p)
  "Display a benchmark including number of packages and modules loaded.

If RETURN-P, return the message as a string instead of displaying it."
  (funcall (if return-p #'format #'message)
           "DEmacs loaded %d packages across %d modules in %.03fs"
           (- (length load-path) (length (get 'load-path 'initial-value)))
           (if doom-modules (hash-table-count doom-modules) -1)
           doom-init-time))

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
  ;; (setq spacious-padding-subtle-mode-line
  ;;       '(:mode-line-active shadow :mode-line-inactive shadow))
  (setq spacious-padding-subtle-mode-line nil)
  (spacious-padding-mode 1))



;; (use-package! stillness-mode
;;   :config
;;   (stillness-mode 1))



(after! isearch
  (setq isearch-lazy-count t)
  (setq isearch-wrap-pause nil)
  (setq search-whitespace-regexp ".*?"))



(use-package! rainbow-mode
  :hook (emacs-lisp-mode . rainbow-mode)
  :hook (help-mode . rainbow-mode)
  :config
  (setq rainbow-x-colors nil)) ; disable the keyword colors in rainbow mode



(use-package! inhibit-mouse
  :defer t
  :config
  (add-hook 'inhibit-mouse-mode-hook
            #'(lambda()
                (if (bound-and-true-p inhibit-mouse-mode)
                    (progn
                      (setq show-help-function nil)
                      (setq mouse-highlight nil))
                  (progn
                    (setq show-help-function #'tooltip-show-help-non-mode)
                    (setq mouse-highlight t))))))



(use-package! bookmark+
  :commands (bmkp-jump-url-browse bmkp--pop-to-buffer-same-window)
  :defer t
  :init
  (setq bmkp-bookmark-map-prefix-keys          (list (kbd " b p"))
        bmkp-jump-map-prefix-keys              (list (kbd " b j"))
        bmkp-jump-other-window-map-prefix-keys (list (kbd " b w j"))))



;; (use-package! ultra-scroll
;;   :init
;;   ;; (setq scroll-conservatively 101 ; important!
;;   ;;         scroll-margin 0)
;;   :config
;;   (ultra-scroll-mode 1))



(use-package! topspace
  :hook (after-init . global-topspace-mode)
  :config

  (defvar +topspace-ignore-modes-list
    '(vterm-mode helpful-mode eshell-mode eat-mode org-agenda-mode shell-mode
      magit-status-mode occur-edit-mode ibuffer-mode embark-collect-mode
      dape-info-scope-mode dape-info-stack-mode dape-info-breakpoints-mode
      dape-repl-mode dape-info-watch-mode dape-info-modules-mode
      dape-info-sources-mode package-menu-mode pdf-view-mode inferior-emacs-lisp-mode
      ;; special mode: e.g. *Warnings* buffer
      Man-mode special-mode occur-mode vdiff-3way-mode-map magit-revision-mode
      shell-command-mode compilation-mode eww-mode devdocs-mode chatgpt-shell-mode
      elfeed-search-mode
      ;; Minor modes
       vdiff-mode)
    "major modes to leave out of topspace") ; REVIEW: PR this??

  (defun +topspace--active-outside-modes-list ()
    "Default function that `topspace-active' is set to.
Return nil if topspace should not exist in the buffer."
    (require 'cl-lib)
    (and (or (not (fboundp 'frame-parent)) ; child frames should return nil
             (not (frame-parent)))
         (and (not (memq major-mode +topspace-ignore-modes-list)) ; check if current `major-mode' is in the ignore list
              (not (provided-mode-derived-p major-mode +topspace-ignore-modes-list)) ; check if a parent mode of `major-mode' is in the ignore list
              (not (cl-some (lambda (mode) ; check if any active local-minor-mode is in the ignore list
                              (member mode local-minor-modes))
                            +topspace-ignore-modes-list)))))

  (setq topspace-active #'+topspace--active-outside-modes-list)) ; major modes to leave out of topspace



(after! visual-fill-column
  (setq visual-fill-column-enable-sensible-window-split t))



(use-package! blamer
  :defer t
  ;; :hook (after-init . global-blamer-mode)
  :config
  (setq blamer-idle-time 1.0
        blamer-commit-formatter "• %s"
        blamer-prettify-time-p t
        blamer-smart-background-p t
        blamer-view 'overlay
        blamer-max-commit-message-length 80
        ;; blamer-author-formatter "  %s, "
        blamer-author-formatter "%s, "
        blamer-force-truncate-long-line nil
        blamer-max-lines 2))



(after! help
  (remove-hook 'helpful-mode-hook 'visual-line-mode)
  (setq help-window-select t))



(use-package! isearch
  :defer t
  :config
  (setq isearch-repeat-on-direction-change nil
        search-nonincremental-instead nil))



(use-package! stock-tracker
  :defer t
  ;; :hook (after-init . stock-tracker-start)
  :init
  ;; (evil-set-initial-state 'stock-tracker-mode 'insert)
  (defadvice! +stock-tracker-start-same-window--a (orig-fun &rest args)
    :around #'stock-tracker-start
    (cl-letf (((symbol-function 'switch-to-buffer-other-window)
               #'switch-to-buffer))
      (apply orig-fun args)))
  :config
  (setq stock-tracker-up-red-down-green nil
        stock-tracker-list-of-stocks '("BABA" "GOOG" "AAPL" "NVDA" "TSLA" "PLTR" "TQQQ" "BTC.CM="))
  (defun stock-tracker-start ()
    "Start stock-tracker, show result in `stock-tracker--buffer-name' buffer."
    (interactive)
    (when stock-tracker-list-of-stocks
      (stock-tracker--cancel-timers)
      (stock-tracker--run-timers)
      (stock-tracker--refresh)
      (unless (get-buffer-window stock-tracker--buffer-name)
        (switch-to-buffer stock-tracker--buffer-name)))))



(use-package! kanagawa-themes
  :defer t
  :init
  (setq kanagawa-themes-org-height nil
        kanagawa-themes-org-bold nil))



(use-package! proced
  :defer t
  :config
  (setq proced-enable-color-flag t
        proced-tree-flag t
        proced-auto-update-flag 'visible
        proced-auto-update-interval 5
        proced-descend t
        proced-filter 'user))



(after! tab-bar
  (setq tab-bar-close-button-show nil
        tab-bar-new-button-show nil
        tab-bar-show 1
        tab-bar-select-tab-modifiers '(control)
        tab-bar-new-tab-to 'rightmost
        tab-bar-position nil
        tab-bar-new-tab-choice 'clone))



(after! gptel
  (setq gptel-prompt-prefix-alist
        '((markdown-mode . "")
          (org-mode . "")
          (text-mode . ""))
        gptel-response-prefix-alist
        '((markdown-mode . "### ")
          (org-mode . "*** ")
          (text-mode . "### "))
        gptel-default-mode 'org-mode
        gptel-use-header-line nil
        gptel-track-media t
        gptel-org-convert-response t
        gptel-expert-commands t))

(use-package! chatgpt-shell
  :defer t
  :config
  (after! gptel
    (setq chatgpt-shell-openai-key #'gptel-api-key-from-auth-source)))



;; Copied from doom
(use-package! eglot
  :commands eglot eglot-ensure
  :hook (eglot-managed-mode . +lsp-optimization-mode)
  :init
  (setq eglot-sync-connect 1
        eglot-autoshutdown t
        eglot-ignored-server-capabilities '(:documentHighlightProvider)
        eglot-extend-to-xref nil ; my minimal is t
        ;; NOTE: We disable eglot-auto-display-help-buffer because :select t in
        ;;   its popup rule causes eglot to steal focus too often.
        eglot-auto-display-help-buffer nil)
  (when (modulep! :checkers syntax -flymake)
    (setq eglot-stay-out-of '(flymake)))

  :config
  (set-popup-rule! "^\\*eglot-help" :size 0.15 :quit t :select t)
  (set-lookup-handlers! 'eglot--managed-mode
    :definition      #'xref-find-definitions
    :references      #'xref-find-references
    :implementations #'eglot-find-implementation
    :type-definition #'eglot-find-typeDefinition
    :documentation   #'+eglot-lookup-documentation)

  ;; Leave management of flymake to the :checkers syntax module.
  (when (modulep! :checkers syntax -flymake)
    (add-to-list 'eglot-stay-out-of 'flymake))

  ;; NOTE: This setting disable the eglot-events-buffer enabling more consistent
  ;;   performance on long running emacs instance. Default is 2000000 lines.
  ;;   After each new event the whole buffer is pretty printed which causes
  ;;   steady performance decrease over time. CPU is spent on pretty priting and
  ;;   Emacs GC is put under high pressure.
  (cl-callf plist-put eglot-events-buffer-config :size 0)

  (set-debug-variable! 'eglot-events-buffer-config '(:size 2000000 :format full))

  (defadvice! +lsp--defer-server-shutdown-a (fn &optional server)
    "Defer server shutdown for a few seconds.
This gives the user a chance to open other project files before the server is
auto-killed (which is a potentially expensive process). It also spares the
server an expensive restart when its buffer is reverted."
    :around #'eglot--managed-mode
    (letf! (defun eglot-shutdown (server)
             (if (or (null +lsp-defer-shutdown)
                     (eq +lsp-defer-shutdown 0))
                 (prog1 (funcall eglot-shutdown server)
                   (+lsp-optimization-mode -1))
               (run-at-time
                (if (numberp +lsp-defer-shutdown) +lsp-defer-shutdown 3)
                nil (lambda (server)
                      (unless (eglot--managed-buffers server)
                        (prog1 (funcall eglot-shutdown server)
                          (+lsp-optimization-mode -1))))
                server)))
      (funcall fn server))))

(use-package! consult-eglot
  :when (modulep! :completion vertico)
  :defer t
  :init
  (map! :after eglot
        :map eglot-mode-map
        [remap xref-find-apropos] #'consult-eglot-symbols))


(use-package! flycheck-eglot
  :when (modulep! :checkers syntax -flymake)
  :hook (eglot-managed-mode . flycheck-eglot-mode))



(after! emacs-mini-frame
  (setq mini-frame-completions-focus 'minibuffer)
  (setq mini-frame-completions-show-parameters
        '(((height . 1.0) (width . 1.0) (left . 1.0))))
  (setq mini-frame-show-parameters
        '((left . 0.5) (top . 0.25) (width . 0.5) (height . 1) (background-color . "#000000")))
  (setq mini-frame-internal-border-color "#FFFFFF")) ; restart the mode to see changes
;; also can make use of `mini-frame-internal-border-color'



;;; Readers
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :hook (nov-mode . mixed-pitch-mode)
  :hook (nov-mode . visual-line-mode)
  :hook (nov-mode . visual-fill-column-mode)
  :config
  (setq nov-text-width t)
  (setq nov-variable-pitch nil))

(use-package! calibredb :defer t)



(after! cc-mode
  (add-hook! 'c++-mode-hook
    (defun +cc-comment-style-to-block ()
      "Use block comments instead of line comments"
      (c-toggle-comment-style 1)))
  (add-hook! 'c-mode-hook
    (defun +cc-comment-style-to-line ()
      "Use block comments instead of line comments"
      (c-toggle-comment-style -1))))

(after! c-ts-mode
  (setq c-ts-mode--feature-list
        '((comment definition) (keyword preprocessor string type)
          (assignment constant function escape-sequence label literal)
          (bracket delimiter error operator property variable))
        c-ts-mode-indent-offset 4
        c-ts-mode--thing-settings
        `(;; It's more useful to include semicolons as sexp so
          ;; that users can move to the end of a statement.
          ;; (sexp (not ,(rx (or "{" "}" "[" "]" "(" ")" ",")))) ; I prefer the regular sexp function
          ;; compound_statement makes us jump over too big units
          ;; of code, so skip that one, and include the other
          ;; statements.
          (sentence
           ,(regexp-opt '("preproc"
                          "declaration"
                          "specifier"
                          "attributed_statement"
                          "labeled_statement"
                          "expression_statement"
                          "if_statement"
                          "switch_statement"
                          "do_statement"
                          "while_statement"
                          "for_statement"
                          "return_statement"
                          "break_statement"
                          "continue_statement"
                          "goto_statement"
                          "case_statement")))
          (text ,(regexp-opt '("comment"
                               "raw_string_literal"))))))



(use-package! jinx
  :defer t
  :config
  (setq jinx-languages "en_US")
  (setq jinx-camel-modes '(prog-mode)))

