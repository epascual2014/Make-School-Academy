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

    
    var posts: [Post] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        // Follow relationships query for current user
        let followingQuery = PFQuery(className: "Follow")
        followingQuery.whereKey("fromUser", equalTo: PFUser.currentUser()!)
    
        // Fetch posts from Followed Users
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
    
        // Query to retrieve all posts from current user
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
    
        // Combines 2nd and 3rd queries to return any posts.
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        
        // Fetch PFUser
        query.includeKey("user")
        // Results are ordered by descending order
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            
            // Received all posts in an array.
            self.posts = result as? [Post] ?? []
            
            for post in self.posts {
                do {
                    let data = try post.imageFile?.getData()
                    post.image = UIImage(data: data!, scale: 1.0)
                    
                } catch {
                    print("could not get image")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
}

// MARK: Tab Bar Delegate

extension TimelineViewController: UITabBarControllerDelegate, UITableViewDataSource {
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell

        cell.postImageView.image = posts[indexPath.row].image
        
        return cell
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