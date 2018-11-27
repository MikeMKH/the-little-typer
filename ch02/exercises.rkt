#lang pie

; 80
(claim Pear U)

(define Pear
  (Pair Nat Nat))

; 82
(check-same Pear (cons 3 5) (cons 3 (add1 4)))

; 93
(claim Pear-maker U)

(define Pear-maker
  (→ Nat Nat
      Pear))

(claim elim-Pear
  (→ Pear Pear-maker
      Pear))

(define elim-Pear
  (λ (pear maker)
    (maker (car pear) (cdr pear))))

; 95
(check-same (Pair Nat Nat)
  (cons 17 3)
  (elim-Pear
    (cons 3 17)
    (λ (a d)
      (cons d a))))

; 3.24
(claim +
  (-> Nat Nat
      Nat))

; 3.26
(claim step-+
  (-> Nat
      Nat))

(define step-+
  (λ (+n-1)
    (add1 +n-1)))

; 3.27
(define +
  (λ (n m)
    (iter-Nat n
      m
      step-+)))

; 100
(claim pearwise+
  (→ Pear Pear
     Pear))

(define pearwise+
  (λ (a b)
    (elim-Pear a
      (λ (a1 d1)
        (elim-Pear b
          (λ (a2 d2)
            (cons
              (+ a1 a2)
              (+ d1 d2))))))))

(check-same Pear
  (cons 3 4)
  (pearwise+
    (cons 1 2)
    (cons 2 2)))