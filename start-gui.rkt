#lang racket/gui
(require "chat-gui.rkt")
(provide (all-defined-out))

;; horizontal panels for aligning buttons
(define alignment-a
  (new horizontal-pane%
       [parent w]
       [alignment '(center bottom)]))

(define alignment-b
  (new horizontal-pane%
       [parent w]
       [alignment '(center top)]))

;; the emacs-esque message that will display
(define open-text
  (new message%
       [parent alignment-a]
       [label "      This is Climate Change Clint v1.0
Climate Change Clint is licensed under GPLv3 
    and comes with ABSOLUTELY NO WARRANTY.
"]))

;; button deletes itself upon launch
(define launch-button
  (new button%
       [parent alignment-b]
       [label "Launch Clint"]
       [min-width 250]
       [min-height 70]
       [callback (lambda (t e)
                   (begin
                     (send alignment-b delete-child launch-button)
                     (send alignment-a delete-child open-text)
                     (make-clint)))]))

(define (open-gui)(send w show #t))

