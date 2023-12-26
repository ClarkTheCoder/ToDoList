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
        
        loadItems()

    }
    
    // Tableview datasource methods fi
   
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
        
        // toggle completed item
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        saveItems()
        
        // prevents cell from staying highlighted
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
            }
            
            self.saveItems()
        }
        
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
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}


