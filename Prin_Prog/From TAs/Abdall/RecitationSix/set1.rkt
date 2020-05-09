;; PROGRAMMING  SET 1

;; length

(define length
  (lambda (l) 






(define test1 (length '(1 2 3 4 5))) ;; Answer > 5 

;; fact

(define fact
  (lambda (x)






(define test2 (fact 0)) ;; Answer > 1
(define test3 (fact 1)) ;; Answer > 1
(define test4 (fact 5)) ;; Answer > 120

;; count

(define count
  (lambda (l)






(define test5 (count '(a b c d e)))         ;; Answer > 5
(define test6 (count '(2 abs '() x 333 b))) ;; Answer > 6


;; delete

(define delete
  (lambda (x l)






(define test7 (delete 'x '(a b c y x z))) ;; Answer > '(a b c y z)
(define test8 (delete 1 '(a b c y x z)))  ;; Answer > '(a b c y x z)

;; rev         -- you may use "append" here

(define rev
  (lambda (l)







(define test9  (rev '(a b c y x z)))    ;; Answer > '(z x y c b a)
(define test10 (rev '(a 2 (c) y x z)))  ;; Answer > '(z x y (c) 2 a)

