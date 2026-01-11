;;; eyth-doom-vibrant-theme.el --- Description -*- lexical-binding: t; -*-
;;
;; Created: March 03, 2025
;; Modified: March 03, 2025
;; Author: Eyoel Tesfu <eyoelytesfu@gmail.com>
;; Maintainer: Eyoel Tesfu <eyoelytesfu@gmail.com>
;; Homepage: https://github.com/EyoelYT/demacs
;; Source: doom-vibrant
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)
;;
;;; Variables

(defgroup eyth-doom-vibrant-theme nil
  "Options for the `doom-vibrant' theme."
  :group 'doom-themes)

(defcustom eyth-doom-vibrant-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'eyth-doom-vibrant-theme
  :type 'boolean)

(defcustom eyth-doom-vibrant-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'eyth-doom-vibrant-theme
  :type 'boolean)

(defcustom eyth-doom-vibrant-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'eyth-doom-vibrant-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme eyth-doom-vibrant
  "A dark theme based off of doom-one with more vibrant colors."
  :family 'doom-one
  :background-mode 'light

  ;; name        gui       256           16
  (
   ;; (bg         '("#242730" "black"       "black" )) ; original doom vibrant bg
   (bg         '("#1a1b26" "black"       "black" ))    ; tokyo night bg
   (fg         '("#bbc2cf" "#bfbfbf"     "brightwhite" ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#2a2e38" "black"       "black"       ))
   (fg-alt     '("#5D656B" "#5d5d5d"     "white"       ))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("#1c1f24" "#101010"     "black"       ))
   (base1      '("#1c1f24" "#1e1e1e"     "brightblack" ))
   (base2      '("#21272d" "#21212d"     "brightblack" ))
   (base3      '("#23272e" "#262626"     "brightblack" ))
   (base4      '("#484854" "#5e5e5e"     "brightblack" ))
   (base5      '("#62686E" "#666666"     "brightblack" ))
   (base6      '("#757B80" "#7b7b7b"     "brightblack" ))
   (base7      '("#9ca0a4" "#979797"     "brightblack" ))
   (base8      '("#DFDFDF" "#dfdfdf"     "white"       ))

   (grey       base4)
   (red        '("#ff665c" "#ff6655"    "red"             ))
   (orange     '("#e69055" "#dd8844"    "brightred"       ))
   (green      '("#7bc275" "#99bb66"    "green"           ))
   (dark-green '("#004b1f" "#003b1f"    "darkgreen"       ))
   (teal       '("#4db5bd" "#44b9b1"    "brightgreen"     ))
   (yellow     '("#FCCE7B" "#ECBE7B"    "yellow"          ))
   (yellow-yellow '("#FFEA00" "#FFEA00" "yellowyellow"    ))
   (blue       '("#51afef" "#51afef"    "brightblue"      ))
   (dark-blue  '("#1f5582" "#2257A0"    "blue"            ))
   (magenta    '("#C57BDB" "#c678dd"    "brightmagenta"   ))
   (violet     '("#a991f1" "#a9a1e1"    "magenta"         )) ;a9a1e1
   (dviolet     '("#4c006e" "#5e0087"   "dviolet"         ))
   (cyan       '("#5cEfFF" "#46D9FF"    "brightcyan"      ))
   (dark-cyan  '("#6A8FBF" "#5699AF"    "cyan"            ))

   ;; These are the "universal syntax classes" that doom-themes establishes.
   ;; These *must* be included in every doom themes, or your theme will throw an
   ;; error, as they are used in the base theme defined in doom-themes-base.
   (highlight      blue)
   (vertical-bar   base0)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if eyth-doom-vibrant-brighter-comments dark-cyan base5))
   (doc-comments   (if eyth-doom-vibrant-brighter-comments (doom-lighten dark-cyan 0.15) (doom-lighten base4 0.3)))
   (constants      violet)
   (functions      cyan)
   (keywords       blue)
   (methods        violet)
   (operators      magenta)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         "#3d4451")
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    yellow)
   (vc-added       green)
   (vc-deleted     red)

   ;; These are extra color variables used only in this theme; i.e. they aren't
   ;; mandatory for derived themes.
   (modeline-fg             fg)
   (modeline-fg-inactive    (doom-blend blue grey (if eyth-doom-vibrant-brighter-modeline 0.9 0.2)))
   (modeline-bg             bg)

   (modeline-bg-inactive     `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0)))
   (modeline-bg-active       `(,(doom-darken (car bg-alt) 0.2) ,@(cdr base0)))
   (modeline-bg-alt-inactive (doom-darken bg 0.25))

   (-modeline-pad
    (when eyth-doom-vibrant-padded-modeline
      (if (integerp eyth-doom-vibrant-padded-modeline) eyth-doom-vibrant-padded-modeline 4))))


  ;;;; Base theme face overrides
  ;; TODO: add the font-lock faces
  ;; TODO: add the tree-sitter faces
  (((font-lock-comment-face &override)
    :background (if eyth-doom-vibrant-brighter-comments (doom-darken bg-alt 0.095) 'unspecified))
   (cursor :background yellow-yellow)
   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground blue :bold bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-inactive
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-active
    :background modeline-bg-active :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if eyth-doom-vibrant-brighter-modeline base8 highlight))
   (org-block :background (doom-darken base3 0.1))
   ;; (org-column :weight normal :slant normal :background bg :underline nil :strike-through nil) ; FIXME: :weight normal -> giving "Debugger entered--Lisp error: (void-variable normal)" errors
   (+org-todo-onhold :foreground yellow-yellow :bold bold)
   (+org-todo-cancel :foreground red :bold bold)
   (+org-todo-project :foreground blue :bold bold)

   ;;;; all-the-icons
   ((all-the-icons-dblue &override) :foreground dark-cyan)
   ;;;; centaur-tabs
   (centaur-tabs-unselected :background bg-alt :foreground base6)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar          :background bg)
   (doom-modeline-bar          :background (if (and (bound-and-true-p spacious-padding-mode) (not (bound-and-true-p spacious-padding-subtle-mode-line)))
                                               modeline-bg-inactive
                                             bg))
   (doom-modeline-bar-inactive :background (if (and (bound-and-true-p spacious-padding-mode) (not (bound-and-true-p spacious-padding-subtle-mode-line)))
                                               modeline-bg-inactive
                                             bg))
   (doom-modeline-buffer-path
    :foreground (if eyth-doom-vibrant-brighter-modeline base8 blue) :bold bold)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; markdown-mode
   (markdown-header-face :inherit 'bold :foreground red)
   ;;;; Tree-sitter
   ;; (tree-sitter-hl-face:punctuation.bracket :foreground comments)
   ;; (tree-sitter-hl-face:attribute :foreground blue)
   (tree-sitter-hl-face:function\.call :foreground functions)
   ;; (tree-sitter-hl-face:function\.macro :foreground magenta)
   ;; (tree-sitter-hl-face:type\.builtin :foreground teal :italic t)
   ;; (tree-sitter-hl-face:variable\.special :foreground constants)
   ;; (tree-sitter-hl-face:operator :foreground operators)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg)
   (solaire-default-face :background bg)
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background (if (and (bound-and-true-p spacious-padding-mode) (not (bound-and-true-p spacious-padding-subtle-mode-line)))
                                             'unspecified
                                           modeline-bg-alt-inactive)
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt-inactive)))
   ;;;; whitespace <built-in>
   ;; (whitespace-empty :background base4)
   (whitespace-space   :foreground base3)
   (whitespace-newline :foreground bg)
   ;;;; corfu
   (corfu-current :background dviolet)
   ;;;; eldoc
   (eldoc-highlight-function-argument :foreground fg :bold bold)
   ;;;; ediff
   ;; (ediff-fine-diff-C )
   ;; (ediff-fine-diff-B )
   ;; (ediff-fine-diff-A :weight normal :background dark-green :extend t) ; FIXME: :weight normal -> giving "Debugger entered--Lisp error: (void-variable normal)" errors
   )

  ;;;; Base theme variable overrides
  ;; ()
  )

;;; eyth-doom-vibrant-theme.el ends here
