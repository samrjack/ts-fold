;;; ts-fold-parsers.el --- Adapter layer to Tree-Sitter  -*- lexical-binding: t; -*-

;; Copyright (C) 2021-2022  Shen, Jen-Chieh
;; Created date 2021-10-04 17:45:48

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Adapter layer to Tree-Sitter
;;
;; This isn't a real parser implementation, but records down the rule
;; in order to let the Tree-Sitter to parse things correctly.  Think of
;; the rule sets!
;;

;;; Code:

;;
;; (@* "Externals" )
;;

;; TODO(everyone): keep the forward declared alphabetically sorted

;;
;; (@* "Parsers" )
;;

;; TODO(everyone): keep the function alphabetically sorted

(defun ts-fold-parsers-agda ()
  "Rule set for Agda."
  '(()))

(defun ts-fold-parsers-bash ()
  "Rule set for Bash."
  '((compound_statement . ts-fold-range-seq)
    (expansion          . ts-fold-range-seq)
    (comment
     . (lambda (node offset)
         (ts-fold-range-line-comment node offset "#")))))

(defun ts-fold-parsers-c ()
  "Rule set for C."
  '((compound_statement     . ts-fold-range-seq)
    (declaration_list       . ts-fold-range-seq)
    (enumerator_list        . ts-fold-range-seq)
    (field_declaration_list . ts-fold-range-seq)
    (preproc_if             . ts-fold-range-c-preproc-if)
    (preproc_ifdef          . ts-fold-range-c-preproc-ifdef)
    (preproc_elif           . ts-fold-range-c-preproc-elif)
    (preproc_else           . ts-fold-range-c-preproc-else)
    (comment                . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-c++ ()
  "Rule set for C++."
  (append (ts-fold-parsers-c)))

(defun ts-fold-parsers-csharp ()
  "Rule set for C#."
  '((block                                . ts-fold-range-seq)
    (accessor_list                        . ts-fold-range-seq)
    (enum_member_declaration_list         . ts-fold-range-seq)
    (declaration_list                     . ts-fold-range-seq)
    (switch_body                          . ts-fold-range-seq)
    (anonymous_object_creation_expression . ts-fold-range-seq)
    (initializer_expression               . ts-fold-range-seq)
    ;;(if_directive                         . ts-fold-range-seq)
    ;;(else_directive                       . ts-fold-range-seq)
    ;;(elif_directive                       . ts-fold-range-seq)
    ;;(endif_directive                      . ts-fold-range-seq)
    ;;(region_directive                     . ts-fold-range-seq)
    ;;(endregion_directive                  . ts-fold-range-seq)
    (comment                              . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-css ()
  "Rule set for CSS."
  '((keyframe_block_list . ts-fold-range-seq)
    (block               . ts-fold-range-seq)
    (comment             . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-elixir ()
  "Rules set for Elixir."
  '((list . ts-fold-range-seq)
    (map . ts-fold-range-seq)
    (tuple . ts-fold-range-seq)
    (comment
     . (lambda (node offset)
         (ts-fold-range-line-comment node offset "#")))
    (do_block . ts-fold-range-elixir)))

(defun ts-fold-parsers-go ()
  "Rule set for Go."
  '((block   . ts-fold-range-seq)
    (comment . ts-fold-range-seq)))

(defun ts-fold-parsers-html ()
  "Rule set for HTML."
  '((element . ts-fold-range-html)
    (comment . (ts-fold-range-seq 1 -1))))

(defun ts-fold-parsers-java ()
  "Rule set for Java."
  '((switch_block                    . ts-fold-range-seq)
    (block                           . ts-fold-range-seq)
    (element_value_array_initializer . ts-fold-range-seq)
    (module_body                     . ts-fold-range-seq)
    (enum_body                       . ts-fold-range-seq)
    (class_body                      . ts-fold-range-seq)
    (constructor_body                . ts-fold-range-seq)
    (annotation_type_body            . ts-fold-range-seq)
    (interface_body                  . ts-fold-range-seq)
    (array_initializer               . ts-fold-range-seq)
    (comment                         . (ts-fold-range-seq 1 -1))))

