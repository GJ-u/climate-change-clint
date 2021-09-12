#lang racket/gui
(require srfi/13)
(require "clint-cli/chat-responses.rkt")
(require "clint-cli/utils.rkt")
(provide (all-defined-out))

(define name "")

(if (file-exists? "name.txt")
    (set! name (file->string "name.txt"))
    '())

(define clint-neutral (read-bitmap "portraits/clint.png"))
(define clint-happy (read-bitmap "portraits/clint-happy.png"))
(define clint-goofy (read-bitmap "portraits/clint-goofy.png"))


#| CHAT FUNCTION DEFINITIONS |#

; greet the user with a climate tip
(define (greeting-response)
  (string-append "Clint: " (string-sentencecase (choose greeting))
                 (case (random 2) [(0) (string-append " " (string-titlecase name))]
                   [(1) ""]) ", "
                 (string-downcase (choose tips))))

; greet the user with a question
(define (greeting-and-question)
  (string-append "Clint: "(string-sentencecase (choose greeting))
                 (string-append " "(string-titlecase name))
                 ", " (string-sentencecase questions))) 

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (string-append "Clint: " (choose affirmative-after-modal) " " mode))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (string-append "Clint: " (choose modal-i-response) " " mode " that?"))

(define (name-question) (string-append "Clint: " "What is your name?"))

(define (wh-response input)
  (cond
    [(string-contains input "what") (string-append "Clint: " (choose what-answers))]
    [(string-contains input "who") (string-append "Clint: " (choose who-answers))]
    [(string-contains input "where") (string-append "Clint: " (choose where-answers))]
    [(string-contains input "when") (string-append "Clint: " (choose when-answers))]
    [(string-contains input "why") (string-append "Clint: " (choose why-answers))]
    [(string-contains input "how") (string-append "Clint: " (choose how-answers))]
    [(string-contains input "clint") "Clint: That's my name!"]))
