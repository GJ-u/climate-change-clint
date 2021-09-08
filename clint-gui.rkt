#lang racket/gui


(require "chat-functions-gui.rkt")
(require "clint-cli/utils.rkt")
(require "clint-cli/chat-responses.rkt")
(require srfi/13)

;; variable definitions
(define nil '())
(define await-weather #f)
(define await-name #f)

; respond: str -> str
; cond block is ordered by priority
(define (respond input)
  (cond
    ;; Allow user to set their name  
    [(string-ci=? input "name") (ask-name)]
    ;; Greet the user with a tip or a question
    [(string-contains-or input greeting)
     (begin
       (if (= (random 2) 0)
           (greeting-response)
           (ask-question) ))]
    ;; Dealing with specific questions or explanations
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
    ;; Give generic response
    [else (string-append "Clint: " (choose generic-responses))]
    ))

;; ask-name: nil -> str
(define (ask-name)
  (set! await-name #t)
  "Clint: Please tell me your name.")

;; ask-question: nil -> func
(define (ask-question)
  (set! await-weather #t)
  (greeting-and-question))

#| GUI DEFINITIONS START HERE |#

(define style (make-object style-delta% 
                'change-normal-color))

;; main window
(define w (new frame%
               [label "Climate Change Clint"]
               [width 800]
               [height 800]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

;; horizontal panel for alignment
(define top-panel (new horizontal-pane%
                       [parent w]
                       [vert-margin 10]
                       [horiz-margin 10]
                       [alignment '(left top)]))

;; canvas to write text to
(define canvas (new editor-canvas%
                    [parent w]
                    [style '(no-focus hide-hscroll)]
                    ))

;; define the text that will be written to the canvas
;; used for both input and output
(define editor (new text%))
(send editor lock #t) ; disable typing in the editor
(send editor auto-wrap #t) ; wrap text in the editor

(send canvas set-editor editor) ; set the canvas to recieve this text

;; text-field callback
(define (f t e)
  (if (equal? 'text-field-enter (send e get-event-type) )
      (begin
        (send editor lock #f)
        (send editor insert (string-append "\n" (send t get-value) "\n"))
        (let ((input (string-downcase (send t get-value))))
          
          (cond
            [await-weather
              (begin
                (with-output-to-file "weather.txt" #:exists 'replace
                  (lambda () (printf "~a" input)))
                (set! await-weather #f))]
            [await-name
              (begin
                (with-output-to-file "name.txt" #:exists 'replace
                  (lambda () (printf "~a" input)))
                (set! await-weather #f))]
            [else nil])
          
          (send txt set-value "")
          (send style set-delta-foreground "Olive")
          (send editor change-style style)
          (send editor insert (respond input))
          (send style set-delta-foreground "black")
          (send editor change-style style)
          (send editor lock #t)))
      nil))

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
