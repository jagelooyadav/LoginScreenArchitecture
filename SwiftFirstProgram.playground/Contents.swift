import UIKit

// write a function  for adding 2 number. number would be given as parametek

func Sum(number1: Int,number2: Int) -> Int {
    return number1 + number2
}

print(Sum(number1: 34, number2: 66))

// program  write a prgram to print series like below

// 1, 4, 9, 16.....

//where number of elemnt and start element would be given


func printSquareSeries(first: Int, serriesCount: Int) {
    var nextElement = first
    print(first)
    if serriesCount == 1 {
        return
    }
    for element in 2...serriesCount {
        let serriestElemntSRT = sqrt(Double(nextElement))
        nextElement = Int((serriestElemntSRT + 1) * (serriestElemntSRT + 1))
        print(nextElement)
    }
}

// 1, 5

// 1, 4 9, 16, 25

printSquareSeries(first: 1, serriesCount: 10)
