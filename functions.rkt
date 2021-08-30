#lang racket

(provide (all-defined-out))

(require srfi/13)

;; string-contains-or : str, lst -> str or bool
(define (string-contains-or str lst)
  (cond
    [(null? lst) #f]
    [(string-contains str (car lst)) (car lst)]
    [else (string-contains-or str (cdr lst))]))

;; string-contains-and : str, str, lst -> bool
(define (string-contains-and str str-must lst)
  (cond
    [(and (string-contains str str-must)(string-contains-or str lst)) #t]
    [else #f]))

;; choose : lst -> int
(define (choose lst)
  (list-ref lst (random (length lst))))
 
