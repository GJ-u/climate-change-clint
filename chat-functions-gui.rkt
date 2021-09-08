#lang racket
(require srfi/13)
(require "clint-cli/chat-responses.rkt")
(require "clint-cli/utils.rkt")
(provide (all-defined-out))

#| CHAT FUNCTION DEFINITIONS |#

; greet the user with a climate tip
(define (greeting-response)
  (string-append "Clint: " (string-sentencecase (choose greeting)) ", "
          (string-downcase (choose tips))))

; greet the user with a question
(define (greeting-and-question)
  (string-append "Clint: "(string-sentencecase (choose greeting)) ", "
          (string-sentencecase questions))) 

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (string-append "Clint: " (choose affirmative-after-modal) " " mode))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (string-append "Clint: " (choose modal-i-response) " " mode " that?"))


