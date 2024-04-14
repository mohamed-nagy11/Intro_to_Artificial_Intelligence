;;;; Exercise 2: Allen’s Time Relations


;;; Exercise 2.1:

(defstruct interval
	task
	begin
	end)

;;; Exercise 2.2:

(defun meet (i j)
(= (interval-end i) (interval-begin j)))

(defun before (i j)
(< (interval-end i) (interval-begin j)))

(defun after (i j)
(before j i))

(defun during (i j)
(and (<= (interval-begin j) (interval-begin i)) 
     (<= (interval-end i) (interval-end j))))

(defun overlap (i j)
(or 
(and (< (interval-begin i) (interval-begin j))
     (> (interval-end i) (interval-begin j)))
(and (> (interval-end i) (interval-end j))
     (< (interval-begin i) (interval-end j)))))

(defun equals (i j)
(and 
(= (interval-begin i) (interval-begin j))
(= (interval-end i) (interval-end j))))

(defun finishes (i j)
(= (interval-end i) (interval-end j)))

(defun contains (i j)
(and 
(< (interval-begin i) (interval-begin j))
(> (interval-end i) (interval-end j))))

;; Another Implementation:
;; (defun contains (i j)
;; (during j i))

;;; Exercise 2.3:

(defvar relations '(meet before after during overlap equals finishes contains))
(defvar i (make-interval :begin 5 :end 10))
(defvar j (make-interval :begin 7 :end 13))

(mapcar (lambda (relation)
	(format t "~a [~a, ~a] [~a, ~a] ~a ~%"
		relation (interval-begin i) (interval-end i)
		(interval-begin j) (interval-end j)
		(funcall relation i j)))
	relations)