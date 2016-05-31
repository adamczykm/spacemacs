;;; packages.el --- anks layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <anks@ninja-arch>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `anks-packages'.  Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `anks/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `anks/pre-init-PACKAGE' and/or
;;   `anks/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst anks-packages
  '(
    evil-multiedit
    ace-jump-buffer
    )
  "The list of Lisp packages required by the anks layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil
- :location: Specify a custom installation location. The following values are legal: - The symbol `elpa' (default) means PACKAGE will be installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format"
  )


(defun anks/init-ace-jump-buffer ()
  "More here."
  (use-package ace-jump-buffer
              :defer nil
              :config (evil-leader/set-key "1" 'ace-jump-buffer)))

(defun anks/init-evil-multiedit ()
  "More here https://github.com/hlissner/evil-multiedit."
  (use-package evil-multiedit
    :defer nil
    :init
    :config
    ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
    (progn
      (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
      ;; Highlights all matches of the selection in the buffer.
      (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

      ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
      ;; incrementally add the next unmatched match.
      (define-key evil-normal-state-map (kbd "m") 'evil-multiedit-match-and-next)
      ;; Match selected region.
      (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)

      ;; Same as M-d but in reverse.
      (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
      (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

      ;; OPTIONAL: If you prefer to grab symbols rather than words, use
      ;; `evil-multiedit-match-symbol-and-next` (or prev).

      ;; Restore the last group of multiedit regions.
      (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

      ;; RET will toggle the region under the cursor
      (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

      ;; ...and in visual mode, RET will disable all fields outside the selected region
      (define-key evil-visual-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

      ;; For moving between edit regions
      (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
      (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
      (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
      (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

      ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
      (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match))
    ;; Once regions are highlighted, changes are mirrored across them all.

    ;; Many evil-mode motions/operators will have slightly different behavior while evil-multiedit is active or the cursor is in an iedit region:

    ;; D: clear the region
    ;; C: clear to end-of-region and go into insert mode
    ;; A: go into insert mode at end-of-region
    ;; I: go into insert mode at start-of-region
    ;; V: select the region
    ;; $: go to end-of-region
    ;; 0/^: go to start-of-region
    ;; gg/G: go to the first/last region
    ))

;;; packages.el ends here
