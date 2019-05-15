//
//  ViewController.swift
//  Bouwer ToDo
//
//  Created by Henrik Bouwer Knudsen on 13/05/2019.
//  Copyright © 2019 Henrik Bouwer Knudsen. All rights reserved.
//


import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    //Creates a plist that we can save and retreive from
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        loadItems()

    }
    //Lager Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none

        
        return cell
    }
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Make sure that the order is as so.
        //context.delete uses the itamArray to delete the data, and the app will crash if itemArray.remove is called before context.delete tries to use it
        
        // V To delete items from the context V
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
    //    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
        saveItems()
        
        print(itemArray[indexPath.row])

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Hva som skjer etter at brukeren trykker på "Add Item"
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems () { 
        
        do {

           try context.save()
        } catch {
            print("Error saving contect \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error Fetching data from context \(error)")
        }
    }
}
//MARK: - Search Bar methods

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
       loadItems(with : request)
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
        
    }
}
    


