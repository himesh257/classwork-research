#lang racket
(define (abs x)
  (if (< x 0) (-x) (x)))

(define (sorts x)
  (sort x))