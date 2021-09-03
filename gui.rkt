#lang racket/gui

(require "clint.rkt")


(define w (new frame%
               [label "Climate Change Clint"]
               [width 400]
               [height 300]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

(define top-panel (new horizontal-pane%
                       [parent w]
                       [vert-margin 10]
                       [horiz-margin 10]
                       [alignment '(left top)]))

(define input (new text-field%
                   [parent w]
                   [label ">>"]
                   [min-width 150]
                   [min-height 30]
                   [vert-margin 10]
                   [horiz-margin 10]
                   [stretchable-width #t]
                   [stretchable-height #f]))

(define text (new message%
                  [parent w]
                  [label "clint's response"]))

(send w show #t)