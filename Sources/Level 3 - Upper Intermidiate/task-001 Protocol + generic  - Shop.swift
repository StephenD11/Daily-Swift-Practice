import UIKit

//Задача №16 - Работа с протоколами

//Протокол корзины
protocol CartManageable {
    associatedtype Item: Sellable
    
    func totalPrice() -> Double
    func totalPriceWithDiscount(percent: Double) -> Double
    func filterByCategory(_ category: String) -> [AnySellable]
}

// Type erasure (чистка типа) для Sellable
struct AnySellable: Sellable {
    let name: String
    let price: Int
    let category: String
    private let _displayInfo: () -> Void
    
    //Задаем generic тип для протокола Sellable
    init<T: Sellable>(_ sellable: T) {
        self.name = sellable.name
        self.price = sellable.price
        self.category = sellable.category
        self._displayInfo = sellable.displayInfo
    }
    
    func displayInfo() {
        _displayInfo()
    }
}

//Базовый протокол для всех вещей
protocol Sellable {
    var name: String { get }
    var price: Int { get }
    var category: String { get }
    
    func displayInfo()
}

//Расширение протокола Sellable
extension Sellable {
    func displayInfo() {
        print("Товар: \(name), Категория: \(category), Цена: \(price)₽")
    }
    
    func applyDiscount(percent: Int) -> Double {
        return Double(price) * (1 - Double(percent)/100)
    }
    
}

struct Book: Sellable {
    var name: String
    var price: Int
    var category: String

}

struct Electronic: Sellable {
    var name: String
    var price: Int
    var category: String
   
    func displayInfo() {
        print("Товар: \(name), Категория: \(category), Цена: \(price)₽, Гарантия: 12 месяцев")
    }
}

struct Clothing: Sellable {
    var name: String
    var price: Int
    var category: String
    
}

let book = Book(name: "Swift для начинающих", price: 1500, category: "Книга")
let phone = Electronic(name: "iPhone 15", price: 120_000, category: "Электроника")
let tshirt = Clothing(name: "Футболка", price: 800, category: "Одежда")
let laptop = Electronic(name: "MacBook Pro", price: 250_000, category: "Электроника")

//Создаем массив с расширеным и очищеным типом AnySellable
let products: [AnySellable] = [
    AnySellable(book),
    AnySellable(phone),
    AnySellable(tshirt),
    AnySellable(laptop)
]


for product in products {
    product.displayInfo()
}

print("Общая сумма: \(products.totalPrice())₽")
print("Общая сумма со скидкой 10%: \(products.totalPriceWithDiscount(percent: 10))₽")

let electronics = products.filterByCategory("Электроника")
print("Электроника в корзине:")
for item in electronics {
    item.displayInfo()
}


//Расширение массива с типом AnySellable 
extension Array: CartManageable where Element == AnySellable {
    typealias Item = Element

    func totalPrice() -> Double {
        return self.reduce(0.0) { add, next in
            add + Double(next.price)
        }
    }
    
    func totalPriceWithDiscount(percent: Double) -> Double {
        return self.totalPrice() * (1 - percent / 100)
    }
    
    func filterByCategory(_ category: String) -> [AnySellable] {
        var filteredArray: [AnySellable] = []
        for item in self {
            if item.category == category {
                filteredArray.append(item)
            }
        }
        return filteredArray
    }
}


/*
 Товар: Swift для начинающих, Категория: Книга, Цена: 1500₽
 Товар: iPhone 15, Категория: Электроника, Цена: 120000₽, Гарантия: 12 месяцев
 Товар: Футболка, Категория: Одежда, Цена: 800₽
 Товар: MacBook Pro, Категория: Электроника, Цена: 250000₽, Гарантия: 12 месяцев
 Общая сумма: 371300₽
 Общая сумма со скидкой 10%: 334170₽
 Электроника в корзине:
 Товар: iPhone 15, Категория: Электроника, Цена: 120000₽, Гарантия: 12 месяцев
 Товар: MacBook Pro, Категория: Электроника, Цена: 250000₽, Гарантия: 12 месяцев
 */
