#lang pie

;----------------------------------
; need + definition from chapter 3
;----------------------------------

; 3.24
(claim +
  (→ Nat Nat
    Nat))

; 3.27
(define +
  (λ (n m)
    (iter-Nat n
      m
      (λ (+n-1)
        (add1 +n-1)))))

;--------------------------------------
; need double definition from chapter 9
;--------------------------------------

; 9.21
(claim double
  (→ Nat
    Nat))

(define double
  (λ (n)
    (iter-Nat n
      0
      (+ 2))))

; 5
(claim Even
  (→ Nat
      U))

(define Even
  (λ (n)
    (Σ ((half Nat))
      (= Nat n (double half)))))

; 9
(claim zero-is-even
  (Even 0))

(define zero-is-even
  (cons 0
    (same 0)))

(claim ten-is-even
  (Even 10))

(define ten-is-even
  (cons 5
    (same 10)))

; 13
(claim +two-even
  (Π ((n Nat))
    (→ (Even n)
        (Even (+ 2 n)))))

; 26
(define +two-even
  (λ (n e_n)
    (cons (add1 (car e_n))
      (cong (cdr e_n) (+ 2)))))

; 28
(claim two-is-even
  (Even 2))

(define two-is-even
  (+two-even 0 zero-is-even))

(claim four-is-even
  (Even 4))

(define four-is-even
  (+two-even 2 two-is-even))

; 32
(claim Odd
  (→ Nat
      U))

(define Odd
  (λ (n)
    (Σ ((haf Nat))
      (= Nat n (add1 (double haf))))))

; 34
(claim one-is-odd
  (Odd 1))

(define one-is-odd
  (cons 0
    (same 1)))

(claim five-is-odd
  (Odd 5))

(define five-is-odd
  (cons 2
    (same 5)))

; 38
(claim add1-even->odd
  (Π ((n Nat))
    (→ (Even n)
        (Odd (add1 n)))))

; 44
(define add1-even->odd
  (lambda(n e_n)
    (cons (car e_n)
      (cong (cdr e_n) (+ 1)))))

(claim three-is-odd
  (Odd 3))

(define three-is-odd
  (add1-even->odd 2 two-is-even))

; 49
(claim add1-odd->even
  (Π ((n Nat))
    (→ (Odd n)
        (Even (add1 n)))))

; 56
(define add1-odd->even
  (λ (n e_n)
    (cons (add1 (car e_n))
      (cong (cdr e_n) (+ 1)))))

(claim six-is-even
  (Even 6))

(define six-is-even
  (add1-odd->even 5 five-is-odd))

(claim +two-odd
  (Π ((n Nat))
    (→ (Odd n)
        (Odd (+ 2 n)))))

(define +two-odd
  (λ (n e_n)
    (cons (add1 (car e_n))
      (cong (cdr e_n) (+ 2)))))

(claim seven-is-odd
  (Odd 7))

(define seven-is-odd
  (+two-odd 5 five-is-odd))