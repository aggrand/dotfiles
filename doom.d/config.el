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
;; - `doom-symbol-font' -- for symbols
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
(setq doom-font (font-spec :family "Iosevka" :size 20 :weight 'semi-light))
(setq doom-variable-pitch-font (font-spec :family "ETBembo" :size 20 :weight 'semi-light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory (format "%s/roam" org-directory))

;; TODO: There might be a way to not need vulpea?
(use-package! vulpea
  :demand t
  :hook ((org-roam-db-autosync-mode . vulpea-db-autosync-enable)))

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

(after! projectile
        (when (file-directory-p "~/projects")
        (setq projectile-project-search-path '("~/projects")))
        ;;(setq projectile-switch-project-action 'projectile-dired)
        (setq projectile-switch-project-action (lambda ()
        (+workspace/new (projectile-project-name)) ;; crea un nuevo workspace con el nombre del proyecto
        (let ((project-root (projectile-project-root)))
          (dired project-root))))
        (add-hook 'projectile-after-switch-project-hook
          (lambda ()
            (when (magit-toplevel)
              (magit-status))))

)

(use-package! anki-editor
  :hook (org-mode . (lambda ()
                (anki-editor-mode)
                (add-hook 'after-save-hook #'anki-editor-push-notes nil 'local)))
  :config
  (setq anki-editor-org-tags-as-anki-tags nil))


;; TODO: Make this work
(defun my/org-verb-setup ()
  (verb-mode)
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map)
  (map! :map org-mode-map
        :localleader
        ("v" . (:keymap verb-command-map :which-key "verb"))))

(use-package! verb
  :hook (org-mode . my/org-verb-setup))

(after! treesit
  (setq treesit-language-source-alist
        '((bash "https://github.com/tree-sitter/tree-sitter-bash")
          (elisp "https://github.com/Wilfred/tree-sitter-elisp")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (html "https://github.com/tree-sitter/tree-sitter-html")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (json "https://github.com/tree-sitter/tree-sitter-json")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

  )

;; ----------------------     EXWM Configs below    -----------------------

;;;; Launches a program that runs without a shell.
;;(defun run-in-background (command)
;;  (let ((command-parts (split-string command "[ ]+")))
;;    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))
;;
;;;; Disable menu-bar, tool-bar and scroll-bar to increase the usable space.
;;(menu-bar-mode -1)
;;(tool-bar-mode -1)
;;(scroll-bar-mode -1)
;;;; Also shrink fringes to 1 pixel.
;;(fringe-mode 1)
;;
;;;; Turn on `display-time-mode' if you don't use an external bar.
;;(setq display-time-default-load-average nil)
;;(setq display-time-day-and-date t)
;;(setq display-time-24hr-format t)
;;(display-time-mode t)
;;
;;;; You are strongly encouraged to enable something like `ido-mode' to alter
;;;; the default behavior of 'C-x b', or you will take great pains to switch
;;;; to or back from a floating frame (remember 'C-x 5 o' if you refuse this
;;;; proposal however).
;;;; You may also want to call `exwm-config-ido' later (see below).
;;
;;;; Emacs server is not required to run EXWM but it has some interesting uses
;;;; (see next section).
(server-start)
;;
;;;; Below are configurations for EXWM.
;;
;;;; Add paths (not required if EXWM is installed from GNU ELPA).
;;;(add-to-list 'load-path "/path/to/xelb/")
;;;(add-to-list 'load-path "/path/to/exwm/")
;;
;;;; Load EXWM.
;;(require 'exwm)
;;
;;;; ;; Fix problems with Ido (if you use it).
;;;; ;; (require 'exwm-config)
;;;; ;; (exwm-config-ido)
;;;; ;; (exwm-config--fix/ido-buffer-window-other-frame)
;;;;
;;;; Set the initial number of workspaces (they can also be created later).
;;(setq exwm-workspace-number 4)
;;;;
;;;; All buffers created in EXWM mode are named "*EXWM*". You may want to
;;;; change it in `exwm-update-class-hook' and `exwm-update-title-hook', which
;;;; are run when a new X window class name or title is available.  Here's
;;;; some advice on this topic:
;;;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
;;;; + For applications with multiple windows (e.g. GIMP), the class names of
;;;;   all windows are probably the same.  Using window titles for them makes
;;;;   more sense.
;;;; In the following example, we use class names for all windows except for
;;;; Java applications and GIMP.
;;(add-hook 'exwm-update-class-hook
;;          (lambda ()
;;            (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;;                        (string= "gimp" exwm-instance-name))
;;              (exwm-workspace-rename-buffer exwm-class-name))))
;;(add-hook 'exwm-update-title-hook
;;          (lambda ()
;;            (when (or (not exwm-instance-name)
;;                      (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;;                      (string= "gimp" exwm-instance-name))
;;              (exwm-workspace-rename-buffer exwm-title))))
;;
;;;; Global keybindings can be defined with `exwm-input-global-keys'.
;;;; Here are a few examples:
;;(setq exwm-input-global-keys
;;      `(
;;        ;; Bind "s-r" to exit char-mode and fullscreen mode.
;;        ([?\s-r] . exwm-reset)
;;        ;; Bind "s-w" to switch workspace interactively.
;;        ([?\s-w] . exwm-workspace-switch)
;;        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
;;        ,@(mapcar (lambda (i)
;;                    `(,(kbd (format "s-%d" i)) .
;;                      (lambda ()
;;                        (interactive)
;;                        (exwm-workspace-switch-create ,i))))
;;                  (number-sequence 0 9))
;;        ;; Bind "s-&" to launch applications ('M-&' also works if the output
;;        ;; buffer does not bother you).
;;        ([?\s-&] . (lambda (command)
;;		     (interactive (list (read-shell-command "$ ")))
;;		     (start-process-shell-command command nil command)))
;;        ;; Bind "s-<f2>" to "slock", a simple X display locker.
;;        ([s-f2] . (lambda ()
;;		    (interactive)
;;		    (start-process "" nil "/usr/bin/slock")))))
;;
;;;; To add a key binding only available in line-mode, simply define it in
;;;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
;;(define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
;;
;;(setq doom-leader-alt-key "<s-SPC>")
;;(exwm-input-set-key (kbd doom-leader-alt-key) doom-leader-map)
;;
;;(require 'exwm-systemtray)
;;(exwm-systemtray-enable)
;;
;;;; You can hide the minibuffer and echo area when they're not used, by
;;;; uncommenting the following line.
;;;; (setq exwm-workspace-minibuffer-position 'bottom)
;;;;
;;;; Do not forget to enable EXWM. It will start by itself when things are
;;;; ready.  You can put it _anywhere_ in your configuration.
;;(exwm-enable)
;;(display-battery-mode)
;;
;;;; TODO: Make these work
;;(map! :leader
;;       (:prefix ("e". "exwm")
;;         :desc "Reset" "r" 'exwm-reset
;;         :desc "Workspace" "w" 'exwm-workspace-switch
;;         :desc "Fullscren" "f" 'exwm-layout-set-fullscreen
;;         :desc "Char mode" "a" 'exwm-input-release-keyboard
;;         :desc "Move" "m" 'exwm-workspace-move-window
;;         :desc "Modeline" "o" 'exwm-layout-toggle-mode-line
;;         :desc "Run" "r" #'(lambda (command)
;;		     (interactive (list (read-shell-command "$ ")))
;;		     (start-process-shell-command command nil command))
;;         :desc "Volume" "v" #'(start-process-shell-command "pavucontrol" nil "pavucontrol")
;;         :desc "Network" "n" #'(start-process-shell-command "nmtui" nil "nmtui")
;;))
;;
;;(defun exwm-init-hook ()
;;  ;; Turn off ido mode, which exwm enables by default.
;;  (ido-mode 0))
;;  ;; Launch apps that will run in the background
;;  ;; (efs/run-in-background "nm-applet")
;;  ;;(efs/run-in-background "plasma-pa"))
;;  ;; (efs/run-in-background "blueman-applet"))
;;(add-hook 'exwm-init-hook #'exwm-init-hook)
;;
;;;; TODO Keybind meta structure editing to be constistent
;;;; want: meta-j/k to always move the line, and meta-S-j/k to always move subtree

(global-visual-line-mode 1)

;; --------------------------- Org Config ----------------------------------------

(setq org-ellipsis " ▾"
            org-hide-emphasis-markers t)


(add-hook 'org-mode-hook (lambda ()

                          (display-line-numbers-mode 0)
                          (org-modern-mode 1)
                          ;; (org-modern-indent-mode 90)
                          (org-fragtog-mode)

                          (visual-line-mode 1)
                          (setq visual-fill-column-width 100
                                visual-fill-column-center-text t)
                          (visual-fill-column-mode 1)

                          (set-face-attribute 'org-modern-symbol nil :inherit 'fixed-pitch)

                          (variable-pitch-mode 1)

                          ;;;; TODO: Do a mapping or something.
                          (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
                          (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
                          (set-face-attribute 'org-block-end-line nil :inherit 'fixed-pitch)
                          (set-face-attribute 'org-block-begin-line nil :inherit 'fixed-pitch)
                          (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
                          ;; (set-face-attribute 'org-modern-bracket-line nil :inherit 'fixed-pitch)
                          ))

(map! :leader
      :desc "Search nodes by content"
      "n r c" (lambda () (interactive)(consult-ripgrep org-roam-directory)))

(map! :leader
      :desc "Open the org roam ui"
      "n r u o" (org-roam-ui-open))

(map! :leader
      :desc "Open org calendar"
      "o a c" (lambda () (interactive)(cfw:open-org-calendar)))


(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

(setq cfw:org-agenda-schedule-args '(:timestamp :deadline))

;; The following two parts are from:
;; https://d12frosted.io/posts/2020-06-24-task-management-with-roam-vol2.html
(setq org-agenda-prefix-format
      '((agenda . " %i %(vulpea-agenda-category 25)%?-12t% s")
        (todo . " %i %(vulpea-agenda-category 25) ")
        (tags . " %i %(vulpea-agenda-category 25) ")
        (search . " %i %(vulpea-agenda-category 25) ")))

;;Category is defined by one of the following items:

;;- CATEGORY property
;;- TITLE keyword
;;- TITLE property
;;- filename without directory and extension

;;When LEN is a number, resulting string is padded right with
;;spaces and then truncated with ... on the right if result is
;;longer than LEN.
(defun vulpea-agenda-category (&optional len)
  (let* ((file-name (when buffer-file-name
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name))))
         (title (vulpea-buffer-prop-get "title"))

         ;; TODO Doesn't seem to work
         ;;(category (org-get-category))
         ;;(result
         ;; (or (if (and
         ;;          title
         ;;          (string-equal category file-name))
         ;;         title
         ;;       category)
         ;;     ""))
         )
         title
    (if (numberp len)
        (s-truncate len (s-pad-right len " " title))
      result)

    ))

(require 'org-checklist)

(after! org

  ;;(add-to-list 'org-modules 'org-habit)

  (add-to-list 'org-modules 'org-checklist)

  (setq org-capture-templates
            `(("i" "Inbox" entry (file "tasks.org")
               , (concat "* INBOX %?\n"
                         "/Entered on/ %U"))
              ("d" "Dream Journal" entry (file+datetree (format "%s/dream-journal" org-directory))
               "* %?\nEntered on %U\n")
              ("j" "Daily Journal" entry (file+datetree (format "%s/journal.org" org-directory))
               "* %?\nEntered on %U\n")
              ("o" "Local Inbox" entry (file "tasks-local.org")
               , (concat "* INBOX %?\n"
                         "/Entered on/ %U"))
              ))

      ;; Consider adding a project here
      ;; TODO Should never really be used
      (setq org-todo-keywords '((sequence "TODO(t)" "INBOX(i)" "NEXT(n)" "PROJECT(p)" "MAYBE(m)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(x)")))
      (setq org-todo-repeat-to-state "NEXT")

      ;; Don't show archived stuff in the agenda.
      ;; (setq org-agenda-tag-filter-preset '("-archive", "-someday"))

      ;;(setq org-agenda-log-mode-items '(clock))
      ;;(setq org-agenda-start-with-log-mode t)
      (setq org-log-done 'time)
      (setq org-log-redeadline 'time)
      (setq org-log-reschedule 'time)
      (setq org-log-into-drawer t)

      (setq org-startup-with-inline-images t)

      (setq org-archive-location "archive.org")
      (setq org-archive-tag "archive")

      (setq org-deadline-warning-days 0)
      (setq org-agenda-start-day "+0d")
      (setq org-agenda-span 1)
      (setq org-agenda-start-on-weekday nil)
      (setq org-agenda-todo-ignore-scheduled 'future)
      (setq org-agenda-todo-ignore-time-comparison-use-seconds t)
      (setq org-agenda-tags-todo-honor-ignore-options t)
      (setq org-agenda-hide-tags-regexp ".*")
      (setq org-agenda-tag-filter-preset '("-habit"))

      (defun org-agenda-open-hook ()
        (olivetti-mode))

      (add-hook 'org-agenda-mode-hook 'org-agenda-open-hook)

      ;; Use 4 am as the day start
      (setq org-extend-today-until 4
            org-use-effective-time t)


      ;;(setq org-agenda-custom-commands
      ;;    '(("w" "Work-related tasks" tags-todo "@work"
      ;;       ((org-agenda-overriding-header "Work")))
      ;;      ("h" "Personal tasks" tags-todo "@home-chore"
      ;;       ((org-agenda-overriding-header "Home")))
      ;;      ("c" "Recurring chores" tags-todo "chore"
      ;;       ((org-agenda-overriding-header "Chore")))
      ;;      ))

      ;; Not really necessary, can just filter in the main view
      ;;(setq org-agenda-custom-commands
      ;;    '(("i" "Inbox" tags-todo "+TODO=\"INBOX\""
      ;;       ((org-agenda-overriding-header "Unprocessed Inbox Items")))
      ;;      ("t" "Todo" tags-todo "+TODO=\"TODO\""
      ;;       ((org-agenda-overriding-header "Actionable Todo Items")))
      ;;      ("o" "Someday" tags-todo "+TODO=\"SOMEDAY\""
      ;;       ((org-agenda-overriding-header "Someday / Maybe Items")))
      ;;      ("w" "Waiting" tags-todo "+TODO=\"WAITING\""
      ;;       ((org-agenda-overriding-header "Items Waiting for an External Dependency")))
      ;;      ("c" "Recurring chores" tags-todo "chore"
      ;;       ((org-agenda-overriding-header "Chore")))
      ;;      ))

      (setq org-agenda-custom-commands
      '(("n" "Next Actions"
         ((todo "NEXT" ((org-agenda-overriding-header "Next Actions") (org-agenda-dim-blocked-tasks 'invisible)))
          (agenda "" ((org-agenda-span 7)
                      (org-agenda-overriding-header "Upcoming Deadlines and Appointments")
                      (org-agenda-entry-types '(:deadline :timestamp))
                      )); review upcoming deadlines and appointments
          )
         (
          (org-agenda-tag-filter-preset '("-habit"))
          (org-agenda-start-day "-0d")
          )
         )

       ("h" "Next Habits"
         ((tags-todo "habit-evening+TODO=\"NEXT\"" ((org-agenda-overriding-header "Daytime Habits ☀️") (org-agenda-sorting-strategy '(priority-down effort-down scheduled-up))))
         (tags-todo "habit+evening+TODO=\"NEXT\"" ((org-agenda-overriding-header "Evening Habits 🌙") (org-agenda-sorting-strategy '(priority-down effort-down scheduled-up))))
          )
         ((org-agenda-tag-filter-preset '("+habit")))
         )


        ("r" "Review of Everything"
         (; review upcoming deadlines and appointments
                                           ; type "l" in the agenda to review logged items
          (todo "TODO" ((org-agenda-overriding-header "Step 0: Backstop: Capture any accidental TODO items.")))
          (todo "INBOX" ((org-agenda-overriding-header "Step 1: Process your inbox. (Don't forget literal mail/email inboxes too! And mobile-inbox.org!) If doable in 2 min or less, just do it. Otherwise assign to a next action, a waiting element, a someday/maybe, a note, or just delete.")))
          (todo "PROJECT" ((org-agenda-overriding-header "Step 2: Review all projects and goals (which are in roam).")))
          (todo "WAITING" ((org-agenda-overriding-header "Step 3: Review waiting items. Decide whether to continue waiting or take some action.")))
          (todo "NEXT" ((org-agenda-overriding-header "Step 4: Review actionable items and set priorities. Postpone any that we can't complete today.")))
          (agenda "" ((org-agenda-span 7) (org-agenda-overriding-header "Step 5: Take a peek at the week ahead.")))

          (todo "MAYBE" ((org-agenda-overriding-header "Step 6: Review someday / maybe items. Convert to action items or projects as necessary.")))
        )
         ((org-agenda-tag-filter-preset '("-habit")))
         )
        ))

      (setq org-tag-alist
        '((:startgroup)
           ; Put mutually exclusive tags here
           (:endgroup)
           ; Roam tags
           ("bibliographic" . ?b)
           ("revisit" . ?r)
           ("has-todos" . ?t)
           ("index" . ?i)

           ; GTD tags
           ("food" . ?f)
           ("habit" . ?h)
           ("evening" . ?e)
           ("@home" . ?o)
           ("@school" . ?s)))

        ;; Get todos from roam
        ;; https://systemcrafters.net/build-a-second-brain-in-emacs/5-org-roam-hacks/
        ;;
        (add-to-list 'org-tags-exclude-from-inheritance "has-todos")

        (defun vulpea-project-p ()
        "Return non-nil if current buffer has any todo entry.

        TODO entries marked as done are ignored, meaning the this
        function returns nil if current buffer contains only completed
        tasks."
        (org-element-map                          ; (2)
        (org-element-parse-buffer 'headline) ; (1)
        'headline
        (lambda (h)
        (eq (org-element-property :todo-type h)
                'todo))
        nil 'first-match))                     ; (3)

        (add-hook 'find-file-hook #'vulpea-project-update-tag)
        (add-hook 'before-save-hook #'vulpea-project-update-tag)

        (defun vulpea-project-update-tag ()
        "Update PROJECT tag in the current buffer."
        (when (and (not (active-minibuffer-window))
                        (vulpea-buffer-p))
                (save-excursion
                (goto-char (point-min))
                (let* ((tags (vulpea-buffer-tags-get))
                        (original-tags tags))
                (if (vulpea-project-p)
                        (setq tags (cons "has-todos" tags))
                (setq tags (remove "has-todos" tags)))

                ;; cleanup duplicates
                (setq tags (seq-uniq tags))

                ;; update tags if changed
                (when (or (seq-difference tags original-tags)
                        (seq-difference original-tags tags))
                (apply #'vulpea-buffer-tags-set tags))))))

        (defun vulpea-buffer-p ()
        "Return non-nil if the currently visited buffer is a note."
        (and buffer-file-name
        (string-prefix-p
                (expand-file-name (file-name-as-directory org-roam-directory))
                (file-name-directory buffer-file-name))))

        (defun vulpea-project-files ()
        (seq-uniq
        (seq-map
        #'car
        (org-roam-db-query
        [:select [nodes:file]
        :from tags
        :left-join nodes
        :on (= tags:node-id nodes:id)
        :where (like tag (quote "%\"has-todos\"%"))]))))

        (defun vulpea-agenda-files-update (&rest _)
        "Update the value of `org-agenda-files'."
        (setq org-agenda-files (append (vulpea-project-files)
                               '("tasks.org" "tasks-local.org" "events.org"))))

        (advice-add 'org-agenda :before #'vulpea-agenda-files-update)
        (advice-add 'org-todo-list :before #'vulpea-agenda-files-update)

        (defcustom org-inline-image-background nil
        "The color used as the default background for inline images.
        When nil, use the default face background."
        :group 'org
        :type '(choice color (const nil)))

        (defun create-image-with-background-color (args)
        "Specify background color of Org-mode inline image through modify `ARGS'."
        (let* ((file (car args))
                (type (cadr args))
                (data-p (caddr args))
                (props (cdddr args)))
        ;; Get this return result style from `create-image'.
        (append (list file type data-p)
                (list :background (or org-inline-image-background (face-background 'default)))
                props)))

        (advice-add 'create-image :filter-args
                #'create-image-with-background-color)

      (setq org-inline-image-background "white")

      (setq org-roam-list-files-command
      "fd . -e org --no-ignore -t f --exclude '.git' --exclude '.cache'")

        (setq org-roam-capture-templates
            `(("d" "default" plain "%?"
               :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
               :unnarrowed t)

              ("b" "bibliographic" plain (file "templates/bibliographic.org")
                :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: :bibliographic:\n#+date: %U\n")
                :unnarrowed t)

                ("l" "linked-bibliographic" plain (file "templates/linked-bibliographic.org")
                :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" ":PROPERTIES:\n:ROAM_REFS: ${link}\n:END:\n#+title: ${title}\n#+filetags: :bibliographic:\n#+date: %U\n")
                :unnarrowed t)

                ("o" "local" plain "%?"
                :if-new (file+head "local/%<%Y%m%d%H%M%S>-${slug}.org" ":PROPERTIES:\n:ROAM_REFS: ${link}\n:END:\n#+title: ${title}\n#+filetags: :local:\n#+date: %U\n")
                :unnarrowed t)

              ))


        )

(after! org-roam
  ;; Override file discovery commands so that gitignored things are included
  (setq org-roam-list-files-commands
        '((fd . "fd . -e org -t f --no-ignore")
          (fdfind . "fdfind . -e org -t f --no-ignore")
          (rg . "rg --files --no-ignore -g \"*.org\"")
          (find . "find . -type f -name \"*.org\""))))

;;(use-package! org-roam-ui
;;    :after org-roam ;; or :after org
;;;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;;;         a hookable mode anymore, you're advised to pick something yourself
;;;;         if you don't care about startup time, use
;;    :config
;;    (setq org-roam-ui-sync-theme t
;;          org-roam-ui-follow t
;;          org-roam-ui-update-on-save t
;;          org-roam-ui-open-on-start nil
;;))
