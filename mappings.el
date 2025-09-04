;;; $DOOMDIR/mappings.el -*- lexical-binding: t; -*-



(map! "C-S-s"                  #'evil-avy-goto-char-timer
      "C-S-d"                  #'duplicate-dwim
      "C-S-h"                  #'hrm-help-transient

      "M-t"                    #'ey/search-and-search
      :gm "C-s"                #'ey/window-search
      :gm "C-S-a"              #'ey/visual-to-last-non-blank-in-current-line
      :gm "C-S-e"              #'ey/visual-to-last-non-blank-in-current-line
      :gm "C-S-i"              #'ey/visual-to-first-non-blank-in-current-line

      :mi "C-t"                #'+workspace/display
      :ng "C-."                #'doom/window-maximize-buffer
      "C-x V"                  #'shrink-window

      "M-u"                    #'upcase-dwim
      "M-c"                    #'capitalize-dwim
      "M-U"                    #'downcase-dwim
      "M-C"                    #'downcase-dwim

      :m "S-<up>"              #'ey/scroll-line-and-window-up
      :m "S-<down>"            #'ey/scroll-line-and-window-down
      :m "S-<left>"            #'ey/evil-scroll-left
      :m "S-<right>"           #'ey/evil-scroll-right ; emacs-state useful when mark selecting

      "C-<backspace>"          #'doom/delete-backward-word
      "C-S-<delete>"           #'doom/delete-forward-word ; C-<delete> uses kill ring
      "C-S-<backspace>"        #'doom/delete-forward-word
      ;; "S-<backspace>"       #'delete-forward-char ; TODO: Add S-DEL for terminal mode ;; Commented because I'm not used to it, and also needs `ey/evil-do-insert-state--advice'

      :m "M-1"                 #'+workspace/switch-to-0
      :m "M-2"                 #'+workspace/switch-to-1
      :m "M-3"                 #'+workspace/switch-to-2
      :m "M-4"                 #'+workspace/switch-to-3
      :m "M-5"                 #'+workspace/switch-to-4
      :m "M-6"                 #'+workspace/switch-to-5
      :m "M-7"                 #'+workspace/switch-to-6
      :m "M-8"                 #'+workspace/switch-to-7
      :m "M-9"                 #'+workspace/switch-to-8
      :m "M-0"                 #'+workspace/switch-to-final

      :n "z i"                 #'hs-hide-all
      :n "z u"                 #'hs-show-all
      :n "z p"                 #'hs-toggle-hiding

      "<M-up>"                 #'drag-stuff-up
      "<M-down>"               #'drag-stuff-down
      "<M-left>"               #'drag-stuff-left
      "<M-right>"              #'drag-stuff-right

      :m "]X"                  #'highlight-changes-next-change
      :m "[X"                  #'highlight-changes-previous-change

      [remap describe-symbol]  #'helpful-symbol

      "C-,"                    #'+default/search-buffer

      :n "z="                  #'jinx-correct
      :m "[s"                  #'jinx-previous
      :m "]s"                  #'jinx-next

      "<f6>"                   #'recompile
      "C-M-<return>"           #'recompile

      :m "<escape>"                   #'doom/escape

      (:after evil
       "<backspace>"           #'evil-delete-backward-char-and-join
       :n "DEL"                #'evil-delete-backward-char-and-join

       :m "<up>"               #'evil-previous-visual-line
       :o "<up>"               #'evil-previous-line
       :m "<down>"             #'evil-next-visual-line
       :o "<down>"             #'evil-next-line
       :m "<home>"             #'evil-beginning-of-visual-line
       :m "<end>"              #'evil-end-of-visual-line

       :i "C-u"                #'evil-scroll-up
       :i "C-d"                #'evil-scroll-down

       :nvim "C-<tab>"         #'evil-switch-to-windows-last-buffer ; overwrite aya mappings

       :gmi "C-q"              #'ey/google-search)

      (:after evil-org
       :map evil-org-mode-map
       :im [return] nil ; FIXME: remove when doom upgrade
       :mnv "g l" nil ; I want evil-lion-left to work
       :i "C-h" nil) ; Disable annoying org-beginning-of-line ; TODO: Working?

      (:map minibuffer-mode-map
       ;; :n "<down>"          #'vertico-next
       ;; :n "<up>"            #'vertico-previous
       :n "RET"                #'exit-minibuffer)

      (:after corfu
       "C-SPC"                 #'completion-at-point
       :map corfu-mode-map
       :i "C-S-SPC"            #'cape-dabbrev)

      (:map minibuffer-local-shell-command-map
            "C-SPC"            #'completion-at-point
            "TAB"              #'completion-at-point)

      (:map c-mode-base-map
            "TAB" nil) ; I want to jump between bracket characters

      (:after dirvish
       :map dirvish-mode-map
       "C-c C-p"               #'dirvish-subtree-up
       "C-c C-u"               #'dirvish-subtree-up
       :gm [left]  nil
       :gm [right] nil
       :gm "g <left>"          #'dirvish-subtree-up
       :n  "z" nil)

      (:after cc-mode
       :map java-mode-map ; where `java-mode' is defined
       :localleader
       (:prefix ("t" . "Test")
                "t"            #'+java/run-test
                "a"            #'dap-java-run-test-class
                "d"            #'+java/debug-test
                "D"            #'dap-java-debug-test-class))

      (:after org
       :map org-mode-map
       ;; Use `doom/backward-to-bol-or-indent' in org-mode (unmap doom's remap
       ;; to `org-beginning-of-line')
       [remap doom/backward-to-bol-or-indent] nil
       :map org-read-date-minibuffer-local-map
       :ni "S-<left>"          #'org-calendar-backward-day
       :ni "S-<right>"         #'org-calendar-forward-day
       :ni "S-<up>"            #'org-calendar-backward-week
       :ni "S-<down>"          #'org-calendar-forward-week
       :map org-mode-map
       :i  "S-<left>"          #'org-shiftleft
       :i  "S-<right>"         #'org-shiftright)

      (:map resize-window-repeat-map
            "V"                #'shrink-window)

      (:after ibuffer
       :map ibuffer-mode-map
       :n "S-<return>"         #'ibuffer-visit-buffer-other-window
       :n "g r"                #'ibuffer-update)

      (:after embark
       ;; remove C-h to give space for 'embark-prefix-help-command'
       ;; (:map evil-motion-state-map
       ;;       "C-w C-h" nil)
       ;; (:map evil-window-map
       ;;       "C-h" nil)
       ;; (:map general-override-mode-map
       ;;  ;; :ei "M-SPC w C-h" nil
       ;;  :nvm "SPC w C-h" nil)
       ;; (:after magit
       ;;  :map magit-mode-map
       ;;  :nv "C-w C-h" nil)
       :map embark-buffer-map
       "s"                     #'save-buffer)

      (:after vterm
       :map vterm-mode-map
       :i "M-1"                #'+workspace/switch-to-0
       :i "M-2"                #'+workspace/switch-to-1
       :i "M-3"                #'+workspace/switch-to-2
       :i "M-4"                #'+workspace/switch-to-3
       :i "M-5"                #'+workspace/switch-to-4
       :i "M-6"                #'+workspace/switch-to-5
       :i "M-7"                #'+workspace/switch-to-6
       :i "M-8"                #'+workspace/switch-to-7
       :i "M-9"                #'+workspace/switch-to-8
       :i "M-0"                #'+workspace/switch-to-final
       "C-<delete>"            #'+vterm-send-C-delete
       "C-S-<delete>"          #'+vterm-send-C-delete
       "C-S-<backspace>"       #'+vterm-send-C-delete
       :m "C-a"                #'doom/backward-to-bol-or-indent
       :m "C-<up>"             #'backward-paragraph
       :m "C-<down>"           #'forward-paragraph
       :m "C-<left>"           #'left-word
       :m "C-<right>"          #'right-word)

      (:map compilation-shell-minor-mode-map
       ;; :m "S-<iso-lefttab>" #'compilation-previous-error
       ;; :m "<tab>"           #'compilation-next-error
       :n "M-<return>"         #'compile-goto-error
       :m "M-<up>"             #'compilation-previous-error
       :m "M-<down>"           #'compilation-next-error
       :m "M-<right>"          #'compilation-next-file
       :m "M-<left>"           #'compilation-previous-file)

      (:when (modulep! :editor multiple-cursors)
        ;; leave the insert states (esp in org mode (shifttime))
        :n "M-S-<up>"          #'evil-mc-make-cursor-move-prev-line
        :n "M-S-<down>"        #'evil-mc-make-cursor-move-next-line
        :n "gz <up>"           #'evil-mc-make-cursor-move-prev-line
        :n "gz <down>"         #'evil-mc-make-cursor-move-next-line
        :n "gz                 #" #'evil-mc-make-and-goto-prev-match
        :n "gz*"               #'evil-mc-make-and-goto-next-match
        :n "M-S-<left>"        #'evil-mc-make-and-goto-prev-match
        :n "M-S-<right>"       #'evil-mc-make-and-goto-next-match
        :ni "M-d"              #'evil-multiedit-match-symbol-and-next
        :ni "M-D"              #'evil-multiedit-match-symbol-and-prev
        (:after evil-multiedit
         :map evil-multiedit-mode-map
         :nvi "M-d"            #'evil-multiedit-match-and-next
         :nvi "M-D"            #'evil-multiedit-match-and-prev
         :i [return]    nil ; we want "return on insert" to input a newline
         :i "RET"       nil ; we want "RET on insert" to input a newline
         :nv [return]          #'evil-multiedit-toggle-or-restrict-region
         :nv "RET"             #'evil-multiedit-toggle-or-restrict-region))

      (:after vdiff
       :map vdiff-mode-map
       "C-c" vdiff-mode-prefix-map
       :map vdiff-3way-mode-map
       "C-c" vdiff-mode-prefix-map)

      (:after trasient
       :map transient-map
       "<escape>"              #'transient-quit-one)

      (:after magit
       :map magit-section-mode-map
       :ng "C-<tab>"           #'evil-switch-to-windows-last-buffer
       :ng "<backtab>"         #'magit-section-cycle
       :ng "C-S-<iso-lefttab>" #'magit-section-cycle-global
       :ng "C-S-<down>"        #'magit-section-forward
       :ng "C-S-<up>"          #'magit-section-backward
       :ng "M-RET"             #'magit-diff-visit-worktree-file-other-window
       :ng "S-<return>"        #'magit-diff-visit-worktree-file-other-window
       :map magit-diff-section-map
       "C-<return>"       #'magit-diff-visit-file-other-window)

      (:after diff-hl
       :map diff-hl-show-hunk-map
       "s"                     #'diff-hl-show-hunk-stage-hunk)

      (:after org-agenda
       :map org-agenda-keymap
       :m "C-<return>"         #'ey/org-agenda-goto-narrowed-subtree)

      (:after vertico
       :map vertico-map
       [remap
        evil-delete-backward-char-and-join]
       #'vertico-directory-delete-char
       :map vertico-flat-map
       [remap left-char]        'left-char
       [remap right-char]       'right-char)

      (:after evil-maps
       :n "C-p"                #'ey/compile) ; after `evil-paste-pop' or whatever was binded

      (:after org-colview
       :map org-columns-map
       "g" nil
       "r" nil
       "g r"                   #'org-columns-redo
       "S-<left>"              #'ey/evil-scroll-left
       "S-<right>"             #'ey/evil-scroll-right)

      (:map isearch-mode-map
            "<tab>"            #'isearch-repeat-forward
            "TAB"              #'isearch-repeat-forward ; needed when in terminal
            "<escape>"         #'isearch-cancel
            "<backtab>"        #'isearch-repeat-backward)

      (:after gptel
       :map gptel-mode-map ; I don't want to accidentally send stuff!!
       :nv "RET"        nil
       :nv "S-<return>" nil
       :nv "S-RET"      nil
       "C-c RET"        nil)

      (:after devdocs
       :map devdocs-mode-map
       :n ">"                  #'devdocs-next-page
       :n "<"                  #'devdocs-previous-page
       :n "p"                  #'devdocs-peruse
       :n "U"                  #'devdocs-update-all)

      (:map tabulated-list-mode-map
       :n "gr"                 #'tabulated-list-revert) ; PR to `evil-collection'?

      (:map special-mode-map
            "TAB"              #'forward-button)

      (:leader

       "l f"                   #'ey/find-files-recursively
       "l a"                   #'ey/find-all-dirs-and-files-recursively
       "f d"                   #'ey/consult-fd-or-find
       "r g"                   #'ey/consult-ripgrep-custom
       "r f"                   #'consult-line
       "s F"                   #'consult-flycheck
       "s w"                   #'ey/duplicate-window-and-search-buffer
       "s O"                   #'+default/search-other-window

       "f o"                   #'ey/find-file-under-selection-other-window
       "f w"                   #'ey/find-file-under-selection-other-window
       "b w"                   #'ey/consult-workspace-buffer-other-window ; current workspace only
       "w b"                   #'ey/consult-workspace-buffer-other-window
       "b W"                   #'consult-buffer-other-window ; across workspaces
       "b U"                   #'bmkp-url-target-set

       "d O"                   #'xref-find-definitions-other-window
       "t a"                   #'+org-appear-toggle
       "t A"                   #'+corfu/toggle-auto-complete
       "t t"                   #'topspace-mode
       "t T"                   #'global-topspace-mode
       "t C"                   #'ey/toggle-center-buffer-content
       "l t"                   #'ey/toggle-sane-line-numbers
       "l T"                   #'global-display-line-numbers-mode
       "t B"                   #'global-blamer-mode
       "t H"                   #'highlight-changes-mode
       "t s"                   #'jinx-mode
       "t S"                   #'global-jinx-mode

       "'"                     #'vertico-repeat-select
       "i n"                   #'nerd-icons-insert
       "i i"                   #'ey/yank-image-from-win-clipboard-through-powershell

       "p t"                   #'magit-todos-list
       "t d"                   #'global-diff-hl-mode
       "t D"                   #'diff-hl-margin-mode
       "g d"                   #'diff-hl-revert-hunk
       "g x"                   #'diff-hl-revert-hunk
       "g ="                   #'diff-hl-show-hunk
       "g w"                   #'ey/magit-status-other-window
       "g W"                   #'ey/magit-status-here-other-window
       "p -"                   #'projectile-dired
       "d u"                   #'dired-du-mode

       "b K"                   #'kill-buffer-and-window
       "b Q"                   #'doom/kill-all-buffers

       "w t"                   #'transpose-frame
       "w C-h"         nil
       "w S-<up>"              #'+evil/window-move-up
       "w S-<down>"            #'+evil/window-move-down
       "w S-<left>"            #'+evil/window-move-left
       "w S-<right>"           #'+evil/window-move-right
       "w C-S-<left>"          #'winner-undo
       "w C-S-<right>"         #'winner-redo
       "w u"                   #'winner-undo
       "w r"                   #'winner-redo
       "w e"                   #'doom/window-maximize-buffer
       "w M"                   #'doom/window-maximize-buffer
       "w Q"                   #'doom/window-maximize-buffer
       "b o i"                 #'ibuffer-other-window

       "s m"                   #'ey/show-modeline-in-echo-area
       "s M"                   #'global-hide-mode-line-mode

       ;; "o p"                #'treemacs
       ;; "o p"                #'+treemacs/toggle ; doom's better half!

       "o x"                   #'devdocs-lookup
       "o X"                   #'devdocs-lookup-all

       "v v"                   #'+tab-bar-show-tabs
       "v N"                   #'+tab-bar-new-named-tab
       "v n"                   #'tab-bar-new-tab
       "v r"                   #'tab-bar-rename-tab
       "v d"                   #'tab-bar-close-tab
       "v S <right>"           #'tab-bar-move-tab
       "v S <left>"            #'tab-bar-move-tab-backward

       "<left>"                #'evil-window-left
       "<right>"               #'evil-window-right
       "<up>"                  #'evil-window-up
       "<down>"                #'evil-window-down

       "TAB <left>"            #'+workspace/switch-left
       "TAB <right>"           #'+workspace/switch-right
       "TAB ,"                 #'+workspace/switch-to
       "TAB ."                 #'ey/+workspace/switch-to-last-focus
       "TAB S"                 #'+workspace/swap-this-and-other
       "TAB y"                 #'+workspace/yank-current-workspace-name
       "TAB S-<left>"          #'+workspace/swap-left
       "TAB S-<right>"         #'+workspace/swap-right

       "1"                     #'+workspace/switch-to-0
       "2"                     #'+workspace/switch-to-1
       "3"                     #'+workspace/switch-to-2
       "4"                     #'+workspace/switch-to-3
       "5"                     #'+workspace/switch-to-4
       "7"                     #'+workspace/switch-to-7
       "8"                     #'+workspace/switch-to-8
       "9"                     #'+workspace/switch-to-9
       "0"                     #'+workspace/switch-to-final

       (:when (modulep! :ui popup)
         "`"                   #'+popup/toggle)
       (:after lsp-mode
               "t h"           #'lsp-toggle-symbol-highlight)))

;; TODO: try out something like this using `:prefix'
;; (map! :map universal-argument-map
;;         :prefix doom-leader-key     "u" #'universal-argument-more
;;         :prefix doom-leader-alt-key "u" #'universal-argument-more)
