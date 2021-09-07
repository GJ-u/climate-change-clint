#lang racket/gui


(require "chat-functions-gui.rkt")
(require "clint-cli/utils.rkt")
(require "clint-cli/chat-responses.rkt")
(require srfi/13)
(provide (all-defined-out))
(define nil '())

; respond: str -> func
; cond block is ordered by priority
(define (respond input)
(cond
            [(string-ci=? input "name") (ask-name)]
            [(string-contains-or input greeting)
             (begin
               (if (= (random 2) 0)
                   (greeting-response)
                   (ask-question) ))]
            
            [(string-contains-or input because-words) (string-append "Clint: " (choose because-responses))]
            [(string-contains-or input user-questions) (string-append "Clint: " (choose user-question-responses))]
            ;; Dealing with modal verbs
            [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
            [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
             (modal-i (string-contains-or input modal-verbs-i))]
            ;; Dealing with normal questions
            [(string-contains input "what") (string-append "Clint: " (choose what-answers))]
            [(string-contains input "who") (string-append "Clint: " (choose who-answers))]
            [(string-contains input "where") (string-append "Clint: " (choose where-answers))]
            [(string-contains input "when") (string-append "Clint: " (choose when-answers))]
            [(string-contains input "why") (string-append "Clint: " (choose why-answers))]
            [(string-contains input "how") (string-append "Clint: " (choose how-answers))]
            
            [else (string-append "Clint: " (choose generic-responses))]
            ))

(define await-weather #f)
(define await-name #f)

; ask about the weather and write the response to a file
(define (ask-question)
  (set! await-weather #t)
  (greeting-and-question))

(define (ask-name)
  (set! await-name #t)
  "Clint: Please tell me your name.")

(define style (make-object style-delta% 
                                 'change-normal-color))



(define w (new frame%
               [label "Climate Change Clint"]
               [width 800]
               [height 800]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

(define top-panel (new horizontal-pane%
                       [parent w]
                       [vert-margin 10]
                       [horiz-margin 10]
                       [alignment '(left top)]))

(define canvas (new editor-canvas%
                    [parent w]
                    [style '(no-focus)]
                    ))

(define editor (new text%))
(send editor lock #t)
(send canvas set-editor editor)

(define (f t e)
  (if (equal? 'text-field-enter (send e get-event-type) )
      (begin
        (send editor lock #f)
        (let ((input (send t get-value)))
          
          (if await-weather
           (begin
             (with-output-to-file "weather.txt" #:exists 'replace
             (lambda () (printf "~a" input)))
             (set! await-weather #f))
           nil)

          (if await-name
              (begin
                (with-output-to-file "name.txt" #:exists 'replace
                  (lambda () (printf "~a" input)))
                (set! await-weather #f))
              nil)
          
          (send editor insert (string-append "\n" input "\n"))
          (send txt set-value "")
          (send editor auto-wrap #t)
          (send style set-delta-foreground "ffaeb1")
          (send editor change-style style)
          (send editor insert (respond input))
          (send style set-delta-foreground "black")
          (send editor change-style style)
          (send editor lock #t)))
      '()))

(define txt (new text-field%
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
