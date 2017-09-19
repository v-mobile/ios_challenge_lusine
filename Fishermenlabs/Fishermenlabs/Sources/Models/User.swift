//
//  User.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var userId = ""
    dynamic var gender = ""
    dynamic var name: UserName?
    dynamic var location:Location?
    dynamic var email = ""
    dynamic var phone = ""
    dynamic var avatar = ""
    
    
    dynamic var isFavorite = false
    
    override public func isEqual(_ object: Any?) -> Bool {
        
        if let castedObject = object as? User {
            return self.userId == castedObject.userId
        }
        
        return false
        
    }
}
