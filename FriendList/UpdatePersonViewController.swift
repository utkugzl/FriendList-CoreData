//
//  UpdatePersonViewController.swift
//  FriendList
//
//  Created by Utku Güzel on 1.07.2023.
//

import UIKit

class UpdatePersonViewController: UIViewController {
    
    let context = appDeelgate.persistentContainer.viewContext

    
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personPhoneTextField: UITextField!
    
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person {
            personNameTextField.text = p.personName
            personPhoneTextField.text = p.personPhone
        }
    }
    

    @IBAction func updatePerosn(_ sender: UIButton) {
        
        if let name = personNameTextField.text, let phone = personPhoneTextField.text, let p = person {
            
            p.personName = name
            p.personPhone = phone
            
            appDeelgate.saveContext()
            
            
        }
        
    }

}
