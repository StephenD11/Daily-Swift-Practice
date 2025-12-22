import UIKit

// Задача №3 “Заказы в кафе с фильтром и подсчётом”

struct OrderItem {
    var name: String
    var price: Double
    var quantity: Int
    
    var totalPrice: Double {
        return price * Double(quantity)
    }
    
    func info() -> String {
        return "\(name) — \(quantity) шт., цена: \(totalPrice)"
    }
}


struct Order {
    var id: Int
    var tableNumber: Int
    var items: [OrderItem]
    var status: String
    
    //Общее количество заказанного
    func totalQuantity() -> Int { return items.reduce(0) {add, item in return add + item.quantity} }
    
    //Общая сумма заказанного
    func totalSum() -> Double { return items.reduce(0) {add, item in return add + item.totalPrice} }
    
    //Самое дорогое из заказанного
    func mostExpensiveItem() -> OrderItem? {
        return items.max(by: { item1, item2 in return item1.totalPrice < item2.totalPrice})
    }
    
}
//Функция получает список заказов и фильтрует по статусу, считая общую сумму и колличество заказанного
func processOrders(_ orders: [Order], _ status: String) {
    
    var sortedOrders: [Order] =  orders.filter { order in return order.status == status
        }
        
    let total = sortedOrders.reduce(0) { add, order in
            add + order.totalSum()
        }
        
    for order in sortedOrders {

    print("""
        Заказ №\(order.id), столик \(order.tableNumber)
        Количество товаров: \(order.totalQuantity())
        Сумма заказа: \(order.totalSum())
        Самый дорогой товар: \(order.mostExpensiveItem()?.name ?? "Нет") — \(order.mostExpensiveItem()?.quantity ?? 0) шт., цена: \(order.mostExpensiveItem()?.totalPrice ?? 0)
                
        """)
        }
        print("Итоговая сумма всех выбранных заказов: \(total)")

}


let orders = [
    Order(id: 101, tableNumber: 1, items: [
        OrderItem(name: "Latte", price: 4.5, quantity: 2),
        OrderItem(name: "Croissant", price: 2.0, quantity: 3)
    ], status: "new"),
    Order(id: 102, tableNumber: 2, items: [
        OrderItem(name: "Espresso", price: 3.0, quantity: 1),
        OrderItem(name: "Muffin", price: 2.5, quantity: 2)
    ], status: "served"),
    Order(id: 103, tableNumber: 3, items: [
        OrderItem(name: "Cappuccino", price: 4.0, quantity: 1),
        OrderItem(name: "Bagel", price: 3.0, quantity: 2)
    ], status: "new")
]

processOrders(orders, "new")

/*
 Заказ №101, столик 1
 Количество товаров: 5
 Сумма заказа: 15.0
 Самый дорогой товар: Latte — 2 шт., цена: 9.0
 ---

 Заказ №103, столик 3
 Количество товаров: 3
 Сумма заказа: 10.0
 Самый дорогой товар: Bagel — 2 шт., цена: 6.0
 ---

 Итоговая сумма всех выбранных заказов: 25.0
 */
