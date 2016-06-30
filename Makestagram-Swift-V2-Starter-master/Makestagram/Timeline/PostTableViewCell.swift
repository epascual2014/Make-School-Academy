//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/29/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
        
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        
    }
    
    
    var post: Post? {

        didSet {
            if let post = post {
                // bind the image of the post to the "postImage" view
                post.image.bindTo(postImageView.bnd_image)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
