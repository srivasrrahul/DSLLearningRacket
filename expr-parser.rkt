#lang brag
main-expr : expr
expr : plus-expr | minus-expr | term
plus-expr : term "+" expr
minus-expr : term "-" expr
term : "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" 