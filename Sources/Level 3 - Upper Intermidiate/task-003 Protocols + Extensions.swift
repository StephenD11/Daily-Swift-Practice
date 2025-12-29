import UIKit

//Задача №3 - Календарь - Protocols + extensions

protocol Event {
    var title : String { get }
    var duration : Int { get }
    
    func info()
}

extension Event {
    func info() {
        print("Событие: \(title), Длительность: \(duration) мин")
    }
    
    func endTime(startHour: Int, startMinute: Int) -> (hour: Int, minute: Int) {
        let totalMinutes = startMinute + duration
        let endHours = startHour + totalMinutes / 60
        let endMinutes = totalMinutes % 60
        return (endHours % 24, endMinutes)
    }
    
}



struct Meeting : Event {
    var title : String
    var duration : Int
    var participants: Int
}

extension Meeting {
    func info() {
        print("Событие: \(title), Длительность: \(duration) мин., Количество участников: \(participants)")
    }
    
}

struct Call : Event {
    var title : String
    var duration : Int
    var phoneNumber : String
}

extension Call {
    func info() {
        print("Событие: \(title), Длительность: \(duration) мин., Звонок с номером: \(phoneNumber)")
    }
}

struct Reminder : Event {
    var title : String
    var duration : Int
}

let metting: Meeting = Meeting(title: "Совещание", duration: 90, participants: 5)
let call: Call = Call(title: "Звонок клиенту", duration: 15, phoneNumber: "+7 900 123 45 67")
let reminder: Reminder = Reminder(title: "Принять витамины", duration: 5)

let events: [Event] = [metting, call, reminder]

for event in events {
    event.info()
    
    let end = event.endTime(startHour: 9, startMinute: 30)
    print("Окончание события: \(end.hour):\(String(format: "%02d", end.minute))")
}

/*
 Событие: Совещание, Длительность: 90 мин, Количество участников: 5
 Окончание события: 11:00
 Событие: Звонок клиенту, Длительность: 15 мин, Звонок с номером: +7 900 123 45 67
 Окончание события: 9:45
 Событие: Принять витамины, Длительность: 5 мин
 Окончание события: 9:35
 */
