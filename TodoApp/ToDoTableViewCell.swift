//
//  ToDoTableViewCell.swift
//  TodoApp
//
//  Created by Emily Popovic on 2017-12-31.
//  Copyright © 2017 Emily Popovic. All rights reserved.
//

import UIKit

protocol TodoCellDelegate {
    
    func didRequestDelete (_ cell: ToDoTableViewCell)
    
    func didRequestComplete (_ cell: ToDoTableViewCell)
    
}

class ToDoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var todoLabel: UILabel!
    
    var delegate:TodoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func completeTodo(_ sender: Any) {
        
        //check if we have a delegate object
        if let delegateObject = self.delegate{
            delegateObject.didRequestComplete(self)
        }
    }
    
    @IBAction func deleteTodo(_ sender: Any) {
        if let delegateObject = self.delegate{
            delegateObject.didRequestDelete(self)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
