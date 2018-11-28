#lang pie

; 24
(claim +
  (→ Nat Nat
      Nat))

; 27
(define +
  (λ (n m)
    (iter-Nat n
      m
      (λ (+n-1)
        (add1 +n-1)))))

(check-same Nat 4 (+ 2 2))
(check-same Nat 3 (+ 0 3))
(check-same Nat 8 (+ 8 0))

; 43
(claim zerop
  (→ Nat
      Atom))

(define zerop
  (λ (n)
    (rec-Nat n
      't
      (λ (n-1 zerop_n-1)
        'nil))))

(check-same Atom 't (zerop 0))
(check-same Atom 'nil (zerop 1))
(check-same Atom 'nil (zerop 100))

; 62
(claim *
  (→ Nat Nat
      Nat))
; 66
(claim step-*
  (→ Nat Nat Nat
      Nat))

(define step-*
  (λ (m n-1 *_n-1)
    (+ m *_n-1)))

; 79
(define *
  (λ (n m)
    (rec-Nat n
      0
      (step-* m))))
        
(check-same Nat 4 (* 2 2))
(check-same Nat 0 (* 0 2))
(check-same Nat 0 (* 2 0))
(check-same Nat 12 (* 2 6))
(check-same Nat 12 (* 6 2))