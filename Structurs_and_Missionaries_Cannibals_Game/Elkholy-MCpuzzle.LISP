;;; +=============================================+
;;; | State definitions and associated predicates |
;;; +=============================================+

(defun make-state (boat-side missionaries-side cannibals-side)
  (list boat-side missionaries-side cannibals-side))

(defun boat-side (state)
  (nth 0 state))

(defun missionaries-side (state)
  (nth 1 state))

(defun cannibals-side (state)
  (nth 2 state))

(defun goal-state-p (state)
  (and (eq (boat-side state) 'right)
       (= (missionaries-side state) 0)
       (= (cannibals-side state) 0)))

(defun safe-state-p (state)
  (or (and (<= 0 (missionaries-side state) 3)
           (<= 0 (cannibals-side state) 3)
           (<= (missionaries-side state) (cannibals-side state))
           (<= (- 3 (missionaries-side state)) (- 3 (cannibals-side state)))
           (if (eq (boat-side state) 'left)
               (<= (missionaries-side state) 2)
               (<= (missionaries-side state) 1)))
      nil))

(defun generate-next-states (state)
  (let ((next-states '()))
    (let ((current-boat-side (boat-side state))
          (current-missionaries-side (missionaries-side state))
          (current-cannibals-side (cannibals-side state)))
      (if (eq current-boat-side 'left)
          (progn
            (if (>= current-missionaries-side 2)
                (push (make-state 'right (- current-missionaries-side 2) current-cannibals-side) next-states))
            (if (>= current-missionaries-side 1)
                (push (make-state 'right (- current-missionaries-side 1) current-cannibals-side) next-states))
            (if (>= current-cannibals-side 2)
                (push (make-state 'right current-missionaries-side (- current-cannibals-side 2)) next-states))
            (if (>= current-cannibals-side 1)
                (push (make-state 'right current-missionaries-side (- current-cannibals-side 1)) next-states)))
          (progn
            (if (<= (- 3 current-missionaries-side) 2)
                (push (make-state 'left (+ current-missionaries-side 2) current-cannibals-side) next-states))
            (if (<= (- 3 current-missionaries-side) 1)
                (push (make-state 'left (+ current-missionaries-side 1) current-cannibals-side) next-states))
            (if (<= (- 3 current-cannibals-side) 2)
                (push (make-state 'left current-missionaries-side (+ current-cannibals-side 2)) next-states))
            (if (<= (- 3 current-cannibals-side) 1)
                (push (make-state 'left current-missionaries-side (+ current-cannibals-side 1)) next-states)))))
    next-states))

;;; +======================+
;;; | Operator definitions |
;;; +======================+

(defun move-missionaries (state num)
  (make-state (boat-side state)
              (- (missionaries-side state) num)
              (cannibals-side state)))

(defun move-cannibals (state num)
  (make-state (boat-side state)
              (missionaries-side state)
              (- (cannibals-side state) num)))

(defun move-boat (state)
  (make-state (if (eq (boat-side state) 'left) 'right 'left)
              (missionaries-side state)
              (cannibals-side state)))

(defun move-missionaries-cannibals (state missionaries cannibals)
  (move-boat
   (move-missionaries
    (move-cannibals state cannibals)
    missionaries)))

(defun take-self (state)
  (and (not (and (eq (boat-side state) 'left)
                (= (missionaries-side state) 2)
                (= (cannibals-side state) 0)))
       (not (and (eq (boat-side state) 'left)
                (= (missionaries-side state) 1)
                (= (cannibals-side state) 0)))
       (not (and (eq (boat-side state) 'left)
                (= (missionaries-side state) 0)
                (= (cannibals-side state) 2)))
       (not (and (eq (boat-side state) 'left)
                (= (missionaries-side state) 0)
                (= (cannibals-side state) 1)))
       (not (and (eq (boat-side state) 'right)
                (= (missionaries-side state) 2)
                (= (cannibals-side state) 0)))
       (not (and (eq (boat-side state) 'right)
                (= (missionaries-side state) 1)
                (= (cannibals-side state) 0)))
       (not (and (eq (boat-side state) 'right)
                (= (missionaries-side state) 0)
                (= (cannibals-side state) 2)))
       (not (and (eq (boat-side state) 'right)
                (= (missionaries-side state) 0)
                (= (cannibals-side state) 1)))
       (safe-state-p (move-boat state))))

;;; +===================+
;;; | Utility functions |
;;; +===================+

(defun opposite (side)
  (if (eq side 'left) 'right 'left))

(defun initial-state ()
  (make-state 'left 3 3))

(defun print-state (state)
  (format t "Boat on ~a, ~a missionaries, ~a cannibals on ~a.~%"
          (boat-side state)
          (missionaries-side state)
          (cannibals-side state)
          (if (eq (boat-side state) 'left) "left" "right")))

(defvar *visited-states* nil)

(defun solve-missionaries-and-cannibals (state)
  (print-state state)
  (if (goal-state-p state)
      (format t "Solution Found!~%")
      (let ((next-states '()))
        (if (take-self state)
            (push (move-boat state) next-states))
        (if (and (safe-state-p (move-missionaries state 1))
                 (not (equal state (move-missionaries state 1))))
            (push (move-missionaries state 1) next-states))
        (if (and (safe-state-p (move-cannibals state 1))
                 (not (equal state (move-cannibals state 1))))
            (push (move-cannibals state 1) next-states))
        (if (and (safe-state-p (move-missionaries-cannibals state 1 1))
                 (not (equal state (move-missionaries-cannibals state 1 1))))
            (push (move-missionaries-cannibals state 1 1) next-states))
        (loop for next-state in next-states
              unless (member next-state *visited-states* :test #'equal)
              do
              (progn
                (push next-state *visited-states*)
                (solve-missionaries-and-cannibals next-state))))))



(defun start-solver ()
  (let ((initial-state (make-state 'left 3 3)))
    (push initial-state *visited-states*)
    (solve-missionaries-and-cannibals initial-state)))

(start-solver)
