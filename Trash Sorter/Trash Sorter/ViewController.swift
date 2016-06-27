//
//  ViewController.swift
//  Trash Sorter
//
//  Created by Edrick Pascual on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var recycledItems = [String?]()
    var trashedItems = [String?]()
    var compostedItems = [String?]()
    
    @IBOutlet weak var enterItemTextField: UITextField!

    @IBOutlet weak var trashSelector: UISegmentedControl!
    
    @IBAction func saveItemButton(sender: AnyObject) {
        
        if ((enterItemTextField.text?.validateEntry()) != nil) {
            
            switch trashSelector.selectedSegmentIndex {
                case 0:
                    recycledItems.append(enterItemTextField.text!)
                case 1:
                    trashedItems.append(enterItemTextField.text!)
                case 2:
                    compostedItems.append(enterItemTextField.text!)
            default:
                break
            }
        }
        enterItemTextField.text = ""
        print(recycledItems, trashedItems, compostedItems)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainMenuIdentifier" {
            if let garbageMenuTableViewController = segue.destinationViewController as? GarbageMenuTableViewController {
                garbageMenuTableViewController.recycledItems = recycledItems
                garbageMenuTableViewController.trashedItems = trashedItems
                garbageMenuTableViewController.compostedItems = compostedItems
                
            }
        }
    }
    
    
    
}

extension String {
    func validateEntry() -> Bool {
        if self == "" || self.isEmpty {
            return false
        } else {
            return true
        }
    }
}

