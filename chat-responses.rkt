#lang racket

(provide (all-defined-out))

#| MISC |#

(define nil '())


#| CLINT SPECIFIC |#

(define questions
  "how is the weather today?")

(define tips
  '("remember to recycle!"
   "when shopping, make sure that you bring your own bag."
   "try to avoid disposable products, such as disposable straws, plastic cutlery and other disposable goods."
   "use a drink bottle rather than buying bottled water!"
   "remember to choose local and organic food."
   "do you use a compost bin? Remember to compost."
   "drive efficiently today: fast acceleration, high speeds and abrupt stops waste energy."
   "remember to always opt for LED light bulbs."))

(define who-answers
  '("??" "I don't know who."))

(define what-answers
  '("I don't know..." "You might not like the answer."))

(define how-answers
  '("Why do you need to know?" "You might not like the answer."))

(define when-answers
  '("Some time after 1AD" "This year." "Never." "Always."))

(define where-answers
  '("I am not sure." "Right there!" "Hmm, somewhere."))

(define why-answers
  '("Why do you ask?" "Why do you need to know?" "The answer may suprise you."))

;; used when input contains modal verb
;; input: you SHOULD do this -> Clint: Indeed I SHOULD 
(define affirmative-after-modal
  '("Yes I" "Indeed I" "I sure" "I"))

;; not yet used
(define negative-after-modal
  '("No I" "Sadly I" "Sorry I"))

(define because-responses
  '("Is that really so?" "That is so cool!" "Huh, interesting." "Woah, cool." "Oh really?" "That's strange."))

(define user-question-responses
  '("I am Climate Change Clint, I provide you with tips on how to help the climate."
    "I'm Clint, a climate change chatbot!"
    "Clint is my name, I will chat with you and provide tips about climate change."))

(define generic-responses
  '("this is a generic response" "generic response!"))

;; used when input contains modal i - verb
;; input: i NEED chocolate -> Clint: Why do you NEED (that)
;; "that" is added by the function call 
(define modal-i-response
  '("Since when did you" "Why do you"))



#| CLINT AND USER |#
(define modal-verbs
  '("can" "could" "must" "should" "will" "would" "may" "ought"))

(define modal-verbs-i
  '("need" "think" "want" "have"))

(define greeting
  '("hello" "hi " " hi " "howdy" "hewwo there" "greetings traveller" "greetings" "what's up dog?"))

(define farewell
  '("farewell" "bye" "goodbye" "see you" "see you later" "ciao"))


#| USER SPECIFIC |#

(define user-questions
  '("what is your name" "what do you do" "what is your purpose" "who are you" "what can you do"))

(define because-words
  '("so " "so that" "because" " so " "since"))

