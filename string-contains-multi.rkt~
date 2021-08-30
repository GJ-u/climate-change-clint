#lang racket

(provide (all-defined-out))

(require srfi/13)

;; string-contains-or : str, lst -> bool
(define (string-contains-or str lst)
  (cond
    [(null? lst) #f]
    [(string-contains str (car lst)) #t]
    [else (string-contains-or str (cdr lst))]))

;; string-contains-and : str, str, lst -> bool
(define (string-contains-and str str-must lst)
  (cond
    [(and (string-contains str str-must)(string-contains-or str lst)) #t]
    [else #f]))

(define (split-string str)
  (let loop ((acc '()) (current '()) (chars (string->list str)))
    (cond ((null? chars)
           (reverse (cons (list->string (reverse current)) acc)))
          ((char=? (car chars) #\space)
           (loop (cons (list->string (reverse current)) acc)
                 '()
                 (cdr chars)))
          (else
           (loop acc
                 (cons (car chars) current)
                 (cdr chars))))))

(define (choose lst)
  (list-ref lst (random (length lst))))
 
