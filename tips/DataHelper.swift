//
//  DataHelper.swift
//  tips
//
//  Created by Naseem on 1/12/16.
//  Copyright © 2016 Naseem. All rights reserved.
//

import Foundation

class DataHelper {

    static func saveTipPercentage(percentage: Int, index: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(percentage, forKey: "percentagePosition\(index)")
        defaults.synchronize()
    }

    static func loadTipPercentages() -> [Int] {
        var tipPercentages = [18, 20, 22]
        let defaults = NSUserDefaults.standardUserDefaults()
        for index in 0...2 {
            let tipPercentage = defaults.objectForKey("percentagePosition\(index)")
            if (tipPercentage != nil) {
                tipPercentages[index] = tipPercentage!.integerValue
            } else {
                defaults.setInteger(tipPercentages[index], forKey: "percentagePosition\(index)")

            }
        }
        defaults.synchronize()
        return tipPercentages
    }

}