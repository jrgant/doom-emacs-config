;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jason Gantenberg"
      user-mail-address "jason.gantenberg@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 23)
      doom-variable-pitch-font (font-spec :family "NimbusRomNo9L-Reg" :size 26))

;; Modeline tweaks.
(display-battery-mode t)
(setq display-time-24hr-format t)
(display-time-mode t)

;; Set global defaults to control appearance and interaction with text.
(setq-default line-spacing 8)
(global-visual-line-mode t)
(+global-word-wrap-mode +2)
(delete-selection-mode t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Start emacs in fullscreen mode.
(toggle-frame-fullscreen)

;; Remove delay for helm popups.
(setq x-wait-for-event-timeout nil)

;; Load custom keybindings and snippets.
(load! "keybindings")
(setq yas-snippet-dirs '("~/.doom.d/snippets/"))

;; Bash fix.
(setq shell-file-name "C:/cygwin64/bin/bash")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Projectile settings
(use-package! projectile
  :defer true
  :init
  (setq projectile-project-search-path '("~/Documents/Github" "~/Documents/Github/egcmsm"))
  )

;; Org mode configuration.
(use-package! org
  :defer true
  :init
  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq
   org-directory "~/org/"
   org-agenda-files '(
     "~/org/"
     "~/Google Drive/Brown/RA/RASST_2017-19_Howe-Zullo/Meetings/"
     "~/Google Drive/Brown/RA/RASST_2017-19_Howe-Zullo/Project06_Sanofi-RSV/Meetings"
     )
   )
  )



;; REFERENCES AND CITATIONS
;; Lots of this configuration comes from https://rgoswami.me/posts/org-note-workflow
;; Bibtex settings.
(use-package! bibtex-mode
  :defer true
  :init
  (setq
   bibtex-completion-bibliography "~/bibliography/master-references.bib"
   bibtex-completion-library-path "~/bibliography/pdfs-main/"
   bibtex-completion-notes-path "~/bibliography/notes/"
   bibtex-completion-additional-search-fields '(keywords)
   bibtex-completion-find-additional-pdfs t
   ;; citation key formatting
   bibtex-autokey-year-length 4
   bibtex-autokey-name-case-convert-function 'capitalize
   bibtex-autokey-name-year-separator ""
   bibtex-autokey-year-title-separator "-"
   bibtex-autokey-titlewords 1
   bibtex-autokey-titlewords-stretch 0
   bibtex-autokey-titleword-ignore '("[Ii]n" "[Oo]n" "[Aa]n" "[Dd]o" "[Tt]he" "[Oo]r" "[Ii]s" "[Ff]or" "[Aa]")
   ;; note template
   bibtex-completion-notes-template-multiple-files
   (concat
    "#+TITLE: ${title}\n"
    "#+ROAM_KEY: cite:${=key=}\n\n"
    "- tags :: \n\n"
    ":PROPERTIES:\n"
    ":Custom_ID: ${=key=}\n"
    ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
    ":AUTHOR: ${author-abbrev}\n"
    ":JOURNAL: ${journaltitle}\n"
    ":YEAR: ${year}\n"
    ":DOI: ${doi}\n"
    ":DIR: ./${=key=}\n"
    ":END:\n\n"
    )
   )
  )

;; Org-ref settings.
(use-package! org-ref
  :after  (:any org bibtex-mode helm-bibtex)
  :config
  (setq
   org-ref-default-bibliography '("~/bibliography/master-references.bib")
   org-ref-completion-library 'org-ref-helm-insert-cite-link
   org-ref-pdf-directory "~/bibliography/pdfs-main/"
   org-ref-notes-directory "~/bibliography/notes/"
   org-ref-notes-function 'orb-edit-notes
   org-ref-notes-title-format ":PROPERTIES:\n :Custom_ID: %k\n :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n :AUTHOR: %9a\n :JOURNAL: %j\n :YEAR: %y\n :DOI: %D\n :DIR: ./${=key=}\n :END:\n\n"
   )
  )

;; Org-roam-bibtex.
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-preformat-keywords '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}\n
- tags ::\n
- keywords :: ${keywords}\n
\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n :AUTHOR: ${author-or-editor}\n :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n :NOTER_PAGE: \n :END:\n\n"
           :unnarrowed t)))
  )

;; Org-noter configuration.
(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path '("~/bibliography/notes/")
   )
  )
 
;; STATISTICAL PROGRAMMING
;; Jupyter REPL setup.
(use-package! jupyter
  :defer true
  :init
  (setq jupyter-repl-echo-eval-p t)
  :config
  (when (buffer-file-name "*.R") #'jupyter-repl-associate-buffer)
  )

;; temporary fix for freeze due to submitting large code blocks to repl
;; h/t https://github.com/nnicandro/emacs-jupyter/issues/219#issue-569361931
(add-hook 'jupyter-repl-mode-hook
          (lambda () (font-lock-mode 0)))

;; ESS settings for R.
(use-package! ess
  :defer true
  :init
  (setq
   inferior-ess-r-program "C:/Program Files/R/R-4.0.2/bin/R.exe"
   ess-indent-with-fancy-comments nil
   )
  )


;; FILE NAVIGATION
;; show dotfiles
(add-hook! ranger-mode . (ranger-toggle-dotfiles))


;; SLACK SETUP
(use-package! slack
  :defer true
  :init
  (setq slack-buffer-emojify t)
  :config
  (slack-register-team
   :name "Gorram Reavers"
   :token (auth-source-pick-first-password
           :host "gorram-reavers.slack.com"
           :user "evilmammoth")
   )
  )
