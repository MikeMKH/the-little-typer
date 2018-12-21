#lang pie

;------------------------------------------
; definition of Dec from chapter 15
;------------------------------------------

; 15.107
(claim Dec
  (→ U
      U))

(define Dec
  (λ (X)
    (Either X
      (→ X
          Absurd))))

;------------------------------------------
; proof =consequence from chapter 15
;------------------------------------------

; 15.11
(claim =consequence
  (→ Nat Nat
      U))

; 15.21
(define =consequence
  (λ (n j)
    (which-Nat n
      (which-Nat j
        Trivial
        (λ (j-1)
          Absurd))
      (λ (n-1)
        (which-Nat j
          Absurd
          (λ (j-1)
            (= Nat n-1 j-1)))))))

;------------------------------------------
; proof =consequence-same from chapter 15
;------------------------------------------

; 15.22
(claim =consequence-same
  (Π ((n Nat))
    (=consequence n n)))

; 15.27
(define =consequence-same
  (λ (n)
    (ind-Nat n
      (λ (k)
        (=consequence k k))
      sole
      (λ (n-1 =consequence_n-1)
        (same n-1)))))

;------------------------------------------
; tatic use-Nat= from chapter 15
;------------------------------------------

; 15.36
(claim use-Nat=
  (Π ((n Nat)
       (j Nat))
    (→ (= Nat n j)
        (=consequence n j))))

; 15.42
(define use-Nat=
  (λ (n j)
    (λ (n=j)
      (replace n=j
        (λ (k)
          (=consequence n k))
        (=consequence-same n)))))

;------------------------------------------
; proof zero-not-add1 from chapter 15
;------------------------------------------

; 15.44
(claim zero-not-add1
  (Π ((n Nat))
    (→ (= Nat zero (add1 n))
        Absurd)))

; 15.47
(define zero-not-add1
  (λ (n)
    (use-Nat= zero (add1 n))))

; 4
(claim zero?
  (Π ((j Nat))
    (Dec
     (= Nat zero j))))

; 16
(define zero?
  (λ (j)
    (ind-Nat j
      (λ (k)
        (Dec
          (= Nat zero k)))
      (left
        (same zero))
      (λ (j-1 zero?_j-1)
        (right
          (zero-not-add1 j-1))))))

(check-same
  (Either (= Nat 0 0) (→ (= Nat 0 0) Absurd))
  (zero? 0)
  (left (same 0)))

; 35
(claim add1-not-zero
  (Π ((n Nat))
    (→ (= Nat (add1 n) zero)
        Absurd)))

(define add1-not-zero
  (λ (n)
    (use-Nat= (add1 n) zero)))

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

;------------------------------------------
; proof sub1= from chapter 15
;------------------------------------------

; 15.50
(claim sub1=
  (Π ((n Nat)
       (j Nat))
    (→ (= Nat (add1 n) (add1 j))
        (= Nat n j))))

(define sub1=
  (λ (n j)
    (use-Nat= (add1 n) (add1 j))))

; 43
(claim dec-add1=
  (Π ((n-1 Nat)
       (j-1 Nat))
    (→ (Dec
          (= Nat n-1 j-1))
        (Dec
          (= Nat (add1 n-1) (add1 j-1))))))

; 50
(define dec-add1=
  (λ (n-1 j-1 eq-or-not)
    (ind-Either eq-or-not
      (λ (target)
        (Dec
          (= Nat (add1 n-1) (add1 j-1))))
      (λ (yes)
        (left
          (cong yes (+ 1))))
      (λ (no)
        (right
          (λ (n=j)
            (no
              (sub1= n-1 j-1 n=j))))))))