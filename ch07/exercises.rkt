#lang pie

; 12
(claim mot-peas
  (→ Nat
      U))

; 13
(define mot-peas
  (λ (k)
    (Vec Atom k)))

; 20
(claim step-peas
  (Π ((l-1 Nat))
    (→ (mot-peas l-1)
        (mot-peas (add1 l-1)))))

(define step-peas
  (λ (l-1)
    (λ (peas_l-1)
      (vec:: 'peas peas_l-1))))

; 4
(claim peas
  (Π ((how-many Nat))
    (Vec Atom how-many)))

; 25
(define peas
  (λ (how-many)
    (ind-Nat how-many
      mot-peas
      vecnil
      step-peas)))

(check-same (Vec Atom 0) (peas 0) vecnil)
(check-same (Vec Atom 1) (peas 1) (vec:: 'peas vecnil))
(check-same (Vec Atom 2) (peas 2) (vec:: 'peas (vec:: 'peas vecnil)))

; 33
(claim base-last
  (Π ((E U))
    (→ (Vec E (add1 zero))
        E)))

; 34
(define base-last
  (λ (E)
    (λ (es)
      (head es))))

; 40
(claim mot-last
  (→ U Nat
      U))

(define mot-last
  (λ (E k)
    (→ (Vec E (add1 k))
        E)))

; 49
(claim step-last
  (Π ((E U)
       (l-1 Nat))
    (→ (mot-last E l-1)
        (mot-last E (add1 l-1)))))

(define step-last
  (λ (E l-1)
    (λ (last_l-1)
      (λ (es)
        (last_l-1 (tail es))))))

; 28
(claim last
  (Π ((E U)
       (l Nat))
    (→ (Vec E (add1 l))
        E)))

; 54
(define last
  (λ (E l)
    (ind-Nat l
      (mot-last E)
      (base-last E)
      (step-last E))))

(check-same Atom (last Atom 9 (peas 10)) 'peas)
(check-same Nat (last Nat 0 (vec:: 1 vecnil)) 1)
(check-same Nat (last Nat 1 (vec:: 1 (vec:: 2 vecnil))) 2)