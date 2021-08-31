;;; Clint Climate Change

#lang racket
(require srfi/13)
(require "responses.rkt")
(require "functions.rkt")

;; prompt: nil -> nil
(define (prompt)
  (display "\n>> ")
  (read-line))

;; name: placeholder!!
(define (name)
  (display "What is your name? ")
  (let ((name (read-line)))
    name))

; main-loop:
(define (main-loop)
  (let ((input(string-downcase (prompt))))  
    (if (string-contains-or input farewell)
        (p (choose farewell))
        (begin
          (respond input )
          (main-loop)))))

; respond: 
(define (respond input)
  (cond
    [(string-contains-or input greeting)
     (begin
       (if (= (random 2) 0)
           (greeting-response)
           (ask-question)))]
    [(string-contains-or input question) (p (choose question))] ; placeholder
    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]
    [(string-contains-or input because-words) (p (choose because-responses))]
    ))

(define (ask-question)
  (greeting-and-question)
  (let ((answer (prompt)))
    (begin (with-output-to-file "user.txt" #:exists 'replace
  (lambda () (printf "~a" answer)))
           (printf "Clint: I see. ~a" (string-downcase (choose tips))))))

(main-loop)
