import UIKit

// Задание №2: “Корзина покупок с итоговыми вычислениями”


struct CartItem {
    var productName: String
    var unitPrice: Double
    var quantity: Int
    var discount: Double?
    
    var totalPrice: Double {
        if let discount = discount {
            return unitPrice * (1 - discount) * Double(quantity)
        } else {
            return unitPrice * Double(quantity)
        }
    }
}

struct Cart {
    var items: [CartItem]
    
    func totalQuantity() -> Int {
        return items.reduce(0) {add, crt in return add + crt.quantity}
    }
    
    func totalSum() -> Double {
        return items.reduce(0) { add, crt in return add + crt.totalPrice }
    }
        
    
    func mostExpensiveItem() -> CartItem? {
        
        /*Первый вариант, через который решил
        var sortedItems: [CartItem] = items.sorted { item1, item2 in return item1.totalPrice > item2.totalPrice }
        return sortedItems[0]
        */
        
        //Улучшил когда проверял. Не создается массив, а просто выдается максимальный объект
        return items.max(by: { item1, item2 in return item1.totalPrice < item2.totalPrice})
        
    }
    
    
    func printReceipt() {
        print("--- Чек ---")
        for item in items {
            print("\(item.productName) x\(item.quantity) - \(item.totalPrice)")

        }
        print("""
        Итого товаров: \(totalQuantity())
        Сумма заказа: \(totalSum())
        Самый дорогой товар: \(mostExpensiveItem()?.productName ?? "Нет товара" ) — \(mostExpensiveItem()?.totalPrice ?? 0)
        ----------------
        
        """)


        
    }
}


let cart = Cart(items: [
    CartItem(productName: "iPhone", unitPrice: 900, quantity: 2, discount: nil),
    CartItem(productName: "T-Shirt", unitPrice: 15, quantity: 3, discount: nil),
    CartItem(productName: "Milk", unitPrice: 1, quantity: 1, discount: nil)
])

cart.printReceipt()


/*
 --- Чек ---
 iPhone x2 — 1800.0
 T-Shirt x3 — 45.0
 Milk x1 — 1.0
 Итого товаров: 6
 Сумма заказа: 1846.0
 Самый дорогой товар: iPhone — 1800.0
 ------------
 */
