;;; $DOOMDIR/private.el -*- lexical-binding: t; -*-

;; set!!
;; `org-directory', `org-id-locations-file', `org-agenda-files'
;; `org-roam-directory'
;; `org-journal-dir',
;; `projectile-project-search-path'
;; `find-function-C-source-directory'

(after! org
  (setq org-directory nil)
  (setq org-id-locations-file nil)
  (setq org-agenda-files nil)
(after! org-roam
  (setq org-roam-directory nil))

(after! org-journal
  (setq org-journal-dir nil))

(after! projectile
  (setq projectile-project-search-path nil)

(setq find-function-C-source-directory nil)
