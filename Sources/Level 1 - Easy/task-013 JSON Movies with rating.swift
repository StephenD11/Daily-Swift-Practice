import UIKit

var jsonString: String = """
[
  {
    "title": "Inception",
    "year": 2010,
    "genres": ["Action", "Sci-Fi"],
    "ratings": [
      {"user": "Alice", "score": 9},
      {"user": "Bob", "score": 8}
    ]
  },
  {
    "title": "The Matrix",
    "year": 1999,
    "genres": ["Action", "Sci-Fi"],
    "ratings": [
      {"user": "Chris", "score": 10},
      {"user": "Dana", "score": 9}
    ]
  },
  {
    "title": "Titanic",
    "year": 1997,
    "genres": ["Romance", "Drama"],
    "ratings": [
      {"user": "Eva", "score": 8},
      {"user": "Frank", "score": 7}
    ]
  }
]
"""

struct Rating : Codable {
    var user: String
    var score: Int
}

struct Movie : Codable {
    var title: String
    var year: Int
    var genres: [String]
    var ratings: [Rating]
    
    //Средняя оценка по фильму
    var averageScore: Double {
        let total = ratings.reduce(0) { sum, rating in sum + rating.score }
        return Double(total) / Double(ratings.count)
    }
    
    //Пользователь поставил наивысшую оценку
    var topUser: String {
        return ratings.max(by: { r1, r2 in return r1.score > r2.score  })?.user ?? "No ratings"
    }
}

var jsonData = jsonString.data(using: .utf8)
var encodeMovies: [Movie] = []

do {
    var movies = try JSONDecoder().decode([Movie].self, from: jsonData!)
    
    //Фильтруем фильм если в их жанрах есть Action
    var filteredMovies: [Movie] = movies.filter { movie in return movie.genres.contains("Action")}
    
    //Сортируем фильм по среднему рейтингу
    var sortedMoviesAverage: [Movie] = filteredMovies.sorted { movie1, movie2 in return movie1.averageScore > movie2.averageScore }
    
    //Выводим в консоль полученные данные
    for movie in sortedMoviesAverage {
        print("""
              Movie: \(movie.title) - Year: \(movie.year)  - Genres: \(movie.genres) - Rating: \(movie.averageScore)")
              Top User by rating: \(movie.topUser) with rating: 
              
              """
    )}
    
    
    movies.forEach { movie in
        if movie.averageScore > 8.5 {
            print("Movie \(movie.title) score - \(movie.averageScore) more than 8.5")
            print()
        }
    }
    
    
    

    //Если фильм был выпущен ранее 2000 года, добавляем 20 лет (по заданию так было 🤷‍♂️)
    movies = movies.map { movie in
        var updatedMovie = movie
        if updatedMovie.year < 2000 {
            updatedMovie.year += 20
        }
        return updatedMovie
    }
    
    //Присваевыем глобальному свойству значение изменных данных
    encodeMovies = movies
    print()
    
} catch {
    print(error)
}


//Кодируем обратно
do {
    var encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted]
    
    var jsonData = try encoder.encode(encodeMovies)
    
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
    
} catch {
    print("Encoding error \(error)")
}
