#lang racket
(require "tips.rkt")
(provide (all-defined-out))

;; help message when asked for a tip without addition arguments
(define tip-info
  "For advice on climate change, please type \"tip\" followed by a word from the following list:\n-Home\n-Travel\n-Work\n-Nature\n-Communication\n-Education\n-Shopping\nFor example, \"tip travel\"")

;; clint-pair: a list of a pair of lists. clint pairs are in order of response priority.
;; the car is the user input that clint checks for.
;; the cdr is the output that clint will randomly choose.
(define clint-pairs
  (list
   '(("farewell" "bye" "goodbye" "see you" "see you later" "ciao" "cya")
     "See you! Have a climate concious day!" "Goodbye." "Farewell, remember to recycle.") 
   '(("how are you" "what's up" "whats up" "hru" "what are you doing" "how are you")
     "I am fine thank you, and you?"
     ; source: https://www.wired.co.uk/article/climate-change-facts-2019
    "I'm alright, just thinking about the fact that there is more carbon dioxide in our athmosphere now than at any point during human history."
    "I am feeling terrible. Average wildlife populations have dropped by 60% in the past 40 years."
    "I am doing alright, as alright as I can be knowing that humans have already caused 1.07C of global heating.")
   ; avoiding ridiculously long list by using cons pairs.
   (cons '("tip home") home) (cons '("tip travel") travel) (cons '("tip work") work) (cons '("tip nature") nature)
   (cons '("tip communication") communication) (cons '("tip education") education) (cons '("tip shopping") shopping)
   ; backquoting to include the help message defined above. this is because the help message is too long.
   `(("tip" "advice"),tip-info)
   '(("what is your name" "what do you do" "what is your purpose" "who are you" "what can you do")
     "I am Climate Change Clint, I provide you with tips on how to help the climate."
    "I'm Clint, a climate change chatbot!"
    "Clint is my name, I will chat with you and provide tips about climate change.")
   '(("so " "so that" "because" " so " "since")
     "Is that really so?" "That is so cool!" "Huh, interesting." "Woah, cool." "Oh really?" "That's strange.")
   '(("yes" "ye " "mhm" "yeah" "right" "good" "great" "excellent")
     "Yay!" "Cool..." "That's right!" "Mhm..." "Is that a good or a bad thing?" "Great!" "That's so nice.")
   '(("no" "incorrect" "wrong" "nuh" "nope" "bad" "terrible" "awful")
     "Oh? Why?" "Noooo :(" "Oh, right." "Do you really think that is the case?" "Ah, is that a good or a bad thing?")
   '(("what") "what?" "You might not like the answer..." "I don't know!" "How could you find out?")
   '(("who") "??" "I don't know who." "Someone, somewhere." "I don't know who.")
   '(("how") "Why do you need to know?" "You might not like the answer.")
   '(("when") "Some time after 1AD" "This year." "Never." "Always.")
   '(("where") "I am not sure." "Right there!" "Hmm, somewhere.")
   '(("why") "Why do you ask?" "Why do you need to know?" "The answer may suprise you.")
   ))

; list of generic responses that the respond-else function will return upon not finding any of the above words in the input.
(define generic-responses
  '("Mhm..." "What." "Oh, I see." "How are you doing?" "That is so interesting." "Huh, I hadn't thought of that before." "Maybe your life has something to do with this."
    "Sure..."   "Have you considered going outside?"))

#| MISC |#

(define nil '())

#| CLINT SPECIFIC |#

(define tips
  '("remember to recycle!"
   "when shopping, make sure that you bring your own bag."
   "try to avoid disposable products, such as disposable straws, plastic cutlery and other disposable goods."
   "use a drink bottle rather than buying bottled water!"
   "remember to choose local and organic food."
   "do you use a compost bin? Remember to compost."
   "drive efficiently today: fast acceleration, high speeds and abrupt stops waste energy."
   "remember to always opt for LED light bulbs."))

;; used when input contains modal verb
;; input: you SHOULD do this -> Clint: Indeed I SHOULD 
(define affirmative-after-modal
  '("Yes I" "Indeed I" "I sure" "I"))

;; not yet used
(define negative-after-modal
  '("No I" "Sadly I" "Sorry I"))

;; used when input contains modal i - verb
;; input: i NEED chocolate -> Clint: Why do you NEED (that)
;; "that" is added by the function call 
(define modal-i-response
  '("Since when did you" "Why do you"))

#| CLINT AND USER |#
;; defined seperately because of the special procedures associated.
;; the special procedures being constructing a sentence at random, as defined in chat-functions.rkt

(define modal-verbs
  '("can" "could" "must" "should" "will" "would" "may" "might"))

(define modal-verbs-i
  '("need" "think" "want" "have"))

(define greeting
  '("hello" "hewwo" "hey" "hey there" "hi " "greetings traveller" "yo!" "hello there" "greetings" "sup"))
   