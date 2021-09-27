#lang racket
(require srfi/13)
(require "responses.rkt" "chat-functions.rkt" "utils.rkt")
(provide (all-defined-out))

; main-loop: nil -> func
(define (main-loop)
  (let ((input(string-downcase (prompt))))  
    (if (string-contains-or input (caar clint-pairs))
        (p (choose (cdar clint-pairs)))
        (begin
          (respondc input)
          (main-loop)))))

; respond: str -> func
; cond block is ordered by priority
(define (respondc input)
  (cond
    [(string-ci=? input "name") (ask-name)]
    [(string-contains-or input greeting)
     (begin
       (case (random 3)
         [(0) (greeting-response)]
         [(1) (greeting-and-question)]
         [(2) (if (file-exists? "weather.txt") (mention-weather)
                  (greeting-response))]))]
    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]

    [else (p (q input clint-pairs))]
    ))

(define (start-clint)
  (p "You are now speaking to Climate Change Clint, to set your name, type 'name'")
  (main-loop))
