import UIKit
import Combine

let subject = PassthroughSubject<String, Never>()

subject.sink(receiveValue: { output in
    print(output)
})

subject.send("A")
