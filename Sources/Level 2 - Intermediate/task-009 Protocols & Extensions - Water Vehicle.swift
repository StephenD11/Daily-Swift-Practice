import UIKit

// Задача №5: Protocol + Extension -  Система транспорта на водных объектах

protocol WaterTransport {
    var name: String { get }
    var maxSpeed: Int { get }
    
    func move()
    
    
}

extension WaterTransport {
    func move() {
        print("Судно \(name) движется со скоростью \(maxSpeed) км/ч")
    }
    
    func isFast() -> Bool {
        return maxSpeed >= 50
    }
    
    func travelTime(distance: Int) -> Double {
        return Double(distance) / Double(maxSpeed)
    }
}


struct Catamaran : WaterTransport {
    var name: String
    var maxSpeed: Int
    var capacity: Int
    
    func move() {
        print("Судно \(name) движется со скоростью \(maxSpeed) км/ч, колличество: \(capacity)")
    }
}

struct MotorBoat : WaterTransport {
    var name: String
    var maxSpeed: Int
    var enginePower: Int
    
    func move() {
        print("Судно \(name) движется со скоростью \(maxSpeed) км/ч, мощность: \(enginePower)")
    }
    
    func travelTime(distance: Int) -> Double {
        let bonusSpeed = Double(enginePower / 50) * 0.1 * Double(maxSpeed)
        let effectiveSpeed = Double(maxSpeed) + bonusSpeed
        return Double(distance) / effectiveSpeed
    }
}

struct Kayak : WaterTransport {
    var name: String
    var maxSpeed: Int
    var singleUse: Bool = true
    
    func move() {
        print("Судно \(name) движется со скоростью \(maxSpeed) км/ч, \(singleUse ? "Однодневное использование" : "Нет")")
    }
    
    func travelTime(distance: Int) -> Double {
        let effectiveSpeed = singleUse ? Double(maxSpeed) * 0.8 : Double(maxSpeed)
        return Double(distance) / effectiveSpeed
    }
}


let catamaran = Catamaran(name: "Sea Breeze", maxSpeed: 30, capacity: 20)
let motorBoat = MotorBoat(name: "Speedster", maxSpeed: 80, enginePower: 150)
let kayak = Kayak(name: "River Rider", maxSpeed: 12)

let fleet: [WaterTransport] = [catamaran, motorBoat, kayak]

for vessel in fleet {
    vessel.move()
    print(String(format: "Время на 100 км: %.2f ч\n", vessel.travelTime(distance: 100)))
}


/*
 Судно Sea Breeze движется со скоростью 30 км/ч, колличество: 20
 Время на 100 км: 3.33 ч

 Судно Speedster движется со скоростью 80 км/ч, мощность: 150
 Время на 100 км: 0.91 ч

 Судно River Rider движется со скоростью 12 км/ч, Однодневное использование
 Время на 100 км: 10.42 ч
 */
