import UIKit

/*
 Задача №15 — ARC (Automatic Reference Counting)
 Как возникает retain cycle (цикл сильных ссылок) и как его правильно разрывать с помощью weak-ссылок.
*/

class Person {
    var name: String
    // Сильная ссылка на машину
    var car: Car?
    
    init(name: String) {
        self.name = name
        print("\(name) init")
    }
    
    deinit {
        print("\(name) deinit")
    }
    
}

class Car {
    var model: String
    
    // weak-ссылка на владельца, чтобы не было retain cycle
    weak var person: Person?
    
    init(model: String) {
        self.model = model
        print("\(model) init")
    }
    
    
    deinit {
        print("\(model) deinit")
    }
    
}

var person: Person? = Person(name: "Alex")
var car: Car? = Car(model: "BMW")

person?.car = car
car?.person = person

person = nil
car = nil
