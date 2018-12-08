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

; 21
(claim double
  (→ Nat
    Nat))

(define double
  (λ (n)
    (iter-Nat n
      0
      (+ 2))))

(check-same Nat (double 0) 0)
(check-same Nat (double 1) 2)
(check-same Nat (double 2) 4)

; 22
(claim twice
  (→ Nat
      Nat))

(define twice
  (λ (n)
    (+ n n)))

(check-same Nat (twice 0) 0)
(check-same Nat (twice 1) 2)
(check-same Nat (twice 2) 4)

; 39
(claim mot-twice=double
  (→ Nat
    U))

; 40
(define mot-twice=double
  (λ (k)
    (= Nat
      (twice k)
      (double k))))

; 48
(claim mot-step-twice=double
  (→ Nat Nat
    U))

(define mot-step-twice=double
  (λ (n-1 k)
    (= Nat
      (add1 k)
      (add1 (add1 (double n-1))))))

; 31
(claim mot-add1+=+add1
  (→ Nat Nat
      U))

(define mot-add1+=+add1
  (λ (j k)
    (= Nat
      (add1 (+ k j))
      (+ k (add1 j)))))

; 32
(claim step-add1+=+add1
  (Π ((m Nat)
       (n-1 Nat))
    (→ (mot-add1+=+add1 m n-1)
        (mot-add1+=+add1 m (add1 n-1)))))

; 33
(define step-add1+=+add1
  (λ (m n-1)
    (λ (add1+=+add1_n-1)
      (cong add1+=+add1_n-1 (+ 1)))))

; 29
(claim add1+=+add1
  (Π ((n Nat)
      (m Nat))
    (= Nat
       (add1 (+ n m))
       (+ n (add1 m)))))

; 35
(define add1+=+add1
  (λ (n m)
    (ind-Nat n
      (mot-add1+=+add1 m)
      (same (add1 m))
      (step-add1+=+add1 m))))

; 41
(claim step-twice=double
  (Π ((n-1 Nat))
    (→ (mot-twice=double n-1)
        (mot-twice=double (add1 n-1)))))

; 51
(define step-twice=double
  (λ (n-1)
    (λ (twice=double_n-1)
      (replace (add1+=+add1 n-1 n-1)
        (mot-step-twice=double n-1)
        (cong twice=double_n-1 (+ 2))))))

; 23
(claim twice=double
  (Π ((n Nat))
    (= Nat (twice n) (double n))))

; 52
(define twice=double
  (λ (n)
    (ind-Nat n
      mot-twice=double
      (same zero)
      step-twice=double)))

; 53
(claim twice=double-of-17
  (= Nat (twice 17) (double 17)))

(define twice=double-of-17
  (twice=double 17))

(claim twice=double-of-17-again
  (= Nat (twice 17) (double 17)))

; 54
(define twice=double-of-17-again
  (same 34))

(check-same Nat (twice 17) (double 17))
(check-same (= Nat 34 34) (twice=double 17) (same 34))

;----------------------------------
; playing with same and symm
;----------------------------------

(claim identity
  (Π ((u U))
    (→ u
        u)))

(define identity
  (λ (E x) x))

(check-same Nat (identity Nat 1) 1)
(check-same Atom (identity Atom 'a) 'a)

(claim identity-again
  (Π ((u U))
    (→ u
      u)))

(define identity-again
  (λ (E y) y))

(claim identity=identity-again
  (Π ((u U)
      (v u))
    (= u
       (identity u v)
       (identity-again u v))))

(define identity=identity-again
  (λ (E v)
    (same v)))

(check-same (= Nat 1 1) (identity=identity-again Nat 1) (same 1))
(check-same (= Atom 'a 'a) (identity=identity-again Atom 'a) (same 'a))

(claim identity-again=identity
  (Π ((u U)
      (v u))
    (= u
       (identity-again u v)
       (identity u v))))

(define identity-again=identity
  (λ (E v)
    (symm (identity=identity-again E v))))

(check-same (= Nat 1 1) (identity-again=identity Nat 1) (same 1))
(check-same (= Atom 'a 'a) (identity-again=identity Atom 'a) (same 'a))