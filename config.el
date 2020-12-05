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
(setq doom-font (font-spec :family "Cascadia Code" :size 24)
      doom-variable-pitch-font (font-spec :family "Charter" :size 24))

;; Modeline tweaks.
(display-battery-mode t)
(setq display-time-24hr-format t)
(display-time-mode t)

;; Set global defaults to control appearance and interaction with text.
(setq-default line-spacing 8)
(global-visual-line-mode t)
(+global-word-wrap-mode +2)
(delete-selection-mode t)
(setq auto-window-vscroll t)

;; Use trash (instead of delete) as default delete mode.
(setq delete-by-moving-to-trash t)

;; Use posframe globally
;; (helm-posframe-enable)
;; (setq helm-posframe-parameters
;;       '((left-fringe . 12)
;;         (right-fringe . 12)))

(use-package! ivy-posframe
  :after ivy
  :custom-face
  (ivy-posframe-border ((t . (:background "#ffffff"))))
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
        ivy-posframe-parameters '((left-fringe . 12)
                                  (right-fringe . 12)))
  (ivy-posframe-mode 1)
)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dark+)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Start emacs in fullscreen mode.
(toggle-frame-fullscreen)

;; Disable Image Magick rendering. Use Emacs 27.1 defaults.
(setq imagemagick-enabled-types nil)

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
  (setq projectile-project-search-path '("~/Documents/Github"
                                         "~/Documents/Github/egcmsm"))
  )

;; Org mode configuration.
(use-package! org
  :defer true
  :init
  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq org-directory "~/org/")
  (setq org-agenda-files '("~/jason/org/"
                           "~/Google Drive/Brown/RA/RASST_2017-19_Howe-Zullo/Meetings/"
                           "~/Google Drive/Brown/RA/RASST_2017-19_Howe-Zullo/Project06_Sanofi-RSV/Meetings/"
                           ))
  (setq org-latex-packages-alist
        '("\\usepackage[T1]{fontenc}"
          "\\usepackage{tikz}"
          "\\usetikzlibrary{arrows,shapes,positioning}"
          "\\usepackage{booktabs}"
          "\\usepackage{tcolorbox}"
          "\\tcbset{colback=red!5!white,colframe=red!75!black,fonttitle=\\bfseries}"
          "\\usepackage[left=1in,top=1in,bottom=1in,right=1in]{geometry}"
          ))
  ;; org-babel will be ready for R
  (setq org-babel-R-command "C:/Progra~1/R/R-4.0.3/bin/x64/R --slave --no-save")

  (with-eval-after-load 'ox-latex
    (setq org-latex-compiler "xelatex"
          org-latex-pdf-process (list "latexmk -pdflatex='xelatex -shell-escape -synctex=1' -pdf -f %f")))
  )


;; REFERENCES AND CITATIONS
;; Lots of this configuration comes from https://rgoswami.me/posts/org-note-workflow
;; Bibtex settings.
(use-package! bibtex-mode
  :defer true
  :init
  (setq bibtex-completion-bibliography "~/bibliography/master-blaster.bib"
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
  :config
  (visual-fill-column-mode)
  )

;; Org-ref settings.
(use-package! org-ref
  :after  (:any org bibtex-mode ivy-bibtex helm-bibtex)
  :config
  (setq org-ref-default-bibliography '("~/bibliography/master-blaster.bib")
        ;org-ref-completion-library 'org-ref-helm-insert-cite-link
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
        org-ref-completion-library 'org-ref-helm-cite
        org-ref-pdf-directory "~/bibliography/pdfs-main/"
        org-ref-notes-directory "~/bibliography/notes/"
        org-ref-notes-function 'orb-edit-notes
        bibtex-dialect 'biblatex
        org-ref-notes-title-format ":PROPERTIES:\n :Custom_ID: %k\n :NOTER_DOCUMENT: %F\n :AUTHOR: %9a\n :JOURNAL: %j\n :YEAR: %y\n :DOI: %D\n :DIR: ./${=key=}\n :ROAM_KEY: cite:%k\n :DIR: ./%k\n :END:\n\n")
  )

;; Org-roam settings
(use-package! org-roam
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :preface
  (defvar org-roam-directory nil)
  :init
  :config
  (setq org-roam-directory "~/bibliography/notes"
        org-roam-verbose nil
        org-roam-buffer-no-delete-other-windows t
        org-roam-completion-system 'default
        )

  ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; (but not `find-file', to limit the scope of this behavior).
  (add-hook 'find-file-hook
    (defun +org-roam-open-buffer-maybe-h ()
      (and +org-roam-open-buffer-on-find-file
           (memq 'org-roam-buffer--update-maybe post-command-hook)
           (not (window-parameter nil 'window-side)) ; don't proc for popups
           (not (eq 'visible (org-roam-buffer--visibility)))
           (with-current-buffer (window-buffer)
             (org-roam-buffer--get-create)))))

  ;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
  ;; makes it easier to distinguish among other org buffers.
  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)
)

;; Org-roam-bibtex.
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq orb-preformat-keywords '("=key=" "title" "url" "file" "author-or-editor" "keywords" "author-abbrev" "journaltitle" "date" "doi"))
  (setq orb-templates '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}\n
- tags ::\n
\n* Notes\n :PROPERTIES:\n :Custom_ID: ${=key=}\n :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n :AUTHOR: ${author-or-editor}\n :JOURNAL: ${journaltitle}\n :DATE: ${date}\n :DOI: ${doi}\n :DIR: ./${=key=}\n :END:\n\n"
           :unnarrowed t)))
  )

;; Org-noter configuration.
(use-package! org-noter
  :after pdf-view
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'vertical-split
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
(add-hook! 'jupyter-repl-mode-hook (lambda () (font-lock-mode 0)))

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
