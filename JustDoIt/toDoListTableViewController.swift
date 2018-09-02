//
//  toDoListTableViewController.swift
//  JustDoIt
//
//  Created by leon on 2018/9/1.
//  Copyright © 2018年 leonlee. All rights reserved.
//

import UIKit

class toDoListTableViewController: UITableViewController {

    var itemArray = ["Apple"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "toDoListArray") as? [String]{
            itemArray = items
        }
        
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
        print(indexPath.row)
    
        //Add checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Delete the effect
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(itemArray[indexPath.row])
    
    }
    
    //add new item section
    
    @IBAction func addButtonPressed(_ sender: Any) {
    
    var textField = UITextField()
        
    let alert = UIAlertController(title: "Add new item", message: "add new item to the list", preferredStyle: .alert)
        
    
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
        
        // what will happen once the button pressed
        
        self.defaults.set(self.itemArray,forKey: "toDoListArray")
        
        self.itemArray.append(textField.text!)
        
        self.tableView.reloadData()
        
        print(textField.text!)
        
        }
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Add new item"
            textField = alertTextFiled
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
