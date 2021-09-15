#lang racket
(require "chat-functions-gui.rkt")
(provide (all-defined-out))
(define clint-pairs
  (list
   '(("farewell" "bye" "goodbye" "see you" "see you later" "ciao" "cya")
     "!""!") 
   '(("how are you" "what's up" "whats up" "hru" "what are you doing" "how are you")
     "I am fine thank you, and you?"
    "I'm alright, just thinking about the fact that there is more carbon dioxide in our athmosphere now than at any point during human history."
    "I am feeling terrible. Average wildlife populations have dropped by 60% in the past 40 years."
    "I am doing alright, as alright as I can be knowing that humans have already caused 1.07C of global heating.")
   '(("what is your name" "what do you do" "what is your purpose" "who are you" "what can you do")
     "I am Climate Change Clint, I provide you with tips on how to help the climate."
    "I'm Clint, a climate change chatbot!"
    "Clint is my name, I will chat with you and provide tips about climate change.")
   '(("so " "so that" "because" " so " "since")
     "Is that really so?" "That is so cool!" "Huh, interesting." "Woah, cool." "Oh really?" "That's strange.")
   '(("yes" "ye " "mhm" "yeah" "right")
     "Yay!" "Cool..." "That's right!" "Mhm..." "Is that a good or a bad thing?" "Great!")
   '(("no" "incorrect" "wrong" "nuh")
     "Oh? Why not?" "Noooo :(" "Oh, right." "Do you really think that is the case?" "Ah, is that a good or a bad thing?")
   '(("what") "what?" "You might not like the answer..." "I don't know!" "How could you find out?")
   '(("who") "??" "I don't know who." "Someone, somewhere.")
   '(("how") "Why do you need to know?" "You might not like the answer.")
   '(("when") "Some time after 1AD" "This year." "Never." "Always.")
   '(("where") "I am not sure." "Right there!" "Hmm, somewhere.")
   '(("why") "Why do you ask?" "Why do you need to know?" "The answer may suprise you.")
   ))

(define generic-responsesq
  '("Mhm..." "What." "Oh, I see." "How are you doing?"))
  
   