;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Astrawan Wayan"
      user-mail-address "astra@pm.me")

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
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 11.0 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 11.0 :weight 'medium)
      doom-symbol-font (font-spec :family "FiraCode Nerd Font Mono" :size 11.0 :weight 'medium)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 18.0 :weight 'medium)
      doom-serif-font (font-spec :family "FiraCode Nerd Font" :size 11.0 :weight 'normal))

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
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


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

(setq private-user-directory doom-user-dir)

(load! (concat doom-user-dir "private/private-funcs"))

(setq fancy-splash-image (concat private-user-directory "private/banners/doom-brutal.png"))

(remove-hook! '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook! '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(after! mu4e
  (private/mu4e-setup))

;; Eighty Column Rule Hook
(setq-default display-fill-column-indicator-character ?·)
(add-hook! 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq
 standard-indent 2)

;; Enable syntax highlight in org-latex via minted texlive package
(use-package! ox-latex
  :config
  (setq org-latex-src-block-backend 'minted
        ;; enable shell escape to make pygmentize command working properly
        org-latex-pdf-process '("latexmk -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f")))
(after! ox-latex
  (add-to-list 'org-latex-packages-alist '("" "minted" nil)))

;; Treemacs
(use-package! treemacs
  :config
  (setq
   treemacs-follow-mode t
   treemacs-position 'right
   treemacs-width 40))

;; Org Roam
(use-package! org-roam
  :config
  (setq
   org-roam-completion-everywhere t
   org-roam-directory (file-truename "~/Documents/Org/RoamNotes")))
(after! org-roam
  (require 'org-roam-ui))

(use-package! plantuml-mode
  :config
  (setq
   plantuml-jar-path "~/Projects/runtimes/plantuml/plantuml.jar"
   plantuml-default-exec-mode 'jar))

(after! yasnippet
  (require 'yasnippet-snippets))

;; Org Roam UI
;; (map! :leader
;;       (:prefix-map ("n". "notes")
;;        (:when (modulep! :lang org +roam2)
;;         (:prefix ("r" . "roam")
;;          :desc "UI" "u" #'org-roam-ui-mode))))

(use-package! sh-script
  :config
  (setq sh-basic-offset 2))

;; SQL
(add-hook! sql-mode-hook 'lsp)
(use-package! lsp
  :config
  (setq
   lsp-enable-indentation nil
   lsp-use-plists t
   lsp-sqls-workspace-config-path nil
   lsp-sqls-connections
   '(((driver . "postgresql") (dataSourceName . "host=127.0.0.1 port=5432 user=postgres password=p@55w0rd dbname=postgres sslmode=disable"))
     ((driver . "postgresql") (dataSourceName . "host=127.0.0.1 port=5433 user=postgres password=p@55w0rd dbname=sapi sslmode=disable")))))

(use-package! typescript-mode
  :config
  (setq typescript-indent-level 2))

(use-package! web-mode
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-attr-indent-offset 2))
