#lang racket/gui
(require srfi/13)
(require "clint-cli/utils.rkt" "clint-cli/responses.rkt")
(provide (all-defined-out))
;; the gui specific version of chat-functions.rkt.
;; necessary because of variable mutation, and the lack of 'printf', forcing the use of 'string-append' instead.

;; initialise name and weather variables if the relevant files exist.
(define name (if (file-exists? "name.txt") (file->string "name.txt") ""))
(define weather (if (file-exists? "weather.txt") (file->string "weather.txt") ""))

;; list of bitmaps. the portraits are chosen at random from this list.
(define clint-list (list
                    (read-bitmap (build-path "portraits" "clint.png"))
                    (read-bitmap (build-path "portraits" "clint-happy.png"))
                    (read-bitmap (build-path "portraits" "clint-goofy.png"))
                    (read-bitmap (build-path "portraits" "clint-sad.png"))
                     (read-bitmap (build-path "portraits" "clint-sob.png"))))

#| CHAT FUNCTION DEFINITIONS |#

;; greet the user with a climate tip
(define (greeting-response)
  (string-append (string-sentencecase (choose greeting))
                 (case (random 2) [(0) (string-append " " (string-titlecase name))]
                   [(1) ""]) ", "
                 (string-downcase (choose tips))))

;; greet the user with a question
(define (greeting-and-question)
  (string-append (string-sentencecase (choose greeting))
                 (string-append " "(string-titlecase name))
                 ", How is the weather today?"))

;; greet user and mention weather
(define (weather-mention)
  (string-append (string-sentencecase (choose greeting))
                 ", last time we spoke, you said the weather was "
                 weather ". Is that still the case?"))

;; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (string-append "Clint: " (choose affirmative-after-modal) " " mode))

;; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (string-append (choose modal-i-response) " " mode " that?"))

;; you may wonder why respond-else is also defined here
;; the answer is that i do not want utils.rkt to begin with a require statement,
;; which it would need to, as respond-else relies on generic-responses defined in responses.rkt
(define (respond-else input clint-pairs)
  (cond
    [(null? clint-pairs) (choose generic-responses)]
    [(string-contains-or input (caar clint-pairs)) (choose (cdar clint-pairs))]
    [else (respond-else input (cdr clint-pairs))]))






