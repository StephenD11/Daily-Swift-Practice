import UIKit

//Задача №2 - Работа с протоколами и расширением

protocol Vehicle {
    var model: String { get }
    var maxSpeed: Int { get }
    var capacity: Int { get }
    
    func description()
    func travelTime(distance: Int) -> Double
    func averageSpeed(stopMinutes: Int, distance: Int) -> Double
}

extension Vehicle {
    func description() {
        print("Транспорт: \(model), Макс. скорость: \(maxSpeed) км/ч, Вместимость: \(capacity) чел")
        }
    
    func travelTime(distance: Int) -> Double {
        return Double(distance) / Double(maxSpeed)
    }
    
    
    func compare(to other: Vehicle) -> String {
        return self.maxSpeed > other.maxSpeed ? "\(self.model) быстрее" : "\(other.model) быстрее"
    }
    
    func averageSpeed(stopMinutes: Int, distance: Int) -> Double {
        return Double(distance) / (travelTime(distance: distance) + Double(stopMinutes)/60)
    }
    
}

struct Car: Vehicle {
    var model : String
    var maxSpeed : Int
    var capacity : Int
    var fuelConsumption: Double
    

}

extension Car {
    func description() {
        print("Транспорт: \(model), Макс. скорость: \(maxSpeed) км/ч, Вместимость: \(capacity) чел, Тип топлива: бензин, Примерное время на 100 км: \(travelTime(distance: 100)) ч, Расход топлива: \(fuelConsumption) л/100 км")
    }
    
    func fuelFor(distance: Int) -> Double {
     return fuelConsumption * Double(distance) / 100
    }
}

struct Bicycle: Vehicle {
    var model : String
    var maxSpeed : Int
    var capacity : Int

}

struct Scooter: Vehicle {
    var model : String
    var maxSpeed : Int
    var capacity : Int

    
}

let car = Car(model: "Toyota Camry", maxSpeed: 200, capacity: 5, fuelConsumption: 8.5)
let bike = Bicycle(model: "Giant Escape 3", maxSpeed: 25, capacity: 1)
let scooter = Scooter(model: "Xiaomi M365", maxSpeed: 25, capacity: 1)

let fleet: [Vehicle] = [car, bike, scooter]

for vehicle in fleet {
    vehicle.description()
    print("Средняя скорость на 120 км с остановками 30 мин: \(String(format: "%.2f", vehicle.averageSpeed(stopMinutes: 30, distance: 120))) км/ч")
    if let car = vehicle as? Car {
        print("Расход топлива на 120 км: \(car.fuelFor(distance: 120)) л")
    }
}

print("\nСравнение транспортов по скорости:")

for (i, vehicle) in fleet.enumerated() {
    for otherVehicle in fleet.dropFirst(i + 1) {
        print("\(vehicle.model) vs \(otherVehicle.model): \(vehicle.compare(to: otherVehicle))")
    }
}


