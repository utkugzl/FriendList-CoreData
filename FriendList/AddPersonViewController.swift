//
//  AddPersonViewController.swift
//  FriendList
//
//  Created by Utku Güzel on 1.07.2023.
//

import UIKit

class AddPersonViewController: UIViewController {
    
    let context = appDeelgate.persistentContainer.viewContext


    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personPhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPerson(_ sender: UIButton) {
        
        if let name = personNameTextField.text, let phone = personPhoneTextField.text {
            
            let person = Person(context: context)
            
            person.personName = name
            person.personPhone = phone
            
            appDeelgate.saveContext()
            
            
        }
        
    }
}
