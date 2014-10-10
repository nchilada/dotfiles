
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(package-initialize)

(defvar my-packages '(ace-jump-mode))
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/")
; Now add modules to that directory and specify `(require ________)`
; or `(load-library ________)` here.

(define-key global-map (kbd "C-x c") 'ace-jump-char-mode) ; Jump to character
(define-key global-map (kbd "C-x w") 'ace-jump-mode) ; Jump to word
;(define-key global-map (kbd "C-x l") 'ace-jump-line-mode) ; Jump to line, conflicts with line count function

; Interactively Do Things offers some sort of filename completion
; when opening and switching between buffers.  For switching,
; the flex/fuzzy-matching option lets you type in characters
; appearing ANYWHERE in the filename.  Use C-s and C-r to scroll
; through the options.
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
; Display ido results vertically, rather than horizontally
;;(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;;    (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

;(setq-default linum-mode 1)
(line-number-mode 1)
(column-number-mode 1)

(setq-default c-basic-offset 4) ; indentation size
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ; don't insert tabs in place of 8 spaces

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'prog-mode-hook 'subword-mode) ; recognize CamelCase,
                                         ; just like lisp-case and snake_case

(setq-default ring-bell-function 'ignore) ; no bell, e.g. when reaching the beginning/end of the buffer

(global-font-lock-mode 1)

(define-key global-map (kbd "RET") 'newline-and-indent)

(set 'temporary-file-directory "/tmp")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(when (display-graphic-p)
 ;; 2012-12-19
 ;; I moved the customize-face settings for the "default" face here because,
 ;; while it works correctly in Emacs.app, it creates an ugly red background
 ;; in the CLI.
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#22080A" :foreground "#BBBBBB" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Monaco"))))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background light)) (:foreground "SteelBlue1"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "Goldenrod"))))
 '(isearch ((((class color) (min-colors 88) (background light)) (:background "DeepPink"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "DeepPink"))))
 '(lazy-highlight ((((class color) (min-colors 88) (background light)) (:background "DarkGreen" :foreground "LightGray"))))
 '(minibuffer-prompt ((t (:foreground "SteelBlue1"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "SteelBlue3" :foreground "grey10" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((default (:inherit mode-line)) (((class color) (min-colors 88) (background light)) (:background "grey25" :foreground "grey10" :box (:line-width -1 :color "grey75") :weight light))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "darkblue"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "yellow1")))))

(add-to-list 'auto-mode-alist '("\\.flex\\'" . c-mode))

(setq tramp-default-method "ssh")

; See http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  "Move point to beginning of text, then beginning of line."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))
;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)
