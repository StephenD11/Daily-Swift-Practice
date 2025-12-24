import UIKit

//Задача №18 тестовая задача работы с TodoList и замыканием (observer)

enum TodoAction {
    case add(String)
    case remove(String)
    case getAll
}

class TodoList {
    private var tasks: [String] = []
    var onUpdate: ((TodoAction, [String]) -> Void)?
    
    
    init(tasks: [String] = []) {
        self.tasks = tasks
    }
    
    
    func add(task: String) {
        guard task != "" else {
            print("Задача не можем быть без имени")
            return
        }
        
        tasks.append(task)
        onUpdate?(.add(task), tasks)
    }
    
    func remove(task: String) {
        guard tasks.contains(task) else {
            print("Задачу '\(task)' нельзя удалить так как ее нет в списке")
            return
        }
        
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
            onUpdate?(.remove(task), tasks)
        }
    }
    
    
    func getAllTasks() {
        onUpdate?(.getAll, tasks)
    }
    
}

var newTask: TodoList? = TodoList(tasks: ["Идти на работу", "Сходить в аптеку"])

newTask?.onUpdate = { action, tasks in
    switch action {
    case .add(let task):
        print("Добавлена задача: \(task). Список: \(tasks)")
    case .remove(let task):
        print("Удалена задача: \(task). Список: \(tasks)")
    case .getAll :
    print("Текущий список задач: \(tasks)")
    }
}

newTask?.add(task:"Доделать список")
newTask?.remove(task: "Уехать из города")
newTask?.remove(task: "Доделать список")
newTask?.getAllTasks()
