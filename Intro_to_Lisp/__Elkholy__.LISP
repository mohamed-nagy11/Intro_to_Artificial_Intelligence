
 ;;;; Exercise 3: (4)

(defun ESTIMATE-SIZE (n)
	(cond
	((< n 10) 'SMALL)
	((and (<= 10 n) (< n 50)) 'MEDIUM)
	((>= n 50) 'BIG)))



;;;; Exercise 3: (5)

(defun NEGATIVE-P (n)
	(if (< n 0) T NIL))
 




;;;; Exercise 3: (6)

(defun X5 (x)
	(if (numberp x) (* x 5) x))




;;;; Exercise 3: (7)


(defun MAPIPULATE (x)
	(mapcar #'(lambda (y) (if (< y 0) (* 5 y) y)) x))




;;;; Exercise 4: (1)

(defun power (n m)
	(let ((res 1))
		(dotimes (counter m res)
			(setf res (* res n)))))





;;;; Exercise 4: (2)

(defun all-evenp (x)
	 (let ((evenlist '()))
		(dolist (element x (reverse evenlist))
			(if (evenp element) (push element evenlist)))))





;;;; Exercise 4: (3)

(defun what-is (n)
	(cond
	((atom n) 'atom)
	((listp n) 'list)
	((numberp n) 'number)))





;;;; Exercise 4: (4)

(defun average-reduce (x)
	(/ (reduce #'+ x) (length x)))





;;;; Exercise 4: (5) (a)

(defun my-member-cond (element list)
	(cond
	((null list) nil)
	((equal (first list) element) list)
	(t (my-member-cond element (rest list)))))





;;;; Exercise 4: (5) (b)


(defun my-member-do (element list)
	(do ((x list (rest x)))
	((or (null x) (equal (first x) element)) x )))




;;;; Exercise 4: (6) (a)


(defun my-find-cond (element list)
	(cond
	((null list) nil)
	((equal (first list) element) element)
	(t (my-find-cond element (rest list)))))






;;;; Exercise 4: (6) (b)


(defun my-find-do (element list)
	(do ((x list (rest x)))
	((or (null x) (equal (first x) element)) (first x))))





;;;; Exercise 4: (7) (a)


(defun double-mapcar (x)
	(mapcar #'+ x x))





;;;; Exercise 4: (7) (b)


(defun double-dolist (x)
	(let ((result '()))
		(dolist (element x (reverse result))
			(push (* 2 element) result))))





;;;; Exercise 4: (7) (c)


(defun double-do (x)
	(let ((result '()))
		(do ((i 0 (+ i 1)) (len (length x) len))
			((>= i len) (reverse result))
			(push (* 2 (nth i x)) result))))





;;;; Exercise 4: (7) (d)


(defun double-recursive (x)
	(cond
	((null x) '())
	(t (cons (* 2 (first x)) (double-recursive (rest x))))))





;;;; Exercise 4: (8)


(defun exify (s)
	(if (null s)
		nil
		(cons
		(if (listp (first s))
			(exify (first s))
			(if (eq (first s) nil)
				nil
				'X))
		(exify (rest s)))))





;;;; Exercise 4: (9)


(defun count-anywhere (element s)
	(if (null s)
		0
		(+ (if (eq (first s) element) 1 0) (count-anywhere element (rest s))
	(if (listp (first s))
		(count-anywhere element (first s))
		0))))





;;;; Exercise 4: (10)


(defun dot-product (s1 s2)
	(reduce #'+ (mapcar #'* s1 s2)))





;;;; Exercise 4: (11)


(defun x-product (func list1 list2)
	(apply #'append
		(mapcar (lambda (x)
			(mapcar (lambda (y) (funcall func x y)) list2))
				list1)))


