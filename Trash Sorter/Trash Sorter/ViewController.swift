//
//  ViewController.swift
//  Trash Sorter
//
//  Created by Edrick Pascual on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var recycleItems = [String?]()
    var trashItems = [String?]()
    var compostItems = [String?]()
    
    @IBOutlet weak var enterItemTextField: UITextField!

    @IBOutlet weak var trashSelector: UISegmentedControl!
    
    @IBAction func saveItemButton(sender: AnyObject) {
        if let trashItem = enterItemTextField.text {
            
            switch trashSelector.selectedSegmentIndex {
                case 0:
                    recycleItems.append(trashItem)
                case 1:
                    trashItems.append(trashItem)
                case 2:
                    compostItems.append(trashItem)
            default:
                break
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


