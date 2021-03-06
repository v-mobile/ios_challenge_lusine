//
//  ErrorHandler.swift
//  Fishermenlabs
//
//  Created by Lusine Hovhannisyan on 9/18/17.
//  Copyright © 2017 Lusine Hovhannisyan. All rights reserved.
//

import Foundation

protocol ErrorHandler {
    
    func onOffleineError()
    func onUnexpectedError()
}

extension ErrorHandler {
    
    func onOffleineError() {
        AlertHelper.showOfflineAlert()
    }
    
    func onUnexpectedError() {
        AlertHelper.showUnexpectedErrorAlert()
    }
}
