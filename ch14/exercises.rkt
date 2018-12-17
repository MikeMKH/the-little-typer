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