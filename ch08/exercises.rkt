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

; 5
(claim incr
  (-> Nat
      Nat))

(define incr
  (lambda (n)
    (iter-Nat n
      1
      (+ 1))))

(check-same Nat (incr 0) 1)
(check-same Nat (incr 1) 2)

(claim incr-2=3
  (= Nat (incr 2) 3))

(define incr-2=3
  ; either definition proves the claim
  ; (same (incr 2)
  (same 3)
  )

; 38
(claim +1=add1
  (Pi ((n Nat))
    (= Nat (+ 1 n) (add1 n))))

; 41
(define +1=add1
  (lambda (n)
    (same (add1 n))))

; 60
(claim mot-incr=add1
  (-> Nat
      U))

(define mot-incr=add1
  (lambda (k)
    (= Nat (incr k) (add1 k))))

; 59
(claim base-incr=add1
  (= Nat (incr zero) (add1 zero)))

(define base-incr=add1
  (same (add1 zero)))

; 69
(claim step-incr=add1
  (Pi ((n-1 Nat))
    (-> (= Nat
          (incr n-1)
          (add1 n-1))
        (= Nat
          (add1
            (incr n-1))
          (add1
            (add1 n-1))))))

; 80
(define step-incr=add1
  (lambda (n-1)
    (lambda (incr=add1_n-1)
      (cong incr=add1_n-1 (+ 1)))))

; 43
(claim incr=add1
  (Pi ((n Nat))
    (= Nat (incr n) (add1 n))))

; 81
(define incr=add1
  (lambda (n)
    (ind-Nat n
      mot-incr=add1
      base-incr=add1
      step-incr=add1)))

; 90 with pies!
(claim pie
  (-> Atom
      Atom))

(define pie
  (lambda (all-pies)
    'delicious))

(check-same Atom (pie 'pumpkin) (pie 'honey))
(check-same Atom (pie 'apple) (pie 'mud))