//
//  PersonTableViewCell.swift
//  FriendList
//
//  Created by Utku Güzel on 1.07.2023.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
