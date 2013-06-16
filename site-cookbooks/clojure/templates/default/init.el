;;; -*-coding:utf-8-*-

;; Ensure el-get existence.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")


;; Install required macros.
(el-get 'sync 'paredit 'rainbow-delimiters 'clojure-mode 'nrepl)


;; Customized functions to format LISP expressions before saving file.
(defun format-all () (interactive)
  (save-excursion
  (mark-whole-buffer)
	(indent-for-tab-command)))

(defun shrink-close-paren () (interactive)
  (save-excursion
	(mark-defun)
	(while (re-search-forward ")[ \t\n]+?)" nil t)
	  (replace-match "))" nil nil)
	  (mark-defun))))

(defun lisp-format () (interactive)
  (format-all)
  (shrink-close-paren))

(defun add-lisp-format-before-save () (interactive)
  (add-hook 'before-save-hook
			'lisp-format
			t t))

(add-hook 'clojure-mode-hook
		  'add-lisp-format-before-save)

;; Add paredit support to various LISP modes.
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
