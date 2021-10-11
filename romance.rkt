#lang racket/gui
(require "chat-functions-gui.rkt")

(define climate-pickups
  '("Are you the environment? Because I care about you." "Baby, the connection I am feeling is stronger than the one between climate change and extreme weather."
    "Reuse, seduce, recycle."))

(define button-text
  '( ("Yes, I am interested in coal power \nplants." "I like recycling.")
     ("I love you Clint, do you want to help \nme install solar panels tomorrow?" "Haha! Climate change is not real!\nYou are delusional!")
     ("Hehe, aww." "No, you.")
     ("Oh????? Really?" "Mhm, I would like to do this again sometime.")
     ("Do you have any climate-change related \npickup lines?" "What do you think about me?")
     ("You are so weird, I think we should end this." "Ok, I need to go now, see you next time.")
     ("" "")))

(define response-text
  `( ("Clint: Yay! I am so excited. What are your interests?" "Clint: What?! Why are you here then, just to break my heart?")
     ("Clint: What! Go away." "Clint: Wow... I think I might be in love.")
     ("Clint: Absolutely. You are so cool." "Clint: I think you need to reevaluate your life.")
     ("Clint: Well, this has been a good date!" "Clint: I am not sure if I am that interested in you... We seem to be different people.")
     ("Clint: Yeah, sorry about that." "Clint: That would be OK.")
     ,(cons (string-append "Clint: " (list-ref climate-pickups (random (length climate-pickups)) )) "Clint: Well.... hmmmmmm...")
     ("Clint: So do I!! You can click the X button to leave." "Clint: Ye, until next time.")
     ("Clint: What! Why are you still here." "...")))
  
(define w (new frame%
               [label "Climate Change Clint"]
               [width 800]
               [height 300]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

(define const-text (new message%
                        [label "  Are you ready to date Clint?"]
                        [parent w]
                        [vert-margin 10]))

;; horizontal panel for alignment
(define top-panel (new horizontal-pane%
                       [parent w]
                       [vert-margin 10]
                       [horiz-margin 10]
                       [alignment '(left bottom)]))

;; editor: displays interactions between clint and user
(define editor (new text%
                    [auto-wrap #t]))
(send editor lock #f) ; disable typing in the editor

;; display clint's beautiful face
(define clint-portrait (new button%
                            [parent top-panel]
                            [label (car clint-list)]
                            [min-width 250]
                            [min-height 250]))

;; canvas to write text to
(define canvas (new editor-canvas%
                    [parent top-panel]
                    [editor editor]
                    [style '(no-focus hide-hscroll)]
                    [min-height 250]))

(define bottom-panel (new horizontal-pane%
                          [parent w]
                          [vert-margin 0]
                          [horiz-margin 10]
                          [alignment '(center bottom)]
                          ))

(define style (make-object style-delta% 
                'change-normal-color))

(define (button-callback B E)
  (begin
    (send editor insert (format "~%~a" (send B get-label)))
    (if (null? button-text)
        (exit)
        (begin (send button-one set-label (caar button-text))
               ; set text colour to green
               (send style set-delta-foreground "Olive")
               (send editor change-style style)
               
               (cond
                 [(eq? B button-one)
                  (send editor insert (format "~%~a" (caar response-text)))]
                 [(eq? B button-two)
                  (send editor insert (format "~%~a" (cadar response-text)))])
               (set! response-text (cdr response-text))
               (send button-two set-label (cadar button-text))
               (set! button-text (cdr button-text))
               
               ; set text colour to black
               (send style set-delta-foreground "Black")
               (send editor change-style style)))))

(define button-one (new button%
                        [parent bottom-panel]
                        [label "Yes!! I cannot wait."]
                        [min-width 350]
                        [min-height 50]
                        [callback button-callback]))

(define button-two (new button%
                        [parent bottom-panel]
                        [label "Not really..."]
                        [min-width 350]
                        [min-height 50]
                        [callback button-callback]))

(send editor insert (format "Clint: Hewwo there ~a, are you ready for our date?" name))

(send w show #t)