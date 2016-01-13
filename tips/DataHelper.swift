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

    static func saveDefaultTip(index: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "defaultTipPercentageIndex")
        defaults.synchronize()
    }

    static func loadDefaultTip() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.objectForKey("defaultTipPercentageIndex")
        return (tipIndex == nil) ? 1 : tipIndex!.integerValue
    }
    
    static func cacheBillAmount(billAmount: Double, seconds: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let expirationTime = NSDate().timeIntervalSince1970 + NSTimeInterval(seconds)
        defaults.setObject(["amount": billAmount, "exp": expirationTime], forKey: "billAmountAndExpiration")
    }

    static func getBillAmount() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        let billAmountAndExpiration = defaults.objectForKey("billAmountAndExpiration")
        if (billAmountAndExpiration == nil) {
            return nil
        }
        let billAmount = Double(billAmountAndExpiration!["amount"] as! NSNumber)
        let expiration = Double(billAmountAndExpiration!["exp"]as! NSNumber)
        if (NSDate().timeIntervalSince1970 > expiration) {
            return nil
        }
        return billAmount
    }

}