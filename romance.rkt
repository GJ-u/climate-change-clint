#lang racket/gui
(require "chat-functions-gui.rkt")

(define button-text
  '( ("RESPONSE 1" "RESPONSE 2")
     ("EEEEEEEEE" "eoeeoeee")))

(define response-text
  '( ("Clint: Yay! I am so excited. What are your interests?" "Clint: What?! Why are you here then, just to break my heart?")
     ("good response" "bad respones")))
  
;;; clint: romance mode
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

(define (button-callback B E)
  (begin
    (send editor insert (format "~%~a" (send B get-label)))
    (if (or (null? button-text) (null? response-text))
        (exit)
        (begin (send button-one set-label (caar button-text))
               (cond
                 [(eq? B button-one)
                  (send editor insert (caar response-text))]
                 [(eq? B button-two)
                  (send editor insert (cadar response-text))])
               (send button-two set-label (cadar button-text))
               (set! button-text (cdr button-text))))))

(define button-one (new button%
                        [parent bottom-panel]
                        [label "yes"]
                        [min-width 350]
                        [min-height 50]
                        [callback button-callback]))

(define button-two (new button%
                        [parent bottom-panel]
                        [label "no"]
                        [min-width 350]
                        [min-height 50]
                        [callback button-callback]))

(send editor insert (format "Hewwo there ~a, are you ready for our date?" name))

(send w show #t)