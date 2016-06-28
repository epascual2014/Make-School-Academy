//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

var photoTakingHelper: PhotoTakingHelper?

class TimelineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
    }
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        if (viewController is PhotoViewController) {
            takePhoto()
            print("Take Photo")
            return false
        } else {
            return true
        }
    }
    
    func takePhoto() {
        // Instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
        
        }
    }
}