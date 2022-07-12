import UIKit
import Foundation

class TimerWrapper {
    var timer: Timer?
    
    init() {
        print("init")
    }
    
    deinit {
        timer?.invalidate()
        print("deinit")
    }
}

var t: TimerWrapper? = TimerWrapper()

t?.timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
    print("repeats")
}

DispatchQueue.global().async {
    sleep(3)
    t = nil
}
