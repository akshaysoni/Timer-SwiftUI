//
//  AppState.swift
//  Timer
//
//  Created by Akshay Soni on 22/05/23.
//

import UIKit

class AppState: ObservableObject {
    
    @Published var isActive: Bool = false
    var timerActive: Bool = false
    var timeElapsedInBackgroundInSec:Int = 0 
    
    private var observers = [NSObjectProtocol]()

    init() {
        observers.append(
            NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
                self.isActive = false
                UserDefaults.setDate(date: Date())
                UserDefaults.setTimerOn(value: self.timerActive)
//                debugPrint("didEnterBackgroundNotification")
            }
        )
        observers.append(
            NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
                self.timerActive = UserDefaults.getIsTimerOn()
//                debugPrint("didBecomeActiveNotification")
                if self.timerActive {
                    if let _date = UserDefaults.getDate() {
                        let difference = Date().seconds(from: _date)
                        self.timeElapsedInBackgroundInSec = difference
                        debugPrint("timeElapsedInBackgroundInSec \(difference)")
                    }
                }
                self.isActive = true
                UserDefaults.removeDate()
                
            }
        )
    }
    
    deinit {
        observers.forEach(NotificationCenter.default.removeObserver)
    }
}
