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
        Item(taskName: "Добавить всяких элементов чтобы на to do list было похоже", completed: true),
        Item(taskName: "Попытаться делать дальше..", completed: true),
        Item(taskName: "Понять что ничего не получается", completed: true),
        Item(taskName: "Расстроиться", completed: true),
        Item(taskName: "🗿🗿🗿", completed: false),
        Item(taskName: "Добавить немного копипасты", completed: true)
    ]
    
    var sortedAscending: Bool = true
    
    func addItem(taskName: String, completed: Bool = false) {
        toDoItems.append(Item(taskName: taskName, completed: completed))
    }
    
    func sortByTitle() {
        toDoItems.sort {
            sortedAscending ? $0.taskName < $1.taskName : $0.taskName > $1.taskName
        }
    }
    
    func changeState(at index: Int) -> Bool {
        toDoItems[index].completed = !toDoItems[index].completed
        return toDoItems[index].completed
    }
    
    func updateItem(at index: Int, with taskName: String) {
        toDoItems[index].taskName = taskName
    }
}
