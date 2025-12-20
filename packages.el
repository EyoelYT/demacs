;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)
                                        ;

;; Jupyter Support
;; (package! jupyter)
;; (package! ein)

;; Themes
(package! ef-themes :recipe (:host github :repo "protesilaos/ef-themes" :depth 1))
(package! doric-themes :recipe (:host github :repo "protesilaos/doric-themes" :depth 1))
(package! naysayer-theme)
(package! gruber-darker-theme)
(package! avk-emacs-themes)
(package! anti-zenburn-theme)
(package! catppuccin-theme)
;; (package! tao-theme) ; Error "%s is not a color"
(package! inkpot-theme)
(package! idea-darkula-theme)
(package! atom-one-dark-theme)
(package! kanagawa-themes :recipe (:host github :repo "EyoelYT/kanagawa-emacs"))
(package! the-matrix-theme)
(package! vscdark-theme :recipe (:host github :repo "EyoelYT/vscdark-theme"))
(package! hercules-theme :recipe (:host github :repo "0xcefaedfe/hercules-theme"))
(package! ubuntu-theme)
(package! nordic-night-theme :recipe (:host github :repo "EyoelYT/nordic-night"))

;; (package! github-modern-theme) ;; Deprecated?
;; (package! acme-theme)          ;; Deprecated?
(package! github-dark-vscode-theme)
(package! eclipse-theme)
(package! blackboard-theme)
(package! borland-blue-theme)
(package! cloud-theme)
(package! ahungry-theme)
(package! color-theme-sanityinc-solarized)
(package! color-theme-sanityinc-tomorrow)
(package! commentary-theme)
(package! professional-theme)
;; (package! nano-theme)
(package! nubox)
(package! obsidian-theme)
(package! rebecca-theme)
;; (package! remember-last-theme) ; Disappeared from github
(package! reykjavik-theme)
(package! soft-morning-theme)
(package! spacemacs-theme)
(package! standard-themes)
(package! starlit-theme)
(package! stimmung-themes)
(package! subatomic-theme)
(package! subatomic256-theme)
(package! sweet-theme)
;; (package! vscode-dark-plus-theme) ; Error: Invalid face box
;; (package! white-theme) ; Error: it just disappeared from github
(package! xresources-theme)
(package! yabaki-theme)
(package! silkworm-theme)
(package! soft-morning-theme)
(package! soft-stone-theme)
(package! spacemacs-theme)
(package! subatomic-theme)
;; (package! moe-theme) ; Errors out "%s is not a valid theme"
(package! kaolin-themes)
(package! gotham-theme)
(package! stimmung-themes)
(package! paper-theme)
(package! grey-paper-theme)
(package! jazz-theme)
(package! kuronami-theme)
;; (package! apropospriate-theme) ; Errors out "%s is not a valid theme"
;; (package! danneskjold-theme) ; org mode looks bad atm
(package! codex-theme)
(package! helix-theme)
(package! doom-nano-themes :recipe (:host github :repo "ronisbr/doom-nano-themes" :depth 1))
(package! busybee-theme)
;; (package! nofrils-acme-theme) ; git fetch returns 503 url error
(package! wildcharm-light-theme)
(package! wildcharm-theme)
(package! grandshell-theme)
(package! tron-legacy-theme)
(package! hemisu-theme)
(package! cyberpunk-theme)
(package! haki-theme)
(package! hc-zenburn-theme)
(package! prassee-theme)
(package! grayscale-theme)
(package! kosmos-theme)
(package! basic-theme)
(package! hima-theme)
(package! simplicity-theme)
(package! tangonov-theme)
(package! iodine-theme)
(package! sublime-themes)
(package! doom-two-tone-themes
  :recipe (:host github
           :repo "eliraz-refael/doom-two-tone-themes"
           :files ("doom-two-tone-themes.el" "themes/*.el")))
(package! south-theme
  :recipe (:host github
           :repo "SophieBosio/south"
           :files ("south-theme.el")))
(package! everforest
  :recipe (:host github
           :repo "Theory-of-Everything/everforest-emacs"))
(package! temple-os-emacs-theme
  :recipe (:host github
           :repo "Senka07/temple-os-emacs-theme"))

;;                NOT INSTALLED
;; /////////////////////////////////////////////////////
;; (package! material-theme)
;; (package! iosevka-theme)
;; (package! rimero-theme)
;; (package! sakura-theme)
;; (package! seti-theme)
;; (package! simplicity-theme)
;; (package! smyx-theme)
;; (package! sorcery-theme)
;; (package! sublime-themes)
;; (package! svg-mode-line-themes)
;; (package! termbright-theme)
;; (package! uwu-theme)
;; (package! arjen-grey-theme)
;; (package! aircon-theme)
;; (package! alect-themes)
;; (package! almost-mono-themes)
;; (package! ample-theme)
;; (package! ample-zen)
;; (package! ancient-one-dark-emacs)
;; (package! atom-dark-theme-emacs)
;; (package! badger-theme)
;; (package! basic-theme)
;; (package! berrys-theme)
;; (package! birds-of-paradise-plus-theme)
;; (package! emacs-afternoon-theme)
;; (package! emacs-bliss-theme)
;; (package! emacs-boron-theme)
;; (package! emacs-cherry-blossom-theme)
;; (package! emacs-clues-theme)
;; (package! emacs-color-theme-autumn-light)
;; (package! emacs-constant-theme)
;; (package! emacs-reformatter)
;; /////////////////////////////////////////////////////

