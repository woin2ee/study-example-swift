import UIKit
import Combine

let numbers = [1, 2, 3, 4, 5]

numbers.publisher
    .sink {
        print($0)
    } // 1 2 3 4 5

numbers.publisher
    .dropFirst()
    .sink {
        print($0)
    } // 2 3 4 5

numbers.publisher
    .dropFirst(3)
    .sink {
        print($0)
    } // 4 5

// -----------------------------------------------------------------------

let publisher = CurrentValueSubject<String, Never>("A")

publisher
    .sink {
        print($0)
    } // A

publisher
    .dropFirst(2) // 2개를 skip 함 (A, B)
    .sink {
        print($0)
    } // ""

publisher.send("B") // B
publisher.send("C") // C C
