import UIKit

//Задача №12 "Книжный магазин" - Тренировка работы с JSON декодированием и обратным кодированием

var jsonString: String = """
[
  {
    "title": "The Swift Programming Language",
    "author": "Apple Inc.",
    "pages": 500,
    "genres": ["Programming", "Swift"],
    "isBorrowed": false
  },
  {
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "pages": 464,
    "genres": ["Programming", "Best Practices"],
    "isBorrowed": true
  },
  {
    "title": "1984",
    "author": "George Orwell",
    "pages": 328,
    "genres": ["Dystopia", "Fiction"],
    "isBorrowed": false
  },
  {
    "title": "Harry Potter and the Sorcerer's Stone",
    "author": "J.K. Rowling",
    "pages": 309,
    "genres": ["Fantasy", "Adventure"],
    "isBorrowed": true
  }
]
"""

struct Book : Codable {
    var title: String
    var author: String
    var pages: Int
    var genres: [String]
    var isBorrowed: Bool
    
    var shortDescription: String {
        "\(title) by \(author), \(pages) pages"
    }
    
}

var jsonData = jsonString.data(using: .utf8)

var makeBorrowed: [Book] = []

do {
    var bookStore = try JSONDecoder().decode([Book].self, from: jsonData!)
    
    var filteredBooks: [Book] = bookStore
        .filter { book in book.isBorrowed }
        .sorted { book1, book2 in return book1.pages < book2.pages }
    
    filteredBooks.forEach { book in
        print(book.shortDescription)
    }
    
    print()
    
    //Задаем массиву иземенненые данные
    makeBorrowed = bookStore.map {book in
        var mutableBook = book
        if !mutableBook.isBorrowed {
            mutableBook.isBorrowed.toggle()
            print("\(book.title) - \(book.author) change status")
        }
        return mutableBook
    }
    
} catch {
    print("Error: \(error)")
}

//Кодируем обратно после изменнеий
do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    let jsonData = try encoder.encode(makeBorrowed)
    
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
} catch {
    print("Error with encoding: \(error)")
}
