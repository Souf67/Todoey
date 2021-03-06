//
//  ViewController.swift
//  Todoey
//
//  Created by AmarTest on 28/08/2018.
//  Copyright © 2018 Amar. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
   
    // 1/3 Pour le persistent local data storage
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Fake nEWS"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "FILS DE Pite"
        itemArray.append(newItem3)
        
       
        
        
        // 3/3 Dernière étape pour le persistent storage
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            
         itemArray = items
            
       }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
         // Pour mettre le checkmark au clic
        cell.accessoryType = item.done ? .checkmark : .none
    
        
       
       
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Pour changer l'animation lors de la selection
        tableView.deselectRow(at: indexPath, animated: true)
        
         // Pour mettre le checkmark au clic
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        

         tableView.reloadData()
        
        
    }
    
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        // Initialise le popup, on donne un titre
        let alert = UIAlertController(title: "Nouvelle tâche", message: "", preferredStyle: .alert)
        
        // Initialise le bouton en dessous du popup
        let action = UIAlertAction(title: "Ajouter la tâche", style: .default) { (action) in
            
            // Ce qui se passe quand l'utilisateurs clic sur le boutton add dans l'alerte
            
            // Ajout de la nouvelle tache
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            // 2/3 Method pour sauvegarder les données si l'app crash (persistent local data storage)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            // Obligatoire pour mettre à jour les nouvelles données
            self.tableView.reloadData()
          
        }
        // Pour ajouter le textField dans le popup
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Nouvelle tâche"
                textField = alertTextField
        }
        
       
        // La partie du haut
        present(alert, animated: true, completion: nil)
        // La partie du bas, le bouton
        alert.addAction(action)
        
        
        
    }
    
}

