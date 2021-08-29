;;; Climate Change Clint

#lang racket
(require srfi/13)
(require "responses.rkt")
(require "string-contains-multi.rkt")

;; prompt: nil -> nil
(define (prompt)
  (display "\n>> ")
  (read-line))

;; name: nil -> symbol
(define (name)
  (display "What is your name? ")
  (let ((name (read-line)))
    name))

; main-loop: 
(define (main-loop)
  (let ((input(string-downcase (prompt))))  
    (if (string-contains input "bye") ; placeholder
          (display "Clint: goodbye?") ; placeholder
        (begin
          (respond input )
          (main-loop)))))

; respond: 
(define (respond input)
  (cond
    [(string-contains-or input greeting) (printf "Clint: ~a" (string-titlecase (choose greeting)))]
    [(string-contains-or input question) (printf "Clint: ~a" (choose question))] ; placeholder

    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")
          (string-contains-or input modal-verbs-i))
    (modal-i (string-contains-or input modal-verbs-i))]
    ))

(main-loop)