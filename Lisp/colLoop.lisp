#!/usr/bin/sbcl --script


#| --------------------------------------------------------------------------------------------
# Struct colNum that contains 2 elements: number and sequence length
# --------------------------------------------------------------------------------------------|#
(defstruct colNum
  num
  seqLength
)

#| --------------------------------------------------------------------------------------------
# Calls sort function with a sortType and prints it out to cmdline
# --------------------------------------------------------------------------------------------|#
(defun printNums(colArr arrSize sortType)

    (numSort colArr arrSize sortType)
    (loop for i from 0 to (- arrSize 1) do
        (format t "~d ~d" (colNum-num (aref colArr i)) (colNum-seqLength (aref colArr i)))
        (terpri)
    )
)

#| --------------------------------------------------------------------------------------------
# Sorts the array with Insertion Sort
# Based on the sortType passed through, it sorts according to num or seqLength
# Returns the sorted array
# --------------------------------------------------------------------------------------------|#
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

#| --------------------------------------------------------------------------------------------
# Searches the minimum value through the array of colNum struct
# Return the minimum values location
# --------------------------------------------------------------------------------------------|#
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

#| --------------------------------------------------------------------------------------------
# Replaces any duplicates in the array according to if num is less than or equal to element
# Returns true or false depending on if a duplicate was found
# --------------------------------------------------------------------------------------------|#
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

#| --------------------------------------------------------------------------------------------
# Calculates the amount of numbers required to reach 1 in a collatz sequence
# Until num is 1, check if even or off and set num accordingly
# Utilizes loop
# Returns the count
# --------------------------------------------------------------------------------------------|#
(defun collatz(num count)
    (loop while (/= num 1) do
        (setf count (+ count 1))

        (if (= (mod num 2) 0)
            (setf num (/ num 2))
            (setf num (+ (* num 3) 1))
        )

    )
    (return-from collatz count)
)

#| --------------------------------------------------------------------------------------------
# Main()
# Takes command line arguments and pares it as an unsigned Int64
# Fills up array and prints
# --------------------------------------------------------------------------------------------|#
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