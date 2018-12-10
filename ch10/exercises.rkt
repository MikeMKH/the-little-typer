#lang pie

;-----------------------
; length from chapter 5
;-----------------------

; 5.38
(claim step-length
  (Π ((E U))
    (→ E (List E) Nat
        Nat)))

(define step-length
  (λ (E)
    (λ (e es length-es)
      (add1 length-es))))

; 5.36
(claim length
  (Π ((E U))
    (→ (List E)
        Nat)))

; 5.39
(define length
  (λ (E)
    (λ (es)
      (rec-List es
        0
        (step-length E)))))

; 70
(claim mot-list->vec
  (Π ((E U))
    (→ (List E)
        U)))

(define mot-list->vec
  (λ (E es)
    (Vec E (length E es))))

; 71
(claim step-list->vec
  (Π ((E U)
       (e E)
       (es (List E)))
    (→ (mot-list->vec E es)
        (mot-list->vec E (:: e es)))))

; 72
(define step-list->vec
  (λ (E e es)
    (λ (list->vec_es)
      (vec:: e list->vec_es))))

; 54
(claim list->vec
  (Π ((E U)
       (es (List E)))
    (Vec E (length E es))))

; 77
(define list->vec
  (λ (E es)
    (ind-List es
      (mot-list->vec E)
      vecnil
      (step-list->vec E))))

(check-same (Vec Atom 0)
  (list->vec Atom nil)
  vecnil)

(check-same (Vec Nat 2)
  (list->vec Nat (:: 1 (:: 2 nil)))
  (vec:: 1 (vec:: 2 vecnil)))

(check-same (Vec Atom 1)
  (list->vec Atom (:: 'a nil))
  (vec:: 'a vecnil))