(defun ts-fold-parsers-javascript ()
  "Rule set for JavaScript."
  '((export_clause   . ts-fold-range-seq)
    (statement_block . ts-fold-range-seq)
    (comment         . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-json ()
  "Rule set for JSON."
  '((object . ts-fold-range-seq)
    (array  . ts-fold-range-seq)))

(defun ts-fold-parsers-julia ()
  "Rule set for Julia."
  '((block_comment       . (ts-fold-range-seq 1 -1))
    (for_statement       . (ts-fold-range-seq 2 -2))
    (function_definition . ts-fold-range-julia)
    (if_statement        . (ts-fold-range-seq 1 -2))
    (let_statement       . (ts-fold-range-seq 2 -2))
    (macro_definition    . ts-fold-range-julia)
    (module_definition   . ts-fold-range-julia)
    (quote_statement     . ts-fold-range-julia)
    (struct_definition   . ts-fold-range-julia)
    (triple_string       . (ts-fold-range-seq 2 -2))
    (try_statement       . (ts-fold-range-seq 2 -2))
    (while_statement     . ts-fold-range-julia)))

(defun ts-fold-parsers-nix ()
  "Rule set for Nix."
  '((attrset       . ts-fold-range-seq)
    (interpolation . ts-fold-range-seq)
    (list          . ts-fold-range-seq)))

(defun ts-fold-parsers-ocaml ()
  "Rule set for OCaml."
  '((comment             . ts-fold-range-ocaml-comment)
    (module_definition   . ts-fold-range-ocaml-module-definition)
    (type_definition     . ts-fold-range-ocaml-type-definition)
    (value_definition    . ts-fold-range-ocaml-value-definition)))

(defun ts-fold-parsers-php ()
  "Rule set for PHP."
  '((namespace_use_group . ts-fold-range-seq)
    (declaration_list    . ts-fold-range-seq)
    (use_list            . ts-fold-range-seq)
    (switch_block        . ts-fold-range-seq)
    (compound_statement  . ts-fold-range-seq)
    (comment
     . (lambda (node offset)
         (if (string-prefix-p "#" (tsc-node-text node))
             (ts-fold-range-line-comment node offset "#")
           (ts-fold-range-c-like-comment node offset))))))

(defun ts-fold-parsers-python ()
  "Rule set for Python."
  '((function_definition . ts-fold-range-python)
    (class_definition    . ts-fold-range-python)
    (list                . ts-fold-range-seq)
    (comment
     . (lambda (node offset)
         (ts-fold-range-line-comment node offset "#")))))

(defun ts-fold-parsers-r ()
  "Rule set for R."
  '((brace_list . ts-fold-range-seq)))

(defun ts-fold-parsers-ruby ()
  "Rule set for Ruby."
  '((class    . ts-fold-range-ruby-class-def)
    (method   . ts-fold-range-ruby-class-def)
    (array    . ts-fold-range-seq)
    (do       . (ts-fold-range-seq 1 -2))  ; match with `end`
    (do_block . (ts-fold-range-seq 1 -2))  ; match with `end`, in spec file
    (then     . ts-fold-range-ruby-if)        ; `if` and `elsif` block
    (else     . (ts-fold-range-ruby-if 4 0))  ; `else` block
    (comment
     . (lambda (node offset)
         (ts-fold-range-line-comment node offset "#")))))

(defun ts-fold-parsers-rust ()
  "Rule set for Rust."
  '((declaration_list       . ts-fold-range-seq)
    (enum_variant_list      . ts-fold-range-seq)
    (field_declaration_list . ts-fold-range-seq)
    (use_list               . ts-fold-range-seq)
    (field_initializer_list . ts-fold-range-seq)
    (match_block            . ts-fold-range-seq)
    (macro_definition       . (ts-fold-range-rust-macro 1 -1))
    (block                  . ts-fold-range-seq)
    (line_comment           . (lambda (node offset)
                                (ts-fold-range-line-comment node offset "///")))
    (block_comment          . ts-fold-range-block-comment)))

