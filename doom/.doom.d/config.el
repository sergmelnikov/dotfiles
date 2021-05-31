;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sergey Melnikov"
      user-mail-address "melnikhov@gmail.com"
      ;; doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light)
      doom-font (font-spec :family "Fira Code" :size 16 :weight 'light)
      org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/"
      org-roam-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/"
      +org-roam-open-buffer-on-find-file nil
      display-line-numbers-type nil
      shell-file-name "/bin/bash"
      fill-column 80
      projectile-project-search-path '("~/code/"))

(setq doom-themes-enable-bold nil)
(load-theme 'doom-oceanic-next t)

(setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc))

(setq display-time-24hr-format t)
(display-time-mode 1)
;; (setq display-time-day-and-date t)

(setenv "PATH" "/bin:/usr/local/bin:/usr/bin:/usr/sbin/:/sbin:")

(add-hook 'after-init-hook 'org-roam-mode)
(setq org-roam-capture-templates
        '(("l" "Lit" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+title: ${title}\n"
           :unnarrowed t)
          ("r" "Roam note" entry (file create-org-file)
           "* #+title:\n\n\n* Ссылки\n\n←  \n#+roam_tags:"
           :unnarrowed t)
          ("p" "Private" plain (function org-roam-capture--get-point)
           "%?"
           :head "#+title:
#+roam_tags:"
           :unnarrowed t)))

;; This function return quantity of three-symbols org files
(defun get-files-quantity ()
    (string-to-number
        (shell-command-to-string "ls ~/Library/Mobile\\ Documents/iCloud~com~appsonthemove~beorg/Documents/org/???.org | wc -l")))

;; This function return string line from notes-id.txt with id
(defun get-id-from-file (filePath)
    "Return the contents of filename's line"
    (with-temp-buffer
        (insert-file-contents filePath nil (- (* 4 notes-quantity) 4) (- (* 4 notes-quantity) 1))
        (buffer-string)))

(defun create-org-file ()
    "Create an org file in ~/Library/Mobile\ Documents/iCloud~com~appsonthemove~beorg/Documents/org/"
    (interactive)
    (setq notes-quantity (+ 1 (get-files-quantity)))
    (let ((name (get-id-from-file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/notes-id.txt")))
      (expand-file-name (format "%s.org"
                                name) "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/")))

(map! :leader
      (:prefix-map ("n" . "notes")
       (:prefix ("k" . "anki")
        :desc "Anki mode" "m" #'anki-editor-mode
        :desc "Insert Anki note" "i" #'anki-editor-insert-note
        :desc "Push notes" "p" #'anki-editor-push-notes
        :desc "Retry pushing notes" "r" #'anki-editor-retry-failure-notes))
      (:prefix-map ("t" . "toggle")
        :desc "Display column indicator" "c" #'display-fill-column-indicator-mode))

(custom-set-variables
 '(package-selected-packages (quote (evil-escape evil-better-visual-line org-roam))))

(use-package evil-better-visual-line
  :ensure t
  :config
  (evil-better-visual-line-on))

;; Full screen mode
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
    (toggle-frame-fullscreen))

;; Auto change language to english when enter normal mode from insert mode
(setq lang_source "com.apple.keylayout.US")                     ;set default var lang_source for issw arg
(add-hook 'evil-insert-state-entry-hook                         ;what we do when enter insert mode
          (lambda ()
            (shell-command (concat "issw " lang_source))))      ;
(add-hook 'evil-insert-state-exit-hook                          ;what we do when enter normal mode
          (lambda ()
            (setq lang_source (shell-command-to-string "issw"))
            (shell-command "issw com.apple.keylayout.US")))
(setq lang_source "com.apple.keylayout.US")                     ;set default var lang_source for issw arg
(add-hook 'evil-replace-state-entry-hook                         ;what we do when enter insert mode
          (lambda ()
            (shell-command (concat "issw " lang_source))))      ;
(add-hook 'evil-replace-state-exit-hook                          ;what we do when enter normal mode
          (lambda ()
            (setq lang_source (shell-command-to-string "issw"))
            (shell-command "issw com.apple.keylayout.US")))

(add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)))

(setq
    org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
)

(setq deft-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/"
      deft-extensions '("org")
      deft-recursive t
      deft-org-mode-title-prefix nil
      deft-time-format " %Y.%m.%d")

;; Minimal splash screen
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
