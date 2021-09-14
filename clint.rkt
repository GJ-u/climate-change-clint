#lang racket/gui

(require "clint-gui.rkt")
(require "clint-cli/clint.rkt")

(define gui-mode (make-parameter #f))
(define cli-mode (make-parameter #f))

(define command-line-arguments
  (command-line
   #:final
   [("--cli") "Run Climate Change Clint in CLI mode."
              (start-clint)]
   [("--gui") "Run Climate Change Clint in GUI mode."
              (send w show #t)]))

