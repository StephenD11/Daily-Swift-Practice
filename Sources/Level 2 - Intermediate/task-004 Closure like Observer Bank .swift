import UIKit

//Задача №17 - тестовая задача работы с банком и замыканием (observer)w


class BankAccount {
    private var balance: Double = 0.0
    var onUpdate: ((Double) -> Void)?
    
    //Инициализатор с заданым сразу стартовым балансом
    init(startBalance: Double = 0) {
        self.balance = startBalance
    }
    
    //Метод пополнения
    func deposit(amount: Double) {
        guard amount > 0 else {
            print("Нельзя положить отрицательную сумму")
            return
        }
        balance += amount
        onUpdate?(balance)   // уведомляем наблюдателя
    }
    
    //Метод снятие
    func withdraw(amount: Double) {
        guard amount > 0 else {
            print("Нельзя снять отрицательную сумму")
            return
        }
        if amount > balance {
            print("Недостаточно средств")
        } else {
            balance -= amount
            onUpdate?(balance) // уведомляем наблюдателя
        }
    }
    
    // метод получения баланса
    func getBalance() -> Double {
        return balance
    }
    
}

let account = BankAccount(startBalance: 100)
account.onUpdate = { newBalance in
    print("Баланс обновлён: \(newBalance)")
}

account.deposit(amount: 50)
account.withdraw(amount: 200)
account.withdraw(amount: 50)
