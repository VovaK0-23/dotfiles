;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Vova"
      user-mail-address "451585@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Open Sans" :size 13))
(after! doom-themes
  (setq  doom-themes-enable-bold t
         doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :weight bold))

;; Make sure the margin is visible to begin with
;; (setq-default right-margin-width 1)
;; Move flycheck to right margin
;; (setq-default flycheck-indication-mode 'right-margin)

;;after startup actions
(defun after-startup()
  (fringe-mode 4)
  (auto-save-visited-mode))
(add-hook 'emacs-startup-hook 'after-startup)

;;auto save modified file when focus lost
(defun save ()
  (unless (frame-focus-state)
      (if (buffer-file-name)
          (save-some-buffers t))))
;; set the buffer focus hooks for the current buffer:
(add-function :after after-focus-change-function 'save)

;;set modes for different file extensions
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))

;; js2-mode autocomplition
(after! js2-mode
  (set-company-backend! 'js2-mode
    '(company-dabbrev :with ac-js2-company company-capf company-tide company-yasnippet)))

;; rjsx-mode autocomplition
(after! rjsx-mode
  (set-company-backend! 'rjsx-mode
    '(company-dabbrev :with company-capf company-tide company-yasnippet)))

;; shortcuts
(setq centaur-tabs-enable-key-bindings t)
(define-key evil-normal-state-map (kbd "SPC <right>") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "SPC <left>") 'centaur-tabs-backward)
(define-key evil-normal-state-map (kbd "SPC <down>") 'centaur-tabs-forward-group)
(define-key evil-normal-state-map (kbd "SPC <up>") 'centaur-tabs-backward-group)
(define-key evil-normal-state-map (kbd "SPC DEL") 'centaur-tabs--kill-this-buffer-dont-ask)
(define-key evil-normal-state-map (kbd "SPC 1") 'treemacs)

(setq mode-require-final-newline t)
(setq solidity-solium-path "/home/vova/.nvm/versions/node/v16.11.1/bin/solium")
(setq solidity-sols-path "/home/vova/.nvm/versions/node/v16.11.1/bin/solcjs")
(setq flycheck-solidity-solium-soliumrcfile "/home/vova/Documents/blockchain_tutorial/.soliumrc.json")
(setq solidity-flycheck-solc-checker-active t)
(setq solidity-flycheck-solium-checker-active t)

(setq flycheck-solidity-solc-addstd-contracts t)
(setq-default tab-width 2)
(setq-hook! 'solidity-mode-hook tab-width 4)
(setq-hook! 'ruby-mode-hook +format-with 'rubocop)
(setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(if (display-graphic-p)
    (setq doom-theme 'doom-nord)
  ;; (setq doom-theme 'doom-one-light))
  (setq doom-theme 'doom-dracula))
;; (setq doom-themes-treemacs-theme "doom-atom")
(setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; run script
(defun run-current-file ()
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call “perl x.pl” in a shell.
File suffix is used to determine what program to run.
If the file is modified, ask if you want to save first. (This command always run the saved version.)
If the file is emacs lisp, run the byte compiled version if exist."
  (interactive)

  (let (suffixMap fName fSuffix progName cmdStr)
    ;; a keyed list of file suffix to comand-line program path/name
    (setq suffixMap
          '(("php" . "php")
            ;; ("coffee" . "coffee -p")
            ("pl" . "perl")
            ("py" . "python")
            ("rb" . "ruby")
            ("js" . "node")             ; node.js
            ("sh" . "bash")
            ("ml" . "ocaml")
            ("vbs" . "cscript")))
    (setq fName (buffer-file-name))
    (setq fSuffix (file-name-extension fName))
    (setq progName (cdr (assoc fSuffix suffixMap)))
    (setq cmdStr (concat progName " \""   fName "\""))

    (when (buffer-modified-p)
      (progn
        (when (y-or-n-p "Buffer modified. Do you want to save first?")
          (save-buffer) ) ) )

    (if (string-equal fSuffix "el") ; special case for emacs lisp
        (progn
          (load (file-name-sans-extension fName)))
      (if progName
          (progn
            (message "Running…")
            (message progName)
            (if (y-or-n-p "Async shell?")
                (async-shell-command cmdStr "*run-current-file output*")
            (shell-command cmdStr "*run-current-file output*" )))
        (message "No recognized program file suffix for this file.")))
    ))
