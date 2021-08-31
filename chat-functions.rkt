#lang racket
(require srfi/13)
(require "chat-responses.rkt")
(require "utils.rkt")
(provide (all-defined-out))

#| CHAT FUNCTION DEFINITIONS |#

(define (greeting-response)
  (printf "Clint: ~a, ~a" (string-titlecase (choose greeting))
          (string-downcase (choose tips))))

(define (greeting-and-question)
  (printf "Clint: ~a, ~a" (string-titlecase (choose greeting))
          (string-downcase questions)))

(define (modal-affirmative [mode (choose modal-verbs)])
  (printf "Clint: ~a ~a!" (choose affirmative-after-modal) mode))

(define (modal-i [mode (choose modal-verbs-i)])
  (printf "Clint: ~a ~a that?" (choose modal-i-response) mode))

(define (p str)
  (printf "Clint: ~a" str))

(define (ask-question)
  (greeting-and-question)
  (let ((answer (prompt)))
    (begin (with-output-to-file "user.txt" #:exists 'replace
  (lambda () (printf "~a" answer)))
           (printf "Clint: I see. ~a" (string-downcase (choose tips))))))




;; prompt: nil -> nil
(define (prompt)
  (display "\n>> ")
  (read-line))

