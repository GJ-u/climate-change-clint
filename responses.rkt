#lang racket

(require "string-contains-multi.rkt")
(provide (all-defined-out))
#| CHAT VARIABLE DEFINITIONS |#

(define nil '())

;; used for both clint and user
(define greeting
  '("hello" "hi " " hi " "howdy" "hewwo there" "greetings traveller" "what's up dog?"))

;; clint specific 
(define questions
  '("How is the weather today?"
    "How are you feeling about the climate today?"))

;; clint specific
(define tips
  '("Remember to recycle!"
   "When shopping, make sure that you bring your own bag."
   "Try to avoid disposable products, such as disposable straws, plastic cutlery and other disposable goods."
   "Use a drink bottle rather than buying bottled water!"
   "Remember to choose local and organic food."
   "Do you use a compost bin? Remember to compost."
   "Drive efficiently today: fast acceleration, high speeds and abrupt stops waste energy."
   "Always opt for LED light bulbs"))
  
;; user specific (question!?!?)
(define question
  '("who" "what" "when" "where" "how" "why" "?"))

;; used for both clint and user
(define modal-verbs
  '("can" "could" "must" "should" "will" "would" "may" "ought"))

(define modal-verbs-i
  '("need" "think" "want" "have"))

;; clint specific
(define affirmative-after-modal
  '("Yes I" "Indeed I" "I sure" "I"))

(define negative-after-modal
  '("No I" "Sadly I" "Sorry I"))

(define modal-i-response
  '("Since when did you" "Why do you"))

#| CHAT FUNCTION DEFINITIONS |#

(define (modal-affirmative [mode (choose modal-verbs)])
  (printf "Clint: ~a ~a!" (choose affirmative-after-modal) mode))

(define (modal-i [mode (choose modal-verbs-i)])
  (printf "Clint: ~a ~a that?" (choose modal-i-response) mode))
  