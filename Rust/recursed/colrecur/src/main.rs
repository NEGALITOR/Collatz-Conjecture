use std::vec::Vec;
use std::env;


/* --------------------------------------------------------------------------------------------
* Struct colNum that contains 2 elements: number and sequence length
* --------------------------------------------------------------------------------------------*/
#[derive(Copy, Clone)]
struct ColNum {
    num : u64,
    seq_length : u64
}

/* --------------------------------------------------------------------------------------------
* Main()
* Takes command line arguments and pares it as an unsigned Int64
* Fills up array and prints
* --------------------------------------------------------------------------------------------*/
fn main() {
    let mut _col_arr : Vec<ColNum> = Vec::with_capacity(10);
    let mut _col_arr_size = 0;

    let args: Vec<String> = env::args().collect();

    let lower : u64 = args[1].parse().unwrap();
    let upper : u64 = args[2].parse().unwrap();

    for _j in 0..10 {
        _col_arr.push(ColNum {num : 0, seq_length: 0})
    }

    for i in lower..upper {
        let mut _col_value = ColNum {num : i, seq_length: 0};
        _col_value.seq_length = collatz(_col_value.num, _col_value.seq_length);

        if !replace_duplicate(&mut _col_arr, _col_value, _col_arr_size) {
            if _col_arr_size < 10 {

                _col_arr[_col_arr_size] = _col_value;
                _col_arr_size+=1;

            } else {

                let _location = search_min(&mut _col_arr, _col_arr_size);
                if _col_arr[_location].seq_length < _col_value.seq_length {_col_arr[_location] = _col_value;}

            }
        }
    }

    print_arr(&mut _col_arr, _col_arr_size, 0);
    println!();
    print_arr(&mut _col_arr, _col_arr_size, 1);
}

/* --------------------------------------------------------------------------------------------
* Calculates the amount of numbers required to reach 1 in a collatz sequence
* Until num is 1, check if even or off and return collatz accordingly
* Utilizes recursion
* Returns the count
* --------------------------------------------------------------------------------------------*/
fn collatz(num: u64, mut count: u64) -> u64 {
    if num == 1 {return count;}
    count+=1;
    if num%2 == 0 {return collatz(num/2, count);}
    return collatz((num*3)+1, count)

}

/* --------------------------------------------------------------------------------------------
* Replaces any duplicates in the array according to if num is less than or equal to element
* Returns true or false depending on if a duplicate was found
* --------------------------------------------------------------------------------------------*/
fn replace_duplicate(_col_arr: &mut Vec<ColNum>, _col_value: ColNum, _arr_size: usize) -> bool {
    for i in 0.._arr_size {
        if _col_arr[i].seq_length == _col_value.seq_length {
            if _col_value.num <= _col_arr[i].num {_col_arr[i] = _col_value}
            return true;
        }
    }
    return false;
}

/* --------------------------------------------------------------------------------------------
* Sorts the array with Insertion Sort
* Based on the sortType passed through, it sorts according to num or seqLength
* Returns the sorted array
* --------------------------------------------------------------------------------------------*/
fn search_min(_col_arr: &mut Vec<ColNum>, _arr_size: usize) -> usize {
    let mut _min_st = _col_arr[0];
    let mut _min_seq_length = 0;
    let mut _location = 0 as usize;

    for i in 0.._arr_size {

        _min_seq_length = _min_st.seq_length.min(_col_arr[i].seq_length);

        if _min_seq_length == _col_arr[i].seq_length {

            _min_st = _col_arr[i];
            _location = i;
        }
    }
    _location
}

/* --------------------------------------------------------------------------------------------
* Sorts the array with Insertion Sort
* Based on the sortType passed through, it sorts according to num or seqLength
* Returns the sorted array
* --------------------------------------------------------------------------------------------*/
fn sort_arr(_col_arr: &mut Vec<ColNum>, _arr_size: usize, _sort_type: i8) {

    if _sort_type == 0 {

        println!("Sorted based on sequence length");
        for i in 0.._arr_size {
            let mut index = i as usize;

            for j in i.._arr_size {
                if _col_arr[j].seq_length > _col_arr[index].seq_length {
                    index = j
                }
            }

            let maxim = _col_arr[index];
            _col_arr[index] = _col_arr[i];
            _col_arr[i] = maxim;
        }
    } else {

        println!("Sorted based on sequence size");
        for i in 0.._arr_size {
            let mut index = i as usize;

            for j in i.._arr_size {
                if _col_arr[j].num > _col_arr[index].num {
                    index = j
                }
            }

            let maxim = _col_arr[index];
            _col_arr[index] = _col_arr[i];
            _col_arr[i] = maxim;
        }

    }
}

/* --------------------------------------------------------------------------------------------
* Calls sort function with a sortType and prints it out to cmdline
* --------------------------------------------------------------------------------------------*/
fn print_arr(_col_arr: &mut Vec<ColNum>, _arr_size: usize, _sort_type: i8) {
    sort_arr(_col_arr, _arr_size, _sort_type);
    for i in 0.._arr_size {
        println!("{} {}", _col_arr[i].num, _col_arr[i].seq_length);
    }
}