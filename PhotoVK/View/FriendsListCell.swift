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
        userImage.image = UIImage(named: "placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
