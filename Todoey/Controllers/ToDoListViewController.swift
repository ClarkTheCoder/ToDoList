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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad(){
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Sarah"
        itemArray.append(newItem2)
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
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
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // Tableview delegate methods
    
    // this method informs delegate of current row selected (indexpath)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
            // add new item to itemArray
            if textField.text != nil {
                self.itemArray.append(newItem)
            } else {
                newItem.title = "New Item"
                self.itemArray.append(newItem)
            }
            
            self.saveItems()
            
            // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
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
    
    // Model Manipulation
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            // encode data
            let data = try encoder.encode(itemArray)
            // write to file path
            try data.write(to: dataFilePath!)
        }catch {
            // print error
            print("error encoding data \(error)")
        }
        
        // forces tableview to call its datasource methods again
        tableView.reloadData()
    }
}


