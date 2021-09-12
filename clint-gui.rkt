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
    [(string-contains-or input hru-questions) (string-append "Clint: " (choose hru-responses))]
    ;; Dealing with modal verbs
    [(string-contains-or input modal-verbs)(modal-affirmative (string-contains-or input modal-verbs))]
    [(and (string-contains input "i")(string-contains-or input modal-verbs-i))
     (modal-i (string-contains-or input modal-verbs-i))]
    ;; Dealing with normal questions
    [(string-contains-or input '("what" "who" "where" "when" "why" "how" "clint")) (wh-response input)]
    ;; Give generic response
    [else (string-append "Clint: " (choose generic-responses))]
    ))

;; ask-name: nil -> str
(define (ask-name)
    (set! await-name #t)
    (name-question))

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
               [height 300]
               [style '(fullscreen-button)]
               [alignment '(left top)]))

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

(define clint-portrait (new button%
         [parent top-panel]
         [label (list clint-neutral "" 'top)]
         [min-width 250]
         [min-height 250]))

;; canvas to write text to
(define canvas (new editor-canvas%
                    [parent top-panel]
                    [style '(no-focus hide-hscroll)]
                    [min-height 250]))

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
          (case (random 3)
            [(0) (send clint-portrait set-label clint-happy)]
            [(1) (send clint-portrait set-label clint-neutral)]
            [(2) (send clint-portrait set-label clint-goofy)])          
          (send txt set-value "") ; clear text field
          ; clint's response
          (send style set-delta-foreground "Olive")
          (send editor change-style style)
          (send editor insert (respond input))
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
                 [callback f]))

(send w show #t)
