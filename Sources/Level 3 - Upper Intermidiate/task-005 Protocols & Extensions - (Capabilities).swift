import UIKit

//Задача №5 - Capability-based design

protocol Attackable {
    var attackPower: Int { get }
}

extension Attackable {
    func attack() {
        print("Атака с силой \(attackPower)")
    }
}

//------------//

protocol Healable {
    var healPower: Int { get }
}

extension Healable {
    func heal() {
        print("Лечение на \(healPower) HP")
    }
}

//------------//

protocol Defendable {
    var armor: Int { get }
}

extension Defendable {
    func defend() {
        print("Защита с броней \(armor)")
    }
}

//------------//


struct Warrior : Attackable, Defendable {
    var attackPower: Int
    var armor: Int

}

struct Mage : Attackable, Healable {
    var attackPower: Int
    var healPower: Int
    
}

struct Healer : Healable {
    var healPower: Int
}


let warrior = Warrior(attackPower: 30, armor: 20)
let mage = Mage(attackPower: 25, healPower: 15)
let healer = Healer(healPower: 40)

warrior.attack()
warrior.defend()

mage.attack()
mage.heal()

healer.heal()
