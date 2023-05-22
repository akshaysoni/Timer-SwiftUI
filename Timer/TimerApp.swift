//
//  TimerApp.swift
//  Timer
//
//  Created by Akshay Soni on 21/05/23.
//

import SwiftUI

@main
struct TimerApp: App {
    
    let appState = AppState()
    
    init() {
        registerForNotification()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject( appState )
        }
    }
    
    func registerForNotification() {
        
        UIApplication.shared.registerForRemoteNotifications()
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if granted {
                debugPrint("Granted")
            }
            else {
                debugPrint("Error \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
}
