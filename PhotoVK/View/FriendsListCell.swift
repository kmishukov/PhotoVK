//
//  FriendsListCell.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 12/06/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class FriendsListCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(friend: Friend) {
            if let name = friend.first_name, let surname = friend.last_name {
                nameLabel.text = name + " " + surname
            } else {
                print("Error retrieving first_name & last_name")
                nameLabel.text = "Error?"
            }
            
            userImage.image = UIImage(named: "placeholder")
            if let photoAdress = friend.photo_100 {
                userImage.loadImage(fromURL: photoAdress)
            } else {
                print("Error: image URL is nil.")
                userImage.image = UIImage(named: "errorURL")
            }
            userImage.translatesAutoresizingMaskIntoConstraints = false
            userImage.layer.cornerRadius = 25
            userImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        userImage.image = UIImage(named: "placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
