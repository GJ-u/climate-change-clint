;;; Climate Change Clint

#lang racket
(require srfi/13)
(require "chat-responses.rkt")
(require "utils.rkt")
(require "chat-functions.rkt")

; main-loop: nil -> func
(define (main-loop)
  (let ((input(string-downcase (prompt))))  
    (if (string-contains-or input farewell)
        (p (string-sentencecase (choose farewell)))
        (begin
          (respond input )
          (main-loop)))))

; respond: str -> func
; cond block is ordered by priority
(define (respond input)
  (cond
    [(string-ci=? input "name") (ask-name)]
    [(string-contains-or input greeting)
     (begin
       (if (= (random 2) 0)
           (greeting-response)
           (ask-question)))]
    [(string-contains-or input because-words) (p (choose because-responses))]
    [(string-contains-or input user-questions) (p (choose user-question-responses))]
    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]
    ;; Dealing with normal questions
    [(string-contains input "what") (p (choose what-answers))]
    [(string-contains input "who") (p (choose who-answers))]
    [(string-contains input "where") (p (choose where-answers))]
    [(string-contains input "when") (p (choose when-answers))]
    [(string-contains input "why") (p (choose why-answers))]
    [(string-contains input "how") (p (choose how-answers))]
    [else (p (choose generic-responses))]
    ))


(p "Hello, to set your name, type \'name\'. ")
(main-loop)
