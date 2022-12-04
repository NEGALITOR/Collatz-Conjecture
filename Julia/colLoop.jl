#!/usr2/local/julia-1.8.2/bin/julia


# --------------------------------------------------------------------------------------------
# Struct colNum that contains 2 elements: number and sequence length
# --------------------------------------------------------------------------------------------
mutable struct colNum
    num::Int64
    seqLength::Int64
end

# --------------------------------------------------------------------------------------------
# Main()
# Takes command line arguments and pares it as an unsigned Int64
# Fills up array and prints
# --------------------------------------------------------------------------------------------
function main()

    colArr =  Array{colNum}(undef, 10)
    colArrSize = 1

    lower = parse(UInt64, ARGS[1])
    upper = parse(UInt64, ARGS[2])

    for i in lower:upper

        colValue = colNum(i, 0)
        colValue.seqLength = collatz(colValue.num, colValue.seqLength)
        if (!replaceDuplicate(colArr, colValue, colArrSize))
            if (colArrSize < 11)
                colArr[colArrSize] = colValue
                colArrSize+=1
            else
                location = searchMin(colArr, colArrSize)
                if (colArr[location].seqLength < colValue.seqLength)
                    colArr[location] = colValue
                end
            end
        end
    end
    printNums(colArr, colArrSize, 0)
    printNums(colArr, colArrSize, 1)
end


# --------------------------------------------------------------------------------------------
# Calculates the amount of numbers required to reach 1 in a collatz sequence
# Until num is 1, check if even or off and set num accordingly
# Utilizes loop
# Returns the count
# --------------------------------------------------------------------------------------------
function collatz(num, count)

    while (num != 1)
        count+=1
        if (num%2 == 0)
            num/=2
        else
            num = (num*3)+1
        end
    end
    return count
end

# --------------------------------------------------------------------------------------------
# Replaces any duplicates in the array according to if num is less than or equal to element
# Returns true or false depending on if a duplicate was found
# --------------------------------------------------------------------------------------------
function replaceDuplicate(colArr, colValue, arrSize)

    for i in 1:(arrSize-1)
        if (colArr[i].seqLength == colValue.seqLength)
            if (colValue.num <= colArr[i].num) colArr[i] = colValue end
            return true
        end
    end
    return false;
end

# --------------------------------------------------------------------------------------------
# Searches the minimum value through the array of colNum struct
# Return the minimum values location
# --------------------------------------------------------------------------------------------
function searchMin(colArr, arrSize)

    minSt = colArr[1]
    minSeqLength = 0
    location = 0

    for i in 1:(arrSize-1)
        minSeqLength = min(minSt.seqLength, colArr[i].seqLength)

        if (minSeqLength == colArr[i].seqLength)
            minSt = colArr[i]
            location = i
        end
    end
    return location

end

# --------------------------------------------------------------------------------------------
# Sorts the array with Insertion Sort
# Based on the sortType passed through, it sorts according to num or seqLength
# Returns the sorted array
# --------------------------------------------------------------------------------------------
function sortArr(colArr, arrSize, sortType)

    if (sortType == 0)

        println("Sorted based on sequence length")
        for i in 1:(arrSize-1)
            index = i
        
            for j in i:(arrSize-1)
                if (colArr[j].seqLength > colArr[index].seqLength)
                    index = j
                end
            end
            maxim = colArr[index]
            colArr[index] = colArr[i]
            colArr[i] = maxim
        end

    else
        println("\nSorted based on integer size")
        for i in 1:(arrSize-1)
            index = i
        
            for j in i:(arrSize-1)
                if (colArr[j].num > colArr[index].num)
                    index = j
                end
            end
            maxim = colArr[index]
            colArr[index] = colArr[i]
            colArr[i] = maxim
        end

    end

    return colArr
end

# --------------------------------------------------------------------------------------------
# Calls sort function with a sortType and prints it out to cmdline
# --------------------------------------------------------------------------------------------
function printNums(colArr, arrSize, sortType)

    colArr = sortArr(colArr, arrSize, sortType)
    for i in 1:(arrSize-1)
        println(colArr[i].num, " ", colArr[i].seqLength)
    end
end

main()