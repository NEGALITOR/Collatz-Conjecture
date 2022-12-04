# CSC 330 - Project 3 - Collatz Conjecture

## Description
Write a program to compute the number of items in the Collatz sequence. In other words, compute the numbers in the Collatz sequence for a beginning value and print out how many numbers there are in the sequence. Once you have done that modify your program so that given two command line integer inputs, the program will find and print the 10 smallest integers in your range with the longest collatz sequences. In the case of two integers having the same Collatz sequence length, you need to keep the smaller of the two integers. Produce this list first sorted in descending order by list length and then by initial number in the Collatz sequence. The maximum value of an integer to be input into your program is five billion.

*DISCLAIMER: The user must remember to add their command line arguments when calling the various versions of the program. Failure to do so will break the program in a way that exits the program run*

## Functions
This is a list of the functions included in the various iterations of this program

- `collatz()` - Calculates the collatz sequence and returs the amount generated as count.
- `replaceDuplicate()` - Replaces any duplicate seqLengths within the array of structs. Replaces if the colValue is less than or equal to the array element that has the same seqLength. Returns a true or false if a duplicate is detected.
- `searchmin()` -  Searches the min value within the array of structs and returns the location. Allows code to swap it out if the current element's seqLength is less than the colValue seqLength.
- `sortArr()` - Sorts the array depending on type (num or seqLength) from greatest to least with Insertion Sort.
- `printNums()` - Prints all the numbers and sequences in the array of structs to command line.

## Langauges 

#### *DISCAIMER: For the purpose of the example calls, the arguments being used in the run commands are the same input that was given to us by Dr. Pounds.*
---

### Fortran

**Compilation:**

Loop Compile:
```
gfortran colLoop.f95
```

Recursion Compile:
```
gfortran colLoop.f95
```

**Run:**
```
./a.out (int) (int)
```

---
### Go

**Compilation:**

Loop Compile/Run: 
```
go run colLoop.go (int) (int)
```

Recursion Compile/Run: 
```
go run colRecur.go (int) (int)
```

--- 
### Julia

**Compilation:** You'll need to make the file executable if it is not already by using `chmod +x colLoop.jl` or `chmod +x colRecur.jl`. Then, run the command 

Loop Run:
```
./colLoop.jl (int) (int)
```
Recursion Run:
```
./colRecur.jl (int) (int)
```

---
### Lisp

**Compilation:** You'll need to make the file executable if it is not already by using `chmod +x colLoop.lisp` or `chmod +x colRecur.lisp`. Then, run the command 

Loop Run:
```
./colLoop.lisp (int) (int)
```
Recursion Run:
```
./colRecur.lisp (int) (int)
```

---
### Rust

**Compilation:** Must be in `src` sub-directory of each and execute the following
```
cargo build
```
**Run:**
```
cargo run (int) (int)
```
---

