;;; ef-themes.el --- Elegant and legible themes -*- lexical-binding:t -*-

;; Copyright (C) 2022  Free Software Foundation, Inc.

;; Author: Protesilaos Stavrou <info@protesilaos.com>
;; Maintainer: Ef-Themes Development <~protesilaos/ef-themes@lists.sr.ht>
;; URL: https://git.sr.ht/~protesilaos/ef-themes
;; Mailing-List: https://lists.sr.ht/~protesilaos/ef-themes
;; Version: 0.0.0
;; Package-Requires: ((emacs "28.1"))
;; Keywords: faces, theme, accessibility

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Work-in-progress.

;;; Code:



(eval-when-compile
  (require 'cl-lib)
  (require 'subr-x))

(defgroup ef-themes ()
  "Work-in-progress."
  :group 'faces
  :link '(info-link "(ef-themes) Top")
  :prefix "ef-themes-"
  :tag "Ef Themes")

;;; Commands and their helper functions

(defun ef-themes--list-enabled-themes ()
  "Return list of `custom-known-themes' with ef- prefix."
  (seq-filter
   (lambda (theme)
     (string-prefix-p "ef-" (symbol-name theme)))
   custom-known-themes))

(defvar ef-themes--select-theme-history nil)

(defun ef-themes--select-prompt ()
  "Minibuffer prompt for `ef-themes-select'."
  (completing-read "Select Ef Theme: "
                   (ef-themes--list-enabled-themes)
                   nil t nil
                   'ef-themes--select-theme-history))

;;;###autoload
(defun ef-themes-select (theme)
  "Load an Ef THEME using minibuffer completion.
When called from Lisp, THEME is a symbol."
  (interactive
   (list (intern (ef-themes--select-prompt))))
  (mapc #'disable-theme (ef-themes--list-enabled-themes))
  (load-theme theme :no-confirm))

;;; Faces and variables

(defconst ef-themes-faces
  '(
;;;; all basic faces
    `(default ((,c :background ,bg-main :foreground ,fg-main)))
    `(cursor ((,c :background ,cursor)))
    `(region ((,c :background ,bg-region)))
    `(comint-highlight-input ((,c :inherit bold)))
    `(comint-highlight-prompt ((,c :foreground ,accent-2)))
    `(minibuffer-prompt ((,c :foreground ,accent-2)))
    `(escape-glyph ((,c :foreground ,warning)))
    `(error ((,c :inherit bold :foreground ,err)))
    `(success ((,c :inherit bold :foreground ,info)))
    `(warning ((,c :inherit bold :foreground ,warning)))
    `(fringe ((,c :background unspecified)))
    `(header-line ((,c :background ,bg-dim)))
    `(header-line-highlight ((,c :inherit highlight)))
    `(help-argument-name ((,c :foreground ,accent-0)))
    `(help-key-binding ((,c :inherit bold :foreground ,keybind)))
    `(highlight ((,c :background ,bg-hover :foreground ,fg-intense)))
    `(secondary-selection ((,c :background ,bg-hover-alt :foreground ,fg-intense)))
    `(hl-line ((,c :background ,bg-hl-line)))
    `(button ((,c :foreground ,link :underline ,border)))
    `(link ((,c :foreground ,link :underline ,border)))
    `(shadow ((,c :foreground ,fg-dim)))
    `(tooltip ((,c :background ,bg-alt :foreground ,fg-main)))
;;;; ansi-color
    `(ansi-color-black ((,c :background "black" :foreground "black")))
    `(ansi-color-blue ((,c :background ,blue :foreground ,blue)))
    `(ansi-color-bold ((,c :inherit bold)))
    `(ansi-color-bright-black ((,c :background "gray35" :foreground "gray35")))
    `(ansi-color-bright-blue ((,c :background ,blue-warmer :foreground ,blue-warmer)))
    `(ansi-color-bright-cyan ((,c :background ,cyan-cooler :foreground ,cyan-cooler)))
    `(ansi-color-bright-green ((,c :background ,green-cooler :foreground ,green-cooler)))
    `(ansi-color-bright-magenta ((,c :background ,magenta-cooler :foreground ,magenta-cooler)))
    `(ansi-color-bright-red ((,c :background ,red-warmer :foreground ,red-warmer)))
    `(ansi-color-bright-white ((,c :background "white" :foreground "white")))
    `(ansi-color-bright-yellow ((,c :background ,yellow-warmer :foreground ,yellow-warmer)))
    `(ansi-color-cyan ((,c :background ,cyan :foreground ,cyan)))
    `(ansi-color-green ((,c :background ,green :foreground ,green)))
    `(ansi-color-magenta ((,c :background ,magenta :foreground ,magenta)))
    `(ansi-color-red ((,c :background ,red :foreground ,red)))
    `(ansi-color-white ((,c :background "gray65" :foreground "gray65")))
    `(ansi-color-yellow ((,c :background ,yellow :foreground ,yellow)))
;;;; bongo
    `(bongo-album-title (( )))
    `(bongo-artist ((,c :foreground ,rainbow-0)))
    `(bongo-currently-playing-track ((,c :inherit bold)))
    `(bongo-elapsed-track-part ((,c :background ,bg-alt :underline t)))
    `(bongo-filled-seek-bar ((,c :background ,bg-hover)))
    `(bongo-marked-track ((,c :inherit warning :background ,bg-dim)))
    `(bongo-marked-track-line ((,c :background ,bg-dim)))
    `(bongo-played-track ((,c :strike-through t)))
    `(bongo-track-length ((,c :inherit shadow)))
    `(bongo-track-title ((,c :foreground ,rainbow-1)))
    `(bongo-unfilled-seek-bar ((,c :background ,bg-dim)))
;;;; bookmark
    `(bookmark-face ((,c :background ,bg-magenta :foreground ,fg-intense)))
    `(bookmark-menu-bookmark ((,c :inherit bold)))
;;;; change-log and log-view (`vc-print-log' and `vc-print-root-log')
    `(change-log-acknowledgment ((,c :inherit shadow)))
    `(change-log-conditionals ((,c :foreground ,preprocessor)))
    `(change-log-date ((,c :foreground ,date)))
    `(change-log-email ((,c :foreground ,constant)))
    `(change-log-file ((,c :inherit bold)))
    `(change-log-function ((,c :foreground ,fnname)))
    `(change-log-list ((,c :inherit bold)))
    `(change-log-name ((,c :foreground ,name)))
    `(log-edit-header ((,c :inherit bold)))
    `(log-edit-summary ((,c :inherit bold :foreground ,string)))
    `(log-edit-unknown-header ((,c :inherit shadow)))
    `(log-view-commit-body (( )))
    `(log-view-file ((,c :inherit bold)))
    `(log-view-message ((,c :background ,bg-dim :foreground ,fg-dim)))
;;;; compilation
    `(compilation-column-number ((,c :inherit compilation-line-number)))
    `(compilation-error ((,c :inherit error)))
    `(compilation-info ((,c :inherit success)))
    `(compilation-line-number ((,c :inherit shadow)))
    `(compilation-mode-line-exit ((,c :inherit bold)))
    `(compilation-mode-line-fail ((,c :inherit error)))
    `(compilation-mode-line-run ((,c :inherit warning)))
    `(compilation-warning ((,c :inherit warning)))
;;;; completions
    `(completions-annotations ((,c :inherit italic :foreground ,docstring)))
    `(completions-common-part ((,c :inherit bold :foreground ,accent-0)))
    `(completions-first-difference ((,c :inherit bold :foreground ,accent-1)))
;;;; custom (M-x customize)
    `(custom-button ((,c :box ,fg-dim :background ,bg-alt :foreground ,fg-intense)))
    `(custom-button-mouse ((,c :inherit (highlight custom-button))))
    `(custom-button-pressed ((,c :inherit (secondary-selection custom-button))))
    `(custom-changed ((,c :background ,bg-changed)))
    `(custom-comment ((,c :inherit shadow)))
    `(custom-comment-tag ((,c :inherit (bold shadow))))
    `(custom-invalid ((,c :inherit error :strike-through t)))
    `(custom-modified ((,c :inherit custom-changed)))
    `(custom-rogue ((,c :inherit custom-invalid)))
    `(custom-set ((,c :inherit success)))
    `(custom-state ((,c :foreground ,fg-alt)))
    `(custom-themed ((,c :inherit custom-changed)))
    `(custom-variable-obsolete ((,c :inherit shadow)))
    `(custom-face-tag ((,c :inherit bold :foreground ,type)))
    `(custom-group-tag ((,c :inherit bold :foreground ,builtin)))
    `(custom-group-tag-1 ((,c :inherit bold :foreground ,constant)))
    `(custom-variable-tag ((,c :inherit bold :foreground ,variable)))
;;;; denote
    `(denote-faces-date ((,c :foreground ,date)))
    `(denote-faces-keywords ((,c :foreground ,name)))
;;;; diff-hl
    `(diff-hl-change ((,c :background ,bg-changed-refine)))
    `(diff-hl-delete ((,c :background ,bg-removed-refine)))
    `(diff-hl-dired-change ((,c :inherit diff-hl-change)))
    `(diff-hl-dired-delete ((,c :inherit diff-hl-delete)))
    `(diff-hl-dired-ignored ((,c :inherit dired-ignored)))
    `(diff-hl-dired-insert ((,c :inherit diff-hl-insert)))
    `(diff-hl-dired-unknown ((,c :inherit dired-ignored)))
    `(diff-hl-insert ((,c :background ,bg-added-refine)))
    `(diff-hl-reverted-hunk-highlight ((,c :background ,fg-main :foreground ,bg-main)))
;;;; diff-mode
    `(diff-added ((,c :background ,bg-added)))
    `(diff-changed ((,c :background ,bg-changed :extend t)))
    `(diff-removed ((,c :background ,bg-removed)))
    `(diff-refine-added ((,c :background ,bg-added-refine)))
    `(diff-refine-changed ((,c :background ,bg-changed-refine)))
    `(diff-refine-removed ((,c :background ,bg-removed-refine)))
    `(diff-indicator-added ((,c :inherit (bold diff-added))))
    `(diff-indicator-changed ((,c :inherit (bold diff-changed))))
    `(diff-indicator-removed ((,c :inherit (bold diff-removed))))
    `(diff-context (( )))
    `(diff-error ((,c :inherit error)))
    `(diff-file-header ((,c :inherit bold)))
    `(diff-function ((,c :inherit shadow)))
    `(diff-header (( )))
    `(diff-hunk-header ((,c :inherit bold)))
    `(diff-index ((,c :inherit italic)))
    `(diff-nonexistent ((,c :inherit bold)))
;;;; dired
    `(dired-broken-symlink ((,c :inherit (error link))))
    `(dired-directory ((,c :foreground ,accent-0)))
    `(dired-flagged ((,c :inherit error :background ,bg-dim)))
    `(dired-header ((,c :inherit bold)))
    `(dired-ignored ((,c :inherit shadow)))
    `(dired-mark ((,c :inherit success)))
    `(dired-marked ((,c :inherit success :background ,bg-dim)))
    `(dired-symlink ((,c :inherit link)))
    `(dired-warning ((,c :inherit warning)))
;;;; dired-subtree
    ;; remove backgrounds from dired-subtree faces, else they break
    ;; dired-{flagged,marked} and any other face that sets a background
    ;; such as hl-line.  Also, denoting depth by varying shades of gray
    ;; does not look right.
    `(dired-subtree-depth-1-face (()))
    `(dired-subtree-depth-2-face (()))
    `(dired-subtree-depth-3-face (()))
    `(dired-subtree-depth-4-face (()))
    `(dired-subtree-depth-5-face (()))
    `(dired-subtree-depth-6-face (()))
;;;; diredfl
    `(diredfl-autofile-name ((,c :background ,bg-alt)))
    `(diredfl-compressed-file-name ((,c :foreground ,yellow-cooler)))
    `(diredfl-compressed-file-suffix ((,c :foreground ,red)))
    `(diredfl-date-time ((,c :foreground ,date)))
    `(diredfl-deletion ((,c :inherit dired-flagged)))
    `(diredfl-deletion-file-name ((,c :inherit diredfl-deletion)))
    `(diredfl-dir-heading ((,c :inherit bold)))
    `(diredfl-dir-name ((,c :inherit dired-directory)))
    `(diredfl-dir-priv ((,c :inherit dired-directory)))
    `(diredfl-exec-priv ((,c :foreground ,rainbow-3)))
    `(diredfl-executable-tag ((,c :inherit diredfl-exec-priv)))
    `(diredfl-file-name ((,c :foreground ,fg-main)))
    `(diredfl-file-suffix ((,c :foreground ,variable)))
    `(diredfl-flag-mark ((,c :inherit dired-marked)))
    `(diredfl-flag-mark-line ((,c :inherit dired-marked)))
    `(diredfl-ignored-file-name ((,c :inherit shadow)))
    `(diredfl-link-priv ((,c :foreground ,link)))
    `(diredfl-no-priv ((,c :inherit shadow)))
    `(diredfl-number ((,c :inherit shadow)))
    `(diredfl-other-priv ((,c :foreground ,rainbow-0)))
    `(diredfl-rare-priv ((,c :foreground ,rainbow-0)))
    `(diredfl-read-priv ((,c :foreground ,rainbow-1)))
    `(diredfl-symlink ((,c :inherit dired-symlink)))
    `(diredfl-tagged-autofile-name ((,c :inherit (diredfl-autofile-name dired-marked))))
    `(diredfl-write-priv ((,c :foreground ,rainbow-2)))
;;;; eldoc
    ;; NOTE: see https://github.com/purcell/package-lint/issues/187
    (list 'eldoc-highlight-function-argument `((,c :inherit bold :background ,bg-dim :foreground ,accent-0)))
;;;; elfeed
    `(elfeed-log-date-face ((,c :inherit elfeed-search-date-face)))
    `(elfeed-log-debug-level-face ((,c :inherit elfeed-search-filter-face)))
    `(elfeed-log-error-level-face ((,c :inherit error)))
    `(elfeed-log-info-level-face ((,c :inherit success)))
    `(elfeed-log-warn-level-face ((,c :inherit warning)))
    `(elfeed-search-date-face ((,c :foreground ,date)))
    `(elfeed-search-feed-face ((,c :foreground ,accent-1)))
    `(elfeed-search-filter-face ((,c :inherit success)))
    `(elfeed-search-last-update-face ((,c :inherit bold :foreground ,date)))
    `(elfeed-search-tag-face ((,c :foreground ,accent-0)))
    `(elfeed-search-title-face ((,c :foreground ,fg-dim)))
    `(elfeed-search-unread-count-face ((,c :inherit bold)))
    `(elfeed-search-unread-title-face ((,c :inherit bold :foreground ,fg-main)))
;;;; font-lock
    `(font-lock-builtin-face ((,c :foreground ,builtin)))
    `(font-lock-comment-delimiter-face ((,c :inherit font-lock-comment-face)))
    `(font-lock-comment-face ((,c :inherit italic :foreground ,comment)))
    `(font-lock-constant-face ((,c :foreground ,constant)))
    `(font-lock-doc-face ((,c :inherit italic :foreground ,docstring)))
    `(font-lock-function-name-face ((,c :foreground ,fnname)))
    `(font-lock-keyword-face ((,c :inherit bold :foreground ,keyword)))
    `(font-lock-negation-char-face ((,c :inherit bold)))
    `(font-lock-preprocessor-face ((,c :foreground ,preprocessor)))
    `(font-lock-regexp-grouping-backslash ((,c :inherit bold :foreground ,info)))
    `(font-lock-regexp-grouping-construct ((,c :inherit bold :foreground ,err)))
    `(font-lock-string-face ((,c :foreground ,string)))
    `(font-lock-type-face ((,c :foreground ,type)))
    `(font-lock-variable-name-face ((,c :foreground ,variable)))
    `(font-lock-warning-face ((,c :foreground ,warning)))
;;;; git-commit
    `(git-commit-comment-action ((,c :inherit font-lock-comment-face)))
    `(git-commit-comment-heading ((,c :inherit (bold font-lock-comment-face))))
    `(git-commit-comment-file ((,c :inherit font-lock-comment-face :foreground ,name)))
    `(git-commit-keyword ((,c :foreground ,keyword)))
    `(git-commit-nonempty-second-line ((,c :inherit error)))
    `(git-commit-overlong-summary ((,c :inherit warning)))
    `(git-commit-summary ((,c :inherit bold :foreground ,string)))
;;;; git-rebase
    `(git-rebase-comment-hash ((,c :inherit font-lock-comment-face :foreground ,constant)))
    `(git-rebase-comment-heading  ((,c :inherit (bold font-lock-comment-face))))
    `(git-rebase-description ((,c :foreground ,fg-main)))
    `(git-rebase-hash ((,c :foreground ,constant)))
;;;; isearch, occur, and the like
    `(isearch ((,c :background ,bg-yellow :foreground ,fg-intense)))
    `(isearch-fail ((,c :background ,bg-red :foreground ,fg-intense)))
    `(isearch-group-1 ((,c :background ,bg-magenta :foreground ,fg-intense)))
    `(isearch-group-2 ((,c :background ,bg-green :foreground ,fg-intense)))
    `(lazy-highlight ((,c :background ,bg-blue :foreground ,fg-intense)))
    `(match ((,c :background ,bg-alt :foreground ,fg-intense)))
    `(query-replace ((,c :background ,bg-red :foreground ,fg-intense)))
;;;; line numbers (display-line-numbers-mode and global variant)
    ;; Here we cannot inherit `modus-themes-fixed-pitch'.  We need to
    ;; fall back to `default' otherwise line numbers do not scale when
    ;; using `text-scale-adjust'.
    `(line-number ((,c :inherit (shadow default))))
    `(line-number-current-line ((,c :inherit bold :foreground ,fg-intense)))
    `(line-number-major-tick ((,c :inherit line-number :background ,bg-alt :foreground ,info)))
    `(line-number-minor-tick ((,c :inherit line-number :background ,bg-dim :foreground ,warning)))
;;;; magit
    `(magit-bisect-bad ((,c :inherit error)))
    `(magit-bisect-good ((,c :inherit success)))
    `(magit-bisect-skip ((,c :inherit warning)))
    `(magit-blame-date ((,c :foreground ,blue)))
    `(magit-blame-dimmed ((,c :inherit shadow)))
    `(magit-blame-hash ((,c :foreground ,fg-alt)))
    `(magit-blame-heading ((,c :background ,bg-alt :extend t)))
    ;; `(magit-blame-highlight ((,c :inherit modus-themes-nuanced-cyan)))
    ;; `(magit-blame-margin ((,c :inherit (magit-blame-highlight modus-themes-reset-hard))))
    `(magit-blame-name ((,c :foreground ,name)))
    `(magit-blame-summary ((,c :foreground ,string)))
    `(magit-branch-local ((,c :foreground ,accent-0)))
    `(magit-branch-remote ((,c :foreground ,accent-1)))
    `(magit-branch-upstream ((,c :inherit italic)))
    `(magit-branch-warning ((,c :inherit warning)))
    `(magit-cherry-equivalent ((,c :foreground ,magenta)))
    `(magit-cherry-unmatched ((,c :foreground ,cyan)))
    `(magit-diff-added ((,c :background ,bg-added-faint)))
    `(magit-diff-added-highlight ((,c :background ,bg-added)))
    `(magit-diff-base ((,c :background ,bg-changed-faint)))
    `(magit-diff-base-highlight ((,c :background ,bg-changed)))
    `(magit-diff-context ((,c :inherit shadow)))
    `(magit-diff-context-highlight ((,c :background ,bg-dim)))
    `(magit-diff-file-heading ((,c :inherit bold :foreground ,accent-0)))
    `(magit-diff-file-heading-highlight ((,c :inherit magit-diff-file-heading :background ,bg-alt)))
    `(magit-diff-file-heading-selection ((,c :inherit bold :background ,bg-hover-alt :foreground ,fg-intense)))
    `(magit-diff-hunk-heading ((,c :inherit bold :background ,bg-dim)))
    `(magit-diff-hunk-heading-highlight ((,c :inherit bold :background ,bg-hover)))
    `(magit-diff-hunk-heading-selection ((,c :inherit bold :background ,bg-hover-alt :foreground ,fg-intense)))
    `(magit-diff-hunk-region ((,c :inherit bold)))
    `(magit-diff-lines-boundary ((,c :background ,fg-intense)))
    `(magit-diff-lines-heading ((,c :background ,fg-alt :foreground ,bg-alt)))
    `(magit-diff-removed ((,c :background ,bg-removed-faint)))
    `(magit-diff-removed-highlight ((,c :background ,bg-removed)))
    `(magit-diffstat-added ((,c :inherit success)))
    `(magit-diffstat-removed ((,c :inherit error)))
    `(magit-dimmed ((,c :inherit shadow)))
    `(magit-filename ((,c :foreground ,name)))
    `(magit-hash ((,c :inherit shadow)))
    `(magit-head ((,c :inherit magit-branch-local)))
    `(magit-header-line ((,c :inherit bold)))
    `(magit-header-line-key ((,c :inherit help-key-binding)))
    `(magit-header-line-log-select ((,c :inherit bold)))
    `(magit-keyword ((,c :foreground ,keyword)))
    `(magit-keyword-squash ((,c :inherit bold :foreground ,warning)))
    `(magit-log-author ((,c :foreground ,name)))
    `(magit-log-date ((,c :foreground ,date)))
    `(magit-log-graph ((,c :inherit shadow)))
    `(magit-mode-line-process ((,c :inherit success)))
    `(magit-mode-line-process-error ((,c :inherit error)))
    `(magit-process-ng ((,c :inherit error)))
    `(magit-process-ok ((,c :inherit success)))
    `(magit-reflog-amend ((,c :inherit warning)))
    `(magit-reflog-checkout ((,c :inherit bold :foreground ,blue)))
    `(magit-reflog-cherry-pick ((,c :inherit success)))
    `(magit-reflog-commit ((,c :inherit bold)))
    `(magit-reflog-merge ((,c :inherit success)))
    `(magit-reflog-other ((,c :inherit bold :foreground ,cyan)))
    `(magit-reflog-rebase ((,c :inherit bold :foreground ,magenta)))
    `(magit-reflog-remote ((,c :inherit (bold magit-branch-remote))))
    `(magit-reflog-reset ((,c :inherit error)))
    `(magit-refname ((,c :inherit shadow)))
    `(magit-refname-pullreq ((,c :inherit shadow)))
    `(magit-refname-stash ((,c :inherit shadow)))
    `(magit-refname-wip ((,c :inherit shadow)))
    `(magit-section ((,c :background ,bg-dim :foreground ,fg-main)))
    `(magit-section-heading ((,c :inherit bold)))
    `(magit-section-heading-selection ((,c :inherit bold :background ,bg-hover-alt :foreground ,fg-intense)))
    `(magit-section-highlight ((,c :background ,bg-dim)))
    `(magit-sequence-done ((,c :inherit success)))
    `(magit-sequence-drop ((,c :inherit error)))
    `(magit-sequence-exec ((,c :inherit bold :foreground ,magenta)))
    `(magit-sequence-head ((,c :inherit bold :foreground ,cyan)))
    `(magit-sequence-onto ((,c :inherit (bold shadow))))
    `(magit-sequence-part ((,c :inherit warning)))
    `(magit-sequence-pick ((,c :inherit bold)))
    `(magit-sequence-stop ((,c :inherit error)))
    `(magit-signature-bad ((,c :inherit error)))
    `(magit-signature-error ((,c :inherit error)))
    `(magit-signature-expired ((,c :inherit warning)))
    `(magit-signature-expired-key ((,c :foreground ,warning)))
    `(magit-signature-good ((,c :inherit success)))
    `(magit-signature-revoked ((,c :inherit bold :foreground ,warning)))
    `(magit-signature-untrusted ((,c :inherit (bold shadow))))
    `(magit-tag ((,c :foreground ,constant)))
;;;; marginalia
    `(marginalia-archive ((,c :foreground ,cyan-cooler)))
    `(marginalia-char ((,c :foreground ,magenta)))
    `(marginalia-date ((,c :foreground ,date)))
    `(marginalia-documentation ((,c :inherit italic :foreground ,docstring)))
    `(marginalia-file-name (( )))
    `(marginalia-file-owner ((,c :inherit shadow)))
    `(marginalia-file-priv-dir (( )))
    `(marginalia-file-priv-exec ((,c :foreground ,rainbow-3)))
    `(marginalia-file-priv-link ((,c :foreground ,link)))
    `(marginalia-file-priv-no ((,c :inherit shadow)))
    `(marginalia-file-priv-other ((,c :foreground ,rainbow-0)))
    `(marginalia-file-priv-rare ((,c :foreground ,rainbow-0)))
    `(marginalia-file-priv-read ((,c :foreground ,rainbow-1)))
    `(marginalia-file-priv-write ((,c :foreground ,rainbow-2)))
    `(marginalia-function ((,c :foreground ,magenta)))
    `(marginalia-key ((,c :inherit help-key-binding)))
    `(marginalia-lighter ((,c :inherit shadow)))
    `(marginalia-liqst ((,c :inherit shadow)))
    `(marginalia-mode ((,c :foreground ,cyan)))
    `(marginalia-modified ((,c :inherit warning)))
    `(marginalia-null ((,c :inherit shadow)))
    `(marginalia-number ((,c :foreground ,constant)))
    `(marginalia-size ((,c :foreground ,variable)))
    `(marginalia-string ((,c :foreground ,string)))
    `(marginalia-symbol ((,c :foreground ,builtin)))
    `(marginalia-true (( )))
    `(marginalia-type ((,c :foreground ,type)))
    `(marginalia-value ((,c :inherit shadow)))
    `(marginalia-version ((,c :foreground ,variable)))
;;;; messages
    `(message-cited-text-1 ((,c :foreground ,mail-0)))
    `(message-cited-text-2 ((,c :foreground ,mail-1)))
    `(message-cited-text-3 ((,c :foreground ,mail-2)))
    `(message-cited-text-4 ((,c :foreground ,mail-3)))
    `(message-header-name ((,c :inherit bold)))
    `(message-header-newsgroups ((,c :inherit message-header-other)))
    `(message-header-to ((,c :inherit bold :foreground ,mail-0)))
    `(message-header-cc ((,c :foreground ,mail-1)))
    `(message-header-subject ((,c :inherit bold :foreground ,mail-2)))
    `(message-header-xheader ((,c :foreground ,mail-3)))
    `(message-header-other ((,c :foreground ,mail-4)))
    `(message-mml ((,c :foreground ,info)))
    `(message-separator ((,c :background ,bg-alt)))
;;;; mode-line
    `(mode-line ((,c :background ,bg-mode-line :foreground ,fg-mode-line)))
    `(mode-line-active ((,c :inherit mode-line)))
    `(mode-line-buffer-id ((,c :inherit bold)))
    `(mode-line-emphasis ((,c :inherit bold :foreground ,magenta)))
    `(mode-line-highlight ((,c :inherit highlight)))
    `(mode-line-inactive ((,c :background ,bg-alt :foreground ,fg-dim)))
;;;; notmuch
    `(notmuch-crypto-decryption ((,c :inherit (shadow bold))))
    `(notmuch-crypto-part-header ((,c :foreground ,magenta-cooler)))
    `(notmuch-crypto-signature-bad ((,c :inherit error)))
    `(notmuch-crypto-signature-good ((,c :inherit success)))
    `(notmuch-crypto-signature-good-key ((,c :inherit success)))
    `(notmuch-crypto-signature-unknown ((,c :inherit warning)))
    `(notmuch-jump-key ((,c :inherit help-key-binding)))
    `(notmuch-message-summary-face ((,c :inherit bold :background ,bg-dim)))
    `(notmuch-search-count ((,c :foreground ,fg-dim)))
    `(notmuch-search-date ((,c :foreground ,date)))
    `(notmuch-search-flagged-face ((,c :foreground ,warning)))
    `(notmuch-search-matching-authors ((,c :foreground ,name)))
    `(notmuch-search-non-matching-authors ((,c :inherit shadow)))
    `(notmuch-search-subject ((,c :foreground ,fg-main)))
    `(notmuch-search-unread-face ((,c :inherit bold)))
    `(notmuch-tag-added ((,c :underline t)))
    `(notmuch-tag-deleted ((,c :strike-through t)))
    `(notmuch-tag-face ((,c :foreground ,accent-0)))
    `(notmuch-tag-flagged ((,c :foreground ,warning)))
    `(notmuch-tag-unread ((,c :foreground ,accent-1)))
    `(notmuch-tree-match-author-face ((,c :inherit notmuch-search-matching-authors)))
    `(notmuch-tree-match-date-face ((,c :inherit notmuch-search-date)))
    `(notmuch-tree-match-face ((,c :foreground ,fg-main)))
    `(notmuch-tree-match-tag-face ((,c :inherit notmuch-tag-face)))
    `(notmuch-tree-no-match-face ((,c :inherit shadow)))
    `(notmuch-tree-no-match-date-face ((,c :inherit shadow)))
    `(notmuch-wash-cited-text ((,c :inherit message-cited-text-1)))
    `(notmuch-wash-toggle-button ((,c :background ,bg-dim :foreground ,fg-alt)))
;;;; org
    `(org-agenda-calendar-event ((,c :foreground ,fg-alt)))
    `(org-agenda-calendar-sexp ((,c :inherit (italic org-agenda-calendar-event))))
    `(org-agenda-clocking ((,c :background ,bg-alt :foreground ,red-warmer)))
    `(org-agenda-column-dateline ((,c :background ,bg-alt)))
    `(org-agenda-current-time ((,c :foreground ,variable)))
    `(org-agenda-date ((,c :foreground ,date)))
    `(org-agenda-date-today ((,c :inherit org-agenda-date :underline t)))
    `(org-agenda-date-weekend ((,c :inherit org-agenda-date)))
    `(org-agenda-date-weekend-today ((,c :inherit :inherit org-agenda-date-today)))
    `(org-agenda-diary ((,c :inherit org-agenda-calendar-sexp)))
    `(org-agenda-dimmed-todo-face ((,c :inherit shadow)))
    `(org-agenda-done ((,c :inherit success)))
    `(org-agenda-filter-category ((,c :inherit success)))
    `(org-agenda-filter-effort ((,c :inherit success)))
    `(org-agenda-filter-regexp ((,c :inherit success)))
    `(org-agenda-filter-tags ((,c :inherit success)))
    `(org-agenda-restriction-lock ((,c :background ,bg-dim :foreground ,fg-dim)))
    `(org-agenda-structure ((,c :foreground ,rainbow-1)))
    `(org-agenda-structure-filter ((,c :inherit org-agenda-structure :foreground ,info)))
    `(org-agenda-structure-secondary ((,c :foreground ,rainbow-2)))
    `(org-archived ((,c :background ,bg-alt :foreground ,fg-alt)))
    `(org-block (( )))
    `(org-block-begin-line ((,c :inherit shadow)))
    `(org-block-end-line ((,c :inherit org-block-begin-line)))
    `(org-checkbox ((,c :foreground ,warning)))
    `(org-checkbox-statistics-done ((,c :inherit org-done)))
    `(org-checkbox-statistics-todo ((,c :inherit org-todo)))
    `(org-clock-overlay ((,c :background ,bg-alt :foreground ,red-cooler)))
    `(org-code ((,c :foreground ,builtin)))
    `(org-column ((,c :inherit default :background ,bg-alt)))
    `(org-column-title ((,c :inherit (bold default) :underline t :background ,bg-alt)))
    `(org-date ((,c :foreground ,date)))
    `(org-date-selected ((,c :foreground ,date :inverse-video t)))
    `(org-dispatcher-highlight ((,c :inherit (bold highlight))))
    `(org-document-info ((,c :foreground ,rainbow-1)))
    `(org-document-info-keyword ((,c :inherit shadow)))
    `(org-document-title ((,c :foreground ,rainbow-0)))
    `(org-done ((,c :foreground ,info)))
    `(org-drawer ((,c :inherit shadow)))
    `(org-ellipsis (())) ; inherits from the heading's color
    `(org-footnote ((,c :inherit link)))
    `(org-formula ((,c :foreground ,fnname)))
    `(org-headline-done ((,c :inherit org-done)))
    `(org-headline-todo ((,c :inherit org-todo)))
    `(org-hide ((,c :foreground ,bg-main)))
    `(org-indent ((,c :inherit org-hide)))
    `(org-imminent-deadline ((,c :inherit bold :foreground ,err)))
    `(org-latex-and-related ((,c :foreground ,type)))
    `(org-level-1 ((,c :inherit bold :foreground ,rainbow-1)))
    `(org-level-2 ((,c :inherit bold :foreground ,rainbow-2)))
    `(org-level-3 ((,c :inherit bold :foreground ,rainbow-3)))
    `(org-level-4 ((,c :inherit bold :foreground ,rainbow-4)))
    `(org-level-5 ((,c :inherit bold :foreground ,rainbow-5)))
    `(org-level-6 ((,c :inherit bold :foreground ,rainbow-6)))
    `(org-level-7 ((,c :inherit bold :foreground ,rainbow-7)))
    `(org-level-8 ((,c :inherit bold :foreground ,rainbow-8)))
    `(org-link ((,c :inherit link)))
    `(org-list-dt ((,c :inherit bold)))
    `(org-macro ((,c :foreground ,keyword)))
    `(org-meta-line ((,c :inherit shadow)))
    `(org-mode-line-clock (( )))
    `(org-mode-line-clock-overrun ((,c :inherit bold :foreground ,err)))
    `(org-priority ((,c :foreground ,magenta)))
    `(org-property-value ((,c :foreground ,info)))
    `(org-quote (( )))
    `(org-scheduled ((,c :foreground ,warning)))
    `(org-scheduled-previously ((,c :inherit org-scheduled)))
    `(org-scheduled-today ((,c :inherit (bold org-scheduled))))
    `(org-sexp-date ((,c :foreground ,date)))
    `(org-special-keyword ((,c :inherit shadow)))
    `(org-table ((,c :foreground ,string)))
    `(org-table-header ((,c :inherit (bold org-table))))
    `(org-tag ((,c :foreground ,fg-main)))
    `(org-tag-group ((,c :inherit (bold org-tag))))
    `(org-target ((,c :underline t)))
    `(org-time-grid ((,c :foreground ,fg-dim)))
    `(org-todo ((,c :foreground ,err)))
    `(org-upcoming-deadline ((,c :foreground ,warning)))
    `(org-upcoming-distant-deadline ((,c :inherit org-upcoming-deadline)))
    `(org-verbatim ((,c :foreground ,constant)))
    `(org-verse (( )))
    `(org-warning ((,c :inherit warning)))
;;;; orderless
    `(orderless-match-face-0 ((,c :inherit bold :foreground ,accent-0)))
    `(orderless-match-face-1 ((,c :inherit bold :foreground ,accent-1)))
    `(orderless-match-face-2 ((,c :inherit bold :foreground ,accent-2)))
    `(orderless-match-face-3 ((,c :inherit bold :foreground ,accent-3)))
;;;; outline-mode
    `(outline-1 ((,c :inherit bold :foreground ,rainbow-1)))
    `(outline-2 ((,c :inherit bold :foreground ,rainbow-2)))
    `(outline-3 ((,c :inherit bold :foreground ,rainbow-3)))
    `(outline-4 ((,c :inherit bold :foreground ,rainbow-4)))
    `(outline-5 ((,c :inherit bold :foreground ,rainbow-5)))
    `(outline-6 ((,c :inherit bold :foreground ,rainbow-6)))
    `(outline-7 ((,c :inherit bold :foreground ,rainbow-7)))
    `(outline-8 ((,c :inherit bold :foreground ,rainbow-8)))
;;;; outline-minor-faces
    `(outline-minor-0 (()))
;;;; package (M-x list-packages)
    `(package-description ((,c :foreground ,docstring)))
    `(package-help-section-name ((,c :inherit bold)))
    `(package-name ((,c :inherit link)))
    `(package-status-available ((,c :foreground ,date)))
    `(package-status-avail-obso ((,c :inherit error)))
    `(package-status-built-in ((,c :foreground ,builtin)))
    `(package-status-dependency ((,c :foreground ,warning)))
    `(package-status-disabled ((,c :inherit error :strike-through t)))
    `(package-status-held ((,c :foreground ,warning)))
    `(package-status-incompat ((,c :inherit warning)))
    `(package-status-installed ((,c :foreground ,fg-alt)))
    `(package-status-new ((,c :inherit success)))
    `(package-status-unsigned ((,c :inherit error)))
;;;; rainbow-delimiters
    `(rainbow-delimiters-base-error-face ((,c :inherit (bold rainbow-delimiters-mismatched-face))))
    `(rainbow-delimiters-base-face    ((,c :foreground ,rainbow-0)))
    `(rainbow-delimiters-depth-1-face ((,c :foreground ,rainbow-0)))
    `(rainbow-delimiters-depth-2-face ((,c :foreground ,rainbow-1)))
    `(rainbow-delimiters-depth-3-face ((,c :foreground ,rainbow-2)))
    `(rainbow-delimiters-depth-4-face ((,c :foreground ,rainbow-3)))
    `(rainbow-delimiters-depth-5-face ((,c :foreground ,rainbow-4)))
    `(rainbow-delimiters-depth-6-face ((,c :foreground ,rainbow-5)))
    `(rainbow-delimiters-depth-7-face ((,c :foreground ,rainbow-6)))
    `(rainbow-delimiters-depth-8-face ((,c :foreground ,rainbow-7)))
    `(rainbow-delimiters-depth-9-face ((,c :foreground ,rainbow-8)))
    `(rainbow-delimiters-mismatched-face ((,c :background ,bg-red :foreground ,fg-intense)))
    `(rainbow-delimiters-unmatched-face ((,c :inherit (bold rainbow-delimiters-mismatched-face))))
;;;; show-paren-mode
    `(show-paren-match ((,c :background ,bg-cyan :foreground ,fg-intense)))
    `(show-paren-match-expression ((,c :background ,bg-alt)))
    `(show-paren-mismatch ((,c :background ,bg-red :foreground ,fg-intense)))
;;;; tab-bar-mode
    `(tab-bar ((,c :background ,bg-alt)))
    `(tab-bar-tab-group-current ((,c :background ,bg-main :box (:line-width (2 . -2) :color ,border))))
    `(tab-bar-tab-group-inactive ((,c :background ,bg-alt :box (:line-width (2 . -2) :color ,border))))
    `(tab-bar-tab ((,c :inherit bold :box (:line-width (2 . -2) :style flat-button) :background ,bg-main :foreground ,fg-main)))
    `(tab-bar-tab-inactive ((,c :box (:line-width (2 . -2) :style flat-button) :background ,bg-dim :foreground ,fg-alt)))
;;;;; transient
    `(transient-active-infix ((,c :background ,bg-hover-alt)))
    `(transient-amaranth ((,c :inherit bold :foreground ,yellow-warmer)))
    ;; Placate the compiler for what is a spurious warning.  We also
    ;; have to do this with `eldoc-highlight-function-argument'.
    (list 'transient-argument `((,c :inherit bold :background ,bg-added :foreground ,cyan)))
    `(transient-blue ((,c :inherit bold :foreground ,blue-cooler)))
    `(transient-disabled-suffix ((,c :strike-through t)))
    `(transient-enabled-suffix ((,c :background ,bg-changed)))
    `(transient-heading ((,c :inherit bold)))
    `(transient-inactive-argument ((,c :inherit shadow)))
    `(transient-inactive-value ((,c :inherit shadow)))
    `(transient-key ((,c :inherit help-key-binding)))
    `(transient-mismatched-key ((,c :underline t)))
    `(transient-nonstandard-key ((,c :underline t)))
    `(transient-pink ((,c :inherit bold :foreground ,magenta)))
    `(transient-purple ((,c :inherit bold :foreground ,magenta-cooler)))
    `(transient-red ((,c :inherit bold :foreground ,red)))
    `(transient-teal ((,c :inherit bold :foreground ,cyan-cooler)))
    `(transient-unreachable ((,c :inherit shadow)))
    `(transient-unreachable-key ((,c :inherit shadow)))
    `(transient-value ((,c :inherit success :background ,bg-dim)))
;;;; vertico
    `(vertico-current ((,c :background ,bg-completion)))
;;;; widget
    `(widget-button ((,c :inherit bold :foreground ,link)))
    `(widget-button-pressed ((,c :inherit widget-button :foreground ,link-alt)))
    `(widget-documentation ((,c :inherit font-lock-doc-face)))
    `(widget-field ((,c :background ,bg-alt :foreground ,fg-main :extend nil)))
    `(widget-inactive ((,c :inherit shadow :background ,bg-dim)))
    `(widget-single-line-field ((,c :inherit widget-field))))
  "Face specs for use with `ef-themes-theme'.")

(defconst ef-themes-custom-variables
  '()
  "Custom variables for `ef-themes-theme'.")

;;; Instantiate a theme

(defmacro ef-themes-theme (name palette)
  "Bind NAME's color PALETTE around face specs and variables.
Face specifications are passed to `custom-theme-set-faces'.
While variables are handled by `custom-theme-set-variables'.
Those are stored in `ef-themes-faces' and
`ef-themes-custom-variables' respectively."
  (declare (indent 0))
  (let ((sym (gensym))
        (colors (mapcar #'car (symbol-value palette))))
    `(let* ((c '((class color) (min-colors 256)))
            (,sym ,palette)
            ,@(mapcar (lambda (color)
                        (list color
                              `(let* ((value (car (alist-get ',color ,sym))))
                                 (if (stringp value)
                                     value
                                   (car (alist-get value ,sym))))))
                      colors))
            ;; ,@(symbol-value colors))
       (custom-theme-set-faces ',name ,@ef-themes-faces)
       (custom-theme-set-variables ',name ,@ef-themes-custom-variables))))

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (unless (equal dir (expand-file-name "themes/" data-directory))
      (add-to-list 'custom-theme-load-path dir))))

(provide 'ef-themes)
;;; ef-themes.el ends here
