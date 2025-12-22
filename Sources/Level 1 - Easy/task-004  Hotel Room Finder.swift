import UIKit

//Задача №4 "Бронирование номеров в отеле"

struct HotelRoom: Equatable{
    var number: Int
    var capacity: Int
    var pricePerNight: Double
    var isAvailable: Bool
    var rating: Double?
    
    func info() -> String {
        
        return "Комната \(number): \(capacity) места, цена \(pricePerNight)$, рейтинг \(rating ?? 0)"
    }
}


//Функция фильтрует, сортирует и выводит доступные комнаты и те комнаты которые не подходят
func filterRooms(_ rooms: [HotelRoom], minCapacity: Int, maxPrice: Double) {
    
    var filteredRooms: [HotelRoom] = rooms.filter { room in return room.isAvailable && room.capacity >= minCapacity &&  room.pricePerNight <= maxPrice }
    
    
    var sortedRooms: [HotelRoom] = filteredRooms.sorted { r1, r2 in
        if r1.capacity != r2.capacity {
            return r1.capacity < r2.capacity
        } else {
            return r1.rating ?? 0 > r2.rating ?? 0
        }
    }
    
    for room in sortedRooms {
        print(room.info())
    }
    
    for room in rooms {
        if !sortedRooms.contains(room) {
            print("Комната \(room.number) - не подходит")
        }
    }
    
    print("""
        
        Итого доступных подходящих номеров: \(sortedRooms.count)
        Минимальная цена: \(sortedRooms.min(by: { r1, r2 in return r1.pricePerNight < r2.pricePerNight })?.pricePerNight ?? 0)$
        
        """)
    
}

let rooms = [
    HotelRoom(number: 101, capacity: 2, pricePerNight: 80, isAvailable: true, rating: 4.5),
    HotelRoom(number: 102, capacity: 1, pricePerNight: 60, isAvailable: true, rating: nil),
    HotelRoom(number: 103, capacity: 3, pricePerNight: 120, isAvailable: false, rating: 5.0),
    HotelRoom(number: 201, capacity: 2, pricePerNight: 90, isAvailable: true, rating: 4.8),
    HotelRoom(number: 202, capacity: 4, pricePerNight: 200, isAvailable: true, rating: 5.0)
]

filterRooms(rooms, minCapacity: 2, maxPrice: 150)

/*
 Комната 101: 2 места, цена 80.0$, рейтинг 4.5
 Комната 201: 2 места, цена 90.0$, рейтинг 4.8
 Комната 202: 4 места, цена 200.0$ — не подходит (цена выше maxPrice, поэтому не попадёт)
 Комната 102 — не подходит (capacity < 2)
 Комната 103 — не подходит (isAvailable == false)

 Итого доступных подходящих номеров: 2
 Минимальная цена: 80.0$
 */
