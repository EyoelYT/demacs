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

;; Lsp
;; (package! lsp-pyright)
;; (package! lsp-jedi)

;; (package! centered-cursor-mode)
(package! modern-fringes)

;; Themes
(package! ef-themes :recipe (:host github :repo "protesilaos/ef-themes" :depth 1))
(package! gruber-darker-theme)
(package! avk-emacs-themes)
(package! anti-zenburn-theme)
(package! catppuccin-theme)
(package! tao-theme)
(package! inkpot-theme)
(package! idea-darkula-theme)
(package! atom-one-dark-theme)
;; (package! github-modern-theme) ;; Deprecated?
;; (package! acme-theme)          ;; Deprecated?
(package! eclipse-theme)
(package! blackboard-theme)
(package! borland-blue-theme)
(package! cloud-theme)
(package! ahungry-theme)
(package! color-theme-sanityinc-solarized)
(package! color-theme-sanityinc-tomorrow)
(package! commentary-theme)
(package! professional-theme)
(package! kanagawa-themes)
(package! the-matrix-theme)
(package! nano-theme)
(package! nubox)
(package! obsidian-theme)
(package! rebecca-theme)
(package! remember-last-theme)
(package! reykjavik-theme)
(package! soft-morning-theme)
(package! spacemacs-theme)
(package! standard-themes)
(package! starlit-theme)
(package! stimmung-themes)
(package! subatomic-theme)
(package! subatomic256-theme)
(package! sweet-theme)
(package! ubuntu-theme)
(package! vscdark-theme)
(package! vscode-dark-plus-theme)
(package! white-theme)
(package! xresources-theme)
(package! yabaki-theme)
(package! silkworm-theme)
(package! soft-morning-theme)
(package! soft-stone-theme)
(package! spacemacs-theme)
(package! subatomic-theme)

;; NOT INSTALLED
;; /////////////////////////////////////////////////////
(package! gotham-theme)
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
;; /////////////////////////////////////////////////////

;; all-the-icons
;; aircon-theme
;; alect-themes
;; almost-mono-themes
;; ample-theme
;; ample-zen
;; ancient-one-dark-emacs
;; atom-dark-theme-emacs
;; autothemer
;; badger-theme
;; basic-theme
;; berrys-theme
;; birds-of-paradise-plus-theme
;; emacs-afternoon-theme
;; emacs-bliss-theme
;; emacs-boron-theme
;; emacs-cherry-blossom-theme
;; emacs-clues-theme
;; emacs-color-theme-autumn-light
;; emacs-color-themes
;; emacs-constant-theme
;; emacs-reformatter

;; Debuggers
;; (package! pytest-pdb-break)

;; MISC
;; //////////////////////////////////////////////////
;; (package! writeroom-mode) ;; in init.el :ui zen
(package! writegood-mode)

(package! code-cells)
(package! tab-jump-out)
(package! drag-stuff)
(package! parrot)

(package! transpose-frame)

(package! vimscript-ts-mode)
(package! wolfram-mode)
(package! wolfram)
(package! gradle-mode)
(package! docker-compose-mode)
;; gptel

(package! hackernews)
(package! leetcode)
;; //////////////////////////////////////////////////

;; LSPS
;; (package! lsp-intellij)
(package! lsp-java)

;; ORG-ROAM
(package! org-roam-ui) ;; Org-roam visualizer
        (package! websocket)

;; ORG-MODE
;; (package! org-journal) ;; Installed [Tue Apr 9 03:46:40 2024]
(package! org-bullets)
(package! org-modern) ;; Makes tags look better
;; (package! org-present)

;; (package! centered-cursor-mode)
(package! modern-fringes)
(package! olivetti) ;; Centers Content
