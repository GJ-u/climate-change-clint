#lang racket
(require srfi/13)
(require "chat-responses.rkt")
(require "utils.rkt")
(provide (all-defined-out))

#| CHAT FUNCTION DEFINITIONS |#

;; prompt: nil -> nil
(define (prompt)
  (display "\n>> ")
  (read-line))

; greet the user with a climate tip
(define (greeting-response)
  (printf "Clint: ~a, ~a" (string-sentencecase (choose greeting))
          (string-downcase (choose tips))))

; greet the user with a question
(define (greeting-and-question)
  (printf "Clint: ~a, ~a" (string-sentencecase (choose greeting))
          (string-sentencecase questions)))

; respond to a modal verb affirmatively
(define (modal-affirmative [mode (choose modal-verbs)])
  (printf "Clint: ~a ~a!" (choose affirmative-after-modal) mode))

; respond to i-modals
(define (modal-i [mode (choose modal-verbs-i)])
  (printf "Clint: ~a ~a that?" (choose modal-i-response) mode))

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

(define (ask-name)
  (p "Please tell me your name.")
  (let ((answer (prompt)))
    (begin (with-output-to-file "name.txt" #:exists 'replace
             (lambda () (printf "~a" answer)))
           (p "Name recieved and written to file."))))


(define (n input) (cond     [(string-contains input "what") (string-append "Clint: " (choose what-answers))]
    [(string-contains input "who") (string-append "Clint: " (choose who-answers))]
    [(string-contains input "where") (string-append "Clint: " (choose where-answers))]
    [(string-contains input "when") (string-append "Clint: " (choose when-answers))]
    [(string-contains input "why") (string-append "Clint: " (choose why-answers))]
    [(string-contains input "how") (string-append "Clint: " (choose how-answers))]))
