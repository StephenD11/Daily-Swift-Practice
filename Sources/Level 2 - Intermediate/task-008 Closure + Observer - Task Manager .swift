import UIKit

// Задача №21: Работа с Closure и Observer в классах

enum TaskEvent {
    case added(String)
    case completed(String)
    case removed(String)
    case listUpdated([String])
}

class TaskManager {
    private var tasks: [String]
    private var completedTasks: [String]
    var onEvent: ((TaskEvent) -> Void)?
    
    init(tasks: [String] = [], completedTasks: [String] = []) {
        self.tasks = tasks
        self.completedTasks = completedTasks
    }
    
    private func removeTaskFrom(_ array: inout [String], task: String) -> Bool {
        guard let index = array.firstIndex(of: task) else {
            return false
        }
        
        array.remove(at: index)
        return true
    }
    
    func addTask(_ task: String) {
        guard task != "" && !tasks.contains(task) else {
            print("Ошибка добавления. Либо задача пуста либо уже находится в списке задач")
            return
        }
        
        tasks.append(task)
        onEvent?(.added(task))
        onEvent?(.listUpdated(tasks))
    }
    
    func completeTask(_ task: String) {
        guard removeTaskFrom(&tasks, task: task) else {
                print("Задачи \(task) нет в списке задач")
                return
            }
        
        completedTasks.append(task)
        
        onEvent?(.completed(task))
        onEvent?(.listUpdated(tasks))
        
    }
    
    func removeTask(_ task: String) {
        if removeTaskFrom(&tasks, task: task) || removeTaskFrom(&completedTasks, task: task) {
            onEvent?(.removed(task))
            onEvent?(.listUpdated(tasks))
        } else {
            print("Задачи \(task) нет ни в одном из списков")
        }
    }
    
    func showCompletedTasks() {
        print("Список выполненых задач: \(completedTasks)")
    }
    
}

var manager: TaskManager? = TaskManager()

manager?.onEvent = { event in
    switch event  {
    case .added(let task):
        print("Задача \(task) добавлена")
    case .completed(let task):
        print("Задача \(task) добавлена в список выполненых задач")
    case .removed(let task):
        print("Задача \(task) удалена")
    case .listUpdated(let tasks):
        print("Список задач обновлен: \(tasks)")
    }
    
}

manager?.addTask("Купить молоко")
manager?.addTask("Выучить Swift")
manager?.completeTask("Купить молоко")
manager?.removeTask("Выучить Swift")
manager?.showCompletedTasks()