(defun ts-fold-parsers-scala ()
  "Rule set for Scala."
  '((import_selectors . ts-fold-range-seq)
    (template_body    . ts-fold-range-seq)
    (block            . ts-fold-range-seq)
    (comment          . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-swift ()
  "Rule set for Swift."
  '((switch_statement      . ts-fold-range-seq)
    (function_declaration  . ts-fold-range-seq)
    (enum_declaration      . ts-fold-range-seq)
    (struct_declaration    . ts-fold-range-seq)
    (class_declaration     . ts-fold-range-seq)
    (protocol_declaration  . ts-fold-range-seq)
    (extension_declaration . ts-fold-range-seq)
    (comment               . ts-fold-range-c-like-comment)))

(defun ts-fold-parsers-typescript ()
  "Rule set for TypeScript."
  (append (ts-fold-parsers-javascript)))


;;
;; Range functions
;;

(defun ts-fold-range-seq (node offset)
  "Return the fold range in sequence starting from NODE.

Argument OFFSET can be used to tweak the final beginning and end position."
  (let ((beg (1+ (tsc-node-start-position node)))
        (end (1- (tsc-node-end-position node))))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-line-comment (node offset prefix)
  "Define fold range for line comment.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information.

Argument PREFIX is the comment prefix in string."
  (when-let* ((first-node (ts-fold--continuous-node-prefix node prefix nil))
              (last-node (ts-fold--continuous-node-prefix node prefix t))
              (prefix-len (length prefix))
              (beg (+ (tsc-node-start-position first-node) prefix-len))
              (end (tsc-node-end-position last-node)))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-block-comment (node offset)
  "Define fold range for block comment.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (ts-fold-range-seq node (ts-fold--cons-add '(1 . -1) offset)))

(defun ts-fold-range-c-like-comment (node offset)
  "Define fold range for C-like comemnt.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (let ((text (tsc-node-text node)))
    (if (and (string-match-p "\n" text) (string-prefix-p "/*" text))
        (ts-fold-range-block-comment node offset)
      (if (string-prefix-p "///" text)
          (ts-fold-range-line-comment node offset "///")
        (ts-fold-range-line-comment node offset "//")))))


;; C

(defun ts-fold-range-c-preproc-if (node offset)
  "Define fold range for `if' preprocessor.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (let* ((named-node (tsc-get-child-by-field node :condition))
         (else (tsc-get-child-by-field node :alternative))
         (beg (tsc-node-end-position named-node))
         (end (1- (tsc-node-start-position else))))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-c-preproc-ifdef (node offset)
  "Define fold range for `ifdef' and `ifndef' preprocessor.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((named-node (tsc-get-child-by-field node :name))
              (else (tsc-get-child-by-field node :alternative))
              (beg (tsc-node-end-position named-node))
              (end (1- (tsc-node-start-position else))))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-c-preproc-elif (node offset)
  "Define fold range for `elif' preprocessor.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((named-node (tsc-get-child-by-field node :condition))
              (else (tsc-get-child-by-field node :alternative))
              (beg (tsc-node-end-position named-node))
              (end (1- (tsc-node-start-position else))))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-c-preproc-else (node offset)
  "Define fold range for `else' preprocessor.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((target "#else")
              (len (length target))
              (beg (+ (tsc-node-start-position node) len))
              (end (tsc-node-end-position node)))
    (ts-fold--cons-add (cons beg end) offset)))


;; OCaml

(defun ts-fold-range-ocaml-comment (node offset)
  "Define fold range for `comment'.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (unless (ts-fold--one-liner-node node)
    (when-let*
        ((text  (tsc-node-text node))
         (beg   (if (string-prefix-p "(* " text)
                    (+ 2 (tsc-node-start-position node))
                  (+ 3 (tsc-node-start-position node))))
         (end   (- (tsc-node-end-position node) 2)))
      (ts-fold--cons-add (cons beg end) offset))))

(defun ts-fold-range-ocaml-module-definition (node offset)
  "Define fold range for `module_definition'.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (unless (ts-fold--one-liner-node node)
    (when-let*
        ((module-binding (tsc-get-nth-named-child node 0))
         (body           (tsc-get-child-by-field module-binding :body))
         ;; body is struct ... end
         (beg            (+ 6 (tsc-node-start-position body)))
         (end            (- (tsc-node-end-position node) 3)))
      (ts-fold--cons-add (cons beg end) offset))))

