package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

/* --------------------------------------------------------------------------------------------
* Struct colNum that contains 2 elements: number and sequence length
* --------------------------------------------------------------------------------------------*/
type colNum struct {
	num int64
	seqLength int64
}

/* --------------------------------------------------------------------------------------------
* Main()
* Takes command line arguments and pares it as an unsigned Int64
* Fills up array and prints
* --------------------------------------------------------------------------------------------*/
func main() {
	var colArr[10] colNum
	var colArrSize int = 0

	lower, _ := strconv.Atoi(os.Args[1])
	upper, _ := strconv.Atoi(os.Args[2])

	for i := lower; i < upper; i++ {
		colValue := colNum{num: int64(i), seqLength: 0}
		colValue.seqLength = collatz(colValue.num, colValue.seqLength)
		if !replaceDuplicate(colArr, colValue, colArrSize) {
			if colArrSize < 10 {
				colArr[colArrSize] = colValue
				colArrSize++;
			} else {
				var location int  = searchMin(colArr, colArrSize)
				if colArr[location].seqLength < colValue.seqLength {
					colArr[location] = colValue
				}
			}
		}
	}

	printNums(colArr, colArrSize, 0)
	fmt.Println()
	printNums(colArr, colArrSize, 1)

}

/* --------------------------------------------------------------------------------------------
* Calculates the amount of numbers required to reach 1 in a collatz sequence
* Until num is 1, check if even or off and return collatz accordingly
* Utilizes recursion
* Returns the count
* --------------------------------------------------------------------------------------------*/
func collatz(num int64, count int64) int64 {

	if (num == 1) { return count }
	count++
	if (num%2 == 0) { return collatz(num/2, count) }
	return collatz((num*3)+1, count)
}

/* --------------------------------------------------------------------------------------------
* Replaces any duplicates in the array according to if num is less than or equal to element
* Returns true or false depending on if a duplicate was found
* --------------------------------------------------------------------------------------------*/
func replaceDuplicate(colArr[10] colNum, colValue colNum, arrSize int) bool {
	for i := 0; i < arrSize; i++ {
		if colArr[i].seqLength == colValue.seqLength {
			if colValue.num <= colArr[i].num { colArr[i] = colValue }
			return true
		}
	}
	return false
}

/* --------------------------------------------------------------------------------------------
* Sorts the array with Insertion Sort
* Based on the sortType passed through, it sorts according to num or seqLength
* Returns the sorted array
* --------------------------------------------------------------------------------------------*/
func searchMin(colArr[10] colNum, arrSize int) int {

	var minSt colNum = colArr[0]
	var minNorm float64 = 0
	var location int = 0
	
	for i := 0; i < arrSize; i++ {
	  minNorm = math.Min(float64(minSt.seqLength), float64(colArr[i].seqLength))
	  
	  if int64(minNorm) == colArr[i].seqLength {
		minSt = colArr[i]
		location = i
	  }
	}
	return location
}
  
/* --------------------------------------------------------------------------------------------
* Sorts the array with Insertion Sort
* Based on the sortType passed through, it sorts according to num or seqLength
* Returns the sorted array
* --------------------------------------------------------------------------------------------*/
func sort(colArr[10] colNum, arrSize int, sortType int) [10]colNum {

if sortType == 0 {
	fmt.Println("Sorted based on sequence length")
	var maxim colNum

	for i := 0; i < arrSize; i++ {
	var indx int = i
	
	for j := i; j < arrSize; j++ {
		if colArr[j].seqLength > colArr[indx].seqLength {
		indx = j
		}
	}
	maxim = colArr[indx]
	colArr[indx] = colArr[i]
	colArr[i] = maxim
	}
	return colArr
} else {
	fmt.Println("Sorted based on sequence size")
	var maxim colNum

	for i := 0; i < arrSize; i++ {
	var indx int = i
	
	for j := i; j < arrSize; j++ {
		if colArr[j].num > colArr[indx].num {
		indx = j
		}
	}
	maxim = colArr[indx]
	colArr[indx] = colArr[i]
	colArr[i] = maxim
	}
	return colArr
}

}
  
/* --------------------------------------------------------------------------------------------
* Calls sort function with a sortType and prints it out to cmdline
* --------------------------------------------------------------------------------------------*/
func printNums(colArr[10] colNum, arrSize int, sortType int) {
colArr = sort(colArr, arrSize, sortType)
for i := 0; i < arrSize; i++ {
	if colArr[i].num != 0 {
	fmt.Printf("%d %d\n", colArr[i].num, colArr[i].seqLength)
	}
}
}