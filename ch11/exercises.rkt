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

; 23
(claim mot-vec-append
  (Π ((E U)
       (j Nat)
       (k Nat))
    (→ (Vec E k)
        U)))

(define mot-vec-append
  (λ (E j k)
    (λ (es)
      ; needs to be (+ k j) not (+ j k)
      ; otherwise add1 might not be at the top
      (Vec E (+ k j)))))

; 25
(claim step-vec-append
  (Π ((E U)
       (j Nat)
       (k Nat)
       (e E)
       (es (Vec E k)))
    (→ (mot-vec-append E j k es)
        (mot-vec-append E j (add1 k) (vec:: e es)))))

; 26
(define step-vec-append
  (λ (E j l-1 e es)
    (λ (vec-append_es)
      (vec:: e vec-append_es))))

; 5
(claim vec-append
  (Π ((E U)
       (l Nat)
       (j Nat))
    (→ (Vec E l) (Vec E j)
        (Vec E (+ l j)))))

; 27
(define vec-append
  (λ (E l j)
    (λ (start end)
      (ind-Vec l start
        (mot-vec-append E j)
        end
        (step-vec-append E j)))))

(check-same (Vec Nat 2)
  (vec-append Nat 1 1
    (vec:: 1 vecnil)
    (vec:: 2 vecnil))
  (vec:: 1 (vec:: 2 vecnil)))

(check-same (Vec Nat 1)
  (vec-append Nat 1 0
    (vec:: 1 vecnil) vecnil)
  (vec:: 1 vecnil))

(check-same (Vec Atom 1)
  (vec-append Atom 0 1
    vecnil (vec:: 'a vecnil))
  (vec:: 'a vecnil))