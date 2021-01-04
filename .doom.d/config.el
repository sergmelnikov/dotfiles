;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sergey Melnikov"
      user-mail-address "melnikhov@gmail.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light))
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/")
(setq org-roam-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/")
(add-hook 'after-init-hook 'org-roam-mode)
(setq org-roam-capture-templates
        '(("l" "Lit" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "${slug}"
           :head "#+title: ${title}\n"
           :unnarrowed t)
          ("r" "Roam note" entry (file create-org-file)
           "* %?#+title:\n#+roam_tags:\n\n*\n** Ссылки\n← uplink"
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

(setq display-line-numbers-type t)

(map! :leader
      (:prefix-map ("n" . "notes")
       (:prefix ("k" . "anki")
        :desc "Anki mode" "m" #'anki-editor-insert-note
        :desc "Insert Anki note" "i" #'anki-editor-insert-note
        :desc "Push notes" "p" #'anki-editor-push-notes
        :desc "Retry pushing notes" "r" #'anki-editor-retry-failure-notes)))


(custom-set-variables
 '(package-selected-packages (quote (evil-escape evil-better-visual-line org-roam))))

(use-package evil-better-visual-line
  :ensure t
  :config
  (evil-better-visual-line-on))

(custom-set-faces)

;; Full screen mode
(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
    (toggle-frame-fullscreen))

;; This code helps us to work with Spacemacs (Emacs + Evil mode) in multilanguage mode
;; Pavel Pavlov (c) 2015
;; (setq lang_source "com.apple.keylayout.US")                     ;set default var lang_source for issw arg
;; (add-hook 'evil-insert-state-entry-hook                         ;what we do when enter insert mode
;;           (lambda ()
;;             (shell-command (concat "issw " lang_source))))

;; (add-hook 'evil-insert-state-exit-hook                          ;what we do when enter normal mode
;;           (lambda ()
;;             (setq lang_source (shell-command-to-string "issw"))
;;             (shell-command "issw com.apple.keylayout.US")))

;; (setq lang_source "com.apple.keylayout.US")                     ;set default var lang_source for issw arg
;; (add-hook 'evil-replace-state-entry-hook                        ;what we do when enter insert mode
;;           (lambda ()
;;             (shell-command (concat "issw " lang_source))))

;; (add-hook 'evil-replace-state-exit-hook                          ;what we do when enter normal mode
;;           (lambda ()
;;             (setq lang_source (shell-command-to-string "issw"))
;;             (shell-command "issw com.apple.keylayout.US")))

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


(setq shell-file-name "/bin/bash")

;; Display time
(display-time-mode t)
(setq display-time-24hr-format t)

;; (define-key evil-normal-state-map (kbd "RET") '+evil/insert-newline-below)
(setenv "PATH" "/bin:/usr/local/bin:/usr/bin:")