;;               INSTALLED (How tho??)
;; /////////////////////////////////////////////////////
;; autothemer
;; /////////////////////////////////////////////////////

;;                MISC
;; //////////////////////////////////////////////////
;; (package! writeroom-mode) ;; in init.el :ui zen
(package! writegood-mode)
(package! keycast)
(package! minions)
(package! jinx)
(package! yeetube :recipe (:host codeberg :repo "ThanosApollo/emacs-yeetube"))

(package! code-cells)
(package! tab-jump-out)
(package! drag-stuff)
(package! parrot)

(package! transpose-frame)

(package! expreg)
(package! page-break-lines)
(package! eat)
(package! tldr)
(package! devdocs)

;;; Lang-Syntax-Hl
(package! vimscript-ts-mode)
(package! jai-mode :recipe (:host github :repo "elp-revive/jai-mode"))
(package! wolfram-mode)
(package! wolfram)
(package! gradle-mode)
(package! elf-mode)
(package! docker-compose-mode)
(package! julia-vterm)
(package! ob-julia-vterm)
(package! hyprlang-ts-mode)
(package! typst-ts-mode :recipe (:host sourcehut :repo "meow_king/typst-ts-mode"))
(package! odin-mode :recipe (:host sourcehut :repo "mgmarlow/odin-mode"))

(package! gptel :pin nil) ; unpin!
(package! chatgpt-shell)
(package! hackernews)
(package! hnreader)
(package! reddigg)
(package! leetcode)
(package! fzf)
(package! exec-path-from-shell)
(package! stillness-mode :recipe (:host github :repo "neeasade/stillness-mode.el" :branch "main"))
(package! rainbow-delimiters)
(package! highlight-numbers)
(package! highlight-operators)
(package! highlight-escape-sequences)

;; //////////////////////////////////////////////////

;;; LSPS
(package! mason) ; Use `(mason-ensure)' to activate
;; (package! lsp-intellij)
(package! lsp-java)
(package! lsp-dart)
(package! lsp-haskell)
;; (package! lsp-jedi)
(package! lsp-pyright)

;; DEBUGGERS
;; (package! pytest-pdb-break)
;; (package! dape)

;; ORG-ROAM
(package! org-roam-ui) ; Org-roam visualizer
        (package! websocket)

;; ORG-MODE
;; (package! org-journal) ; Installed [Tue Apr 9 03:46:40 2024]
(package! org-bullets)
(package! org-modern) ; Makes tags look better
;; (package! org-present)

;; (package! centered-cursor-mode)
(package! modern-fringes)
(package! olivetti) ; Centers Content
(package! hydra)
;; (package! pulsar)
;; (package! embrace)
(package! evil-escape :disable t)
(package! which-key :disable t)
;; (package! proof-general :recipe (:host github :repo "ProofGeneral/PG"))
(package! spacious-padding)
(package! bluetooth)
(package! ox-gfm) ; TODO: remove this as it does the same thing as blackfriday ??
(package! dired-du)
(package! org-appear)
(package! inhibit-mouse)
(package! bookmark-plus :recipe (:host github :repo "/emacsmirror/bookmark-plus"))
;; (package! ultra-scroll  :recipe (:host github :repo "/jdtsmith/ultra-scroll" :files ("*.el"))) ; integrated into doom now
(package! topspace)
;; (package! dmenu) ; blocks emacs on a timer (when it's idle). When you come back, everything is blocked
(package! imenu-list)
;; (package! org-alert)
(package! blamer)
;; (package! ws-butler
;;   :recipe (:host github
;;            :repo "emacsmirror/nongnu_elpa"
;;            :branch "elpa/ws-butler"
;;            :local-repo "ws-butler")
;;   :pin "9ee5a7657a22e836618813c2e2b64a548d27d2ff")
;; (package! vw-mode :recipe (:host github :repo "some/place"))
;; (package! sweeprolog :recipe (:files (:defaults "*.pl")))
(package! stock-tracker)
(package! trashed)
(package! emacs-mini-frame :recipe (:host github :repo "/muffinmad/emacs-mini-frame"))
;; (package! leetcode-emacs :recipe (:host github :repo "/ginqi7/leetcode-emacs")
;; (package! tab-bar-echo-area)

(package! eglot :pin "6a9e0c76b9a7a4bf03a7fc91a02b826df507e3ce")
(package! consult-eglot :pin "b71499f4b93bfea4e2005564c25c5bb0f9e73199")
(package! flycheck-eglot :pin "18d0c9869585e6a9ea5c40678f266cf7f5bb2d2e")

(package! nov)
(package! calibredb)
;; (package! nov :pin "b3c7cc28e95fe25ce7b443e5f49e2e45360944a3")
;; (package! calibredb
;;   :recipe (:host github :repo "chenyanming/calibredb.el")
;;   :pin "a3b04c0c37b1e8ceff2472e21a3579e64e944528")

(package! magit-todos)
(package! vdiff)
(package! vdiff-magit)
(package! uniline)
(package! consult-gh)
