#lang pie

; the Commandment of sole
(check-same Trivial sole sole)

; 7
(claim Maybe
  (→ U
      U))

; 8
(define Maybe
  (λ (X)
    (Either X Trivial)))

; 9
(claim nothing
  (Π ((E U))
    (Maybe E)))

(define nothing
  (λ (E)
    (right sole)))

(check-same (Maybe Atom) (nothing Atom) (nothing Atom))

; 10
(claim just
  (Π ((E U))
    (→ E
      (Maybe E))))

(define just
  (λ (E e)
    (left e)))

(check-same (Maybe Nat) (just Nat 1) (just Nat 1))

; 11
(claim maybe-head
  (Π ((E U))
    (→ (List E)
        (Maybe E))))

; 14
(define maybe-head
  (λ (E es)
    (rec-List es
      (nothing E)
      (λ (hd tl head_tl)
        (just E hd)))))

(check-same (Maybe Nat) (maybe-head Nat (:: 1 nil)) (just Nat 1))
(check-same (Maybe Nat) (maybe-head Nat nil) (nothing Nat))

; 15
(claim maybe-tail
  (Π ((E U))
    (→ (List E)
        (Maybe (List E)))))

(define maybe-tail
  (λ (E es)
    (rec-List es
      (nothing (List E))
      (λ (hd tl tail_tl)
        (just (List E) tl)))))

(check-same (Maybe (List Nat))
  (maybe-tail Nat nil)
  (nothing (List Nat)))
(check-same (Maybe (List Nat))
  (maybe-tail Nat (:: 1 (:: 2 (:: 3 nil))))
  (just (List Nat) (:: 2 (:: 3 nil))))

; 44
(claim Fin
  (→ Nat
      U))

; 50
(define Fin
  (λ (n)
    (iter-Nat n
      Absurd
      Maybe)))

(check-same U (Fin 1) (Fin 1))

; 53
(claim fzero
  (Π ((n Nat))
    (Fin (add1 n))))

; 57
(define fzero
  (λ (n)
    (nothing (Fin n))))

(check-same (Maybe Absurd) (fzero 0) (fzero 0))

; 58
(claim fadd1
  (Π ((n Nat))
    (→ (Fin n)
      (Fin (add1 n)))))

; 60
(define fadd1
  (λ (n)
    (λ (i-1)
      (just (Fin n) i-1))))

(check-same (Maybe (Maybe Absurd)) (fadd1 1 (fzero 0)) (fadd1 1 (fzero 0)))

; 63
(claim base-vec-ref
  (Π ((E U))
    (→ (Fin zero) (Vec E zero)
        E)))

; 65
(define base-vec-ref
  (λ (E)
    (λ (no-value-ever es)
      (ind-Absurd no-value-ever
        E))))

; 66
(claim step-vec-ref
  (Π ((E U)
       (l-1 Nat))
    (→ (→ (Fin l-1)
            (Vec E l-1)
            E)
        (→ (Fin (add1 l-1))
            (Vec E (add1 l-1))
            E))))

; 70
(define step-vec-ref
  (λ (E)
    (λ (l-1 vec-ref_l-1)
      (λ (i es)
        (ind-Either i
          (λ (i)
            E)
          (λ (i-1)
            (vec-ref_l-1
              i-1 (tail es)))
          (λ (triv)
            (head es)))))))

; 61
(claim vec-ref
  (Π ((E U)
       (l Nat))
    (→ (Fin l) (Vec E l)
        E)))

; 71
(define vec-ref
  (λ (E l)
    (ind-Nat l
      (λ (k)
        (→ (Fin k) (Vec E k)
            E))
      (base-vec-ref E)
      (step-vec-ref E))))

(check-same Atom 'b
  (vec-ref Atom 4
    (fadd1 3
      (fzero 2))
    (vec:: 'a
      (vec:: 'b
        (vec:: 'c
          (vec:: 'd vecnil))))))