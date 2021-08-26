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
(define (main-loop name)
  (let ((input(prompt)))  
    (if (string-contains input "bye")
        (begin
          (display "Clint: goodbye?"))
        (begin
          (respond input name)
          (main-loop name)))))

; respond: 
(define (respond input name)
  (cond
    [(string-contains-or input greeting) (printf "Clint: ~a" (choose greeting))]
    [(string-contains-or input questions) (printf "Clint: ~a" (choose questions))]
     [(string-contains-or input '("do" "can" "could" "must" "should" "will" "would")) (printf "~a" (modal-response (string-contains-or input '("do" "can" "could" "must" "should" "will" "would")) "name"))]   
    ))



(define (modal-response verb person)
  ;random gen either 1 or 2
  (define num (random 2))
  (if (= 1 num)
      (list 'Yes 'I verb person)
      ;; example: (map string->symbol '("would"))
      (list 'No 'I verb 'not person)))

