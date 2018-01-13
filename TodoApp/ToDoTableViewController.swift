//
//  ToDoTableViewController.swift
//  TodoApp
//
//  Created by Emily Popovic on 2017-12-31.
//  Copyright © 2017 Emily Popovic. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, TodoCellDelegate {
    
    //create array for todo items
    var todoItems:[TodoItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load todo data
        loadData()
    }
    
    //add item to todo list
    @IBAction func addNewTodo(_ sender: Any) {
        //create an alert
        let addAlert = UIAlertController(title: "New Todo", message: "Enter a title", preferredStyle: .alert)
        //placeholder for todo item title
        addAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "ToDo Item Title"
        }
        
        //create button
        addAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action:UIAlertAction) in
            
            //get the text from text field
            guard let title = addAlert.textFields?.first?.text else { return }
            
            //create new todo object
            let newTodo = TodoItem(title: title, completed: false, createdAt: Date(), itemIdentifier: UUID())
            //save the item
            newTodo.saveItem()
            
            //add to the todo list array
            self.todoItems.append(newTodo)
            
            //insert into the table view
            let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
            
            //insert into rows
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }))
        
        //cancel button
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //present alert to user
        self.present(addAlert, animated: true, completion: nil)
    }
    
    
    //delegate functions!
    func didRequestDelete(_ cell: ToDoTableViewCell) {
        
        //if delete clicked then figure out which cell to delete
        //create index path from the cell
        if let indexPath = tableView.indexPath(for: cell){
            
            //delete from documents directory
            todoItems[indexPath.row].deleteItem()
            
            //remove from todo items array
            todoItems.remove(at: indexPath.row)
            
            //remove from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didRequestComplete(_ cell: ToDoTableViewCell) {
        
        //create the index path for the cell
        if let indexPath = tableView.indexPath(for: cell){
            
            //create a todo item
            var todoItem = todoItems[indexPath.row]
            
            //mark the todo item as completed and is automatically saved
            todoItem.markAsCompleted()
            
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }
    }
    
    func strikeThroughText (_ text:String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
    
    //load data of todo list items
    func loadData(){
        
        //initialize array
        todoItems = [TodoItem]()
        
        //sort items
        todoItems = DataManager.loadAll(TodoItem.self).sorted(by: {
            $0.createdAt < $1.createdAt
        })
        
        //reload table
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell

        //set the delegate to self
        //adopted the delegate in the class title
        cell.delegate = self
        
        let todoItem = todoItems[indexPath.row]
        
        cell.todoLabel.text = todoItem.title
        
        //display the visual representation text
        if todoItem.completed {
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
