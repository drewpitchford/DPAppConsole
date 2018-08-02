//
//  ConsoleViewController.swift
//  DPAppConsole
//
//  Created by Drew Pitchford on 8/2/18.
//  Copyright © 2018 Drew Pitchford. All rights reserved.
//

import UIKit

class ConsoleViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var consoleTableView: UITableView!
    
    // MARK: - Properties
    private var logs: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        consoleTableView.estimatedRowHeight = 44
        view.backgroundColor = .black
        LogIntercepter.shared.delegate = self
    }
}

// MARK: - UITableViewDelegate methods
extension ConsoleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.identifier, for: indexPath) as? LogTableViewCell else {
            
            return UITableViewCell()
        }
        
        let log = logs[indexPath.row]
        cell.setUp(withLog: log)
        return cell
    }
}

// MARK: - LogInterceptorDelegate
extension ConsoleViewController: LogInterceptorDelegate {
    
    func logRead(_ message: String) {
        
        logs.append(message)
        consoleTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        consoleTableView.scrollToRow(at: IndexPath(row: logs.count - 1, section: 0), at: .bottom, animated: true)
    }
}
