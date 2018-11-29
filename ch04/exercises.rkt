#lang pie

; 24
(claim flip
  (Π ((A U)
       (D U))
    (→ (Pair A D)
        (Pair D A))))

(define flip
  (λ (A D)
    (λ (p)
      (cons (cdr p) (car p)))))

(check-same (Pair Nat Nat) ((flip Nat Nat) (cons 1 2)) (cons 2 1))
(check-same (Pair Nat Atom) ((flip Atom Nat) (cons 'a 1)) (cons 1'a))

; 41
(claim elim-Pair
  (Π ((A U)
       (D U)
       (X U))
    (→ (Pair A D)
        (→ A D
            X)
        X)))

(define elim-Pair
  (λ (A D X)
    (λ (p f)
      (f (car p) (cdr p)))))

; 8
(claim kar
  (→ (Pair Nat Nat)
      Nat))

; 42
(define kar
  (λ (p)
    (elim-Pair
      Nat Nat
      Nat
      p
      (λ (a d) a))))

(check-same Nat (kar (cons 1 2)) 1)

; 11
(claim kdr
  (→ (Pair Nat Nat)
      Nat))

; 42
(define kdr
  (λ (p)
    (elim-Pair
      Nat Nat
      Nat
      p
      (λ (a d) d))))

(check-same Nat (kdr (cons 1 2)) 2)

; 12
(claim swap
  (→ (Pair Nat Atom)
      (Pair Atom Nat)))

; 43 with flip instead of elim-Pair
(define swap
  (λ (p)
    (flip
      Nat Atom
      p)))

(check-same (Pair Atom Nat) (swap (cons 1 'a)) (cons 'a 1))