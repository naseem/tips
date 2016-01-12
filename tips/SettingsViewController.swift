//
//  SettingsViewController.swift
//  tips
//
//  Created by Naseem on 1/12/16.
//  Copyright © 2016 Naseem. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var percentPicker: UIPickerView!
    let percents = [Int](1...50)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.percentPicker.dataSource = self
        self.percentPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let tipPercentages = DataHelper.loadTipPercentages()
        for index in 0...2 {
            percentPicker.selectRow(tipPercentages[index] - 1, inComponent: index, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percents.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(percents[row])"
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     print(row)
        DataHelper.saveTipPercentage(percents[row], index: component)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
