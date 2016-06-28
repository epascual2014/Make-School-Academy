//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

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
            print("received a callback")
            let post = Post()
            post.image = image
            post.uploadPost()
        }
    }
}
//        
//            
//            if let image = image {
//                
//                // mandatory image quality between 0.0 to 1.0
//                let imageData = UIImageJPEGRepresentation(image, 0.8)!
//                
//                // Turn image into NSData and name it. 
//                // .jpg makes it easier to look on uploaded photos
//                let imageFile = PFFile(name: "image.jpg", data: imageData)!
//                
//                // Assign imageFile to the class "post" related in Parse.
//                let post = PFObject(className: "Post")
//                post["imageFile"] = imageFile
//                post.saveInBackground()
//                
//                print("image posted and saved in parse")
//                
//            }
//        
//        }
//    }