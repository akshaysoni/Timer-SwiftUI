import UIKit

var greeting = "Hello, playground"
formatTime()



//private func formatTime() {
//
//    let secondsRemaining:Float = 58.0
//    let min = secondsRemaining.truncatingRemainder(dividingBy: 60)
//    let sec = secondsRemaining - (Float(min)*60.0)
//    let milliSec = secondsRemaining.remainder(dividingBy: 1) * 1000
//    let time = String(format: "%02i:%02i.%03i", min, sec, milliSec)
//    debugPrint("min = \(min)")
//    debugPrint("sec = \(sec)")
//    debugPrint("milliSec = \(milliSec)")
//    debugPrint(time)
//}

private func formatTime() {

    let secondsRemaining:Float = 62.345
    let min = Int(secondsRemaining/60)
    let sec = Int(secondsRemaining - (Float(min)*60.0))
    let milliSec = Int(secondsRemaining.remainder(dividingBy: 1) * 1000)
//    let time = String(format: "%02i:%02i.%03i", min, sec, milliSec)
    debugPrint("min = \(min)")
    debugPrint("sec = \(sec)")
    debugPrint(String(format: "%.2i:%.2i:%.3i", min, sec, milliSec))
//    debugPrint("milliSec = \(milliSec)")
//    debugPrint(time)
}
