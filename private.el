;;; $DOOMDIR/private.el -*- lexical-binding: t; -*-

;; (after! org
;;   (setq org-directory nil)
;;   (setq org-id-locations-file nil)
;;   (setq org-agenda-files nil)
;;   (setq +org-capture-todo-file nil))
;; (after! org-roam
;;   (setq org-roam-directory nil))
;;
;; (after! org-journal
;;   (setq org-journal-dir nil))
;;
;; (after! projectile
;;   (setq projectile-project-search-path nil))
;;
;; (setq find-function-C-source-directory nil)
(after! org
  (setq org-directory nil)
  (setq org-id-locations-file nil)
  (setq org-agenda-files nil)
  (setq +org-capture-todo-file nil))
(after! org-roam
  (setq org-roam-directory nil))

(after! org-journal
  (setq org-journal-dir nil))

(after! projectile
  (setq projectile-project-search-path nil))

(setq find-function-C-source-directory nil)
