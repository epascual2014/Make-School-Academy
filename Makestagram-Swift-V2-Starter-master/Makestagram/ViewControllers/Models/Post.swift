//
//  Post.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/28/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {

    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    //MARK: PFSubclassing Protocol
    static func parseClassName() -> String {
        return "Post"
    }
    
    override init() {
        super.init()
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
}
