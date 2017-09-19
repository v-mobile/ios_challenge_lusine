//
//  FavoriteUsersViewController.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit

class FavoriteUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoritePeopleLabel: UILabel!

    let usersDataProvider = UsersDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        
        usersDataProvider.delegate = self
        
        usersDataProvider.loadFavoriteUsers()
        
        configureTableView()
        
        
    }

    func configureTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        tableView.reloadData()
        if usersDataProvider.filteredUsers.count > 0 {
            noFavoritePeopleLabel.isHidden = true
        } else {
            noFavoritePeopleLabel.isHidden = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.favoriteButton.isSelected = true
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataProvider.filteredUsers.count
    }
}


extension FavoriteUsersViewController: UsersDataProviderProtocol {
    
    func usersListUpdated() {
        updateUI()
    }
}

extension FavoriteUsersViewController: UsersTableViewCellProtocol {
    
    func favoriteButtonAction(cell: UsersTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            
            let user = usersDataProvider.filteredUsers[indexPath.row]
            
            UserManager().unSave(user)
            usersDataProvider.filteredUsers.remove(at: indexPath.row)
            updateUI()
        }
        
    }
    
}

