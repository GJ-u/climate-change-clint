#lang racket
(require srfi/13)
(require "responses.rkt" "chat-functions.rkt" "utils.rkt")
(provide (all-defined-out))

;; main-loop: nil -> func
(define (main-loop)
  (let ((input(string-downcase (prompt))))
    (if (string-contains-or input (caar clint-pairs))
        (p (choose (cdar clint-pairs)))
        (begin
          (respondc input)
          (main-loop)))))

;; respond: str -> func
;; cond block is ordered by priority
(define (respondc input)
  (cond
    ; setting name
    [(string-ci=? input "name") (ask-name)]
    ; greeting the user
    [(string-contains-or input greeting)
     (begin
       (case (random 3)
         [(0) (greeting-response)]
         [(1) (greeting-and-question)]
         [(2) (if (file-exists? "weather.txt") (mention-weather)
                  (greeting-response))]))]
    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-response (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]
    ; check through other options
    [else (p (respond-else input clint-pairs))]
    ))

;; start-clint is called in clint.rkt when the --cli switch is used.
(define (start-clint)
  (printf "You are now speaking to Climate Change Clint, to set your name, type 'name'. For advice, type 'tip'.
Climate Change Clint is licensed under GPLv3 or later, and comes with ABSOLUTELY NO WARRANTY to the extent permitted by law.")
  (main-loop))
