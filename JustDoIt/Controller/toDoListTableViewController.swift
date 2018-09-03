//
//  toDoListTableViewController.swift
//  JustDoIt
//
//  Created by leon on 2018/9/1.
//  Copyright © 2018年 leonlee. All rights reserved.
//

import UIKit
import CoreData

class toDoListTableViewController: UITableViewController {

    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(dataFilePath)
        print(" Get datafilepath!")
        
        loadItems()
        
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

        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }

        return cell
    }
    
    //MARK-TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    
        //Add checkmark
        
        context.delete(itemArray[indexPath.row])
        
        itemArray.remove(at: indexPath.row)
       
        
//
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        
        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        
        
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
        
        //self.defaults.set(self.itemArray,forKey: "toDoListArray")
        
        let newItem = Item(context: self.context)
        
        newItem.title = textField.text!
        
        newItem.done = false
        
        self.itemArray.append(newItem)
        
        
        self.saveItems()
        
        print(textField.text!)
        
        }
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Add new item"
            textField = alertTextFiled
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }

        func saveItems(){
            
            do{
                
               try context.save()
            
            }catch{
                print("Error saving context\(error)")
            }
            
            self.tableView.reloadData()
            
        }
func loadItems(){
    
    let request : NSFetchRequest<Item> = Item.fetchRequest()
    do{
    itemArray = try context.fetch(request)
    }catch{
        print("Error fetching data from context\(error)")
    }
  }
}

