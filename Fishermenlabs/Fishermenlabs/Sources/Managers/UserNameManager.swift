//
//  UserNameManager.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit

class UserNameManager: NetworkingManager {
    
    func objectFromJson(data: AnyObject) -> AnyObject {
        let userName = UserName()
        
        userName.title = data["title"] as? String ?? userName.title
        userName.first = data["first"] as? String ?? userName.first
        userName.last = data["last"] as? String ?? userName.last
        
        return userName
    }
 
    static func getUserFullName(_ userName:UserName) -> String {
    
        let fullname =  userName.title + " " + userName.first + " " + userName.last
        
        return fullname
    }
    
}
