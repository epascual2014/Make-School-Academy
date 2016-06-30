//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/29/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
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
