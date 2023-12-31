//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by erika.talberga on 31/10/2023.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext?
//    var toDo: [String] = []
    var toDoLists = [ToDoList]()
    var request: NSFetchRequest<ToDoList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
        request = NSFetchRequest<ToDoList>(entityName: "ToDoList")
        
        tableView.isEditing = true
        
        loadCoreData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func addNewItemTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "To Do List", message: "Add a new item", preferredStyle: .alert)
        alertController.addTextField { itemTextField in
            itemTextField.placeholder = "Your item title here..."
        }
            
        #warning("Add another text field")
        
        alertController.addTextField { subtitleTextField in subtitleTextField.placeholder = "Your item detail here..."
        }
        
        
        let addActionButton = UIAlertAction(title: "Add", style: .default) { addActions in
            let textField = alertController.textFields?.first
            let subtitleTextField = alertController.textFields?[1]
            
            let entity = NSEntityDescription.entity(forEntityName: "ToDoList", in: self.managedObjectContext!)
            let list = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
            
            list.setValue(textField?.text, forKey: "item")
            list.setValue(subtitleTextField?.text, forKey: "subtitle")
            self.saveCoreData()
//            self.toDo.append(textField!.text!)
//            self.tableView.reloadData()
        }
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(addActionButton)
        alertController.addAction(cancelActionButton)
        
        present(alertController, animated: true)
    }
    
    @IBAction func deleteAllItemsTapped(_ sender: Any) {
#warning("Alert controller comes up with confirmation Do you really want to delete all?. You can press Delete or Cancel")
        
        let actionSheet = UIAlertController(title: "Delete All?", message: "Are you shure you want to delete all?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteAllCoreData(request: self.request)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
}




// MARK: - CoreData logic
extension ToDoTableViewController {
    func loadCoreData() {
        let request: NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        
        do {
            let result = try managedObjectContext?.fetch(request)
            toDoLists = result ?? []
            self.tableView.reloadData()
        } catch {
            fatalError("Error in loading item into core data!")
        }
    }
    
    func saveCoreData() {
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Error in saving item into core data!")
        }
        loadCoreData()
    }
    
    func deleteAllCoreData(request: NSFetchRequest<ToDoList>) {
#warning("Delete all core data with confirmation (the alert)")
        do {
            let items = try managedObjectContext?.fetch(request)
            if let items = items {
                for item in items {
                    managedObjectContext?.delete(item)
                }
                try managedObjectContext?.save()
                loadCoreData()
            }
        } catch {
            fatalError("Error in deleting core data!")
        }
        
    }
}



// MARK: - Table view data source
extension ToDoTableViewController {
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return toDoLists.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoLists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)

        let toDoList = toDoLists[indexPath.row]
        cell.textLabel?.text = toDoList.item
        cell.detailTextLabel?.text = toDoList.subtitle
        
        if toDoList.completed {
            let checkmark = UIImage(systemName: "checkmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.accessoryView = UIImageView(image: checkmark)
        } else {
            cell.accessoryView = nil
        }
        
        cell.showsReorderControl = false
        cell.backgroundColor = UIColor.systemYellow
        
//        cell.accessoryType = toDoList.completed ? .checkmark : .none

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toDoLists[indexPath.row].completed = !toDoLists[indexPath.row].completed
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        let selectedRow = toDoLists[indexPath.row]
        
        saveCoreData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            managedObjectContext?.delete(toDoLists[indexPath.row])
        }
        
        saveCoreData()
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedItem = toDoLists[fromIndexPath.row]
        toDoLists.remove(at: fromIndexPath.row)
        toDoLists.insert(movedItem, at: to.row)
        
        if let cell = tableView.cellForRow(at: to) {
            cell.showsReorderControl = false
        }
        
        saveCoreData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
