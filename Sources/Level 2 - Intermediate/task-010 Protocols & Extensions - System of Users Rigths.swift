import UIKit

//Задача №6: Protocols + Extenions - Система пользователей и прав доступа


protocol User {
    var name: String { get }
    var accessLevel: Int { get }
    
    func description()
}

extension User {
    func description() {
        print("Пользователь: \(name), Уровень доступа: \(accessLevel)")
    }
    
    func canEdit() -> Bool {
        accessLevel >= 2
    }
}

struct Guest : User {
    var name: String
    var accessLevel: Int = 1
    
}

struct RegularUser : User {
    var name: String
    var accessLevel: Int = 2
    var postsCount: Int
    
    func description() {
        print("Пользователь: \(name), Уровень доступа: \(accessLevel), Количество постов: \(postsCount)")
    }
    
}

struct Admin : User {
    var name: String
    var accessLevel: Int = 3
    var permissions: [String]
    
    func description() {
        let permissionsString = permissions.joined(separator: ", ")
        print("Пользователь: \(name), Уровень доступа: \(accessLevel), Права: \(permissionsString)")
    }
    
}

let guest = Guest(name: "Аноним")
let user = RegularUser(name: "Степа", postsCount: 12)
let admin = Admin(name: "Root", permissions: ["ban_users", "delete_posts", "edit_settings"])

let users: [User] = [guest, user, admin]

for user in users {
    user.description()
    print("Может редактировать: \(user.canEdit())\n")
}

//Ожидаемый вывод
/*
 Пользователь: Аноним, Уровень доступа: 1
 Может редактировать: false

 Пользователь: Степа, Уровень доступа: 2, Количество постов: 12
 Может редактировать: true

 Пользователь: Root, Уровень доступа: 3, Права: ban_users, delete_posts, edit_settings
 Может редактировать: true
 */
