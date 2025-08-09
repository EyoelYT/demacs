;;; $DOOMDIR/mappings.el -*- lexical-binding: t; -*-



(map! :map minibuffer-mode-map :n "RET"    #'exit-minibuffer
        ;; :n "<down>" #'vertico-next
        ;; :n "<up>"   #'vertico-previous
        )

(map! :map c-mode-base-map "TAB" nil) ; I want to jump between bracket characters

(map! "C-S-s" #'evil-avy-goto-char-timer)
(map! :leader "p -" #'projectile-dired)

(map!
 :nvm "<up>"   #'evil-previous-visual-line
 :o   "<up>"   #'evil-previous-line
 :nvm "<down>" #'evil-next-visual-line
 :o   "<down>" #'evil-next-line
 :nvm "<home>" #'evil-beginning-of-visual-line
 :nvm "<end>"  #'evil-end-of-visual-line)

(map! "C-<backspace>"   #'doom/delete-backward-word
      "C-S-<delete>"    #'doom/delete-forward-word ; C-<delete> uses kill ring
      "C-S-<backspace>" #'doom/delete-forward-word
      ;; "S-<backspace>"   #'delete-forward-char ; TODO: Add S-DEL for terminal mode ;; Commented because I'm not used to it, and also needs `ey/evil-do-insert-state--advice'
      "<backspace>"     #'evil-delete-backward-char-and-join
      :n "DEL"          #'evil-delete-backward-char-and-join)

;; (after! dirvish
(map! :after dirvish ; TODO: check if this works
      :map dirvish-mode-map
      :gm [left]  nil
      :gm [right] nil
      :gm "g <left>" #'dirvish-subtree-up
      "C-c C-p" #'dirvish-subtree-up
      "C-c C-u" #'dirvish-subtree-up
      :n  "z" nil)
;; )
(map! :leader :map dired-mode-map "d u" #'dired-du-mode)

(after! lsp-mode
  (map! :leader "t h" #'lsp-toggle-symbol-highlight))

(map! :after cc-mode ; where `java-mode' is defined
        :map java-mode-map
        :localleader
        (:prefix ("t" . "Test")
         :desc "Run test class or method"   "t" #'+java/run-test
         :desc "Run all tests in class"     "a" #'dap-java-run-test-class
         :desc "Debug test class or method" "d" #'+java/debug-test
         :desc "Debug all tests in class"   "D" #'dap-java-debug-test-class))

(after! corfu (map! :leader "t A" #'+corfu/toggle-auto-complete))
(map! "C-SPC" #'completion-at-point)
(map! :map minibuffer-local-shell-command-map
      "C-SPC" #'completion-at-point
      "TAB" #'completion-at-point)

;; TODO: move maps into their after! blocks
(map!
 :i "C-u" #'evil-scroll-up
 :i "C-d" #'evil-scroll-down
 :nvi "C-t" #'+workspace/display)

(map!
 "S-<up>" #'ey/scroll-line-and-window-up
 "S-<down>" #'ey/scroll-line-and-window-down
 :nvi "S-<left>" #'ey/evil-scroll-left
 :nvi "S-<right>" #'ey/evil-scroll-right ; emacs-state useful when mark selecting
 :map org-read-date-minibuffer-local-map
 :ni "S-<left>" #'org-calendar-backward-day
 :ni "S-<right>" #'org-calendar-forward-day)

(map! :leader )

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
      :nm "TAB S"         #'+workspace/swap-this-and-other
      :nm "TAB y"         #'+workspace/yank-current-workspace-name
      :nm "TAB S-<left>"  #'+workspace/swap-left
      :nm "TAB S-<right>" #'+workspace/swap-right
      :nm "TAB ,"         #'+workspace/switch-to

      :nm "1"             #'+workspace/switch-to-0
      :nm "2"             #'+workspace/switch-to-1
      :nm "3"             #'+workspace/switch-to-2
      :nm "4"             #'+workspace/switch-to-3
      :nm "5"             #'+workspace/switch-to-4
      :nm "7"             #'+workspace/switch-to-7
      :nm "8"             #'+workspace/switch-to-8
      :nm "9"             #'+workspace/switch-to-9
      :nm "0"             #'+workspace/switch-to-final)

(map!
 :nm "M-1"  #'+workspace/switch-to-0
 :nm "M-2"  #'+workspace/switch-to-1
 :nm "M-3"  #'+workspace/switch-to-2
 :nm "M-4"  #'+workspace/switch-to-3
 :nm "M-5"  #'+workspace/switch-to-4
 :nm "M-6"  #'+workspace/switch-to-5
 :nm "M-7"  #'+workspace/switch-to-6
 :nm "M-8"  #'+workspace/switch-to-7
 :nm "M-9"  #'+workspace/switch-to-8
 :nm "M-0"  #'+workspace/switch-to-final)

;;; Buffer Selection mapping
;; Remap SPC ` to Ctrl-Tab for switching buffers
(map! :nvim "C-<tab>" #'evil-switch-to-windows-last-buffer)
(map! "C-x V" #'shrink-window
      :map resize-window-repeat-map "V" #'shrink-window)
(map! :leader :nvm "b o i" #'ibuffer-other-window)
(after! ibuffer
 (map! :map ibuffer-mode-map :n "S-<return>" #'ibuffer-visit-buffer-other-window)
 (map! :map ibuffer-mode-map :n "g r" #'ibuffer-update))

(after! embark (map! :map embark-buffer-map "s" #'save-buffer))

;; remove C-h to give space for 'embark-prefix-help-command'
(map! :map doom-leader-map
      "w C-h" nil
      "b K" #'kill-buffer-and-window
      "b Q" #'doom/kill-all-buffers
      :map evil-motion-state-map
      "C-w C-h" nil
      :map evil-window-map
      "C-h" nil
      :map general-override-mode-map
      ;; :ei "M-SPC w C-h" nil
      :nvm "SPC w C-h" nil

      :map magit-mode-map ; TODO: needs an after! ??
      :nv "C-w C-h" nil)

;; S-<arrows> to move windows around
(map! :map doom-leader-map
      "w S-<up>"      #'+evil/window-move-up
      "w S-<down>"    #'+evil/window-move-down
      "w S-<left>"    #'+evil/window-move-left
      "w S-<right>"   #'+evil/window-move-right
      "w C-S-<left>"  #'winner-undo
      "w C-S-<right>" #'winner-redo
      "w u"           #'winner-undo
      "w r"           #'winner-redo
      "w Q"           #'doom/window-maximize-buffer
      "w e"           #'doom/window-maximize-buffer)

(map! :nvim "C-." #'doom/window-maximize-buffer)

(if (modulep! :ui popup)
    (map! :leader
          "`" #'+popup/toggle)) ; Global leader binding

(map! :leader
      :map general-override-mode-map
      :nvm "w t" #'transpose-frame)

(map! "M-u" #'upcase-dwim)
(map! "M-c" #'capitalize-dwim)
(map! "M-U" #'downcase-dwim)
(map! "M-C" #'downcase-dwim)

(map! :leader "'" #'vertico-repeat-select)

(map! :leader :map org-mode-map "t a" #'+org-appear-toggle)

;; TODO: try out something like this using `:prefix'
;; (map! :map universal-argument-map
;;         :prefix doom-leader-key     "u" #'universal-argument-more
;;         :prefix doom-leader-alt-key "u" #'universal-argument-more)

(map!
 :nvim "C-S-a" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-e" #'ey/visual-to-last-non-blank-in-current-line
 :nvim "C-S-i" #'ey/visual-to-first-non-blank-in-current-line

 :map vterm-mode-map
 ;; :nvm "C-s" #'evil-avy-goto-char-timer
 :nvm "C-a" #'doom/backward-to-bol-or-indent)

(after! vterm
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

(map! "<f6>"                   #'recompile
      "C-M-<return>"           #'recompile
      :map compilation-shell-minor-mode-map
      :ni "M-<return>"         #'compile-goto-error

      ;; :ni "S-<iso-lefttab>" #'compilation-previous-error
      ;; :ni "<tab>"           #'compilation-next-error

      :ni "M-<up>"             #'compilation-previous-error
      :ni "M-<down>"           #'compilation-next-error

      :ni "M-<right>"          #'compilation-next-file
      :ni "M-<left>"           #'compilation-previous-file)

(when (modulep! :editor multiple-cursors)
  (map! :nv "gz <up>"         #'evil-mc-make-cursor-move-prev-line
        :nv "M-S-<up>"        #'evil-mc-make-cursor-move-prev-line
        :nv "gz <down>"       #'evil-mc-make-cursor-move-next-line
        :nv "M-S-<down>"      #'evil-mc-make-cursor-move-next-line
        :nv "gz S-<up>"       #'evil-mc-make-and-goto-prev-match
        :nv "gz S-<down>"     #'evil-mc-make-and-goto-next-match
        :ni "M-d"             #'evil-multiedit-match-symbol-and-next
        :ni "M-D"             #'evil-multiedit-match-symbol-and-prev
        (:after evil-multiedit
                (:map evil-multiedit-mode-map
                 :nvi "M-d"   #'evil-multiedit-match-and-next
                 :nvi "M-D"   #'evil-multiedit-match-and-prev
                 [return]       nil   ; we want "RET on insert" to input a newline
                 :nv [return] #'evil-multiedit-toggle-or-restrict-region))))

(map! :gvimer "C-q" #'ey/google-search)

(map! :n "z i" #'hs-hide-all
      :n "z u" #'hs-show-all
      :n "z p" #'hs-toggle-hiding)

(map! :leader "i i" #'ey/yank-image-from-win-clipboard-through-powershell)

(map! "<M-up>"    #'drag-stuff-up
      "<M-down>"  #'drag-stuff-down
      "<M-left>"  #'drag-stuff-left
      "<M-right>" #'drag-stuff-right)

(after! vdiff
  (define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map)
  (define-key vdiff-3way-mode-map (kbd "C-c") vdiff-mode-prefix-map))

(map! :leader "g w" #'ey/magit-status-other-window)
(map! :leader "g W" #'ey/magit-status-here-other-window)

(after! magit
  (transient-append-suffix 'magit-dispatch "Q"
    '(transient-suffix :key "v" :description "vdiff" :command vdiff-magit))

  ;; (map! :after vdiff-mode ; FIXME: Remove this (not needed anymore)
  ;;       :map vdiff-mode-map
  ;;       :n "M-N" #'vdiff-previous-hunk
  ;;       :n "M-n" #'vdiff-next-hunk
  ;;       ;; refine
  ;;       :n "M-F" #'vdiff-refine-all-hunks
  ;;       :n "M-x" #'vdiff-remove-refinements-in-hunk
  ;;       ;; folds
  ;;       :n "M->" #'vdiff-next-fold
  ;;       :n "M-<" #'vdiff-previous-fold
  ;;       :n "M-o" #'vdiff-open-fold
  ;;       :n "M-O" #'vdiff-open-all-folds
  ;;       :n "M-cc" #'vdiff-close-fold
  ;;       :n "M-cC" #'vdiff-close-all-folds
  ;;       :n "M-cO" #'vdiff-close-other-folds
  ;;       ;; changes
  ;;       :n "M-s" #'vdiff-send-changes
  ;;       :n "M-S" #'vdiff-send-changes-and-step
  ;;       :n "M-r" #'vdiff-receive-changes
  ;;       :n "M-R" #'vdiff-receive-changes-and-step
  ;;       ;; refine
  ;;       :n "M-f" #'vdiff-refine-this-hunk
  ;;       ;; buffer
  ;;       :n "M-b" #'vdiff-switch-buffer
  ;;       ;; help
  ;;       :n "M-?" #'vdiff-hydra/body
  ;;       ;; toggle
  ;;       :n "M-tc" #'vdiff-toggle-case
  ;;       :n "M-tw" #'vdiff-toggle-whitespace
  ;;       :n "M-q" #'vdiff-quit
  ;;       :n "M-gd" #'vdiff-refresh
  ;;       :n "M-w" #'vdiff-save-buffers)

  (map! :map magit-section-mode-map
        :n "C-<tab>" #'evil-switch-to-windows-last-buffer
        :n "S-<iso-lefttab>" #'magit-section-cycle
        :n "C-S-<iso-lefttab>" #'magit-section-cycle-global
        :map magit-status-mode-map
        :n "M-RET"   #'magit-diff-visit-worktree-file-other-window
        :n "S-<return>"   #'magit-diff-visit-worktree-file-other-window
        :map magit-diff-mode-map
        :n "M-RET"   #'magit-diff-visit-worktree-file-other-window
        :n "S-<return>"   #'magit-diff-visit-worktree-file-other-window
        ;; :map magit-diff-section-map
        ;; :n "S-<return>"   #'magit-diff-visit-worktree-file-other-window
        ;; :map magit-diff-section-base-map
        ;; :n "S-<return>"   #'magit-diff-visit-worktree-file-other-window
        :map magit-mode-map
        :nv "C-S-<down>" #'magit-section-forward
        :nv "C-S-<up>" #'magit-section-backward))

(map! :leader "p t" #'magit-todos-list)

(map! :leader
      "f o" #'ey/find-file-under-selection-other-window
      "f w" #'ey/find-file-under-selection-other-window
      "b w" #'ey/consult-workspace-buffer-other-window ; current workspace only
      "w b" #'ey/consult-workspace-buffer-other-window
      "b W" #'consult-buffer-other-window)             ; across workspaces

(map! :leader
      "s w" #'ey/open-duplicate-window-and-search)

(map! :leader
      "l f" #'ey/find-files-recursively
      "l a" #'ey/find-all-dirs-and-files-recursively)

(map! "C-S-d" #'duplicate-dwim)

(map! :leader "f d" #'ey/consult-fd-or-find)

(map! :leader "r g" #'ey/consult-ripgrep-custom)
(map! :leader "r f" #'consult-line)
(map! :leader "s F" #'consult-flycheck)

(after! diff-hl
  (map! :map diff-hl-show-hunk-map "s" #'diff-hl-show-hunk-stage-hunk))

(map! :leader
      "t d" #'global-diff-hl-mode
      "t D" #'diff-hl-margin-mode
      "g d" #'diff-hl-revert-hunk
      "g x" #'diff-hl-revert-hunk
      "g =" #'diff-hl-show-hunk)
(map! :leader "i n" #'nerd-icons-insert)

(map!
 :map org-agenda-keymap
 :m "C-<return>" #'ey/org-agenda-goto-narrowed-subtree
 :map org-agenda-mode-map
 :m "S-<up>"     #'ey/scroll-line-and-window-up
 :m "S-<down>"   #'ey/scroll-line-and-window-down
 :m "C-<return>" #'ey/org-agenda-goto-narrowed-subtree
 :map org-mode-map
 :m "S-<up>"     #'ey/scroll-line-and-window-up
 :m "S-<down>"   #'ey/scroll-line-and-window-down)

(after! vertico
  (map! :map vertico-map
        [remap evil-delete-backward-char-and-join] #'vertico-directory-delete-char
        :map vertico-flat-map
        [remap left-char] 'left-char
        [remap right-char] 'right-char))

;; (map! :leader "o p" #'treemacs)
;; (map! :leader "o p" #'+treemacs/toggle) ; better!

(after! evil-maps
  (map!
   :map evil-normal-state-map "C-p"     #'ey/compile
   ;; "<left>"  #'left-char
   ;; "<right>" #'right-char
   :map comint-mode-map :n    "C-p"     #'ey/compile
   :map evil-insert-state-map "C-p"     #'ey/compile))

(after! org-colview
  (map! :map org-columns-map
        "g" nil
        "r" nil
        "g r"       #'org-columns-redo
        "S-<up>"    #'scroll-down-line
        "S-<down>"  #'scroll-up-line
        "S-<left>"  #'evil-scroll-left
        "S-<right>" #'evil-scroll-right))

(map! :leader "b U" #'bmkp-url-target-set)
(map! :leader "d O" #'xref-find-definitions-other-window)
(map! :leader "t T" #'topspace-mode)
(map! :leader "t C" #'ey/toggle-center-buffer-content)
(map! :leader "l t" #'ey/toggle-sane-line-numbers)
(map! :leader "l T" #'global-display-line-numbers-mode)
(map! :leader "t B" #'global-blamer-mode)

;;; Highlight Changes
(map! :leader "t H" #'highlight-changes-mode)
(map! :n "]H" #'highlight-changes-next-change)
(map! :n "[H" #'highlight-changes-previous-change)

(after! helpful (global-set-key [remap describe-symbol] #'helpful-symbol))

(map! "C-s" #'ey/window-search)
(map! :map isearch-mode-map "<tab>"     #'isearch-repeat-forward)
(map! :map isearch-mode-map "TAB"       #'isearch-repeat-forward) ; needed when in terminal
(map! :map isearch-mode-map "<escape>"  #'isearch-cancel)
(map! :map isearch-mode-map "<backtab>" #'isearch-repeat-backward)
(map! :g "M-t" #'ey/search-and-search)

(map! :leader
      "v v"         #'+tab-bar-show-tabs
      "v N"         #'+tab-bar-new-named-tab
      "v n"         #'tab-bar-new-tab
      "v r"         #'tab-bar-rename-tab
      "v d"         #'tab-bar-close-tab
      "v S <right>" #'tab-bar-move-tab
      "v S <left>"  #'tab-bar-move-tab-backward)

(map! :after evil-org
      :map evil-org-mode-map
      :im [return] nil ; FIXME: remove when doom upgrade
      :mnv "g l" nil ; I want evil-lion-left to work
      :i "C-h" nil) ; Disable annoying org-beginning-of-line ; TODO: Working?

(map! :map gptel-mode-map :nv "RET" nil) ; I don't want to accidentally send stuff!!

(map! :leader "s O" #'+default/search-buffer-other-window)
;; (map! "C-," #'ey/get-local-keymap-name)
(map! "C-," #'+default/search-buffer)

(map! :leader "s m" #'ey/show-modeline-in-echo-area)
(map! :leader "s M" #'global-hide-mode-line-mode)
(map! :map org-mode-map [remap doom/backward-to-bol-or-indent] nil) ; Use `doom/backward-to-bol-or-indent' in org-mode
