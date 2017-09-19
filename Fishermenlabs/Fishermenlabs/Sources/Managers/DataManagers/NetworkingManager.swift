//
//  NetworkingManager.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation
import Alamofire


public var baseURL = ""

enum RequestMethod {
    
    case requestMethodGet
    case requestMethodPut
    case requestMethodPost
    case requestMethodDelete
}

typealias CompletionCallback = (Any?, NSError?) -> Void

protocol NetworkingManager {
    func doRequest(method:RequestMethod, url:String, parameters:Dictionary<String, Any>?, headers:Dictionary<String,String>?, completion:@escaping CompletionCallback)
    
    func objectFromJson(data: AnyObject) -> AnyObject
}

extension NetworkingManager {
    
    func doRequest(method:RequestMethod, url:String, parameters:Dictionary<String, Any>?, headers:Dictionary<String,String>?, completion:@escaping CompletionCallback) {
        
        
        let requestMethod: HTTPMethod
        switch method {
        case .requestMethodGet:
            requestMethod = .get
        case .requestMethodPost:
            requestMethod = .post
        case .requestMethodPut:
            requestMethod = .put
        case .requestMethodDelete:
            requestMethod = .delete
        }
    
        let fullURL = FishermenlabsApp.baseURL + url
        
        let isReachable = NetworkReachabilityManager()?.isReachable ?? false
        
        if isReachable {
            if let requestURL = URL(string: fullURL) {
                Alamofire.request(
                    requestURL,
                    method: requestMethod,
                    parameters: parameters)
                    .validate()
                    .responseJSON { (response) -> Void in
                        
                        guard response.result.isSuccess else {
                            let error = NSError(domain: "appRequestFail", code: -1000, userInfo: nil)
                            completion(nil, error)
                            return
                        }
                        if let resultsDict = response.result.value as? Dictionary<String,AnyObject> {
                            if let results = resultsDict["results"] as? Array<AnyObject> {
                                var objects = Array<AnyObject>()
                                
                                for obj in results {
                                    let object = self.objectFromJson(data: obj)
                                    objects.append(object)
                                }
                                completion(objects, nil)
                                return
                            }
                            
                            // TODO: Handle response of not array type
                            
                        }
                        
                        completion(nil, nil)
                        return
                }
            } else {
                print("ERROR: Invalid URL")
            }
        } else {
            DefaultErrorHandler().onOffleineError()
        }
        
        
        
    }
    
    
    func objectFromJson(data: AnyObject) -> AnyObject {
        return self as AnyObject
    }
}
