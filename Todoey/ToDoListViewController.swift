//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Get kinder eggs", "Buy eggs", "Get pepper"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }
    
    // Tableview datasource methods
    // create three cells 
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
    
    // this method informs delegate of current row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // grabs reference to a cell at particular indexpath
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType == .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        }
            
        // prevents item from staying highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


