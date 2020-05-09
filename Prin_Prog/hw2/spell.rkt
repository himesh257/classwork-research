#lang racket

; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2019                              *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(require "include.rkt")

;; contains simple dictionary definition
(require "test-dictionary.rkt")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

(define hash-listword
	(lambda (hashfunctionlist word hashwordlist)
		(cond ((null? hashfunctionlist) hashwordlist)
			(else
				(hash-listword (cdr hashfunctionlist) word (cons ((car hashfunctionlist) word) hashwordlist))
			)
		)
	)
)

(define hash-listdict
	(lambda (hashfunctionlist dict hashdictlist)
		(cond ((null? dict) hashdictlist)
			(else
			(hash-listdict hashfunctionlist (cdr dict) (hash-listword hashfunctionlist (car dict) hashdictlist))
			)
		)
	)
)

(define intersection 
	(lambda (wordhashes dicthashes)
		(cond ((null? wordhashes) '())
			(
				(member (car wordhashes) dicthashes) 
				(cons (car wordhashes) (intersection (cdr wordhashes) dicthashes))
			)
			(else
				(intersection (cdr wordhashes) dicthashes)
			)
		)
	)
)

;; -----------------------------------------------------
;; KEY FUNCTION
;;(define keys
;;  (lambda (w)
;;    (cond ((null? w) 5413)
;;          (else (+ (ctv(car w)) (* (keys(cdr w)) 29))))))

(define keys3
  (lambda (w)
    (cond ((null? w) 5413)
          (else + ctv(car w) reduce(* (keys3(cdr w)) 29)))))

;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))       = 111037761665
;;   (key '(m a y))           = 132038724
;;   (key '(t r e e f r o g)) = 2707963878412931

;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

;; value of parameter "size" should be a prime number
(define gen-hash-division-method
	(lambda (size)
		(lambda (k)
			(modulo (keys k) size)
		)
    )
)

(define gen-hash-multiplication-method
	(lambda (size)
		(lambda (k)
			(floor (* size (- (* (keys k) A) (floor (* (keys k) A)))))
		)	
	)
)

;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 70111))
(define hash-2 (gen-hash-division-method 89989))
(define hash-3 (gen-hash-multiplication-method 700426))
(define hash-4 (gen-hash-multiplication-method 952))

(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
(define hashfl-2 (list hash-1 hash-3))
(define hashfl-3 (list hash-2 hash-3))

;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;; (hash-1 '(h e l l o))        ==> 26303
;; (hash-1 '(m a y))            ==> 19711
;; (hash-1 '(t r e e f r o g))  ==> 3010
;;
;; (hash-2 '(h e l l o))        ==> 64598
;; (hash-2 '(m a y))            ==> 24861
;; (hash-2 '(t r e e f r o g))  ==> 23090
;;
;; (hash-3 '(h e l l o))        ==> 313800.0
;; (hash-3 '(m a y))            ==> 317136.0
;; (hash-3 '(t r e e f r o g))  ==> 525319.0
;;
;; (hash-4 '(h e l l o))        ==> 426.0
;; (hash-4 '(m a y))            ==> 431.0
;; (hash-4 '(t r e e f r o g))  ==> 714.0
 (hash-1 '(h e l l o))        
 (hash-1 '(m a y))           
 (hash-1 '(t r e e f r o g))  
;;
 (hash-2 '(h e l l o))        
 (hash-2 '(m a y))            
 (hash-2 '(t r e e f r o g))
;;
 (hash-3 '(h e l l o))        
 (hash-3 '(m a y))            
 (hash-3 '(t r e e f r o g))  
;;
 (hash-4 '(h e l l o))        
 (hash-4 '(m a y))            
 (hash-4 '(t r e e f r o g))  

;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR

(define gen-checker
	(lambda (hashfunctionlist dict)
		(lambda (word)
			(let* ((hashwordlist '()) (hashdictlist '()))
				(let * ((wordhashes (hash-listword (reverse hashfunctionlist) word hashwordlist)) (dicthashes (hash-listdict (reverse hashfunctionlist) dict hashdictlist))) 
					(let * ((intersecthashes (intersection wordhashes dicthashes)))
						(= (length wordhashes) (length intersecthashes))					
					)
				)
			)
		)
	)
)

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

(define checker-1 (gen-checker hashfl-1 dictionary))
(define checker-2 (gen-checker hashfl-2 dictionary))
(define checker-3 (gen-checker hashfl-3 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t
;;  (checker-2 '(a r g g g g)) ==> #f
;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
  (checker-1 '(a r g g g g)) 
  (checker-2 '(h e l l o))
  (checker-2 '(a r g g g g)) 
