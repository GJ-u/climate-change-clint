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

; convert string to sentencecase
; see https://docs.racket-lang.org/reference/regexp.html
(define/contract (string-sentencecase str)
  (-> string? string?) ; make sure that str is a string
  (match (regexp-match #px"^([^a-z]*)(.)(.+)" str) ; find the first lowercase alphabetical character
    [(list _ prefix first-letter rest-of-string) 
     (~a prefix (string-upcase first-letter) rest-of-string)])) ; capitalise the first lowercase letter, leaving the rest untouched

;; choose : lst -> int
(define (choose lst)
  (if (list? lst)
      (list-ref lst (random (length lst)))
      (vector-ref lst (random (vector-length lst)))))
 
