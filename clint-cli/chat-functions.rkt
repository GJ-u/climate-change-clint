#lang racket
(require srfi/13)
(require "responses.rkt")
(require "utils.rkt")
(provide (all-defined-out))

#| CHAT FUNCTION DEFINITIONS |#

;; prompt: nil -> nil
(define (prompt)
  (display "\n>> ")
  (read-line))

; greet the user with a climate tip
(define (greeting-response)
  (p (string-sentencecase (choose greeting))
          (string-downcase (choose tips))))

; greet the user with a question
(define (greeting-and-question)
  (p (string-sentencecase (choose greeting))
          "how is the weather today?"))

(define (mention-weather)
  (printf "Clint: Last time we spoke, you said that the weather was ~a, is that still the case?"
          (file->string "weather.txt")))

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (p
   (if (= (random 2) 0)
       (string-append (choose affirmative-after-modal) " " mode)
       (string-append (choose negative-after-modal) " " mode " not."))))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (p (choose modal-i-response) mode))

; used to insert "Clint:" before a string
(define (p str [str2 ""])
  (printf "Clint: ~a ~a" str str2))

; ask about the weather and write the response to a file
(define (ask-question)
  (greeting-and-question) ; greet user and ask about the weather
  (let ((answer (prompt)))
    (begin (with-output-to-file "weather.txt" #:exists 'replace ; create file user.txt, if it exists, overwrite
             (lambda () (printf "~a" answer))) ; insert user's answer into user.txt
           (printf "Clint: I see. ~a" (string-sentencecase (choose tips)))))) ; give generic response and tip

; ask about name and write response to file
(define (ask-name)
  (p "Please tell me your name.")
  (let ((answer (prompt)))
    (begin (with-output-to-file "name.txt" #:exists 'replace
             (lambda () (printf "~a" answer)))
           (p "Name recieved and written to file."))))

(define (q input clint-pairs)
  (cond
    [(null? clint-pairs) (choose generic-responses)]
    [(string-contains-or input (caar clint-pairs)) (choose (cdar clint-pairs))]
    [else (q input (cdr clint-pairs))]))
