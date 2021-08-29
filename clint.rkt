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
  (let ((input(prompt)))  
    (if (string-contains input "bye")
        (begin
          (display "Clint: goodbye?"))
        (begin
          (respond input )
          (main-loop)))))

; respond: 
(define (respond input)
  (cond
    [(string-contains-or input greeting) (printf "Clint: ~a" (choose greeting))]
    [(string-contains-or input questions) (printf "Clint: ~a" (choose questions))]
     [(string-contains-or input '("do" "can" "could" "must" "should" "will" "would"))
      (mode (string-contains-or input
                             '("do" "can" "could" "must" "should" "will" "would")))]
    ))








