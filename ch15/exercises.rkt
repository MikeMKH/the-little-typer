#lang pie

; 11
(claim =consequence
  (→ Nat Nat
      U))

; 21
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
      
(check-same U (=consequence 2 2) (=consequence (add1 1) (add1 1)))

; 22
(claim =consequence-same
  (Π ((n Nat))
    (=consequence n n)))

; 27
(define =consequence-same
  (λ (n)
    (ind-Nat n
      (λ (k)
        (=consequence k k))
      sole
      (λ (n-1 =consequence_n-1)
        (same n-1)))))

(check-same (= Nat 1 1) (=consequence-same 2) (same 1))

; 36
(claim use-Nat=
  (Π ((n Nat)
       (j Nat))
    (→ (= Nat n j)
        (=consequence n j))))

; 42
(define use-Nat=
  (λ (n j)
    (λ (n=j)
      (replace n=j
        (λ (k)
          (=consequence n k))
        (=consequence-same n)))))

; 44
(claim zero-not-add1
  (Π ((n Nat))
    (→ (= Nat zero (add1 n))
        Absurd)))

; 47
(define zero-not-add1
  (λ (n)
    (use-Nat= zero (add1 n))))

(claim fake-news
  (→ (= Nat 0 42)
      (= Atom 'truth 'falsehood)))

(define fake-news
  (λ (0=42)
    (ind-Absurd
      (zero-not-add1 41 0=42)
      (= Atom 'truth 'falsehood))))

; 50
(claim sub1=
  (Π ((n Nat)
       (j Nat))
    (→ (= Nat (add1 n) (add1 j))
        (= Nat n j))))

(define sub1=
  (λ (n j)
    (use-Nat= (add1 n) (add1 j))))

; Principle of the Excluded Middle
; 90
(claim pem-not-false
  (Π ((X U))
    (→ (→ (Either X
              (→ X
                Absurd))
          Absurd)
      Absurd)))

; 103
(define pem-not-false
  (λ (X)
    (λ (pem-false)
      (pem-false
        (right
          (λ (x)
            (pem-false
              (left x))))))))

; 107
(claim Dec
  (→ U
      U))

(define Dec
  (λ (X)
    (Either X
      (→ X
          Absurd))))

; 108
(claim pem
  (Π ((X U))
    (Dec X)))