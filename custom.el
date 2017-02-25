(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode helm avy dash magit-popup geiser json-mode js2-mode rainbow-mode elisp-slime-nav rainbow-delimiters company smex ido-ubiquitous flx-ido vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line projectile ov operate-on-number move-text magit imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region editorconfig easy-kill discover-my-major diminish diff-hl crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; OSX
(set-default-font "Monaco 12")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; UI
(when (fboundp 'menu-bar-mode)
   (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
   (scroll-bar-mode -1))

;; Global mode
(setq prelude-whitespace nil)
(setq prelude-clean-whitespace-on-save nil)
(setq prelude-flyspell nil)
(setq prelude-guru nil)

(normal-erase-is-backspace-mode 1)
;(global-linum-mode 1)

;; Windows move up/down 
(defun hold-line-scroll-up()
 "Scroll the page with the cursor in the same line"
 (interactive)
 (let ((next-screen-context-lines
 (count-lines
 (window-start) (window-end))))
 (scroll-up)))
 (global-set-key (kbd "M-n") 'hold-line-scroll-up)

(defun hold-line-scroll-down()
 "Scroll the page with the cursor in the same line"
 (interactive)
 (let ((next-screen-context-lines
 (count-lines
 (window-start) (window-end))))
 (scroll-down)))
 (global-set-key (kbd "M-p") 'hold-line-scroll-down)

;; Undo Tree
(global-set-key (kbd "C-u") 'undo-tree-undo)
(global-set-key (kbd "M-u") 'undo-tree-redo)

;; Files
(global-set-key (kbd "C-x f") 'ido-find-file)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x C-s") 'save-some-buffers)

;; Set Mark
(global-set-key (kbd "C-l") 'set-mark-command)
(global-set-key (kbd "M-l") 'cua-rectangle-mark-mode)

;; Mark region
(defun mark-current-line ()
  "Select the current line."
  (interactive)
  (end-of-line)
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-x l") 'mark-current-line)

(defun mark-current-word ()
"Select the word under cursor. word here is considered any alphanumeric sequence with _ or - ."
 (interactive)
 (let (pt)
   (skip-chars-backward "-_A-Za-z0-9")
   (setq pt (point))
   (skip-chars-forward "-_A-Za-z0-9")
   (set-mark pt)
 ))
(global-set-key (kbd "C-x m") 'mark-current-word)

(defun mark-current-block ()
  "Select the current block of text between blank lines."
  (interactive)
  (let (p1 p2)
    (progn
      (if (re-search-backward "\n[ \t]*\n" nil "move")
          (progn (re-search-forward "\n[ \t]*\n")
                 (setq p1 (point)))
        (setq p1 (point)))
      (if (re-search-forward "\n[ \t]*\n" nil "move")
          (progn (re-search-backward "\n[ \t]*\n")
                 (setq p2 (point)))
        (setq p2 (point))))
    (set-mark p1)))
(global-set-key (kbd "C-x p") 'mark-current-block)

;; Sliver Searcher
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)

;(global-set-key (kbd "C-x c") 'save-buffers-kill-emacs)
;(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
;  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
;  (flet ((process-list ())) ad-do-it))

;; irony
(prelude-require-package 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
