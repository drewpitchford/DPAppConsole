//
//  Constants.swift
//  DPAppConsole
//
//  Created by Drew Pitchford on 8/2/18.
//  Copyright © 2018 Drew Pitchford. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Notifications {}
}

typealias NotificationNames = Constants.Notifications.Names
extension Constants.Notifications {
    
    struct Names {
        
        static let phoneShake = "phone_shook"
    }
}
