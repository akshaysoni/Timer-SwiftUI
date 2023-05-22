//
//  T+Float.swift
//  Timer
//
//  Created by Akshay Soni on 22/05/23.
//

import Foundation

extension Float {
    func roundToDecimal(_ fractionDigits: Int) -> Float {
        let multiplier = pow(10, Float(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
