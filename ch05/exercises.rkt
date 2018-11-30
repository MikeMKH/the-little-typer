#lang pie

; 38
(claim step-length
  (Π ((E U))
    (→ E (List E) Nat
        Nat)))

(define step-length
  (λ (E)
    (λ (e es length-es)
      (add1 length-es))))

; 36
(claim length
  (Π ((E U))
    (→ (List E)
        Nat)))

; 39
(define length
  (λ (E)
    (λ (es)
      (rec-List es
        0
        (step-length E)))))

(check-same Nat (length Atom nil) 0)
(check-same Nat (length Nat (:: 1 (:: 2 nil))) 2)

; 52
(claim step-append
  (Π ((E U))
    (→ E (List E) (List E)
        (List E))))

; 54
(define step-append
  (λ (E)
    (λ (e es append-es)
      (:: e append-es))))

; 47
(claim append
  (Π ((E U))
    (→ (List E) (List E)
        (List E))))

; 54
(define append
  (λ (E)
    (λ (start end)
      (rec-List start
        end
        (step-append E)))))

(check-same (List Nat)
  (append Nat (:: 1 (:: 2 nil)) (:: 3 (:: 4 nil)))
  (:: 1 (:: 2 (:: 3 (:: 4 nil)))))

(check-same (List Atom)
  (append Atom nil nil)
  nil)

(check-same (List Atom)
  (append Atom nil (:: 'a nil))
  (:: 'a nil))

(check-same (List Nat)
  (append Nat (:: 1 nil) nil)
  (:: 1 nil))

; 58
(claim snoc
  (Π ((E U))
    (→ (List E) E
        (List E))))

; 59
(define snoc
  (λ (E)
    (λ (start e)
      (rec-List start
        (:: e nil)
        (step-append E)))))

(check-same (List Nat)
  (snoc Nat nil 1)
  (:: 1 nil))

(check-same (List Atom)
  (snoc Atom (:: 'a nil) 'b)
  (:: 'a (:: 'b nil)))