;;;; (1) Structures in LISP

;;; Exercise 1.1:

(defvar *people* '())

;;; Exercise 1.2:

(defstruct person 
(name 'noname)
(age 0)
(siblings '()))

;;; Exercise 1.3:

(defun add-member (name age)
(push (make-person :name name :age age) *people*))

;;; Exercise 1.4:

(defun find-person (name) 
(find name *people* :key #'person-name))

;;; Exercise 1.5:

(defun make-siblings (name1 name2)
(push (find-person name1) (person-siblings (find-person name2)))
(push (find-person name2) (person-siblings (find-person name1))))

;;; Exercise 1.6:

(defun initialize-people ()
(add-member 'bob 21)
(add-member 'susan 18)
(add-member 'frank 16)
(add-member 'mary 14)
(make-siblings 'bob 'susan)
(make-siblings 'bob 'frank)
(make-siblings 'susan 'frank))

;;; Exercise 1.7:

(defun sibling-names (name)
(if (find-person name)
(mapcar #'person-name (person-siblings (find-person name)))
nil))

;;; Exercise 1.8:

(print (find-person 'bob))

;;#S(PERSON :NAME BOB :AGE 21 :SIBLINGS (#S(PERSON :NAME FRANK :AGE 16 :SIBLINGS #) #S(PERSON :NAME SUSAN :AGE 18 :SIBLINGS #))) 
;;The depth of the printing is controlled to prevent looping over siblings while printing the structure


;;; Exercise 1.9:

(defstruct (person (:print-function print-person)) 
(name 'noname)
(age 0)
(siblings '()))

(defun print-person (person stream depth)
(format stream "~a ~a ~a" (person-name person) (person-age person) (sibling-names (person-name person))))

;;Usage:
;;(print-person (find-person '<name>) *standard-output* 0)
;;Example:
;;(print-person (find-person 'bob) *standard-output* 0)
;;Output
;;BOB 21 (FRANK SUSAN)
;;NIL
