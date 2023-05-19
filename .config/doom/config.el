;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vova K" user-mail-address "451585@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono"))
(setq  doom-variable-pitch-font (font-spec :family "SauceCodePro Nerd Font Mono"))

(custom-set-faces! '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :weight bold))

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :amily "Fira Sans" :size 13))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


(auto-save-visited-mode t)

(global-auto-revert-mode t)
(global-prettify-symbols-mode t)
(setq mode-require-final-newline t)
(setq flycheck-checker-error-threshold 3000)

(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'typescript-tsx-mode-hook 'prettier-js-mode)
(add-hook 'css-mode-hook 'prettier-js-mode)

(add-hook 'ruby-mode-hook 
          (lambda () 
            (add-hook 'before-save-hook  'lsp-format-buffer)))

(use-package reverse-im 
  :custom (reverse-im-input-methods '("russian-computer")) 
  :config (reverse-im-mode t) )

(add-to-list 'default-frame-alist '(alpha . 
                                    (96 
                                     .
                                     90)))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun format-buffer-my () 
  (interactive) 
  (pcase (car(last(split-string buffer-file-name "\\."))) 
    ("scss" (shell-command (format "sass-lint-auto-fix %s" (shell-quote-argument
                                                            buffer-file-name))))))
(defun no-easy-keys () 
  (dolist (tuple '(("<left>" . "h" ) 
                   ("<down>" . "j") 
                   ("<up>" . "k") 
                   ("<right>" . "l"))) 
    (evil-global-set-key 'normal (kbd (car tuple)) 
                         (lambda () 
                           (interactive) 
                           (message (format "No! Use %s instead!" (cdr tuple)))))))

(no-easy-keys)

(evil-global-set-key 'normal (kbd "C-u") 
                     (lambda () 
                       (interactive) 
                       (evil-scroll-up evil-this-motion-count) 
                       (evil-scroll-line-to-center evil-this-motion-count)))

(evil-global-set-key 'normal (kbd "C-d") 
                     (lambda () 
                       (interactive) 
                       (evil-scroll-down evil-this-motion-count) 
                       (evil-scroll-line-to-center evil-this-motion-count)))

(message "(,-,)")
