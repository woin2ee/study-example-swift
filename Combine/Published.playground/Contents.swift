import UIKit
import Combine

class ViewModel {
    @Published var labelTitle = "First Title"
}

class ViewController {
    var cancellable = Set<AnyCancellable>()
    
    lazy var label = UILabel()
    
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func bind() {
        print("--Begin bind()----------------------------------------------------")
        viewModel.$labelTitle
            .sink { title in
                print(".")
                sleep(1)
                print("..")
                sleep(1)
                
                self.label.text = title
                print("Changed Title.")
                
                sleep(1)
                print("..")
                sleep(1)
                print(".")
            }
            .store(in: &cancellable)
        print("--End bind()----------------------------------------------------")
    }
}

let viewModel = ViewModel()
let viewController = ViewController(viewModel: viewModel)

print(viewController.label.text) // nil

viewController.bind()

print(viewController.label.text)

// main thread 에서 변경 수행
viewModel.labelTitle = "Second Title"

print(viewController.label.text)


DispatchQueue.global().sync {
    // 변경이 global queue 에서 일어났기 때문에 publishing 에 따른 sink {} 처리도 같은 global queue 에서 처리함.
    // 따라서 sink {} 까지 처리되어야 밑의 print() 가 실행됨.
    viewModel.labelTitle = "Third Title"
}

print(viewController.label.text)
