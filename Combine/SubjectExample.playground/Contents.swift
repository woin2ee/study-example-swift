import UIKit
import Combine

enum SomeError: Error {
    case someError
}

// MARK: - CurrentValueSubject

let currentValueSubject = CurrentValueSubject<_, SomeError>("A")

currentValueSubject.sink(
    receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("completion >>>>> \(completion)")
        case .failure(let error):
            print("completion >>>>> \(completion) : \(error.localizedDescription)")
        }
    },
    receiveValue: { output in
        print("output >>>>> \(output)")
    }
) // output >>>>> A

currentValueSubject.send("B") // output >>>>> B
currentValueSubject.send("C") // output >>>>> C
currentValueSubject.send("D") // output >>>>> D

currentValueSubject.send(completion: .finished) // completion >>>>> finished
//currentValueSubject.send(completion: .failure(.someError)) // completion >>>>> failure

currentValueSubject.send("E") // send(completion:) 으로 인해 sink 가 종료되어 출력 안됨


// MARK: - PassthroughSubject

let passthroughSubject = PassthroughSubject<String, SomeError>()

passthroughSubject.sink(
    receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("completion >>>>> \(completion)")
        case .failure(let error):
            print("completion >>>>> \(completion) : \(error.localizedDescription)")
        }
    },
    receiveValue: { output in
        print("output >>>>> \(output)")
    }
)

passthroughSubject.send("A") // output >>>>> A
passthroughSubject.send("B") // output >>>>> B

passthroughSubject.send(completion: .finished) // completion >>>>> finished
//passthroughSubject.send(completion: .failure(.someError)) // completion >>>>> failure

passthroughSubject.send("C") // send(completion:) 으로 인해 sink 가 종료되어 출력 안됨
