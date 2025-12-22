import UIKit

// Задача №9: "JSON Category Parser & Filter"
// Декодируем JSON с категориями и продуктами, фильтруем продукты по наличию и активной скидке, сортируем продукты по цене, а категории — по алфавиту

struct Discount: Codable {
    var percent: Int
    var active: Bool
    
}

struct Product: Codable {
    var title: String
    var price: Double
    var stock: Int
    var tags: [String]?
    var discount: Discount?
    
    // Функция для цены с учётом скидки
    func finalPrice() -> Double {
        let percent = discount?.active == true ? discount!.percent : 0
        let result = price - (price * Double(percent) / 100)
        return result
    }
    
}

struct Category: Codable {
    var categoryName: String
    var products: [Product]
}


var shop: String = """
[
  {
    "categoryName": "Electronics",
    "products": [
      {"title": "Laptop", "price": 1100, "stock": 4, "tags": ["hot", "new"], "discount": {"percent": 10, "active": true}},
      {"title": "Smartphone", "price": 900, "stock": 0, "tags": null, "discount": null},
      {"title": "Headphones", "price": 200, "stock": 10, "tags": ["accessory"], "discount": {"percent": 5, "active": false}}
    ]
  },
  {
    "categoryName": "Home",
    "products": [
      {"title": "Vacuum Cleaner", "price": 300, "stock": 2, "tags": ["home"], "discount": {"percent": 20, "active": true}},
      {"title": "Air Purifier", "price": 450, "stock": 0, "tags": ["home", "eco"], "discount": null}
    ]
  }
]
"""


var jsonData = shop.data(using: .utf8)

do {
    // Декодируем JSON в массив категорий
    let parcedShop = try JSONDecoder().decode([Category].self, from: jsonData!)
    
    // Словарь для хранения продуктов с активной скидкой по категории
    var discountedProducts: [String : [Product]] = [:]

    
    for category in parcedShop {
        // Сортируем продукты внутри категории по финальной цене
        var sortedByPriceProducts = category.products.sorted { p1, p2 in return p1.finalPrice() > p2.finalPrice() }
        
        // Добавляем только те продукты, которые есть в наличии
        for product in sortedByPriceProducts {
            if product.stock > 0 {
                // Если ключа нет, создаётся пустой массив, затем добавляем продукт
                discountedProducts[category.categoryName, default: []].append(product)
            }
        }
    }
    // Сортируем категории по алфавиту
    var categorySort = discountedProducts.sorted { p1, p2 in return p1.key < p2.key }
    
    for category in categorySort {
        print("Category: \(category.key)")
        for product in category.value {
            print("""
                \(product.title) - final: \(product.finalPrice()) (\(product.discount?.active == true ? "\(product.discount!.percent)% off" : "no active discount"))
                """)
        }
        print()
    }
    
} catch {
    print(error)
}

/*
 Category: Electronics
 Laptop — final: 990.0$ (10% off)
 Headphones — final: 200.0$ (no active discount)

 Category: Home
 Vacuum Cleaner — final: 240.0$ (20% off)
 */
