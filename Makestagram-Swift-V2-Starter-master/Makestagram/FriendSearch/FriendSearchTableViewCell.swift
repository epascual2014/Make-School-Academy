//
//  FriendSearchTableViewCell.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/30/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

protocol FriendSearchTableViewCellDelegate: class {
    func cell(cell: FriendSearchTableViewCell, didSelectFollowUser user: PFUser)
    func cell(cell: FriendSearchTableViewCell, didSelectUnfollowUser user: PFUser)
}

class FriendSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var followUserButton: UIButton!
    
    // Property delegate
    weak var delegate: FriendSearchTableViewCellDelegate?
    
    var user: PFUser? {
        didSet {
            userNameLabel.text = user?.username
        }
    }
    
    var canFollow: Bool? = true {
        didSet {
            /*
             Change the state of the follow button based on whether or not it is possible to follow a user.
             */

            if let userCanFollow = canFollow {
                followUserButton.selected = !userCanFollow
            }
        }
    }
    
    @IBAction func followUserTapped(sender: AnyObject) {
        if let thisUserCanFollow = canFollow where thisUserCanFollow == true {
            delegate?.cell(self, didSelectFollowUser: user!)
            self.canFollow = false
        } else {
            delegate?.cell(self, didSelectUnfollowUser: user!)
            self.canFollow = true
        }
        
    }
    
    
}
