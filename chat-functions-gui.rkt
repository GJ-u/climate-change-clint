#lang racket/gui
(require srfi/13)
(require "clint-cli/chat-responses.rkt")
(require "clint-cli/utils.rkt")
(provide (all-defined-out))

(define name "")
(define weather "")

(if (file-exists? "name.txt")
    (set! name (file->string "name.txt"))
    "")
(if (file-exists? "weather.txt")
    (set! weather (file->string "weather.txt"))
    "")

(define clint-neutral (read-bitmap (build-path "portraits" "clint.png")))
(define clint-happy (read-bitmap (build-path "portraits" "clint-happy.png")))
(define clint-goofy (read-bitmap (build-path "portraits" "clint-goofy.png")))
(define clint-sad (read-bitmap (build-path "portraits" "clint-sad.png")))
(define clint-sob (read-bitmap (build-path "portraits" "clint-sob.png")))

#| CHAT FUNCTION DEFINITIONS |#

; greet the user with a climate tip
(define (greeting-response)
  (string-append (string-sentencecase (choose greeting))
                 (case (random 2) [(0) (string-append " " (string-titlecase name))]
                   [(1) ""]) ", "
                 (string-downcase (choose tips))))

; greet the user with a question
(define (greeting-and-question)
  (string-append (string-sentencecase (choose greeting))
                 (string-append " "(string-titlecase name))
                 ", " (string-sentencecase questions)))

; greet user and mention weather
(define (weather-mention)
  (string-append (string-sentencecase (choose greeting)) ", last time we spoke, you said the weather was "
                 weather ". Is that still the case?"))

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (string-append "Clint: " (choose affirmative-after-modal) " " mode))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (string-append (choose modal-i-response) " " mode " that?"))

(define (name-question) "What is your name?")







