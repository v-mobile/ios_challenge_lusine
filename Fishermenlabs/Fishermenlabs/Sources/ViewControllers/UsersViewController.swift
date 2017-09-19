//
//  UsersViewController.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit
import SDWebImage

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let usersDataProvider = UsersDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        
        usersDataProvider.delegate = self
        
        usersDataProvider.loadUsers()
        
        configureTableView()
        
    }
    
    func configureTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 155
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapOnViewGestureAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath as IndexPath) as! UsersTableViewCell
        let user = usersDataProvider.filteredUsers[indexPath.row]
        cell.resetCell()

        cell.delegate = self
        
        if user.name != nil {
            cell.nameLabel.text = UserNameManager.getUserFullName(user.name!)
        }
        
        cell.genderLabel.text = user.gender
        cell.emailLabel.text = user.email
        
        if user.location != nil {
            cell.locationLabel.text = LocationManager.getFullLocation(user.location!)
        }
        
        cell.phoneLabel.text = user.phone

        cell.avatarImageView.sd_setImage(with: URL(string: user.avatar), placeholderImage:UIImage.init(named: "defaultAvatar"))
        
        cell.favoriteButton.isSelected = user.isFavorite
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataProvider.filteredUsers.count
    }
}


extension UsersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usersDataProvider.searchUser(keyword: searchText)
        tableView.reloadData()
    }
    
}

extension UsersViewController: UsersDataProviderProtocol {
    
    func usersListUpdated() {
        tableView.reloadData()
    }
}

extension UsersViewController: UsersTableViewCellProtocol {
    
    func favoriteButtonAction(cell: UsersTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            
            let user = usersDataProvider.filteredUsers[indexPath.row]
            
            if user.isFavorite {
                usersDataProvider.filteredUsers[indexPath.row].isFavorite = false
                UserManager().unSave(user)
            } else {
                usersDataProvider.filteredUsers[indexPath.row].isFavorite = true
                user.isFavorite = true
                UserManager().save(user)
            }
            
        }
        
    }
    
}
