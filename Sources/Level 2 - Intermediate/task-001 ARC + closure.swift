import UIKit

//Задача №14 ARC + closure


class Service {
    var id: Int
    var name: String
    var onFinish: (() -> Void)?
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
        
        print("Class init complete")
    }
    
    func prepare() {
        onFinish = { [weak self] in
            guard let self = self else { return }
            print("Func is init")
        }
    }
    
    deinit {
        print("It's over - Deinit complete")
    }
    
}

var service: Service? = Service(id:1, name: "Alex")
service?.prepare()
service?.onFinish?()

service = nil
