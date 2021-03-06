(setq display-line-numbers t)

(global-set-key (kbd "C-c C-x i") #'org-mru-clock-in)
(global-set-key (kbd "C-c C-x C-j") #'org-mru-clock-select-recent-task)
(bind-key "C-<down>" #'+org/insert-item-below)
(map!
 :nvime "<f5> d" #'helm-org-rifle-directories
 :nvime "<f5> b" #'helm-org-rifle-current-buffer
 :nvime "<f5> o" #'helm-org-rifle-org-directory
 :nvime "<f5> a" #'helm-org-rifle-agenda-files)

(map! :leader
      :n "e" #'ace-window
      :n "!" #'swiper
      :n "@" #'swiper-all
      :n "#" #'deadgrep
      :n "$" #'helm-org-rifle-directories
      :n "X" #'org-capture
      (:prefix "o"
        :n "e" #'elfeed
        :n "g" #'metrics-tracker-graph
        :n "o" #'org-open-at-point
        :n "u" #'elfeed-update
        :n "w" #'deft)
      (:prefix "f"
        :n "o" #'plain-org-wiki-helm)
      (:prefix "n"
        :n "D" #'dictionary-lookup-definition
        :n "T" #'powerthesaurus-lookup-word)
      (:prefix "s"
        :n "d" #'deadgrep
        :n "q" #'org-ql-search
        :n "b" #'helm-org-rifle-current-buffer
        :n "o" #'helm-org-rifle-org-directory
        :n "." #'helm-org-rifle-directories)
      (:prefix "b"
        :n "c" #'org-board-new
        :n "e" #'org-board-open)
      (:prefix "t"
        :n "s" #'org-narrow-to-subtree
        :n "w" #'widen)
      (:prefix "/"
        :n "j" #'org-journal-search))

(setq-default fill-column 80)
(global-auto-revert-mode t)

(after! org (set-popup-rule! "^Capture.*\\.org$" :side 'right :size .40 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "Dictionary" :side 'bottom :height .40 :width 20 :select t :vslot 3 :ttl 3))
(after! org (set-popup-rule! "*helm*" :side 'bottom :height .40 :select t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*eww*" :side 'right :size .40 :slect t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*deadgrep" :side 'bottom :height .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*org-roam" :side 'right :size .40 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "\\Swiper" :side 'bottom :size .30 :select t :vslot 4 :ttl 3))
(after! org (set-popup-rule! "*xwidget" :side 'right :size .40 :select t :vslot 5 :ttl 3))
(after! org (set-popup-rule! "*org agenda*" :side 'right :size .40 :select t :vslot 2 :ttl 3))
(after! org (set-popup-rule! "*Org ql" :side 'right :size .40 :select t :vslot 2 :ttl 3))

(setq user-full-name "Nicholas Martin"
      user-mail-address "nmartin84.com")

(setq doom-font (font-spec :family "InputMono" :size 20)
      doom-variable-pitch-font (font-spec :family "InputMono" :height 120)
      doom-unicode-font (font-spec :family "InputMono")
      doom-big-font (font-spec :family "InputMono" :size 20))
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(setq doom-modeline-gnus t
      doom-modeline-gnus-timer 'nil)

(setq doom-theme 'doom-gruvbox)

(after! org (setq org-agenda-use-time-grid nil
                  org-agenda-skip-scheduled-if-done t
                  org-agenda-skip-deadline-if-done t
                  org-habit-show-habits t))
(after! org (setq org-super-agenda-groups
                  '((:auto-category t))))

(load-library "find-lisp")
(after! org (setq org-agenda-files
(find-lisp-find-files "~/.org/" "\.org$")))

(after! org (setq org-capture-templates
                  '(("t" "Tasks")
                    ("p" "Projects")
                    ("r" "References"))))

(after! org (add-to-list 'org-capture-templates
             '("ta" "Append new entry to existing header" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* %^{topic}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
             '("c" "Capture [GTD]" entry (file "~/.org/gtd/inbox.org")
"* TODO %^{taskname}%?
:PROPERTIES:
:CREATED:    %U
:END:
" :immediate-finish t)))

(after! org (add-to-list 'org-capture-templates
             '("tp" "Add Parent w/child to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* TODO %^{taskname}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?

\** TODO %^{child task}" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
             '("pn" "New Project" entry (file+function my/generate-org-note-name org-back-to-heading-or-point-min)
"* TODO %^{projectname}
:PROPERTIES:
:GOAL:    %^{goal}
:END:
:RESOURCES:
:END:

+ REQUIREMENTS:
  %^{requirements}

\** TODO %^{task1}")))

(after! org (add-to-list 'org-capture-templates
             '("tc" "Add Task to Current" entry (file+function buffer-name org-back-to-heading-or-point-min)
"* TODO %^{taskname}
:PROPERTIES:
:CREATED:    %U
:END:
:LOGBOOK:
:END:

%?" :clock-in t :clock-resume t)))

(after! org (add-to-list 'org-capture-templates
                         '("tr" "Recurring Task" entry (file "~/.org/gtd/recurring.org")
                           "* TODO %^{description} %?
:SCHEDULED: %^{schedule}t
:PROPERTIES:
:CREATED:    %U
:END:
:RESOURCES:
:END:
")))

(after! org (add-to-list 'org-capture-templates
             '("rn" "Yank new Example" entry(file+headline"~/.org/notes/references.org" "INBOX")
"* %^{example}
:PROPERTIES:
:CATEGORY: %^{category}
:SUBJECT:  %^{subject}
:END:
:RESOURCES:
:END:

%?")))

(after! org (add-to-list 'org-capture-templates
             '("re" "Yank new Example" entry(file+headline"~/.org/notes/examples.org" "INBOX")
"* %^{example}
:PROPERTIES:
:SOURCE:  %^{source|Command|Script|Code|Usage}
:SUBJECT: %^{subject}
:END:

\#+BEGIN_SRC %^{lang}
%x
\#+END_SRC
%?")))

(after! org (add-to-list 'org-capture-templates
             '("w" "Workout Log" entry(file+olp+datetree"~/.org/journal/workout.org")
               "** %\\1 (%\\2 calories) :: %\\3 (reps)
:PROPERTIES:
:ACTIVITY: %^{ACTIVITY}
:CALORIES: %^{CALORIES}
:REPS:     %^{REPS}
:COMMENT:  %^{COMMENT}
")))

(after! org (add-to-list 'org-capture-templates
             '("F" "Food Log" entry(file+olp+datetree"~/.org/journal/food.org")
"** %\\1 [%\\2]
:PROPERTIES:
:FOOD:     %^{FOOD}
:CALORIES: %^{CALORIES}
:COMMENT:  %^{COMMENT}
:END:")))

(after! org (add-to-list 'org-capture-templates
             '("d" "Diary Log" entry(file+datetree"~/.org/journal/diary.org")
               "** <%<%I:%M:%S>> %^{diary entry}
%?")))

(after! org (setq org-directory "~/.org/"
                  org-image-actual-width nil
                  +org-export-directory "~/.export/"
                  org-archive-location "~/.org/gtd/archive.org::datetree/"
                  org-default-notes-file "~/.org/gtd/inbox.org"
                  projectile-project-search-path '("~/")))

(after! org (setq org-html-head-include-scripts t
                  org-export-with-toc t
                  org-export-with-author t
                  org-export-headline-levels 5
                  org-export-with-drawers t
                  org-export-with-email t
                  org-export-with-footnotes t
                  org-export-with-latex t
                  org-export-with-section-numbers nil
                  org-export-with-properties t
                  org-export-with-smart-quotes t
                  org-export-backends '(pdf ascii html latex odt pandoc)))

(after! org (setq org-todo-keyword-faces
      '(("TODO" :foreground "tomato" :weight bold)
        ("WAITING" :foreground "light sea green" :weight bold)
        ("STARTED" :foreground "DodgerBlue" :weight bold)
        ("DELEGATED" :foreground "Gold" :weight bold)
        ("NEXT" :foreground "violet red" :weight bold)
        ("DONE" :foreground "slategrey" :weight bold))))

(after! org (setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w!)" "STARTED(s!)" "NEXT(n!)" "DELEGATED(e!)" "|" "INVALID(I!)" "DONE(d!)"))))

(after! org (setq org-link-abbrev-alist
                  '(("doom-repo" . "https://github.com/hlissner/doom-emacs/%s")
                    ("wolfram" . "https://wolframalpha.com/input/?i=%s")
                    ("duckduckgo" . "https://duckduckgo.com/?q=%s")
                    ("gmap" . "https://maps.google.com/maps?q=%s")
                    ("gimages" . "https://google.com/images?q=%s")
                    ("google" . "https://google.com/search?q=")
                    ("youtube" . "https://youtube.com/watch?v=%s")
                    ("youtu" . "https://youtube.com/results?search_query=%s")
                    ("github" . "https://github.com/%s")
                    ("attachments" . "~/.org/.attachments/"))))

(after! org (setq org-log-state-notes-insert-after-drawers nil
                  org-log-into-drawer t
                  org-log-done 'time
                  org-log-repeat 'time
                  org-log-redeadline 'note
                  org-log-reschedule 'note))

(after! org (setq org-bullets-bullet-list '("◉" "○")
                  org-hide-emphasis-markers nil
                  org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))
                  org-ellipsis "▼"))
(setq org-emphasis-alist
  '(("*" (bold :foreground "Orange" ))
    ("/" italic)
    ("_" underline)
    ("=" (:foreground "maroon"))
    ("~" (:foreground "deep sky blue"))
    ("+" (:strike-through t))))

(after! org (setq org-publish-project-alist
                  '(("references-attachments"
                     :base-directory "~/.org/notes/images/"
                     :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
                     :publishing-directory "~/publish_html/references/images"
                     :publishing-function org-publish-attachment)
                    ("references-md"
                     :base-directory "~/.org/notes/"
                     :publishing-directory "~/publish_md"
                     :base-extension "org"
                     :recursive t
                     :headline-levels 5
                     :publishing-function org-html-publish-to-html
                     :section-numbers nil
                     :html-head "<link rel=\"stylesheet\" href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" type=\"text/css\"/>"
                     :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomas.github.io/solarized-css/org-info.min.js"
                     :with-email t
                     :with-toc t)
                    ("tasks"
                     :base-directory "~/.org/gtd/"
                     :publishing-directory "~/publish_tasks"
                     :base-extension "org"
                     :recursive t
                     :auto-sitemap t
                     :sitemap-filename "index"
                     :html-link-home "../index.html"
                     :publishing-function org-html-publish-to-html
                     :section-numbers nil
                     ;:html-head "<link rel=\"stylesheet\"
                     ;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
                     ;type=\"text/css\"/>"
                     :with-email t
                     :html-link-up ".."
                     :auto-preamble t
                     :with-toc t)
                    ("pdf"
                     :base-directory "~/.org/gtd/references/"
                     :base-extension "org"
                     :publishing-directory "~/publish"
                     :preparation-function somepreparationfunction
                     :completion-function  somecompletionfunction
                     :publishing-function org-latex-publish-to-pdf
                     :recursive t
                     :latex-class "koma-article"
                     :headline-levels 5
                     :with-toc t)
                    ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks")))))

(after! org (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
                  org-outline-path-complete-in-steps nil
                  org-refile-allow-creating-parent-nodes 'confirm))

(after! org (setq org-startup-indented t
                  org-src-tab-acts-natively t))
(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
(add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)

;(add-hook 'org-mode-hook 'org-num-mode)

(after! org (setq org-tags-column -80))
(after! org (setq org-tag-alist '((:startgrouptag)
                                  ("GTD")
                                  (:grouptags)
                                  ("Control")
                                  ("Persp")
                                  (:endgrouptag)
                                  (:startgrouptag)
                                  ("Control")
                                  (:grouptags)
                                  ("Context")
                                  ("Task")
                                  (:endgrouptag))))

(defun my-deft/strip-quotes (str)
  (cond ((string-match "\"\\(.+\\)\"" str) (match-string 1 str))
        ((string-match "'\\(.+\\)'" str) (match-string 1 str))
        (t str)))

(defun my-deft/parse-title-from-front-matter-data (str)
  (if (string-match "^title: \\(.+\\)" str)
      (let* ((title-text (my-deft/strip-quotes (match-string 1 str)))
             (is-draft (string-match "^draft: true" str)))
        (concat (if is-draft "[DRAFT] " "") title-text))))

(defun my-deft/deft-file-relative-directory (filename)
  (file-name-directory (file-relative-name filename deft-directory)))

(defun my-deft/title-prefix-from-file-name (filename)
  (let ((reldir (my-deft/deft-file-relative-directory filename)))
    (if reldir
        (concat (directory-file-name reldir) " > "))))

(defun my-deft/parse-title-with-directory-prepended (orig &rest args)
  (let ((str (nth 1 args))
        (filename (car args)))
    (concat
      (my-deft/title-prefix-from-file-name filename)
      (let ((nondir (file-name-nondirectory filename)))
        (if (or (string-prefix-p "README" nondir)
                (string-suffix-p ".txt" filename))
            nondir
          (if (string-prefix-p "---\n" str)
              (my-deft/parse-title-from-front-matter-data
               (car (split-string (substring str 4) "\n---\n")))
            (apply orig args)))))))

(provide 'my-deft-title)

(use-package deft
  :bind (("<f8>" . deft))
  :commands (deft deft-open-file deft-new-file-named)
  :config
  (setq deft-directory "~/.org/notes/"
        deft-auto-save-interval 0
        deft-use-filename-as-title nil
        deft-current-sort-method 'title
        deft-recursive t
        deft-extensions '("md" "txt" "org")
        deft-markdown-mode-title-level 1
        deft-file-naming-rules '((noslash . "-")
                                 (nospace . "-")
                                 (case-fn . downcase))))
(require 'my-deft-title)
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)

(use-package elfeed
  :config
  (setq elfeed-db-directory "~/.elfeed/"))

(use-package elfeed-org
  :config
  (setq rhm-elfeed-org-files (list "~/.elfeed/elfeed.org")))

(require 'elfeed)
(require 'elfeed-org)
(elfeed-org)
(after! org (setq rmh-elfeed-org-files (list "~/.elfeed/elfeed.org")
                  elfeed-db-directory "~/.elfeed/"))

;(use-package gnuplot
;  :config
;  (setq gnuplot-program "gnuplot"))

(defun my-agenda-prefix ()
  (format "%s" (my-agenda-indent-string (org-current-level))))

(defun my-agenda-indent-string (level)
  (if (= level 1)
      ""
    (let ((str ""))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "──")))
      (concat str "►"))))

;(after! org (setq org-agenda-property-list '("WHO" "NEXTACT")
;                  org-agenda-property-position 'where-it-fits))

(require 'org)

(org-add-link-type "outlook" 'org-outlook-open)

(defun org-outlook-open (id)
   "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
   (w32-shell-execute "open" (concat "outlook:" id)))

(provide 'org-outlook)
(require 'org-outlook)

(defun org-clock-switch ()
  "Switch task and go-to that task"
  (interactive)
  (setq current-prefix-arg '(12)) ; C-u
  (call-interactively 'org-clock-goto)
  (org-clock-in)
  (org-clock-goto))
(provide 'org-clock-switch)

(setq org-mru-clock-how-many 10)
(setq org-mru-clock-completing-read #'ivy-completing-read)
(setq org-mru-clock-keep-formatting t)
(setq org-mru-clock-files #'org-agenda-files)

;(use-package org-mind-map
;  :init
;  (require 'ox-org)
;  ;; Uncomment the below if 'ensure-system-packages` is installed
;  ;;:ensure-system-package (gvgen . graphviz)
;  :config
;  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
;  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
;  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
;  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
;  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
;  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
;  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
;  )



(use-package ob-plantuml
  :ensure nil
  :commands
  (org-babel-execute:plantuml)
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.tools/plantuml.jar")))

(defun org-update-cookies-after-save()
  (interactive)
  (let ((current-prefix-arg '(4)))
    (org-update-statistics-cookies "ALL")))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
(provide 'org-update-cookies-after-save)

(defun my--browse-url (url &optional _new-window)
  ;; new-window ignored
  "Opens link via powershell.exe"
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((quotedUrl (format "start '%s'" url)))
    (apply 'call-process "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" nil
           0 nil
           (list "-Command" quotedUrl))))

(setq-default browse-url-browser-function 'my--browse-url)

(defun zyrohex/org-notes-refile ()
  "Process an item to the references bucket"
  (interactive)
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6)))
        (org-refile-allow-creating-parent-nodes 'confirm))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-notes-refile)

(defun zyrohex/org-reference-refile (arg)
  "Process an item to the reference bucket"
  (interactive "P")
  (let ((org-refile-targets '(("~/.gtd/references.org" :maxlevel . 6))))
    (call-interactively #'org-refile)))
(provide 'zyrohex/org-reference-refile)

(defun zyrohex/org-tasks-refile ()
  "Process a single TODO task item."
  (interactive)
  (call-interactively 'org-agenda-schedule)
  (org-agenda-set-tags)
  (org-agenda-priority)
  (let ((org-refile-targets '((helm-read-file-name :maxlevel .6)))
        (call-interactively #'org-refile))))
(provide 'zyrohex/org-tasks-refile)

(defun my/last-captured-org-note ()
  "Move to the last line of the last org capture note."
  (interactive)
  (goto-char (point-max)))

(defun my/generate-org-note-name ()
  (setq my-org-note--name (read-string "Name: "))
  (expand-file-name (format "%s.org"my-org-note--name) "~/.org/gtd/projects/"))

(org-super-agenda-mode t)
(after! org-agenda (setq org-agenda-custom-commands
                         '(("k" "Tasks"
                            ((agenda ""
                                     ((org-agenda-files '("~/.org/gtd/tasks.org" "~/.org/gtd/tickler.org" "~/.org/gtd/projects.org"))
                                      (org-agenda-overriding-header "What's on my calendar")
                                      (org-agenda-span 'day)
                                      (org-agenda-start-day (org-today))
                                      (org-agenda-current-span 'day)
                                      (org-time-budgets-for-agenda)
                                      (org-super-agenda-groups
                                       '((:name "Today's Schedule"
                                                :scheduled t
                                                :time-grid t
                                                :deadline t
                                                :order 13)))))
                             (todo ""
                                   ((org-agenda-overriding-header "[[~/.org/gtd/tasks.org][Task list]]")
                                    (org-agenda-prefix-format " %(my-agenda-prefix) ")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:name "CRITICAL"
                                              :priority "A"
                                              :order 1)
                                       (:name "NEXT UP"
                                              :todo "NEXT"
                                              :order 2)
                                       (:name "Emacs Reading"
                                              :and (:category "Emacs" :tag "@read")
                                              :order 3)
                                       (:name "Emacs Config"
                                              :and (:category "Emacs" :tag "@configure")
                                              :order 4)
                                       (:name "Emacs Misc"
                                              :category "Emacs"
                                              :order 5)
                                       (:name "Task Reading"
                                              :and (:category "Tasks" :tag "@read")
                                              :order 6)
                                       (:name "Task Other"
                                              :category "Tasks"
                                              :order 7)
                                       (:name "Projects"
                                              :category "Projects"
                                              :order 8)))))
                             (todo "DELEGATED"
                                   ((org-agenda-overriding-header "Delegated Tasks by WHO")
                                    (org-agenda-files '("~/.org/gtd/tasks.org"))
                                    (org-super-agenda-groups
                                     '((:auto-property "WHO")))))
                             (todo ""
                                   ((org-agenda-overriding-header "References")
                                    (org-agenda-files '("~/.org/gtd/references.org"))
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("i" "Inbox"
                            ((todo ""
                                   ((org-agenda-files '("~/.org/gtd/inbox.org"))
                                    (org-agenda-overriding-header "Items in my inbox")
                                    (org-super-agenda-groups
                                     '((:auto-ts t)))))))
                           ("x" "Get to someday"
                            ((todo ""
                                   ((org-agenda-overriding-header "Projects marked Someday")
                                    (org-agenda-files '("~/.org/gtd/someday.org"))
                                    (org-super-agenda-groups
                                     '((:auto-ts t))))))))))
