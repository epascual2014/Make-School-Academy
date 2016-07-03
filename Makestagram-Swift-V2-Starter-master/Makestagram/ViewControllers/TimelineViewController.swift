//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit

var photoTakingHelper: PhotoTakingHelper?

class TimelineViewController: UIViewController, TimelineComponentTarget {

    var posts: [Post] = []
    
    let defaultRange = 0...4
    let additionalRangeSize = 5
    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        ParseHelper.timelineRequestForCurrentUser(range) { (result: [PFObject]?, error: NSError?) -> Void in
            
            let posts = result as? [Post] ?? []
            completionBlock(posts)
        }
    }
    
    var timelineComponent: TimelineComponent <Post, TimelineViewController>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        timelineComponent = TimelineComponent(target: self)
        self.tabBarController?.delegate = self
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        timelineComponent.loadInitialIfRequired()

    }

}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
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
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) {
            (image: UIImage?) in
            print("received a callback")
            let post = Post()
            post.image.value = image!
            post.uploadPost()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        let post = timelineComponent.content[indexPath.section]
        post.downloadImage()
        post.fetchLikes()
        cell.post = post

        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.section)
    }
    
    //MARK: protocols for height and displaying the header.
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("PostHeader") as! PostSectionHeaderViewTableView
        
        let post = self.timelineComponent.content[section]
        headerCell.post = post
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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