;;; ~/.doom.d/publish.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
      '(("references-attachments"
         :base-directory "~/.references/images/"
         :base-extension "jpg\\|jpeg\\|png\\|pdf\\|css"
         :publishing-directory "~/publish_html/references/images"
         :publishing-function org-publish-attachment)
        ("references-md"
         :base-directory "~/.references/"
         :publishing-directory "~/publish_md"
         :base-extension "org"
         :recursive t
         :html-link-home "../readme.md"
         :sitemap-filename "index"
         :sitemap-title "Nick's Site generated by Emacs"
         :headline-levels 5
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/ExaWKqy.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up "."
         :auto-preamble t
         :with-toc t)
        ("tasks"
         :base-directory "~/.gtd/"
         :publishing-directory "~/publish_tasks"
         :base-extension "org"
         :recursive t
         :auto-sitemap t
         :sitemap-filename "index"
         :html-link-home "../index.html"
         :publishing-function org-html-publish-to-html
         :section-numbers nil
;         :html-head "<link rel=\"stylesheet\"
;href=\"https://codepen.io/nmartin84/pen/MWWdwbm.css\"
;type=\"text/css\"/>"
         :with-email t
         :html-link-up ".."
         :auto-preamble t
         :with-toc t)
        ("pdf"
         :base-directory "~/.gtd/references/"
         :base-extension "org"
         :publishing-directory "~/publish"
         :preparation-function somepreparationfunction
         :completion-function  somecompletionfunction
         :publishing-function org-latex-publish-to-pdf
         :recursive t
         :latex-class "koma-article"
         :headline-levels 5
         :with-toc t)
         ("myprojectweb" :components("references-attachments" "pdf" "references-md" "tasks"))))
