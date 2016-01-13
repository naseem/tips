//
//  ViewController.swift
//  tips
//
//  Created by Naseem on 1/11/16.
//  Copyright © 2016 Naseem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipPercentages: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        updateTipControl()
        if let billAmount = DataHelper.getBillAmount() {
            billField.text = String(format: "%.2f", billAmount)
            updateTipAmount()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTipControl()
        updateTipAmount()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTipAmount()
        DataHelper.saveDefaultTip(tipControl.selectedSegmentIndex)
    }
    
    func updateTipControl() {
        tipPercentages = DataHelper.loadTipPercentages()
        for index in 0...2 {
            tipControl.setTitle("\(tipPercentages[index])%", forSegmentAtIndex: index)
        }
        tipControl.selectedSegmentIndex = DataHelper.loadDefaultTip()
    }

    func updateTipAmount() {
        if let billAmount = Double(billField.text!) {
            let tipPercentage = Double(tipPercentages[tipControl.selectedSegmentIndex])/100
            let tip = billAmount * tipPercentage
            let total = billAmount + tip
            tipLabel.text = "$\(tip)"
            totalLabel.text = "$\(total)"
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
            DataHelper.cacheBillAmount(billAmount, seconds: 600)
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

