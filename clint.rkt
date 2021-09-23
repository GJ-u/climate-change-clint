#lang racket/gui

(require "start-gui.rkt")
(require "clint-cli/cli.rkt")

(define command-line-arguments
  (command-line
   #:final
   [("--cli") "Run Climate Change Clint in CLI mode."
              (start-clint)]
   [("--gui") "Run Climate Change Clint in GUI mode."
              (open-gui)]))

