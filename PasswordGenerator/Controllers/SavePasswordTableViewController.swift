//
//  SavePasswordTableViewController.swift
//  PasswordGenerator
//
//  Created by Luan Ipê on 09/05/22.
//

import UIKit
import CoreData

var savedPasswords = [NSManagedObject]()

class SavePasswordTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPassword))
    }

    @objc func addPassword() -> Void {
        let alert = UIAlertController(title: "Add New Password", message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: ({
            Void in
            
            if let passwordTextField = alert.textFields![1] as? UITextField, let usedToTextField = alert.textFields![0] as? UITextField {
                self.savePassword(passwordToSave: passwordTextField.text!, isUsedTo: usedToTextField.text!)
                self.tableView.reloadData()
            }
            
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField(configurationHandler: ({
            (textField) in
            textField.placeholder = "Used On"
        }))
        
        alert.addTextField(configurationHandler: ({
            (textField) in
            textField.placeholder = "Password"
        }))
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func savePassword(passwordToSave: String, isUsedTo: String) -> Void {
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Password", in: managedContext)
        
        let password = NSManagedObject(entity: entity!, insertInto: managedContext)
        password.setValue(passwordToSave, forKey: "characters")
        password.setValue(isUsedTo, forKey: "usedTo")
        
        do {
            try managedContext.save()
            savedPasswords.append(password)
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Configurações da TableView
    
    override func viewWillAppear(_ animated: Bool) -> Void {
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Password")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            savedPasswords = results as! [NSManagedObject]
        }
        catch {
            print(error)
        }
    }
    
    // Número de itens na seção a partir do tamanho do Array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPasswords.count
    }

    // Função que contem as configurações de exibição da célula
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPasswordCell", for: indexPath) as! SavedPasswordTableViewCell
        let savedPass = savedPasswords[indexPath.row]
        
        cell.password.text = savedPass.value(forKey: "characters") as? String
        cell.usedOn.text = savedPass.value(forKey: "usedTo") as? String
        
        return cell
    }
    
    // Função  para deletar uma senha salva (deleta a célula e o NSManagedObject do Core Data)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(savedPasswords[indexPath.row] as NSManagedObject)
        savedPasswords.remove(at: indexPath.row)
        
        do {
            try managedContext.save()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
}
