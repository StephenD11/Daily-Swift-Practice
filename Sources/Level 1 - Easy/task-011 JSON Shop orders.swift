import UIKit

//Задача №11 "Заказы из магазина"

var importJSONString: String = """
{
  "orders": [
    {
      "id": 101,
      "customer": "Alice",
      "items": [
        { "name": "iPhone", "price": 999, "quantity": 1 },
        { "name": "Case", "price": 49, "quantity": 2 }
      ],
      "promoCode": "SALE10"
    },
    {
      "id": 102,
      "customer": "Bob",
      "items": [
        { "name": "MacBook", "price": 1999, "quantity": 1 }
      ],
      "promoCode": null
    },
    {
      "id": 103,    
      "customer": "Alice",
      "items": [
        { "name": "AirPods", "price": 199, "quantity": 1 },
        { "name": "Charger", "price": 29, "quantity": 1 }
      ],
      "promoCode": "SALE20"
    }
  ]
}
"""

struct StoreResponse : Codable {
    var orders: [Order]
}

struct Order : Codable {
    var id: Int
    var customer: String
    var items: [Item]
    var promoCode: String?
    
    // Вычисляемое свойство — общая сумма без скидки
    var totalAmount: Double { return items.reduce(0) { result, item in
            result + item.price * Double(item.quantity)
        }}
    
    // Вычисляемое свойство — финальная сумма с промокодом
    var finalAmount: Double {
        if promoCode == "SALE10" {
            return totalAmount * 0.9
        } else if promoCode == "SALE20" {
            return totalAmount * 0.8
        } else {
            return totalAmount
        }
    }
    
    
}

struct Item : Codable {
    var name: String
    var price: Double
    var quantity: Int
}


// Словарь для группировки заказов по клиентам
var groupOrders: [String : [Order]] = [:]

var storeData = importJSONString.data(using: .utf8)

do {
    var store = try JSONDecoder().decode(StoreResponse.self, from: storeData!)
    

    
    // Заполняем словарь: ключ = имя клиента, значение = заказы
    store.orders.forEach { order in
        groupOrders[order.customer, default: []].append(order)
    }
    
    // Сортируем заказы каждого клиента по finalAmount
    groupOrders.forEach { key, orders in
        groupOrders[key] =  orders.sorted { order_1, order_2 in return order_1.finalAmount > order_2.finalAmount }
    }
    
    groupOrders.forEach { key, orders in
        print("Customer: \(key)")
        orders.forEach { order in
            print("Order #\(order.id) - \(String(format: "%.2f", order.finalAmount)) $")
        }
        print()
    }
    
    
    
} catch {
    print(error)
}

//Пример вывода:

/*
 Customer: Alice
 Order #103 — 182.4
 Order #101 — 988.2

 Customer: Bob
 Order #102 — 1999
 */


//Обратное кодирование

/*
do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let jsonData = try encoder.encode(groupOrders)
    
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
} catch {
    print("Error with encoding: \(error)")
}
*/
