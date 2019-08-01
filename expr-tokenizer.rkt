#lang br/quicklang
(require "expr-parser.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module expr-mod "expr-expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)


(require brag/support)
(define (make-tokenizer port)
  (define (next-token)
    (define expr-lexer
      (lexer
       [(char-set "0123456789+-") lexeme]
       [any-char (next-token)]))
    (expr-lexer port))  
  next-token)