import UIKit

enum VehicleType {
    case bike
    case scooter
    case car
    case van
}


struct Vehicle: Equatable {
    var id: Int
    var type: VehicleType
    var maxLoad: Double
    var isAvailable: Bool
    var mileage: Int
    var rating: Double?
    
    func info() -> String {
        return "ID \(id) — \(type), load \(maxLoad)kg, mileage \(mileage)km, rating \(rating!)"
    }
}

//Функция фильтрующая объекты по доступу и макс. нагрузке и сортирующая их сначала по типу, рейтингу, пробегу
func filterFleet(_ fleet: [Vehicle], minLoad: Double) {
    
    var levelsVehicle: [VehicleType : Int] = [.van : 3, .car : 2, .scooter : 1, .bike : 0]
    
    var filteredFleet: [Vehicle] = fleet.filter { fleet in return fleet.isAvailable && fleet.maxLoad >= minLoad}
    
    var sortedFleet: [Vehicle] = filteredFleet.sorted { f1, f2 in
        if f1.type != f2.type {
            return levelsVehicle[f1.type]! > levelsVehicle[f2.type]!
        } else if f1.rating != f2.rating {
            return f1.rating ?? 0 > f2.rating ?? 0
        } else {
            return f1.mileage > f2.mileage
        }
    }
    
    for fleet in sortedFleet {
        print(fleet.info())
    }
    
    print("""
        ---
                    
        Не подходят:
        """)
          
    for check in fleet {
        if !sortedFleet.contains(check) {
            print("ID \(check.id) - \(check.type)")
        }
    }
    
    print("""
          ---
          
          Подходит: \(sortedFleet.count)
          Минимальный пробег: \(sortedFleet.min(by: { f1, f2 in return f1.mileage < f2.mileage  })?.mileage ?? 0)
          Максимальная грузоподъёмность: \((sortedFleet.max(by: { f1, f2 in return f1.maxLoad < f2.maxLoad  })?.maxLoad ?? 0))
          """)
}


let fleet = [
    Vehicle(id: 1, type: .car, maxLoad: 250, isAvailable: true, mileage: 12000, rating: 4.5),
    Vehicle(id: 2, type: .bike, maxLoad: 20, isAvailable: true, mileage: 4000, rating: nil),
    Vehicle(id: 3, type: .van, maxLoad: 600, isAvailable: false, mileage: 50000, rating: 4.9),
    Vehicle(id: 4, type: .scooter, maxLoad: 35, isAvailable: true, mileage: 8000, rating: 4.8),
    Vehicle(id: 5, type: .van, maxLoad: 700, isAvailable: true, mileage: 30000, rating: 4.7)
]


filterFleet(fleet, minLoad:40)

/*
 ID 5 — van, load 700kg, mileage 30000km, rating 4.7
 ID 1 — car, load 250kg, mileage 12000km, rating 4.5
 ---

 Не подходят:
 ID 2 — bike (мало грузоподъёмности)
 ID 3 — van (недоступен)
 ID 4 — scooter (мало грузоподъёмности)
 ---

 Подходит: 2
 Минимальный пробег: 12000
 Максимальная грузоподъёмность: 700
 */
