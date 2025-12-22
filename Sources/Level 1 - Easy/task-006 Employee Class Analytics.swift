import UIKit

// Задания №6
// Создаём класс сотрудника с методами подсчёта суммарных и средних продаж, фильтруем сотрудников по активности и среднему показателю, группируем по департаментам и находим топ сотрудника


class Employee {
    var id: Int
    var name: String
    var department: String
    var monthlySales: [Double]
    var isActive: Bool
    
    init(id: Int, name: String, department: String, monthlySales: [Double], isActive: Bool) {
        self.id = id
        self.name = name
        self.department = department
        self.monthlySales = monthlySales
        self.isActive = isActive
    }
    
    func totalSales() -> Double {
        return monthlySales.reduce(0) {add, money in return add + money}
    }
    
    func averageSales() -> Double {
        return totalSales() / Double(monthlySales.count)
    }
    
    func info() -> String {
        return "Employee \(name) (dept: \(department)), total sales: \(totalSales()), average: \(averageSales())"
    }
}

func topPerformers(_ employees: [Employee], _ minAverage: Double) {
    
    //Фильтруем массив
    var filteredEmp: [Employee] = employees.filter { emp in return emp.isActive && emp.averageSales() >= minAverage }
    
    //Создаем словарь с категориями по работникам
    var dictEmp: [String : [Employee]] = [:]

    for emp in filteredEmp {
        dictEmp[emp.department, default: []].append(emp)
    }
    
    for (dep, emps) in dictEmp {
        print("Departmnet: \(dep)")
        
        var topPerformerInDep: Employee? = emps.max(by: { emp1, emp2 in emp1.totalSales() < emp2.totalSales() })
        
        for emp in emps {
            print("\(emp.info())")
        }
        
        print("Total department sales: \(topPerformerInDep?.totalSales() ?? 0), average: \(topPerformerInDep?.averageSales() ?? 0)")
        print()
    }
    
    
    
    //Находим топ сотрудника
    var topPerformer: Employee? = filteredEmp.max(by: { emp1, emp2 in return emp1.totalSales() < emp2.totalSales()})
    print("Top performer overall: \(topPerformer?.name ?? "Неизвестно") (total sales: \(topPerformer?.totalSales() ?? 0))")
    
}


let employees = [
    Employee(id: 1, name: "Alice", department: "Sales", monthlySales: [5000, 7000, 6000], isActive: true),
    Employee(id: 2, name: "Bob", department: "Sales", monthlySales: [3000, 4000, 3500], isActive: true),
    Employee(id: 3, name: "Chris", department: "Marketing", monthlySales: [8000, 9000, 8500], isActive: true),
    Employee(id: 4, name: "Dana", department: "Marketing", monthlySales: [2000, 2500, 2200], isActive: false),
    Employee(id: 5, name: "Eve", department: "Support", monthlySales: [1000, 1200, 1100], isActive: true)
]


topPerformers(employees, 5000)

/*
 Department: Sales
 Employee Alice (dept: Sales), total sales: 18000, average: 6000
 Total department sales: 18000, average: 6000

 Department: Marketing
 Employee Chris (dept: Marketing), total sales: 25500, average: 8500
 Total department sales: 25500, average: 8500

 Top performer overall: Chris (total sales: 25500)
 */
