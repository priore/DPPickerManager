//
//  ViewController.swift
//  DPPickerManager
//
//  Created by Danilo Priore on 05/02/18.
//  Copyright © 2018 Danilo Priore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func didStringsPicker() {
        
        let values = ["Value 1", "Value 2", "Value 3", "Value 4"]
        DPPickerManager.shared.showPicker(title: "Strings Picker", selected: "Value 1", strings: values) { (value, index, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
        
    }
    
    @IBAction func didDatePicker() {
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Date Picker", selected: Date(), min: min, max: max) { (date, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
            }
        }
    }
    
    @IBAction func didTimePicker() {
        DPPickerManager.shared.showPicker(title: "Time Picker", picker: { (picker) in
            picker.date = Date()
            picker.datePickerMode = .time
        }) { (date, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
            }
        }
    }

}

