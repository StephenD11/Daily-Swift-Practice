import UIKit

//Задача №1 “Умный магазин — продвинутый фильтр товаров”

enum ProductType {
    case electronics
    case clothes
    case grocery
    case sport
    case toys
}

struct Product {
    var name: String
    var type: ProductType
    var price: Double
    var discount: Double?
    var inStock: Bool
    
    //Вычисление скидки
    func finalPrice() -> Double {
        if let discount = discount {
            return price * (1 - discount)
        } else {
            return price
        }
    }
}

func processProducts(_ products: [Product], _ minPrice: Double) -> Void {
    
    //Общая цена
    var allPrice: Double = 0
    
    // Товары которые в наличии
    var inStockProducts: [Product] = products.filter {product in return product.inStock && product.finalPrice() >= minPrice}
    
    //Словарь где ключи категории продукта
    var productDict: [ProductType: [Product]] = [:]
    
    //Добавление продуктов в массив словаря
    for product in inStockProducts {
        productDict[product.type, default: []].append(product)
    }
    
    //Сортировка словаря сначала по цене продукта, если цена одинаковая то сортировка по имени
    for (key, value) in productDict {
        let sortedProducts = value.sorted {prod1, prod2 in
            if prod1.finalPrice() != prod2.finalPrice() {
                return prod1.finalPrice() > prod2.finalPrice()
            } else {
                return prod1.name > prod2.name
            }
        }
        productDict[key] = sortedProducts
    }
    
    
    //Красивый вывод (ну почти 😅)
    for numberOfType in productDict {
        
        var categorySum: Double = 0
        
        print("Категория: \(numberOfType.key)")

        for  product in numberOfType.value {
            categorySum += product.finalPrice()
            print("\(product.name) — \(product.finalPrice())")
        }
        print("Сумма категории: \(categorySum)")
        allPrice += categorySum
        print()

    }

    print("Общая сумма: \(allPrice) ")
    
}


let items = [
    Product(name: "iPhone", type: .electronics, price: 1200, discount: 0.1, inStock: true),
    Product(name: "TV", type: .electronics, price: 800, discount: nil, inStock: true),
    Product(name: "T-Shirt", type: .clothes, price: 25, discount: 0.2, inStock: true),
    Product(name: "Bread", type: .grocery, price: 2.5, discount: nil, inStock: true),
    Product(name: "Milk", type: .grocery, price: 1.5, discount: 0.1, inStock: false),
    Product(name: "Basketball", type: .sport, price: 30, discount: 0.3, inStock: true)
]



processProducts(items, 0)


//Результат который должен получится по задаче

/*
 Категория: electronics
 TV — 800.0
 iPhone — 1080.0
 Сумма категории: 1880.0

 Категория: clothes
 T-Shirt — 20.0
 Сумма категории: 20.0

 Категория: grocery
 Bread — 2.5
 Сумма категории: 2.5

 Категория: sport
 Basketball — 21.0
 Сумма категории: 21.0

 Общая сумма: 1923.5
 */
