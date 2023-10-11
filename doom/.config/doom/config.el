;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

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

;;; Modeline
(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-project))

;;; Info
(setq +doom-dashboard-banner-padding '(0 . 2)
      confirm-kill-emacs nil
      ;; initial-frame-alist '((top . 100) (left . 100) (width . 115) (height . 35))
      kill-whole-line t
      pixel-scroll-precision-mode t)
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;;; Project
(defun tux-projectile-switch-project-action ()
  (set-frame-parameter nil 'tux-projectile-project-name projectile-project-name)
  (projectile-run-eshell)
  (projectile-find-file))

(setq projectile-switch-project-action 'tux-projectile-switch-project-action)
(setq frame-title-format
      '(""
        "%b"
        (:eval
         (let ((project-name (projectile-project-name)))
           (if (not (string= "-" project-name))
               (format " ● %s" project-name)
             (format " ● %s" (frame-parameter nil 'tux-projectile-project-name)))))))

;;; Python
(defun autoload-venv()
  (cond
   ((string= (projectile-project-name) "py")
    (pyvenv-activate "~/.venv/python"))
   ((string= (projectile-project-name) "ansible")
    (pyvenv-activate "~/.venv/python"))
   ((string= (projectile-project-name) "test")
    (pyvenv-activate "~/.venv/test"))))
(add-hook 'projectile-after-switch-project-hook #'autoload-venv)

;;; Seach engine
(engine-mode t)
(engine/set-keymap-prefix (kbd "C-c s"))
(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")
(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")
(defengine npm
  "https://www.npmjs.com/search?q=%s"
  :keybinding "n")
(defengine crates
  "https://crates.io/search?q=%s"
  :keybinding "c")
(defengine localhost
  "http://localhost:%s"
  :keybinding "l")
(defengine translate
  "https://translate.google.com/?sl=en&tl=vi&text=%s&op=translate"
  :keybinding "t")
(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
  :keybinding "y")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")

;;; Tux
;; Emulating vi's % key
(after! smartparens
  (defun tux/goto-match-paren (arg)
    "Go to the matching paren/bracket, otherwise (or if ARG is not
    nil) insert %.  vi style of % jumping to matching brace."
    (interactive "p")
    (if (not (memq last-command '(set-mark
                                  cua-set-mark
                                  tux/goto-match-paren
                                  down-list
                                  up-list
                                  end-of-defun
                                  beginning-of-defun
                                  backward-sexp
                                  forward-sexp
                                  backward-up-list
                                  forward-paragraph
                                  backward-paragraph
                                  end-of-buffer
                                  beginning-of-buffer
                                  backward-word
                                  forward-word
                                  mwheel-scroll
                                  backward-word
                                  forward-word
                                  mouse-start-secondary
                                  mouse-yank-secondary
                                  mouse-secondary-save-then-kill
                                  move-end-of-line
                                  move-beginning-of-line
                                  backward-char
                                  forward-char
                                  scroll-up
                                  scroll-down
                                  scroll-left
                                  scroll-right
                                  mouse-set-point
                                  next-buffer
                                  previous-buffer
                                  previous-line
                                  next-line
                                  back-to-indentation
                                  doom/backward-to-bol-or-indent
                                  doom/forward-to-last-non-comment-or-eol
                                  )))
        (self-insert-command (or arg 1))
      (cond ((looking-at "\\s\(") (sp-forward-sexp) (backward-char 1))
            ((looking-at "\\s\)") (forward-char 1) (sp-backward-sexp))
            (t (self-insert-command (or arg 1))))))
  (map! "%" 'tux/goto-match-paren))

;; Add file keybinding
(defun tux/add-file-keybinding (key file &optional desc)
  (let ((key key)
        (file file)
        (desc desc))
    (map! :desc (or desc file)
          key
          (lambda () (interactive) (find-file file)))))

;; Org convert keyword case to lower
(defun tux/org-convert-keyword-case-to-lower ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((count 0)
          (case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]+" nil t)
        (unless (s-matches-p "RESULTS" (match-string 0))
          (replace-match (downcase (match-string 0)) t)
          (setq count (1+ count))))
      (message "Replaced %d occurances" count))))

(setq me-directory "~/Sync/personal/emacs/")

;; Org
(let ((myorg-settings (concat me-directory "org.el")))
  (when (file-exists-p myorg-settings)
    (load-file myorg-settings)))

;;; vterm
(after! vterm
  ;; Use default system shell
  (setq-default vterm-shell (getenv "SHELL"))
  ;; Maximum scrollback to the max
  (setq vterm-max-scrollback 10000)
  ;; Make vterm as snappy as it can be
  (setq vterm-timer-delay nil)
  ;; Use bash as default shell in remote servers.
  (pushnew! vterm-tramp-shells
            '("ssh" "/bin/bash")
            '("scp" "/bin/bash")))
;; Make urls clickable in vterm modes
(add-hook! vterm-mode #'goto-address-mode)

(defun +vterm/split-right ()
  "Create a new vterm window to the right of the current one."
  (interactive)
  (let* ((ignore-window-parameters t)
         (dedicated-p (window-dedicated-p)))
    (split-window-horizontally)
    (other-window 1)
    (+vterm/here default-directory)))
(global-set-key (kbd "<f8>") #'+vterm/split-right)

;;; Dired tramp
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
(setq tramp-verbose 1)
(setq tramp-default-method "ssh")

;;; Me
(let ((personal-settings (concat me-directory "config.el")))
  (when (file-exists-p personal-settings)
    (load-file personal-settings)))
