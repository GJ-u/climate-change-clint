#lang racket/gui

;(require "clint.rkt")


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

(define canvas (new editor-canvas%
                   [parent w]
                   ))

(define editor (new text%))
(send editor lock #t)
(send canvas set-editor editor)

(define (f t e)
  (if (equal? 'text-field-enter (send e get-event-type) )
      (begin
        (send editor lock #f)
        (send editor insert (string-append (send t get-value) "\n"))
        (send editor lock #t))
      '()))

(define input (new text-field%
                   [parent w]
                   [label ">>"]
                   [min-width 150]
                   [min-height 30]
                   [vert-margin 10]
                   [horiz-margin 10]
                   [stretchable-width #t]
                   [stretchable-height #f]
                   [callback f]))


(send w show #t)