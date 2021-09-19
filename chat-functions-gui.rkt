#lang racket/gui
(require srfi/13)
(require "clint-cli/utils.rkt")
(require "clint-cli/responses.rkt")
(provide (all-defined-out))

(define name "")
(define weather "")

(if (file-exists? "name.txt")
    (set! name (file->string "name.txt"))
   null)
(if (file-exists? "weather.txt")
    (set! weather (file->string "weather.txt"))
    null)

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
                 ", How is the weather today?"))

; greet user and mention weather
(define (weather-mention)
  (string-append (string-sentencecase (choose greeting))
                 ", last time we spoke, you said the weather was "
                 weather ". Is that still the case?"))

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (string-append "Clint: " (choose affirmative-after-modal) " " mode))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (string-append (choose modal-i-response) " " mode " that?"))

(define (q input clint-pairs)
  (cond
    [(null? clint-pairs) (choose generic-responses)]
    [(string-contains-or input (caar clint-pairs)) (choose (cdar clint-pairs))]
    [else (q input (cdr clint-pairs))]))






