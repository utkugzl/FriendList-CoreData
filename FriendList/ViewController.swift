//
//  ViewController.swift
//  FriendList
//
//  Created by Utku Güzel on 1.07.2023.
//

import UIKit
import CoreData

let appDeelgate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDeelgate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isSearching = false
    var searchingWord: String?
    
    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isSearching {
            doSearch(personName: searchingWord!)
        } else {
            getPersons()
        }
        
        tableView.reloadData()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as! DetailPersonViewController
            destinationVC.person = personList[index!]
        }
        
        if segue.identifier == "toUpdate" {
            let destinationVC = segue.destination as! UpdatePersonViewController
            destinationVC.person = personList[index!]
        }
    }
    
    
    func getPersons() {
        
        do {
            personList = try context.fetch(Person.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func doSearch(personName: String) {
        
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        
        fetchRequest.predicate = NSPredicate (format: "personName CONTAINS %@", personName)
        
        do {
            personList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    



}

// MARK: - UITableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = personList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        
        cell.personTextLabel.text = "\(person.personName!) - \(person.personPhone!)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            
            let person = self.personList[indexPath.row]
            
            self.context.delete(person)
            
            appDeelgate.saveContext()
            
            
            // Updating UI
            if self.isSearching {
                self.doSearch(personName: self.searchingWord!)
            } else {
                self.getPersons()
            }
            
            self.tableView.reloadData()
        }
        
        
        let updateAction = UIContextualAction(style: .normal, title: "Güncelle") { contextualAction, view, boolValue in
            
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    
    
}


// MARK: - UISearchBar

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchingWord = searchText
        
        if searchText == "" {
            isSearching = false
            getPersons()
        } else {
            isSearching = true
            doSearch(personName: searchingWord!)
        }
        
        tableView.reloadData()
    }
    
}

