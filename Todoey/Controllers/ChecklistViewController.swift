//
//  ChecklistViewController.swift
//  Todoey
//
//  Created by carson on 2023-12-24.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class ChecklistViewController: UITableViewController {
    
    // create empty array of checklists
    var checklistArray = [Checklist]()
    // create file path to checklist plist
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Checklists.plist")
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("ChecklistViewController did load")
        

    }
}


