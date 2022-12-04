#!/usr/bin/sbcl --script

(defstruct colNum
  num
  seqLength
)

(defun printNums(colArr arrSize sortType)

    (numSort colArr arrSize sortType)
    (loop for i from 0 to (- arrSize 1) do
        (format t "~d ~d" (colNum-num (aref colArr i)) (colNum-seqLength (aref colArr i)))
        (terpri)
    )
)

(defun numSort(colArr arrSize sortType)

    (if (= sortType 0)
        (progn
            (princ "Sorted based on sequence length")
            (terpri)
            (let (indx)
                (loop for i from 0 to (- arrSize 1) do
                    (setf indx i)
                    (loop for arrSize from i to (- arrSize 1) do
                        (if (> (colNum-seqLength (aref colArr arrSize)) (colNum-seqLength (aref colArr indx)))
                            (setf indx arrSize)
                        )
                    )
                    (rotatef (aref colArr i) (aref colArr indx))
                )
            )
        )

        (progn
            (princ "Sorted based on sequence size")
            (terpri)
            (let (indx)
                (loop for i from 0 to (- arrSize 1) do
                    (setf indx i)
                    (loop for arrSize from i to (- arrSize 1) do
                        (if (> (colNum-num (aref colArr arrSize)) (colNum-num (aref colArr indx)))
                            (setf indx arrSize)
                        )
                    )
                    (rotatef (aref colArr i) (aref colArr indx))
                )
            )
        )
    )

    
  
)

(defun searchMin(colArr arrSize)

  (let ((count 0) minNorm location minSt)
    (setf minSt (aref colArr 0))
    
    (loop for i across colArr do
      
      (setf minNorm (min (colNum-seqLength minSt) (colNum-seqLength i)))
      
      (if (= minNorm (colNum-seqLength i))
        (progn
          (setf minSt i)
          (setf location count)
        )
      )
      (setf count (+ count 1))
    )
    (return-from searchMin location)
  )

  
)


(defun replaceDuplicate(colArr colValue arrSize)
    (loop for i from 0 to (- arrSize 1) do
        (if (= (colNum-seqLength (aref colArr i)) (colNum-seqLength colValue))
            (progn
                (if (<= (colNum-num colValue) (colNum-num (aref colArr i))) (setf (aref colArr i) colValue))
                (return-from replaceDuplicate 1)
            )
        )
    )
    (return-from replaceDuplicate 0)
)

(defun collatz(num count)
    (if (= num 1) (return-from collatz count))
    (setf count (+ count 1))
    (if (= (mod num 2) 0) (return-from collatz (collatz (/ num 2) count)))
    (return-from collatz (collatz (+ (* num 3) 1) count))
)

(progn
    (defvar colArr (make-array '(10)))
    (defvar colArrSize 0)
    (defvar location 0)
    (defvar colValue)
    

    (defvar lower (parse-integer (nth 1 *posix-argv*)))
    (defvar upper (parse-integer (nth 2 *posix-argv*)))

    (loop for i from lower to upper do
        (setq colValue (make-colNum :num i :seqLength 0))
        (setf (colNum-seqLength colValue) (collatz (colNum-num colValue) (colNum-seqLength colValue)))

        ;;;(format t "~d | ~d" (colNum-num colValue) (colNum-seqLength colValue))
        ;;;(terpri)

        (if (/= (replaceDuplicate colArr colValue colArrSize) 1)
            (progn
                (if (< colArrSize 10)
                    (progn
                        (setf (aref colArr colArrSize) colValue)
                        (setf colArrSize (+ colArrSize 1))
                    )
                    (progn
                        (setf location (searchMin colArr colArrSize))
                        (if (< (colNum-seqLength (aref colArr location)) (colNum-seqLength colValue)) (setf (aref colArr location) colValue))
                    )

                )

            )
        )
    )

    (printNums colArr colArrSize 0)
    (terpri)
    (printNums colArr colArrSize 1)
)