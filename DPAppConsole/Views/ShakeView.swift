//
//  ShakeView.swift
//  DPAppConsole
//
//  Created by Drew Pitchford on 8/2/18.
//  Copyright © 2018 Drew Pitchford. All rights reserved.
//

import Foundation
import UIKit

class ShakeView: UIView {
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == .motionShake {
            
            NotificationCenter.default.post(name: NSNotification.Name(NotificationNames.phoneShake), object: nil)
        }
        
        super.motionEnded(motion, with: event)
    }
}
