//
//  LogTableViewCell.swift
//  DPAppConsole
//
//  Created by Drew Pitchford on 8/2/18.
//  Copyright © 2018 Drew Pitchford. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    static let identifier = "logTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var logLabel: UILabel!
    
    // MARK: - Setup
    func setUp(withLog log: String) {
        
        logLabel.text = log
    }
}
