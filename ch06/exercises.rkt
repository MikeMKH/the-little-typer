#lang pie

; 34
(claim first
  (Π ((E U)
       (l Nat))
    (→ (Vec E (add1 l))
        E)))

; 35
(define first
  (λ (E l)
    (λ (es)
      (head es))))

(check-same Nat (first Nat 0 (vec:: 1 vecnil)) 1)
(check-same Nat (first Nat 1 (vec:: 1 (vec:: 2 vecnil))) 1)

; 43
(claim rest
  (Π ((E U)
       (l Nat))
    (→ (Vec E (add1 l))
        (Vec E l))))

; 44
(define rest
  (λ (E l)
    (λ (es)
      (tail es))))

(check-same (Vec Nat 0) (rest Nat 0 (vec:: 1 vecnil)) vecnil)
(check-same (Vec Nat 1) (rest Nat 1 (vec:: 1 (vec:: 2 vecnil))) (vec:: 2 vecnil))

(check-same (Vec Atom 3)
  (vec::
    (first Atom 1 (vec:: 'a (vec:: 'b vecnil)))
    (rest  Atom 2 (vec:: 'x (vec:: 'y (vec:: 'z vecnil)))))
  (vec:: 'a (vec:: 'y (vec:: 'z vecnil))))