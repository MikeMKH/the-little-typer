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

; 31
(claim mot-vec->list
  (Pi ((E U)
       (l Nat))
    (-> (Vec E l)
        U)))

(define mot-vec->list
  (lambda (E l)
    (lambda (es)
      (List E))))

(claim step-vec->list
  (Pi ((E U)
       (l-1 Nat)
       (e E)
       (es (Vec E l-1)))
    (-> (mot-vec->list E l-1 es)
        (mot-vec->list E (add1 l-1) (vec:: e es)))))

(define step-vec->list
  (lambda (E l-1 e es)
    (lambda (vec->list_es)
      (:: e vec->list_es))))

; 32
(claim vec->list
  (Pi ((E U)
       (l Nat))
    (-> (Vec E l)
        (List E))))

(define vec->list
  (lambda (E l)
    (lambda (es)
      (ind-Vec l es
        (mot-vec->list E)
        nil
        (step-vec->list E)))))

(check-same (List Atom)
  (vec->list Atom 0 vecnil)
  nil)

(check-same (List Nat)
  (vec->list Nat 1 (vec:: 1 vecnil))
  (:: 1 nil))

(check-same (List Atom)
  (vec->list Atom 1 (vec:: 'a vecnil))
  (:: 'a nil))

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

;-------------------------------
; need list->vec from chapter 10
;-------------------------------

; 10.70
(claim mot-list->vec
  (Π ((E U))
    (→ (List E)
        U)))

(define mot-list->vec
  (λ (E es)
    (Vec E (length E es))))

; 10.71
(claim step-list->vec
  (Π ((E U)
       (e E)
       (es (List E)))
    (→ (mot-list->vec E es)
        (mot-list->vec E (:: e es)))))

; 10.72
(define step-list->vec
  (λ (E e es)
    (λ (list->vec_es)
      (vec:: e list->vec_es))))

; 10.54
(claim list->vec
  (Π ((E U)
       (es (List E)))
    (Vec E (length E es))))

; 10.77
(define list->vec
  (λ (E es)
    (ind-List es
      (mot-list->vec E)
      vecnil
      (step-list->vec E))))

; 39
(claim mot-list->vec->list=
  (Pi ((E U))
    (-> (List E)
        U)))

(define mot-list->vec->list=
  (lambda (E es)
    (= (List E)
      es
      (vec->list E
        (length E es)
        (list->vec E es)))))

; 53
(claim ::-fun
  (Pi ((E U))
    (-> E (List E)
        (List E))))

(define ::-fun
  (lambda (E)
    (lambda (e es)
      (:: e es))))

; 40
(claim step-list->vec->list=
  (Pi ((E U)
       (e E)
       (es (List E)))
  (-> (mot-list->vec->list= E es)
      (mot-list->vec->list= E (:: e es)))))

; 54
(define step-list->vec->list=
  (lambda (E e es)
    (lambda (list->vec->list=_es)
      (cong list->vec->list=_es
        (::-fun E e)))))

; 35
(claim list->vec->list=
  (Pi ((E U)
       (es (List E)))
    (= (List E)
       es
       (vec->list E (length E es)
         (list->vec E es)))))

; 55
(define list->vec->list=
  (lambda (E es)
    (ind-List es
      (mot-list->vec->list= E)
      (same nil)
      (step-list->vec->list= E))))

(check-same (= (List Nat) nil nil)
  (list->vec->list= Nat nil)
  (same nil))

(check-same (= (List Nat) (:: 1 nil) (:: 1 nil))
  (list->vec->list= Nat (:: 1 nil))
  (same (:: 1 nil)))

(check-same (= (List Atom) (:: 'a (:: 'b nil)) (:: 'a (:: 'b nil)))
  (list->vec->list= Atom (:: 'a (:: 'b nil)))
  (same (:: 'a (:: 'b nil))))