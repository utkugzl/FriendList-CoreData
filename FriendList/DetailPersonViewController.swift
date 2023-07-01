//
//  DetailPersonViewController.swift
//  FriendList
//
//  Created by Utku Güzel on 1.07.2023.
//

import UIKit

class DetailPersonViewController: UIViewController {

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personPhoneLabel: UILabel!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = person {
            personNameLabel.text = p.personName
            personPhoneLabel.text = p.personPhone
        }
    }
    



}
