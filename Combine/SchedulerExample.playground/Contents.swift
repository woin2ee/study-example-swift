import Foundation
import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - 아무 설정도 안한 기본 Subject

let defaultSubject = PassthroughSubject<String, Never>()

defaultSubject.sink(receiveValue: { output in
    print("------------------------------")
    print("output >>>>> \(output)")
    print("isMainThread? >>>>> \(Thread.isMainThread)")
    print("------------------------------")
})

defaultSubject.send("A")
//------------------------------
//output >>>>> A
//isMainThread? >>>>> true
//------------------------------

DispatchQueue.global().async {
    defaultSubject.send("B")
}
//------------------------------
//output >>>>> B
//isMainThread? >>>>> false
//------------------------------


// MARK: - subscribe, receive 설정

let subject = CurrentValueSubject<String, Never>("AAA")

subject
    .subscribe(on: DispatchQueue.global()) // upstream
//    .receive(on: DispatchQueue.global()) // downstream
    .sink { output in
        print("------------------------------")
        print("output >>>>> \(output)")
        print("isMainThread? >>>>> \(Thread.isMainThread)")
        print("------------------------------")
    }
//------------------------------
//output >>>>> AAA
//isMainThread? >>>>> false
//------------------------------
/// 초기값 "AAA" 에 대한 구독 자체는 subscribe(on:) 으로 설정한 스레드를 따라가고
/// 후에 send(_:) 로 갱신할때 receive(on:) 을 따로 설정해 주지 않은 경우 element 가 생성된 스레드와 동일한 스레드를 사용한다.

subject.send("C")
//------------------------------
//output >>>>> C
//isMainThread? >>>>> true
//------------------------------

DispatchQueue.global().async {
    subject.send("D")
}
//------------------------------
//output >>>>> D
//isMainThread? >>>>> false
//------------------------------


PlaygroundPage.current.finishExecution()

