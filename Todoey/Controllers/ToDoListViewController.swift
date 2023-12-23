//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad(){
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Sarah"
        itemArray.append(newItem2)
    
        
//        if let safeArray = defaults.array(forKey: "ToDoListArray") as? [String] {
//            itemArray = safeArray
//        }

    }
    
    // Tableview datasource methods
   
    // create three rows
    // method responsible for displaying cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        print("cellforrowat")
        
        // optional chaining - textLabel is nil, property won't be called
        // set text for cell
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // Tableview delegate methods
    
    // this method informs delegate of current row selected (indexpath)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get current item that's selected and update done property
        itemArray[indexPath.row].done = itemArray[indexPath.row].done == true ? false : true
        
        // forces tableview to call its datasource methods again
        tableView.reloadData()
    
            
        // prevents item from staying highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // creating this variable so I can effectively grab data from addTextField and use it in UIAlertAction
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // what happens once user clicks the add item button on UIAlert
            if textField.text != nil {
                self.itemArray.append(newItem)
            } else {
                newItem.title = "New Item"
                self.itemArray.append(newItem)
            }
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        // alertTextField is the name I'm giving to the UITextField that I created here
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add an item here"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true) {
            
        }
    }
    
}


