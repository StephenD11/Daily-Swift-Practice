import UIKit

//Задача №10 "Поиск студентов которые еще не завершили обучение и сортировка их же по алфавиту и проценту пройденного курса

var jsonString: String = """
[
  {
    "courseName": "iOS Development",
    "students": [
      {"name": "Alex", "email": "alex@mail.com", "progress": 75, "completed": true},
      {"name": "Ben", "email": null, "progress": 40, "completed": false},
      {"name": "Chris", "email": "chris@mail.com", "progress": 90, "completed": true}
    ]
  },
  {
    "courseName": "SwiftUI",
    "students": [
      {"name": "Dana", "email": "dana@mail.com", "progress": 50, "completed": false},
      {"name": "Eva", "email": null, "progress": 100, "completed": true}
    ]
  }
]
"""

struct Student : Codable {
    var name: String
    var email: String?
    var progress: Int
    var completed: Bool
}

struct Course: Codable {
    var courseName: String
    var students: [Student]
}

var jsonDataUniversity = jsonString.data(using: .utf8)

do {
    
    var university = try JSONDecoder().decode([Course].self, from: jsonDataUniversity!)
    var incompleteStudents: [String : [Student]] = [:]
    
    university.forEach { course in
        let filteredSorted = course.students
            .filter { student in return !student.completed }
            .sorted { std1, std2 in
                if std1.name != std2.name {
                    return std1.name < std2.name
                } else {
                    return std1.progress > std2.progress
                }
            }
        
        if !filteredSorted.isEmpty {
            incompleteStudents[course.courseName] = filteredSorted
        }
    }
    
    incompleteStudents.forEach { courseName, students in
        print("\(courseName)")
        students.forEach { student in
            print("\(student.name) - \(student.progress), email: \(student.email ?? "nil")")
        }
        print()
    }
    
} catch {
    print(error)
}


/*
 Course: iOS Development
 Ben — 40% complete, email: nil

 Course: SwiftUI
 Dana — 50% complete, email: dana@mail.com
 */
