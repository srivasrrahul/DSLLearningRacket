#lang br/quicklang

(define-macro (expr-module-begin PARSE-TREE)
  #'(#%module-begin
     'PARSE-TREE))
(provide (rename-out [expr-module-begin #%module-begin]))


(define-macro (main-expr EXPR)
  #'EXPR)
(provide main-expr)

;(define-macro (expr TERM "+" EXPR)
;  #'(+ TERM EXPR))
;(provide expr)

(define-macro-cases expr
  [(expr A) #'A]
  [(term T) #'T])
(provide expr)


(define-macro (eval-exp A)
  #'1)
(provide eval-exp)


(define-macro (plus-expr (term T1) "+" (expr E))
  #'(plus (string->number T1) E))
(provide plus-expr)


;(define-macro (plus-ext X (plus-expr (term T) "+" (expr B)))
;  #'(plus (+ X (string->number T)) B))
;(provide plus-ext)

(define-macro-cases plus-ext
  [(plus-ext X (plus-expr (term T) "+" (expr B))) #'(plus (+ X (string->number T)) B)]
  [(plus-ext X (minus-expr (term T) "-" (expr B))) #'(minus (+ X (string->number T)) B)])
(provide plus-ext)


(define-macro-cases plus
  [(plus A (term B)) #'(+ A (string->number B))]
  [(plus X Y) #'(plus-ext X Y)])
(provide plus)


(define-macro (minus-expr (term T1) "-" (expr E))
  #'(minus (string->number T1) E))
(provide minus-expr)


;(define-macro (minus-ext X (minus-expr (term T) "-" (expr B)))
;  #'(minus (- X (string->number T)) B))
;(provide minus-ext)

(define-macro-cases minus-ext
  [(minus-ext X (minus-expr (term T) "-" (expr B))) #'(minus (- X (string->number T)) B)]
  [(minus-ext X (plus-expr (term T) "+" (expr B)))  #'(plus (- X (string->number T)) B)])
(provide minus-ext)

(define-macro-cases minus
  [(minus A (term B)) #'(- A (string->number B))]
  [(minus X Y) #'(minus-ext X Y)])
(provide minus)


