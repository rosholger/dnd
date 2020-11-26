#!/bin/bash

FILES="$(git status --porcelain | grep -v '^ D' | grep '.org$' | awk '{print $2}')"
read -r -d '' SCRIPT << EOM
(progn
 (setq org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"dnd.css\"/>")
 (setq org-html-postamble nil)
 (setq org-export-with-section-numbers nil)
 (org-html-export-to-html))
EOM

for file in $FILES; do echo "$file"; emacs "$file" --batch --eval "$SCRIPT"; done