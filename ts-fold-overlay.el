;;; ts-fold-overlay.el --- Overlay logic -*- lexical-binding: t; -*-
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

(defun ts-fold--create-overlay (range replacement)
  "Create invisible overlay in RANGE."
  (when range
    (let* ((beg (car range)) (end (cdr range)) (ov (make-overlay beg end)))
      (overlay-put ov 'creator 'ts-fold)
      (overlay-put ov 'invisible 'ts-fold)
      (overlay-put ov 'display replacement)
      (overlay-put ov 'face 'ts-fold-replacement-face)
      (overlay-put ov 'isearch-open-invisible #'ts-fold--isearch-open))))

(defun ts-fold--isearch-open (ov)
  "Open overlay OV during `isearch' session."
  (delete-overlay ov))


(provide 'ts-fold-overlay)
;;; ts-fold-overlay.el ends here
