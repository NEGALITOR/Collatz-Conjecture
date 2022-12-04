package main

import (
	"fmt"
	"math"
	"os"
	"strconv"
)

type colNum struct {
	num int64
	seqLength int64
}

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

func collatz(num int64, count int64) int64 {

	if (num == 1) { return count }
	count++
	if (num%2 == 0) { return collatz(num/2, count) }
	return collatz((num*3)+1, count)
}

func replaceDuplicate(colArr[10] colNum, colValue colNum, arrSize int) bool {
	for i := 0; i < arrSize; i++ {
		if colArr[i].seqLength == colValue.seqLength {
			if colValue.num <= colArr[i].num { colArr[i] = colValue }
			return true
		}
	}
	return false
}

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
  
  //Insertion sort through norms from greatest to least
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
  
  //Prints Nums
  func printNums(colArr[10] colNum, arrSize int, sortType int) {
	colArr = sort(colArr, arrSize, sortType)
	for i := 0; i < arrSize; i++ {
	  if colArr[i].num != 0 {
		fmt.Printf("%d %d\n", colArr[i].num, colArr[i].seqLength)
	  }
	}
  }