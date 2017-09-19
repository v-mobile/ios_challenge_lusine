//
//  UserManager.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation

class UserManager: NetworkingManager {

    func objectFromJson(data: AnyObject) -> AnyObject {
        let user = User()
        
        let idDict = data["id"] as? Dictionary<String, String>
        let name = idDict?["name"] ?? ""
        let value = idDict?["value"] ?? ""
        user.userId = name + value
        
        user.gender = data["gender"] as? String ?? user.gender
         
        if let userName = UserNameManager().objectFromJson(data: data["name"] as AnyObject) as? UserName {
            user.name = userName
        }
        if let location = LocationManager().objectFromJson(data: data["location"] as AnyObject) as? Location {
            user.location = location
        }

        user.email = data["email"] as? String ?? user.email
        user.phone = data["phone"] as? String ?? user.phone
        
        if let avatarDict = data["picture"] as? Dictionary<String, String> {
            user.avatar =  avatarDict["large"] ?? user.avatar
        }
        
        
        return user
    }
    
    func getUsers(count:Int, callback: @escaping CompletionCallback) {
        let params = ["results": count]
        doRequest(method: .requestMethodGet, url: "", parameters: params, headers: nil, completion: callback)
    }
    
    func getSavedUsers() -> Array<User> {
        
        if let objects = DBManager.retrieve(User.self) as? Array<User> {
            return objects
        }
        
        return Array()
        
        
    }

    func save(_ user: User) {
        
        DBManager.persistObject(user)
    }
    
    func unSave(_ user: User) {
        
        let userId = user.userId
        
        if let obj = DBManager.findObjectWithFilter(User.self, filter: NSPredicate(format: "userId == %@", userId)) {
            DBManager.deleteObject(obj)
        }
        
        NotificationCenter.default.post(name: Notifications.userDeletedFromFavorites, object: user, userInfo: ["object": userId])
        
        
    }
    
}
