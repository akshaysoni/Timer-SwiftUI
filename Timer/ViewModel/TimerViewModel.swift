//
//  TimerViewModel.swift
//  Timer
//
//  Created by Akshay Soni on 21/05/23.
//

import Foundation
import NotificationCenter

class TimerViewModel: ObservableObject {
    
    @Published var time:String = "00:00.00"
    @Published var progress:Float = 0.0
    @Published var isRunning:Bool = false
    private var timer:Timer?
    private var timeOutInseconds:Float = 0.0
    private var secondsRemaining:Float = 0.0
    private var appState:AppState?
//    private var isAppActive: Bool {
//        get {
//            return appState?.isActive ?? true
//        }
//        set {
//            if newValue == false && isRunning == true {
//                pauseTimer()
//                debugPrint("pause Timer")
//            }
//        }
//    }
    
    init(setTimerInSec: Float = 60.0) {
        self.timeOutInseconds = setTimerInSec
        self.secondsRemaining = setTimerInSec
    }
    
//    init(setTimerInSec: Float = 60.0 , isAppActive: Bool , differenceInSecOnAppActive: Int) {
//        self.timeOutInseconds = setTimerInSec
//        self.secondsRemaining = setTimerInSec
//        self.isAppActive = isAppActive
//    }
    
    func setAppState(appState:AppState) {
        self.appState = appState
//        self.isAppActive = appState.isActive
//        debugPrint("setAppState")
//        debugPrint("setAppState \(appState.isActive)")
    }
    
    func startTimer() {
        setNotification()
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] timer in
            self.secondsRemaining = self.secondsRemaining - 0.01
            progress = (secondsRemaining/timeOutInseconds).roundToDecimal(3)
            guard self.secondsRemaining > 0 else {
                self.stopTimer()
                return
            }
            self.formatTime()
        })
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        UserDefaults.setTimeRemaining(seconds: secondsRemaining)
    }
    
    func stopTimer() {
        timer?.invalidate()
        isRunning = false
        progress = 0
        secondsRemaining = 60.0
        formatTime()
        clearAllExistingNotification()
        UserDefaults.clearData()
    }
    
    func appInBackground() {
        if isRunning == true {
            timer?.invalidate()
            UserDefaults.setTimerOn(value: isRunning)
            UserDefaults.setTimeRemaining(seconds: secondsRemaining)
        }
    }
    
    func appInForeground() {
//        debugPrint("appState?.timeElapsedInBackgroundInSec \(String(describing: appState?.timeElapsedInBackgroundInSec))")
        secondsRemaining = UserDefaults.getTimeRemaining()
        debugPrint("seconds Remaining \(secondsRemaining)")
        debugPrint("appState?.timerActive \(String(describing: appState?.timerActive))")
        if appState?.timerActive == true {
            secondsRemaining = max(secondsRemaining - Float(appState?.timeElapsedInBackgroundInSec ?? 0), 0)
            debugPrint("seconds Remaining timerActive \(secondsRemaining)")
            startTimer()
        }
    }
    
    private func formatTime() {
//        let hours = Int(secondsElapsed.truncatingRemainder(dividingBy: 3600))
        let min = Int(secondsRemaining/60)
        let sec = Int(self.secondsRemaining - (Float(min)*60.0))
        let milliSec = Int(self.secondsRemaining.truncatingRemainder(dividingBy: 1) * 100)
        self.time = String(format: "%.2i:%.2i.%.2i", min, sec, milliSec)
        
//        self.time = String(format: "\(min):\(sec).\(milliSec)")
//        debugPrint("min = \(min)")
//        debugPrint("sec = \(sec)")
//        debugPrint("milliSec = \(milliSec)")
//        debugPrint("progress \(progress)")
    }
    
    private func setNotification() {
        clearAllExistingNotification()
        guard secondsRemaining > 0 else { return }
        let content = UNMutableNotificationContent()
        content.title = "Timer Demo"
        content.subtitle = "Your Countdown is over"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsRemaining) , repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func clearAllExistingNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
