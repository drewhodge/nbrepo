;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system.
(require 'ox-publish)

;; Define the publishing project.
(setq org-publish-project-alist
      `(("pages"
         :base-directory "./org/"
         :base-extension "org"
         :recursive t
         :with-author nil           ;; Don't include author name
         :with-creator t            ;; Include Emacs and Org versions in footer
         :with-toc nil              ;; Include a table of contents
         :section-numbers nil       ;; Don't include section numbers
         :time-stamp-file nil       ;; Don't include time stamp in file
         ; HTML5
         :html-doctype "html5"
         :html-html5-fancy t
         :html-preamble "<nav>
                           <a href=\"./index.html\">Home</a> | <a href=\"./toc.html\">TOC</a> | <a href=\"./prayer-cards.html\">Prayer Cards</a> | <a href=\"./statement.html\">Statement</a>
                        </nav>
                        <!--<div id=\"updated\">Updated: %C</div>-->"
         :html-postamble "<hr/>
                <footer>
                  <div class=\"copyright-container\">
                    <div class=\"copyright\">
                       <span style=\"font-size: smaller; color: #9f9f9f;\">Copyright &copy; 2023 Deacon Norm Levesque</span><br/>
                    </div>
                   </div>

                  <div class=\"generated\">
                     <span style=\"font-size: smaller; color: #9f9f9f;\">Created with %c</span>
                  </div>
</footer>"
         :publishing-directory "./public/"
         :publishing-function org-html-publish-to-html)

        ("assets"
         :base-directory "./org/"
         :base-extension "css\\|txt\\|jpg\\|gif\\|png"
         :recursive t
         :publishing-directory  "./public/"
         :publishing-function org-publish-attachment)

        ("deacon.org" :components ("pages" "assets"))))

;; Set variables.
(setq org-html-validation-link nil
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-export-html-postamble-format
      '(("en" "<p class=\"postamble\">Last Updated %d. Created by %c</p>"))
      ;org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")
      org-html-head "<link rel=\"stylesheet\" href=\"./dn-assets/css/simple.css\" />"
      org-html-head-extra "<link rel=\"stylesheet\" href=\"./dn-assets/css/deacon.css\" />")

;; Generate the site output.
(org-publish "deacon.org" t)

(message "Publish complete!")
