//
//  Model.swift
//  MVC_HW
//
//  Created by Egor Kruglov on 06.03.2023.
//

import Foundation

class Item {
    var taskName: String
    
    init(taskName: String) {
        self.taskName = taskName
    }
}

class Model {
    
    var toDoItems = [
        Item(taskName: "Понять что такое MVC"),
        Item(taskName: "Сделать таблицу для начала"),
        Item(taskName: "Добавить всяких элементов чтобы на todolist было похоже")
    ]
    
}
