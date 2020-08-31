;;; $DOOMDIR/keybindings.el -*- lexical-binding: t; -*-

;; Global text manipulation
(map! "C-c c" #'clipboard-kill-ring-save
      "C-c x" #'clipboard-kill-region
      "C-c v" #'clipboard-yank
      )

;; Global referen
(map! :leader
      ;;; <leader> r --- references
      (:prefix-map ("r" . "references")
       :desc "Add reference to .bib by CrossRef"             "c" #'doi-utils-add-entry-from-crossref-query
       :desc "Add reference to .bib by DOI"                  "d" #'doi-utils-add-bibtex-entry-from-doi
       :desc "Insert bibtex from PMID"                       "P" #'pubmed-insert-bibtex-from-pmid
       (:prefix-map ("s" . "search engines")
        :desc "Google Scholar"                               "g" #'gscholar-bibtex
        :desc "Pubmed (DOI)"                                 "p" #'doi-utils-pubmed
        ))
      )

;; Bibtex-mode
(map! :map bibtex-mode-map
       :localleader
       "c" #'org-ref-clean-bibtex-entry
       "u" #'doi-utils-update-bibtex-entry-from-doi
       "s" #'bibtex-sort-buffer
       )