(defun ts-fold-range-ocaml-type-definition (node offset)
  "Define fold range for `type_definition'.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (unless (ts-fold--one-liner-node node)
    (when-let*
        ((type-definition (tsc-get-nth-named-child node 0))
         (body            (tsc-get-child-by-field type-definition :body))
         (text            (tsc-node-text (tsc-get-nth-child body 0)))
         (beg
          (if (string-equal "{" text)
              (1+ (tsc-node-start-position body))
            (tsc-node-end-position (tsc-get-prev-sibling body))))
         (end
          (if (string-equal "{" text)
              (1- (tsc-node-end-position node))
            (tsc-node-end-position node))))
      (ts-fold--cons-add (cons beg end) offset))))

(defun ts-fold-range-ocaml-value-definition (node offset)
  "Define fold range for `value_definition'.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (unless (ts-fold--one-liner-node node)
    (when-let*
        ((let-binding  (tsc-get-nth-named-child node 0))
         (body         (tsc-get-child-by-field let-binding :body))
         (beg          (tsc-node-end-position (tsc-get-prev-sibling body)))
         (end          (tsc-node-end-position node)))
      (ts-fold--cons-add (cons beg end) offset))))

;; Other

(defun ts-fold-range-python (node offset)
  "Define fold range for `function_definition' and `class_definition'.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((named-node (or (tsc-get-child-by-field node :superclasses)
                              (tsc-get-child-by-field node :return_type)
                              (tsc-get-child-by-field node :parameters)
                              (tsc-get-child-by-field node :name)))
              ;; the colon is an anonymous node after return_type or parameters node
              (beg (tsc-node-end-position (tsc-get-next-sibling named-node)))
              (end (tsc-node-end-position node)))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-ruby-class-def (node offset)
  "Define fold range for `method' and `class' in Ruby.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((named-node (or (tsc-get-child-by-field node :superclass)
                              (tsc-get-child-by-field node :parameters)
                              (tsc-get-child-by-field node :name)))
              (beg (tsc-node-end-position named-node))
              (end (tsc-node-end-position node)))
    (ts-fold--cons-add (cons beg (- end 3)) offset)))

(defun ts-fold-range-ruby-if (node offset)
  "Define fold range for `if' (then), `elsif', and `else' in Ruby.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let ((beg (tsc-node-start-position node))
             (end (tsc-node-end-position node)))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-rust-macro (node offset)
  "Return the fold range for `macro_definition' NODE in Rust.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((children (tsc-count-children node))
              (last_bracket (tsc-get-nth-child node (- children 1)))
              (first_bracket (tsc-get-nth-child node 2))
              (beg (tsc-node-start-position first_bracket))
              (end (1+ (tsc-node-start-position last_bracket))))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-elixir (node offset)
  "Return the fold range for `function' `module' NODE in Elixir.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (when-let* ((children (tsc-count-children node))
              (end_child (tsc-get-nth-child node (- children 1)))
              (do_child (tsc-get-nth-child node 1))
              (beg (tsc-node-start-position do_child))
              (end (tsc-node-start-position end_child)))
    (ts-fold--cons-add (cons beg end) offset)))

(defun ts-fold-range-julia (node offset)
  "Return the fold range for a NODE in Julia.

It excludes the NODE's first child and the `end' keyword.  For
argument OFFSET, see function `ts-fold-range-seq' for more
information."
  (let* ((identifier (tsc-get-nth-named-child node 0))
         (end-position (byte-to-position (aref (tsc-node-range identifier) 1)))
         (start-position (byte-to-position (aref (tsc-node-range node) 0)))
         (fold-begin (1- (- end-position start-position))))
    (ts-fold-range-seq node (ts-fold--cons-add (cons fold-begin -2) offset))))

(defun ts-fold-range-html (node offset)
  "Define fold range for tag in HTML.

For arguments NODE and OFFSET, see function `ts-fold-range-seq' for
more information."
  (let* ((beg (tsc-node-end-position (tsc-get-nth-child node 0)))
         (end-node (tsc-get-nth-child node (1- (tsc-count-children node))))
         (end (tsc-node-start-position end-node)))
    (ts-fold--cons-add (cons beg end) offset)))

(provide 'ts-fold-parsers)
;;; ts-fold-parsers.el ends here
