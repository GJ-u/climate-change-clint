#lang racket/gui
(require "chat-functions-gui.rkt")
(require "clint-cli/utils.rkt")
(require "clint-cli/responses.rkt")
(require srfi/13)
(provide (all-defined-out))

;; variable definitions
(define nil '())
(define await-weather #f)
(define await-name #f)

(define (respond input)
  (cond
    [(string-contains-or input (caar clint-pairs)) (exit)]
    [(string-ci=? input "name") (ask-name)]
    [(string-contains-or input greeting)
     (case (random 3)
       [(0) (greeting-response)]
       [(1) (ask-question)]
       [(2) (if (file-exists? "weather.txt") (weather-mention)
                (greeting-response))])]
    [(string-contains-or input modal-verbs)
     (modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]
    [else (q input clint-pairs)]))
    
;; ask-name: nil -> str
(define (ask-name)
  (set! await-name #t)
  "What is your name?")

;; ask-question: nil -> func
(define (ask-question)
  (set! await-weather #t)
  (greeting-and-question))


#| GUI DEFINITIONS START HERE |#
;; main window
(define w (new frame%
               [label "Climate Change Clint"]
               [width 800]
               [height 300]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

;; used to change the colour of the text
(define style (make-object style-delta% 
                'change-normal-color))

;; editor: displays interactions between clint and user
(define editor (new text%
  [auto-wrap #t]))
(send editor lock #t) ; disable typing in the editor

(define (make-clint)

  ;; descriptive text
  (define const-text (new message%
                          [label "  You are now speaking with Climate Change Clint. To set your name, type 'name'."]
                          [parent w]
                          [vert-margin 10]))

  ;; horizontal panel for alignment
  (define top-panel (new horizontal-pane%
                         [parent w]
                         [vert-margin 10]
                         [horiz-margin 10]
                         [alignment '(left bottom)]))

  ;; display clint's beautiful face
  (define clint-portrait (new button%
                              [parent top-panel]
                              [label clint-neutral]
                              [min-width 250]
                              [min-height 250]))

  ;; canvas to write text to
  (define canvas (new editor-canvas%
                      [parent top-panel]
                      [editor editor]
                      [style '(no-focus hide-hscroll)]
                      [min-height 250]))

  ;; handle events in text field
  (define (event-handler text-field event)
    (if (equal? 'text-field-enter (send event get-event-type) )
        (begin
          (send editor lock #f)
          (send editor insert (string-append "\n" (send text-field get-value) "\n"))
          (let ((input (string-downcase (send text-field get-value))))
            ; check whether writing to file is needed
            (cond
              [await-weather
               (begin0 (with-output-to-file "weather.txt" #:exists 'replace
                         (lambda () (printf "~a" input)))
                       (set! await-weather #f))]
              [await-name
               (begin0 (with-output-to-file "name.txt" #:exists 'replace
                         (lambda () (printf "~a" input)))
                       (set! await-name #f))]
              [else nil])
            ; change clint portraits at random
            (case (random 5)
              [(0) (send clint-portrait set-label clint-happy)]
              [(1) (send clint-portrait set-label clint-neutral)]
              [(2) (send clint-portrait set-label clint-goofy)]
              [(3) (send clint-portrait set-label clint-sad)]
              [(4) (send clint-portrait set-label clint-sob)])
            (send txt set-value "") ; clear text field
            ; clint's response
            (send style set-delta-foreground "Olive")
            (send editor change-style style)
            (send editor insert (string-append "Clint: " (respond input)))
            ; reset colours and lock editor
            (send style set-delta-foreground "black")
            (send editor change-style style)
            (send editor lock #t)))
        nil))

  ; text input field
  (define txt (new text-field%
                   [parent w]
                   [label ">>"]
                   [min-width 150]
                   [min-height 30]
                   [vert-margin 10]
                   [horiz-margin 10]
                   [stretchable-width #t]
                   [stretchable-height #f]
                   [callback event-handler]))
  nil)
