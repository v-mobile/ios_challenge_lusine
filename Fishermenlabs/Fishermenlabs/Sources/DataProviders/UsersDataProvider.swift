//
//  UsersDataProvider.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation

protocol UsersDataProviderProtocol: class {
    func usersListUpdated()
}

class UsersDataProvider {
    
    var usersCount = 100
    
    var users = Array<User>()
    var filteredUsers = Array<User>()
  
    weak var delegate: UsersDataProviderProtocol?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDeletedFromFavorites), name: Notifications.userDeletedFromFavorites, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func userDeletedFromFavorites(notification:Notification) {
        
        if let userId = notification.userInfo?["object"] as? String {
            if let index = filteredUsers.index(where: {
                if $0.isInvalidated {
                    return false
                }
                return $0.userId == userId
            }) {
                filteredUsers[index].isFavorite = false
                self.delegate?.usersListUpdated()
            }
            
        }
    }

    
    func loadUsers() {
        
        UserManager().getUsers(count:usersCount) { [unowned self] (result, error) in
            if error == nil && result != nil {
                if let newUsers = result as? Array<User> {
                    self.users = newUsers
                    self.filteredUsers = newUsers
                    self.delegate?.usersListUpdated()
                }
            } else {
                AlertHelper.showUnexpectedErrorAlert()
            }
        }

    }
    
    func searchUser(keyword: String) {
        
        if keyword.characters.count > 0 {
            let key = keyword.lowercased()
            filteredUsers = users.filter({(user: User) -> Bool in
                
                let emailMatch = user.email.lowercased().contains(key)
                var nameMatch = false
                if !emailMatch && user.name != nil {
                    nameMatch = UserNameManager.getUserFullName(user.name!).lowercased().contains(key) 
                }
                
                let stringMatch = emailMatch || nameMatch
                
                return stringMatch
            })
        } else {
            filteredUsers = users
        }
        
        delegate?.usersListUpdated()
        
    }
    
    func loadFavoriteUsers() {
        
        filteredUsers = UserManager().getSavedUsers()
        delegate?.usersListUpdated()
    }
    
}

extension UsersDataProvider {
    
    func usersListUpdated() {
        
    }
}
