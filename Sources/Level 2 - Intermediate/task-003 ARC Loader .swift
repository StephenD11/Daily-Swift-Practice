import UIKit

// Задача №16 - Тестовое задание по понимаю работы с weak / unowned 

class LoaderService {
    var completion: (() -> Void)?
    
    init() {
        print("Object init")
    }
    
    func load() {
        print("Loading...")
        completion?()
    }
    
    deinit {
        print("Object deinit")
    }
    
}

class ScreenController {
    var service: LoaderService?
    
    func start() {
        service = LoaderService()
        service?.completion = { [weak self] in
            guard let self = self else { return }
            print("function init")
        }
        service?.load()
    }
}

var screen: ScreenController? = ScreenController()
screen?.start()


screen = nil
