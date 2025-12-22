import UIKit

//Задания №7
//Парсим массив клиентов из JSON, фильтруем по бонусной карте и минимальному количеству баллов, сортируем по количеству бонусов и выводим информацию

struct BonusCard: Codable {
    var points: Int
    var level: String
}

struct Client: Codable {
    var name: String
    var email: String?
    var phone: String?
    var bonusCard: BonusCard?
    
    func bonusInfo() -> String {
        if let card = bonusCard {
            return "\(self.name) - \(card.points) points, level: \(card.level)"
        } else {
            return "No bonus card"
        }
    }
}


let jsonString = """
    [
        {"name": "Alex", "email": "alex@mail.com", "phone": null, "bonusCard": {"points": 200, "level": "Silver"}},
        {"name": "Ben", "email": null, "phone": "123456789", "bonusCard": null},
        {"name": "Chris", "email": null, "phone": null, "bonusCard": {"points": 900, "level": "Gold"}},
        {"name": "Dana", "email": "dana@mail.com", "phone": "987654321", "bonusCard": {"points": 500, "level": "Platinum"}}
    ]    
    """

let jsonData = jsonString.data(using: .utf8)!

do {
    let clients = try JSONDecoder().decode([Client].self, from: jsonData)
    
    var specialClients: [Client] = clients
        .filter { client in return client.bonusCard?.points ?? 0 >= 300 }
        .sorted { c1, c2 in return c1.bonusCard?.points ?? 0 > c2.bonusCard?.points ?? 0 }
    
    for client in specialClients {
        print(client.bonusInfo())
    }
    
    
} catch {
    print("Error parsing JSON:", error)
}



/*
 Chris — 900 points, level: Gold
 Dana — 500 points, level: Platinum
 */
