;;; ts-fold-vars.elj -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Samuel Jackson
;;
;; Author: Samuel Jackson <dsiq3g@gmail.com>
;; Maintainer: Samuel Jackson <dsiq3g@gmail.com>
;; Created: December 14, 2022
;; Modified: December 14, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/samueljackson/ts-fold-vars
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(require 'ts-fold-parsers)
(require 'ts-fold-summary)

;;
;; (@* "Customization" )
;;

(defgroup ts-fold nil
  "Code folding using tree-sitter."
  :group 'tree-sitter
  :prefix "ts-fold-")

;; TODO(everyone): This is a bit messy, but try to keep this alist
;; alphabetically sorted
(defcustom ts-fold-range-alist
  `((agda-mode       . ,(ts-fold-parsers-agda))
    (c-mode          . ,(ts-fold-parsers-c))
    (c++-mode        . ,(ts-fold-parsers-c++))
    (caml-mode       . ,(ts-fold-parsers-ocaml))
    (csharp-mode     . ,(ts-fold-parsers-csharp))
    (css-mode        . ,(ts-fold-parsers-css))
    (elixir-mode     . ,(ts-fold-parsers-elixir))
    (ess-r-mode      . ,(ts-fold-parsers-r))
    (go-mode         . ,(ts-fold-parsers-go))
    (html-mode       . ,(ts-fold-parsers-html))
    (java-mode       . ,(ts-fold-parsers-java))
    (javascript-mode . ,(ts-fold-parsers-javascript))
    (js-mode         . ,(ts-fold-parsers-javascript))
    (js2-mode        . ,(ts-fold-parsers-javascript))
    (js3-mode        . ,(ts-fold-parsers-javascript))
    (json-mode       . ,(ts-fold-parsers-json))
    (jsonc-mode      . ,(ts-fold-parsers-json))
    (julia-mode      . ,(ts-fold-parsers-julia))
    (nix-mode        . ,(ts-fold-parsers-nix))
    (ocaml-mode      . ,(ts-fold-parsers-ocaml))
    (php-mode        . ,(ts-fold-parsers-php))
    (python-mode     . ,(ts-fold-parsers-python))
    (rjsx-mode       . ,(ts-fold-parsers-javascript))
    (ruby-mode       . ,(ts-fold-parsers-ruby))
    (rust-mode       . ,(ts-fold-parsers-rust))
    (rustic-mode     . ,(ts-fold-parsers-rust))
    (sh-mode         . ,(ts-fold-parsers-bash))
    (scala-mode      . ,(ts-fold-parsers-scala))
    (swift-mode      . ,(ts-fold-parsers-swift))
    (tuareg-mode     . ,(ts-fold-parsers-ocaml))
    (typescript-mode . ,(ts-fold-parsers-typescript)))
  "An alist of (major-mode . (foldable-node-type . function)).

FUNCTION is used to determine where the beginning and end for FOLDABLE-NODE-TYPE
in MAJOR-MODE.  It should take a single argument (the syntax node with type
FOLDABLE-NODE-TYPE) and return the buffer positions of the beginning and end of
the fold in a cons cell.  See `ts-fold-range-python' for an example."
  :type '(alist :key-type symbol
                :value-type (alist :key-type symbol :value-type function))
  :group 'ts-fold)
;;
;; TODO(everyone): keep this alist alphabetically sorted
(defcustom ts-fold-summary-parsers-alist
  `((actionscript-mode . ts-fold-summary-javadoc)
    (bat-mode          . ts-fold-summary-batch)
    (c-mode            . ts-fold-summary-c)
    (c++-mode          . ts-fold-summary-c)
    (csharp-mode       . ts-fold-summary-csharp)
    (css-mode          . ts-fold-summary-javadoc)
    (go-mode           . ts-fold-summary-go)
    (html-mode         . ts-fold-summary-xml)
    (java-mode         . ts-fold-summary-javadoc)
    (javascript-mode   . ts-fold-summary-javadoc)
    (js-mode           . ts-fold-summary-javadoc)
    (js2-mode          . ts-fold-summary-javadoc)
    (js3-mode          . ts-fold-summary-javadoc)
    (julia-mode        . ts-fold-summary-julia-doc)
    (kotlin-mode       . ts-fold-summary-javadoc)
    (lua-mode          . ts-fold-summary-lua-doc)
    (markdown-mode     . ts-fold-summary-markdown)
    (objc-mode         . ts-fold-summary-c)
    (org-mode          . ts-fold-summary-org)
    (php-mode          . ts-fold-summary-javadoc)
    (python-mode       . ts-fold-summary-python-doc)
    (rjsx-mode         . ts-fold-summary-javadoc)
    (ruby-mode         . ts-fold-summary-ruby-doc)
    (rust-mode         . ts-fold-summary-rust-doc)
    (scala-mode        . ts-fold-summary-javadoc)
    (sh-mode           . ts-fold-summary-javadoc)
    (swift-mode        . ts-fold-summary-c)
    (typescript-mode   . ts-fold-summary-javadoc)
    (nxml-mode         . ts-fold-summary-xml))
  "Alist mapping `major-mode' to doc parser function."
  :type '(alist :key-type symbol :value-type function)
  :group 'ts-fold)

(defcustom ts-fold-mode-hook nil
  "Hook to run when enabling `ts-fold-mode`."
  :type 'hook
  :group 'ts-fold)

(defcustom ts-fold-replacement "..."
  "Show this string instead of the folded text."
  :type 'string
  :group 'ts-fold)

(defface ts-fold-replacement-face
  '((t :foreground "#808080" :box '(:line-width -1 :style 'pressed-button)))
  "Face used to display the fold replacement text."
  :group 'ts-fold)

(defface ts-fold-fringe-face
  '((t ()))
  "Face used to display fringe contents."
  :group 'ts-fold)

(provide 'ts-fold-vars)
;;; ts-fold-vars.el ends here
