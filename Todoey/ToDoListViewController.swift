//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Get kinder eggs", "Buy eggs", "Get pepper"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Tableview datasource methods
    // create three rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // optional chaining - textLabel is nil, property won't be called
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // Tableview delegate methods
    
    // this method informs delegate of current row selected (indexpath)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // grabs reference to a cell at particular indexpath and checks to see if there's already existing checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
            
        // prevents item from staying highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // creating this variable so I can effectively grab data from addTextField and use it in UIAlertAction
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // what happens once user clicks the add item button on UIAlert
            if let newItemText = textField.text {
                self.itemArray.append(newItemText)
            } else {
                self.itemArray.append("New Item")
            }
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


