//
//  AppConsole.swift
//  DPAppConsole
//
//  Created by Drew Pitchford on 8/2/18.
//  Copyright © 2018 Drew Pitchford. All rights reserved.
//

import Foundation
import UIKit

public class AppConsole {
    
    // MARK: - Singleton
    public static let shared = AppConsole()
    
    // MARK: - Properties
    private var consoleIsVisible = false
    private var console: ConsoleViewController
    
    // MARK: - Init
    init() {
        
        let shakeView = ShakeView()
        shakeView.backgroundColor = .clear
        UIApplication.shared.keyWindow?.addSubview(shakeView)
        UIApplication.shared.keyWindow?.sendSubview(toBack: shakeView)
        
        let storyboard = UIStoryboard(name: "Console", bundle: Bundle(for: ConsoleViewController.self))
        guard let consoleVC = storyboard.instantiateInitialViewController() as? ConsoleViewController else {
            
            fatalError("Failed to retrieve Console VC. Contact Pod contributors.")
        }
        
        console = consoleVC
    }
    
    // MARK: - Interface
    public func start() {
        
        LogIntercepter.shared.start()
        NotificationCenter.default.addObserver(self, selector: #selector(handleShake), name: NSNotification.Name(NotificationNames.phoneShake), object: nil)
    }
    
    // MARK: - Notification Handlers
    @objc func handleShake() {
        
        if consoleIsVisible {
            
            console.view.alpha = 0.0
            UIApplication.shared.keyWindow?.sendSubview(toBack: console.view)
        }
        else {
            
            UIApplication.shared.keyWindow?.addSubview(console.view)
            console.view.alpha = 1.0
            UIApplication.shared.keyWindow?.bringSubview(toFront: console.view)
        }
        
        consoleIsVisible = !consoleIsVisible
    }
}
