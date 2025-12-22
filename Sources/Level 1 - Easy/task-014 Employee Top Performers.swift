import UIKit

class Employee {
    var id: Int
    var name: String
    var department: String
    var monthlySales: [Double]
    var isActive: Bool
    
    init(id:Int, name: String, department: String, monthlySales: [Double], isActive: Bool) {
        self.id = id
        self.name = name
        self.department = department
        self.monthlySales = monthlySales
        self.isActive = isActive
    }
    
    func totalSales() -> Double {
        return monthlySales.reduce(0) {add, num in return add + num}
    }
    
    func averageSales() -> Double {
        return self.totalSales() / Double(monthlySales.count)
    }
    
    func info() {
        print("Employee \(name) (dept: \(department), total sales: \(totalSales()), average: \(averageSales())")
    }
    
}

func updateTopPerformer(_ employee: Employee, topPerformer: inout Employee?) {
    if topPerformer == nil || employee.totalSales() > topPerformer!.totalSales() {
        topPerformer = employee
    }
}

func workingWithEmployess(_ employees: [Employee], _ minAverage: Double ) {
    
    var groupedDeparts: [String: [Employee]] = [:]
    var topPerformer: Employee? = nil
    
    for employee in employees.filter({ emp in return emp.isActive && emp.averageSales() > minAverage}) {
        groupedDeparts[employee.department, default: []].append(employee)
        
        updateTopPerformer(employee, topPerformer: &topPerformer)
    }
    
    for (depName, depEmpl) in groupedDeparts {
        print("Department: \(depName)")
        var sumDep: Double = 0
        
        for employee in depEmpl {
            sumDep += employee.totalSales()
            employee.info()
        }
        print("Total department sales: \(sumDep), average: \(sumDep / Double(depEmpl.count))\n")
    }
    
    if let top = topPerformer {
        print("Top performer overall: \(top.name) (total sales: \(top.totalSales()))")
    } else {
        print("Top performer overall: don't exist")
    }
    
    
}

let employees = [
    Employee(id: 1, name: "Alice", department: "Sales", monthlySales: [5000, 7000, 6000], isActive: true),
    Employee(id: 2, name: "Bob", department: "Sales", monthlySales: [3000, 4000, 3500], isActive: true),
    Employee(id: 3, name: "Chris", department: "Marketing", monthlySales: [8000, 9000, 8500], isActive: true),
    Employee(id: 4, name: "Dana", department: "Marketing", monthlySales: [2000, 2500, 2200], isActive: false),
    Employee(id: 5, name: "Eve", department: "Support", monthlySales: [1000, 1200, 1100], isActive: true)
]

workingWithEmployess(employees, 1000)

/* Пример вывода
 
 Department: Sales
 Employee Alice (dept: Sales), total sales: 18000, average: 6000
 Total department sales: 18000, average: 6000

 Department: Marketing
 Employee Chris (dept: Marketing), total sales: 25500, average: 8500
 Total department sales: 25500, average: 8500

 Top performer overall: Chris (total sales: 25500)
 */
