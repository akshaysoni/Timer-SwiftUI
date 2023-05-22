//
//  AS+UserDefaults.swift
//  Timer
//
//  Created by Akshay Soni on 22/05/23.
//

import Foundation

extension UserDefaults {
    
    private enum Keys: String {
        case isTimerOn = "isTimerOn"
        case secondsRemaining = "secondsRemaining"
        case date = "date"
    }
    
    static func setDate(date:Date) {
        standard.set(date, forKey: Keys.date.rawValue)
        standard.synchronize()
    }
    
    static func getDate() -> Date? {
        return standard.object(forKey: Keys.date.rawValue) as? Date
    }
    
    static func removeDate() {
        standard.removeObject(forKey: Keys.date.rawValue)
        standard.synchronize()
    }
    
    ///
    
    static func setTimeRemaining(seconds:Float) {
        standard.set(seconds, forKey: Keys.secondsRemaining.rawValue)
        standard.synchronize()
    }
    
    static func getTimeRemaining() -> Float {
        return standard.float(forKey: Keys.secondsRemaining.rawValue)
    }
    
    static func removeTimeRemaining() {
        standard.removeObject(forKey: Keys.secondsRemaining.rawValue)
        standard.synchronize()
    }
    
    
    ///
    
    static func setTimerOn(value:Bool) {
        standard.set(value, forKey: Keys.isTimerOn.rawValue)
        standard.synchronize()
    }
    
    static func getIsTimerOn() -> Bool {
        return standard.bool(forKey: Keys.isTimerOn.rawValue)
    }
    
    static func removeIsTimerOn() {
        standard.removeObject(forKey: Keys.isTimerOn.rawValue)
        standard.synchronize()
    }
    
    static func clearData() {
        standard.removeObject(forKey: Keys.date.rawValue)
        standard.removeObject(forKey: Keys.isTimerOn.rawValue)
        standard.synchronize()
    }
}
