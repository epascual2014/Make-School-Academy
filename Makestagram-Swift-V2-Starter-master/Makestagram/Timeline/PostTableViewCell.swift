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
    
    var postDisposable: DisposableType?
    var likeDisposable: DisposableType?
    
    var post: Post? {

        didSet {
            
            postDisposable?.dispose()
            likeDisposable?.dispose()
            if let post = post {
                
                // bind the image of the post to the "postImage" view
                postDisposable = post.image.bindTo(postImageView.bnd_image)
                likeDisposable = post.likes.observe { (value: [PFUser]?) -> Void in
                    if let actualValue = value {
                        self.likesLabel.text = self.stringFromUserList(actualValue)
                        self.likeButton.selected = actualValue.contains(PFUser.currentUser()!)
                        self.likeIconImageView.hidden = (actualValue.count == 0)
                        
                    } else {
                        self.likesLabel.text = ""
                        self.likeButton.selected = false
                        self.likeIconImageView.hidden = true
                    }
                }
                
            }
        }
    }

    
    func stringFromUserList(userList: [PFUser]) -> String {
        let usernameList = userList.map {
            user in user.username!
        }
        let commaSeparatedUserList = usernameList.joinWithSeparator(",")
        
        return commaSeparatedUserList
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
