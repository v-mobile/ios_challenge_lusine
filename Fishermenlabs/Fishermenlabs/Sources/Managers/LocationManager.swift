//
//  LocationManager.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import UIKit

class LocationManager: NetworkingManager {

    func objectFromJson(data: AnyObject) -> AnyObject {
        
        let location = Location()
        
        location.street = data["street"] as? String ?? location.street
        location.city = data["city"] as? String ?? location.city
        location.state = data["state"] as? String ?? location.state
        
        return location
    }
    
    static func getFullLocation(_ location: Location) -> String {
        
        let fullLocation = location.street + ", " + location.city + ", " + location.state
        
        return fullLocation
    }
    
}
