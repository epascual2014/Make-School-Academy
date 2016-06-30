//
//  ViewController.swift
//  Delegates
//
//  Created by Edrick Pascual on 6/30/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        print(#function)
        
        // Using Tags for selecting which textField to use.
        if textField.tag == 1 {
            print("1")
            
        } else if textField.tag == 2 {
             print("2")
            
        }
    }
    
    

    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let cities = ["city1","city2", "city3"]

    
    @IBOutlet weak var textFieldOne: UITextField!
    
    @IBOutlet weak var textFieldTwo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count 
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    
    
}
