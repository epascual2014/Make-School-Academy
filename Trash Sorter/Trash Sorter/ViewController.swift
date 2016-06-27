//
//  ViewController.swift
//  Trash Sorter
//
//  Created by Edrick Pascual on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var enterItemTextField: UITextField!

    @IBOutlet weak var trashSelector: UISegmentedControl!
    
    @IBOutlet weak var saveItemButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

