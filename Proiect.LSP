;; Converts all texts in the drawing to uppercase.
(defun C:PROIECT (/ OR_OPEN OR_CLOSE filter ss tent telem tcontent telemupper n)
  
  ; retrieve the selection set containing both
  ; single and multiline text objects
  (setq OR_OPEN '(-4 . "<OR")		; this could be useful in larger
	OR_CLOSE '(-4 . "OR>")		; applications
    	filter (list OR_OPEN '(0 . "TEXT") '(0 . "MTEXT") OR_CLOSE)
  	ss (ssget "X" filter)
	)
  (setq cc (ssget "X" '((0 . "CIRCLE")) ))
  (setq all (list OR_OPEN '(0 . "TEXT") '(0 . "MTEXT") '(0 . "CIRCLE") '(0 . "LINE") OR_CLOSE)
	l(ssget "X" all))

  ; iterate over the selection set
  (setq n 0)
  (repeat (sslength ss)
    (setq
      	  ; retrieve the text entity from the ss
    	  tent 		(entget (ssname ss n))
	  ; retrieve the text group
	  telem 	(assoc 1 tent)
	  ; the actual text content is the cdr
	  tcontent 	(cdr telem)
	  ; make the content uppercase
	  tcontent	(strcase tcontent)
	  ; construct the new (dotted pair) element
	  telemupper	(cons 1 tcontent)
	  ; change the entity
	  tent		(subst telemupper telem tent)
	  )
    (entmod tent)	; update the entity definition
    (setq n (1+ n))	; next
    )
  (setq m 0)
  (repeat (sslength cc)
    (setq
      cent(entget(ssname cc m))
      cent2(entget(ssname cc (1+ m)))
      celem (assoc 10 cent)
      celem2(assoc 10 cent2)
      fp(cdr celem)
      sp(cdr celem2)
      )
	(command "line" fp sp "")
      (setq m (1+ m))
    )
  (setq k 0)
  (repeat (sslength l)
    (setq
      kent(entget(ssname l k))
      kelem(assoc 40 kent)
      kcontent(cdr kelem)
      kcontent(+ 2)
      kelemv(cons 40 kcontent)
      kent(subst kelemv kelem kent)
      )
      (entmod kent)
       (setq k (1+ k))
      )
(princ)
)

