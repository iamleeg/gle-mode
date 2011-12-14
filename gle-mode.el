;;; gle-mode.el --- major mode for editing .gle files 
 ;; Author: Graham Lee 
 ;; Keywords: gle extensions 
 ;; Version: 0.1.0 
 ;; Installation: 
 ;; Put this file somewhere in your load-path (e.g. 
/usr/share/emacs/site-lisp) 
 ;; Add the following to your ~/.emacs file: 
 ;; (require 
 ;;     'gle-mode) 
 ;; (setq auto-mode-alist 
 ;;     (append 
 ;;         '(("\\.gle$" . gle-mode)) 
 ;;             auto-mode-alist)) 
 ;; gle-mode will now be called whenever a .gle file is opened, or by 
executing 
 ;; M-x gle-mode 
 ;; Copyright: 
 ;; This file is free software; you can redistribute it and/or modify 
 ;; it under the terms of the GNU General Public License as published by 
 ;; the Free Software Foundation; either version 2, or (at your option) 
 ;; any later version. 
 ;; This file is distributed in the hope that it will be useful, 
 ;; but WITHOUT ANY WARRANTY; without even the implied warranty of 
 ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 ;; GNU General Public License for more details. 
 ;; You should have received a copy of the GNU General Public License 
 ;; along with GNU Emacs; see the file COPYING.  If not, write to 
 ;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
 ;; Boston, MA 02111-1307, USA. 
 ;; To do: 
 ;; Clean the regexps (get the thing <200 lines would be a start!) 
 ;; Add functions such as gle-create-postscript, gle-create-eps etc. 
 ;; Begin gle-mode 
(defvar gle-mode-syntax-table 
   (let ((st (make-syntax-table))) 
     (modify-syntax-entry ?! "<" st) 
     (modify-syntax-entry ?\n ">" st) 
     st) 
   "Syntax table for `gle-mode'.") 
(defvar gle-font-lock-keywords 
   '( 
     ;basic functions 
     ("\\bbegin\\b" (0 font-lock-keyword-face)) 
     ("\\bstart\\b" (0 font-lock-keyword-face)) 
     ("\\bboth\\b" (0 font-lock-keyword-face)) 
     ("\\bend\\b" (0 font-lock-keyword-face)) 
     ("\\bdefine\\b" (0 font-lock-keyword-face)) 
     ("\\bfor\\b" (0 font-lock-keyword-face)) 
     ("\\bto\\b" (0 font-lock-keyword-face)) 
     ("\\bnext\\b" (0 font-lock-keyword-face)) 
     ("\\bif\\b" (0 font-lock-keyword-face)) 
     ("\\bthen\\b" (0 font-lock-keyword-face)) 
     ("\\belse\\b" (0 font-lock-keyword-face)) 
     ("\\binclude\\b" (0 font-lock-keyword-face)) 
     ("\\bpostscript\\b" (0 font-lock-keyword-face)) 
     ("\\bbigfile\\b" (0 font-lock-keyword-face)) 
     ("\\bdata\\b" (0 font-lock-keyword-face)) 
     ("\\bfullsize\\b" (0 font-lock-keyword-face)) 
     ("\\blet\\b" (0 font-lock-keyword-face)) 
     ("\\bset\\b" (0 font-lock-keyword-face)) 
     ;subroutines 
     ("\\bsub\\b" (0 font-lock-function-name-face)) 
     ("\\s *@\\w+" (0 font-lock-function-name-face)) 
     ;commands 
     ("\\b[ar]?line\\b" (0 font-lock-constant-face)) 
     ("\\b[ar]move\\b" (0 font-lock-constant-face)) 
     ("\\barc\\b" (0 font-lock-constant-face)) 
     ("\\barcto\\b" (0 font-lock-constant-face)) 
     ("\\bbezier\\b" (0 font-lock-constant-face)) 
     ("\\bcircle\\b" (0 font-lock-constant-face)) 
     ("\\bclosepath\\b" (0 font-lock-constant-face)) 
     ("\\bcurve\\b" (0 font-lock-constant-face)) 
     ("\\bgrestore\\b" (0 font-lock-constant-face)) 
     ("\\bgsave\\b" (0 font-lock-constant-face)) 
     ("\\bjoin\\b" (0 font-lock-constant-face)) 
     ("\\brbezier\\b" (0 font-lock-constant-face)) 
     ("\\breverse\\b" (0 font-lock-constant-face)) 
     ("\\bsave\\b" (0 font-lock-constant-face)) 
     ("\\btext\\b" (0 font-lock-constant-face)) 
     ("\\bwrite\\b" (0 font-lock-constant-face)) 
     ("\\bbar\\b" (0 font-lock-constant-face)) 
     ("\\bsize\\b" (0 font-lock-constant-face)) 
     ("\\btitle\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?axis\\b" (0 font-lock-constant-face)) 
     ("\\b[hv]scale\\b" (0 font-lock-constant-face)) 
     ("b[xy]2?labels\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?names\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?places\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?side\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?subticks\\b" (0 font-lock-constant-face)) 
     ("\\b[xy]2?title\\b" (0 font-lock-constant-face)) 
     ;subcommands 
     ("\\bwidth\\b" (0 font-lock-variable-name-face)) 
     ("\\bh?err\\b" (0 font-lock-variable-name-face)) 
     ("\\bh?errwidth\\b" (0 font-lock-variable-name-face)) 
     ("\\bh?errup\\b" (0 font-lock-variable-name-face)) 
     ("\\bh?errdown\\b" (0 font-lock-variable-name-face)) 
     ("\\bhei\\b" (0 font-lock-variable-name-face)) 
     ("\\bcolor\\b" (0 font-lock-variable-name-face)) 
     ("\\bdashlen\\b" (0 font-lock-variable-name-face)) 
     ("\\bfont\\b" (0 font-lock-variable-name-face)) 
     ("\\bfontlwidth\\b" (0 font-lock-variable-name-face)) 
     ("\\bjust\\b" (0 font-lock-variable-name-face)) 
     ("\\badd\\b" (0 font-lock-variable-name-face)) 
     ("\\bnobox\\b" (0 font-lock-variable-name-face)) 
     ("\\bname\\b" (0 font-lock-variable-name-face)) 
     ("\\barrow\\b" (0 font-lock-variable-name-face)) 
     ("\\bstroke\\b" (0 font-lock-variable-name-face)) 
     ("\\bfill\\b" (0 font-lock-variable-name-face)) 
     ("\\bjustify\\b" (0 font-lock-variable-name-face)) 
     ("\\bcap\\b" (0 font-lock-variable-name-face)) 
     ("\\blstyle\\b" (0 font-lock-variable-name-face)) 
     ("\\blwidth\\b" (0 font-lock-variable-name-face)) 
     ("\\bfrom\\b" (0 font-lock-variable-name-face)) 
     ("\\bdist\\b" (0 font-lock-variable-name-face)) 
     ("\\bkey\\b" (0 font-lock-variable-name-face)) 
     ("\\b[xy]min\\b" (0 font-lock-variable-name-face)) 
     ("\\b[xy]max\\b" (0 font-lock-variable-name-face)) 
     ("\\bnomiss\\b" (0 font-lock-variable-name-face)) 
     ("\\bsmoothm?\\b" (0 font-lock-variable-name-face)) 
     ("\\bdsubticks\\b" (0 font-lock-variable-name-face)) 
     ("\\bdpoints\\b" (0 font-lock-variable-name-face)) 
     ("\\b[nd]ticks\\b" (0 font-lock-variable-name-face)) 
     ("\\bfont\\b" (0 font-lock-variable-name-face)) 
     ("\\bshift\\b" (0 font-lock-variable-name-face)) 
     ("\\boffset\\b" (0 font-lock-variable-name-face)) 
     ("\\bposition\\b" (0 font-lock-variable-name-face)) 
     ("\\bmarker\\b" (0 font-lock-variable-name-face)) 
     ("\\bmsize\\b" (0 font-lock-variable-name-face)) 
     ("\\bmscale\\b" (0 font-lock-variable-name-face)) 
     ;objects (things that have a begin and end) 
     ("\\bbox\\b" (0 font-lock-string-face)) 
     ("\\bclip\\b" (0 font-lock-string-face)) 
     ("\\borigin\\b" (0 font-lock-string-face)) 
     ("\\bpath\\b" (0 font-lock-string-face)) 
     ("\\bmarker\\b" (0 font-lock-string-face)) 
     ("\\brotate\\b" (0 font-lock-string-face)) 
     ("\\bscale\\b" (0 font-lock-string-face)) 
     ("\\btable\\b" (0 font-lock-string-face)) 
     ("\\btext\\b" (0 font-lock-string-face)) 
     ("\\btranslate\\b" (0 font-lock-string-face)) 
     ;switches 
     ("\\bbutt\\b" (0 font-lock-builtin-face)) 
     ("\\bround\\b" (0 font-lock-builtin-face)) 
     ("\\bsquare\\b" (0 font-lock-builtin-face)) 
     ("\\bmitre\\b" (0 font-lock-builtin-face)) 
     ("\\bbevel\\b" (0 font-lock-builtin-face)) 
     ("\\bleft\\b" (0 font-lock-builtin-face)) 
     ("\\bcenter\\b" (0 font-lock-builtin-face)) 
     ("\\bright\\b" (0 font-lock-builtin-face)) 
     ("\\b[tcblr]{2,2}\\b" (0 font-lock-builtin-face)) 
     ("\\b\\([xy]g\\)(" (1 font-lock-builtin-face)) 
     ("\\b\\([xy]end\\)(" (1 font-lock-builtin-face)) 
     ("\\b\\([xy]pos\\)(" (1 font-lock-builtin-face)) 
     ("\\bon\\b" (0 font-lock-builtin-face)) 
     ("\\boff\\b" (0 font-lock-builtin-face)) 
     ("\\bgrid\\b" (0 font-lock-builtin-face)) 
     ("\\blog\\b" (0 font-lock-builtin-face)) 
     ("\\bnofirst\\b" (0 font-lock-builtin-face)) 
     ("\\bnolast\\b" (0 font-lock-builtin-face)) 
     ;string functions 
     ("\\btime\\$\\b" (0 font-lock-string-face)) 
     ("\\bdate\\$\\b" (0 font-lock-string-face)) 
     ("\\b\\(left\\$\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(right\\$\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(seg\\$\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(num1?\\$\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(val\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(pos\\)\\s *(" (1 font-lock-string-face)) 
     ("\\b\\(len\\)\\s *(" (1 font-lock-string-face)) 
     ;mathematical functions 
     ("\\b\\(abs\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?cosh\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(cos\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?coth?\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?csch?\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?sech?\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?sinh\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(sin\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(atn\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(a?tanh\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(tan\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(exp\\)\\s *(" (1 fon-lock-function-name-face)) 
     ("\\b\\(fix\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(int\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(log\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(log10\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(sgn\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(sqrt?\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(todeg\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(torad\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(not\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(rnd\\)\\s *(" (1 font-lock-function-name-face)) 
     ;graphical functions 
     ("\\b\\([xy]end\\)\\s *(\\s *)" (1 font-lock-function-name-face)) 
     ("\\b\\([xy]pos\\)\\s *(\\s *)" (1 font-lock-function-name-face)) 
     ("\\b\\([xy]g\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(twidth\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(theight\\)\\s *(" (1 font-lock-function-name-face)) 
     ("\\b\\(tdepth\\)\\s *(" (1 font-lock-function-name-face)) 
    ) 
   "Keyword highlighting specification for `gle-mode'.") 
(define-derived-mode gle-mode fundamental-mode "GLE" 
   "A major mode for editing .gle files." 
   (set (make-local-variable 'comment-start) "! ") 
   (set (make-local-variable 'comment-start-skip) "!+\\s-*") 
   (set (make-local-variable 'font-lock-defaults) 
        '(gle-font-lock-keywords)) 
   ) 
(provide 'gle-mode) 
 ;; End gle-mode 