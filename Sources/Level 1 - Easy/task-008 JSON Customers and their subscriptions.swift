import UIKit

let users = """
[
    {"username": "alex", "email": "alex@mail.com", "age": 25, "subscription": {"type": "Premium", "expiresInDays": 40}},
    {"username": "ben", "email": null, "age": 17, "subscription": null},
    {"username": "chris", "email": "chris@mail.com", "age": 32, "subscription": {"type": "Basic", "expiresInDays": 5}},
    {"username": "dana", "email": "dana@mail.com", "age": 40, "subscription": {"type": "Premium", "expiresInDays": 2}},
    {"username": "eva", "email": null, "age": 19, "subscription": {"type": "Basic", "expiresInDays": 90}}
]
"""

struct Subscription: Codable {
    var type: String
    var expiresInDays: Int
}

struct User: Codable {
    var username: String
    var email: String?
    var age: Int
    var subscription: Subscription?
}

func makeSomething(_ users: String) {
    
    var jsonData = users.data(using: .utf8)
    
    do {
        
        var subLevel: [String:Int] = ["Premium" : 1, "Basic" : 0]
        
        let usersArray = try JSONDecoder().decode([User].self, from: jsonData!)
        
        var filteredUsers: [User] = usersArray.filter { client in return client.subscription != nil && client.subscription!.expiresInDays < 10}
        
        var sortedUsers: [User] = filteredUsers.sorted { u1, u2 in
            
            if subLevel[u1.subscription!.type] != subLevel[u2.subscription!.type] {
                return subLevel[u1.subscription!.type]! > subLevel[u2.subscription!.type]!
            } else {
               return  u1.age > u2.age
            }
        }
        
        for user in sortedUsers {
            print("User: \(user.username) | Subscription: \(user.subscription!.type) | Expires in: \(user.subscription!.expiresInDays) days")
        }
        
        
    } catch {
        print(error)
    }
    
}

makeSomething(users)

/*
 User: dana | Subscription: Premium | Expires in: 2 days
 User: chris | Subscription: Basic | Expires in: 5 days
 */
