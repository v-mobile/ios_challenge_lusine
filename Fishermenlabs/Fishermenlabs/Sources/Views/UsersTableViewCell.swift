//
//  UsersTableViewCell.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit

protocol UsersTableViewCellProtocol: class {
    func favoriteButtonAction(cell: UsersTableViewCell)
}

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: UsersTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func resetCell() {
        nameLabel.text = ""
        genderLabel.text = ""
        emailLabel.text = ""
        locationLabel.text = ""
        phoneLabel.text = ""
        avatarImageView.image = nil
        favoriteButton.isSelected = false
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        delegate?.favoriteButtonAction(cell: self)
    }
    
}

extension UsersTableViewCell {
    
    func favoriteButtonAction(cell: UsersTableViewCell) {
        
    }
}
