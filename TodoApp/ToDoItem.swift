//
//  ToDoItem.swift
//  TodoApp
//
//  Created by Emily Popovic on 2017-12-27.
//  Copyright © 2017 Emily Popovic. All rights reserved.
//

import Foundation

struct TodoItem: Codable{
    
    var title:String
    var completed:Bool
    var createdAt:Date
    var itemIdentifier:UUID
    
    func saveItem(){
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    func deleteItem(){
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    mutating func markAsCompleted(){
        self.completed = true
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
}
