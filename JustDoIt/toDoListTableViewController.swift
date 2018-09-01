//
//  toDoListTableViewController.swift
//  JustDoIt
//
//  Created by leon on 2018/9/1.
//  Copyright © 2018年 leonlee. All rights reserved.
//

import UIKit

class toDoListTableViewController: UITableViewController {

    let itemArray = ["Apple","Banana","Pear","Watermellon","Pine Apple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }
    
    //MARK-TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    
        //Add checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Delete the effect
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //add new item section
    
    @IBAction func addButtonPressed(_ sender: Any) {
    
    let alert = UIAlertController(title: "Add new item", message: "add new item to the list", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
            // what will happen once the button pressed
        print("add successfully!")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
