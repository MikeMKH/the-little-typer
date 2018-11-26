#lang pie

; 81
(claim four Nat)

(define four
  (add1
    (add1
      (add1
        (add1
          zero)))))

(check-same Nat four 4)

; 119
(check-same (Pair Nat Atom)
  (cons zero 'onion)
  (cons
    (car
      (the (Pair Nat Atom)
        (cons zero 'something-else)))
    (cdr
      (the (Pair Atom Atom)
        (cons 'apple 'onion)))))

; 120
(the (Pair Atom
       (Pair Atom Atom))
  (cons 'basil
    (cons 'thyme 'oregano)))