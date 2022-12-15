;;; ts-fold.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Samuel Jackson
;;
;; Author: Samuel Jackson <dsiq3g@gmail.com>
;; Maintainer: Samuel Jackson <dsiq3g@gmail.com>
;; Created: December 14, 2022
;; Modified: December 14, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/samueljackson/ts-fold-overlay
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(require 'ts-fold-vars)
(require 'ts-fold-overlay)



;;
;; Define minor mode
;;

;;;###autoload
(define-minor-mode ts-fold-mode
  "Folding code using tree sitter."
  :init-value nil
  :lighter "TS-Fold"
  (if ts-fold-mode
      (ts-fold--enable)
    (ts-fold--disable)))

;;;###autoload
(define-global-minor-mode global-ts-fold-mode ts-fold-mode
  (lambda () (ts-fold-mode 1)))

(provide 'ts-fold)
