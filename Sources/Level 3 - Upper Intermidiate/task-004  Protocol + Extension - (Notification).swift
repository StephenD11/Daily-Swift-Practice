import UIKit

//Задача №4 - Работа с Protocol + Extension - (Уведомления)

protocol Notification {
    var message : String { get }
    var priority : Int { get }
    
    func display()
}

//Расширение для основного протокола
extension Notification {
    
    func display() {
        print("Уведомление: \(message), Приоритет: \(priority)")
    }
    
    func isHighPriority() -> Bool{
        return priority >= 4
    }
}
//Добавляем расширение для массива объектов наследованных от Notification
extension Array where Element == any Notification {
    
    //Фильтруем объекты что больше или равны минимальному приоритету
    func filterByPriority(minPriority: Int) ->  [Notification] {
        return self.filter { item in return item.priority >= minPriority}
    }
    
    //Возвращает массив, отсортированный по приоритету от высокого к низкому
    func sortByPriority() -> [Notification] {
        return self.sorted { item_1, item_2 in return item_1.priority > item_2.priority }
    }
    
    //Возвращает словарь [String: [Notification]], где ключ — имя типа (PushNotification, EmailNotification, SMSNotification), а значение — массив уведомлений этого типа
    func groupByType() -> [String: [Notification]] {
        var groupedDict: [String : [Notification]] = [:]
        
        for item in self {
            let typeName = String(describing: type(of: item))
            groupedDict["\(typeName)", default: []].append(item)
        }
        
        return groupedDict
    }
}


struct PushNotification : Notification{
    var message : String
    var priority : Int
    var icon : String
    
    func display() {
        print("Уведомление: \(message), Приоритет: \(priority), Иконка: \(icon)")
    }
}



struct EmailNotification : Notification{
    var message : String
    var priority : Int
    var subject : String
    
    func display() {
        print("Уведомление: \(message), Приоритет: \(priority), Тема: \(subject)")
    }
}


struct SMSNotification : Notification{
    var message : String
    var priority : Int
}



let push = PushNotification(message: "Новое сообщение", priority: 5, icon: "📩")
let email = EmailNotification(message: "Ваш заказ отправлен", priority: 3, subject: "Информация о заказе")
let sms = SMSNotification(message: "Код подтверждения: 1234", priority: 4)

//Список с объектами подписанными на протокол Notification
let notifications: [Notification] = [push, email, sms]

// Фильтрация
let highPriority = notifications.filterByPriority(minPriority: 4)
print("Высокий приоритет:")
for n in highPriority {
    n.display()
}

// Сортировка
let sorted = notifications.sortByPriority()
print("\nСортировка по приоритету:")
for n in sorted {
    n.display()
}

// Группировка
let grouped = notifications.groupByType()
print("\nГруппировка по типу:")
for (type, group) in grouped {
    print("\(type):")
    for n in group {
        n.display()
    }
}
