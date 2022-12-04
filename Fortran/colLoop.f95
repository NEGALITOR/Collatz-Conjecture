program colLoop
    
    IMPLICIT NONE

    type colNum
        integer (kind = 16) :: num
        integer (kind = 16) :: seqLength
    END type

    type(colNum), dimension(10) :: colArr
    type(colNum) :: colValue
    integer :: colArrSize, location
    integer (kind = 16) :: i, lower, upper
    character (len=32) :: arg

    CALL get_command_argument(1, arg)
    arg = trim(arg)
    read(arg, *) lower

    CALL get_command_argument(2, arg)
    arg = trim(arg)
    read(arg, *) upper

    colArrSize = 1

    do i = lower, upper
        colValue%num = i
        colValue%seqLength = 0
        colValue%seqLength = collatz(colValue%num, colValue%seqLength)

        !write(*,'(i0 , A, i0)') colValue%num, " | ", colValue%seqLength
        
        if (replaceDuplicate(colArr, colValue, colArrSize) /= 1) then
            if (colArrSize < 11) then
                colArr(colArrSize) = colValue
                
                colArrSize = colArrSize + 1
            else
                location = searchMin(colArr, colArrSize)
                if (colArr(location)%seqLength < colValue%seqLength) then
                    colArr(location) = colValue
                END if
            END if
        END if
    END do 

    CALL printNums(colArr, colArrSize, 0)
    write(*,'(A)')
    CALL printNums(colArr, colArrSize, 1)

CONTAINS
    INTEGER FUNCTION collatz(numVal, count)

        integer (kind = 16), intent (in) :: numVal
        integer (kind = 16), intent (out) :: count
        integer (kind = 16) :: num

        num = numVal
        
        do while(num /= 1)
            !write(*,'(i0)') num
            count = count + 1
            !write(*,'(i0)') count
            if (mod(num, 2) == 0) then
                num = num / 2
            else
                num = (num*3) + 1
            END if
        END do
        collatz = count

    END function collatz

    INTEGER FUNCTION replaceDuplicate(colArr, colValue, arrSize)

        type(colNum), dimension(10), intent (inout) :: colArr
        type(colNum), intent (in) :: colValue
        integer, intent (in) :: arrSize
        integer :: i

        do i = 1, arrSize-1
            !write(*,'(i0)') i
            if (colArr(i)%seqLength == colValue%seqLength) then

                if (colValue%num <= colArr(i)%num) then 
                    colArr(i) = colValue 
                END if
                replaceDuplicate = 1
            END if
        END do
        !replaceDuplicate = 0
    END function replaceDuplicate

    !FUNCTION searchMin(colArr, arrSize) result(result)

    !END function


    INTEGER FUNCTION searchMin(colArr, arrSize)
    
    type(colNum), dimension(10), intent(in) :: colArr
    type(colNum) :: minSt
    integer, intent(in) :: arrSize
    integer :: i, location  
    integer :: minSeqLength

    minSeqLength = 0
    location = 1
    minSt = colArr(1)

    do i = 1, arrSize-1
      minSeqLength = min(minSt%seqLength, colArr(i)%seqLength)
      
      if (minSeqLength == colArr(i)%seqLength) then
        minSt = colArr(i)
        location = i
      END if
    END do
    searchMin = location

  END FUNCTION

  SUBROUTINE sort(colArr, arrSize, sortType)
  
  
    type(colNum), dimension(10), intent(out) :: colArr
    type(colNum) :: maxim
    integer, intent(in) :: arrSize
    integer, intent(in) :: sortType
    integer :: indx, i, j

    if (sortType == 0) then
        write(*, '(A)') "Sorted based on sequence length"
        do i = 1, arrSize-1
            indx = i
            do j = i, arrSize-1
                if (colArr(j)%seqLength > colArr(indx)%seqLength) then
                indx = j
                END if
            END do

            maxim = colArr(indx)
            colArr(indx) = colArr(i)
            colArr(i) = maxim
        END do
    else
        write(*, '(A)') "Sorted based on sequence size"
        do i = 1, arrSize-1
            indx = i
            do j = i, arrSize-1
                if (colArr(j)%num > colArr(indx)%num) then
                indx = j
                END if
            END do

            maxim = colArr(indx)
            colArr(indx) = colArr(i)
            colArr(i) = maxim
        END do
    END if

  END SUBROUTINE

  SUBROUTINE printNums(colArr, arrSize, sortType)
  
    type(colNum), dimension(10), intent(inout) :: colArr
    integer, intent(in) :: arrSize
    integer, intent(in) :: sortType

    CALL sort(colArr, arrSize, sortType)
    do i = 1, arrSize-1
      if (colArr(i)%num /= 0) then
        write(*,'(i0 , A, i0)') colArr(i)%num, " ", colArr(i)%seqLength
      END if
    END do

  END SUBROUTINE printNums



END program colLoop
