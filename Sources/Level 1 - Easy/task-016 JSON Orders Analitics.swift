import UIKit

//Задание №15 - JSON +


var jsonString: String = """
[
  {
    "id": 101,
    "customer": "Alex",
    "items": [
      { "name": "iPhone", "price": 900, "quantity": 2 },
      { "name": "Case", "price": 30, "quantity": 1 }
    ]
  },
  {
    "id": 102,
    "customer": "Ben",
    "items": [
      { "name": "MacBook", "price": 2000, "quantity": 1 }
    ]
  },
  {
    "id": 103,
    "customer": "Chris",
    "items": [
      { "name": "Keyboard", "price": 120, "quantity": 1 },
      { "name": "Mouse", "price": 80, "quantity": 1 }
    ]
  }
]
"""

struct Order: Codable {
    var id: Int
    var customer: String
    var items:  [OrderItem]
    
    var totalSum: Double {
        items.reduce(0.0) { add, item in return add + item.price * Double(item.quantity) }
    }
}

struct OrderItem: Codable {
    var name: String
    var price: Double
    var quantity: Int
    

}


var jsonData = jsonString.data(using: .utf8)

do {
    var orders = try JSONDecoder().decode([Order].self, from: jsonData!)
        
    let filteredOrders = orders
        .filter { order in return order.totalSum > 1000 }
        .sorted { o1, o2 in return o1.totalSum > o2.totalSum }
    
    for order in filteredOrders {
        print("Order \(order.id) (\(order.customer)) — total: \(order.totalSum)")
    }
    
} catch {
    print(error)
}
