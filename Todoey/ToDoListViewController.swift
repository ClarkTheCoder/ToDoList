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
        
    }
    
    // Tableview datasource methods
    // create three cells 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }


}

