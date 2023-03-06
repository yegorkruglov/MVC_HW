//
//  Model.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import Foundation

class Item {
    
    var taskName: String
    var completed: Bool
    
    init(taskName: String, completed: Bool) {
        self.taskName = taskName
        self.completed = completed
    }
}

class Model {
    
    var toDoItems = [
        Item(taskName: "Понять что такое MVC", completed: true),
        Item(taskName: "Сделать таблицу для начала", completed: true),
        Item(taskName: "Добавить всяких элементов чтобы на todolist было похоже", completed: true)
    ]
    
    var sortedAscending: Bool = true
    
    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }
    
    func addItem(taskName: String, completed: Bool = false) {
        toDoItems.append(Item(taskName: taskName, completed: completed))
    }
    
    func sortByTitle() {
        toDoItems.sort {
            sortedAscending ? $0.taskName < $1.taskName : $0.taskName > $1.taskName
        }
    }
}
