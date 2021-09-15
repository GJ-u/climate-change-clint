#lang racket
(require "responses.rkt")
(require srfi/13)
(provide (all-defined-out))
;; string-contains-or : str, lst -> str or bool
(define (string-contains-orq str lst)
  (cond
    [(null? lst) #f]
    [(string-contains str (car lst)) (car lst)]
    [else (string-contains-orq str (cdr lst))]))

(define (chooseq lst)
  (list-ref lst (random (length lst))))

(define (q input clint-pairs)
  (cond
    [(null? clint-pairs) (chooseq generic-responsesq)]
    [(string-contains-orq input (caar clint-pairs)) (chooseq (cdar clint-pairs))]
    [else (q input (cdr clint-pairs))]))

;(define (respondq input)
;  (cond
;    [(string-ci=? input "name") (ask-name)]
;    [(string-contains-or input greeting)
;     (begin
;       (if (file-exists? "weather.txt")(weather-mention)
;           (choose (list (greeting-response) (ask-question)))))]
;      [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
;    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
;     (modal-i (string-contains-or input modal-verbs-i))]
;    [else (q input clint-pairs)]))
    
    