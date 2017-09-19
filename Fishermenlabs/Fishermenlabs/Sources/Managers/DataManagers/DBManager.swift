//
//  DBManager.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    static func beginWrite() {
        FishermenlabsApp.uiRealm?.beginWrite()
    }
    
    static func commitWrite() {
        
        do {
            if FishermenlabsApp.uiRealm?.isInWriteTransaction ?? false {
                try FishermenlabsApp.uiRealm?.commitWrite()
            }
        } catch {
            print("Something went wrong with local db")
        }

    }
    
    static func persistObject(_ object: Object) {
        
        if FishermenlabsApp.uiRealm?.isInWriteTransaction ?? false {
            FishermenlabsApp.uiRealm?.create(type(of: object).self, value: object)
        }
    }
    
    static func deleteObject(_ object: Object) {
        
        if FishermenlabsApp.uiRealm?.isInWriteTransaction ?? false {
            if !object.isInvalidated {
                FishermenlabsApp.uiRealm?.delete(object)
            }
        }
    }
    
    static func retrieve<T>(_ type : T.Type) -> Array<Object> {
        
        if let objectType = (type as? Object.Type) {
            if let objects = FishermenlabsApp.uiRealm?.objects(objectType.self) {
                return Array(objects)
            }
            
        }
        
        return Array()
    }

    static func findObjectWithFilter<T>(_ type : T.Type, filter: NSPredicate) -> Object? {
        
        if let objectType = (type as? Object.Type) {
            if let objects = FishermenlabsApp.uiRealm?.objects(objectType.self).filter(filter) {
                return Array(objects).first
            }
        }
        
        return nil
    }
    
}
