import UIKit

// Задача №14 - JSON + filter, sorted - поиск нужных клиентов по требованиям

var jsonString: String = """
[
    {"name": "Alex", "email": "alex@mail.com", "phone": null, "bonusCard": {"points": 200, "level": "Silver"}},
    {"name": "Ben", "email": null, "phone": "123456789", "bonusCard": null},
    {"name": "Chris", "email": null, "phone": null, "bonusCard": {"points": 900, "level": "Gold"}},
    {"name": "Dana", "email": "dana@mail.com", "phone": "987654321", "bonusCard": {"points": 500, "level": "Platinum"}}
]
"""

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
            return "\(card.points) points, level: \(card.level)"
        } else {
            return "No bonus card"
        }
    }
}

var jsonData = jsonString.data(using: .utf8)

do {
    var clients = try JSONDecoder().decode([Client].self, from: jsonData!)
    
    var finalWorkWithClients = clients
        .filter {client in return client.bonusCard?.points ?? 0 >= 300}
        .sorted { c1, c2 in return c1.bonusCard?.points ?? 0 < c2.bonusCard?.points ?? 0}
    
    finalWorkWithClients.forEach { client in
        print("\(client.name) - \(client.bonusInfo())")
    }
    
} catch {
    print(error)
}

