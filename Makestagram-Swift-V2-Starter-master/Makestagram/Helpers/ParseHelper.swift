//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Edrick Pascual on 6/29/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    // Following Relation
    static let ParseFollowClass = "Follow"
    static let ParseFollowFromUser = "fromUser"
    static let ParseFollowToUser = "toUser"
    
    // Like Relation
    static let ParseLikeClass = "Like"
    static let ParseLikeToPost = "toPost"
    static let ParseLikeFromUser = "fromUser"
    
    // Post Relation
    static let ParsePostUser = "user"
    static let ParsePostCreatedAt = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost = "toPost"
    
    // User Relation
    static let ParseUserUsername = "username"
    
    static func timelineRequestForCurrentUser(range: Range<Int>, completionBlock: PFQueryArrayResultBlock) {
        
        // fetch follow relationship for the current user
        let followingQuery = PFQuery(className: ParseFollowClass)
        followingQuery.whereKey(ParseFollowFromUser, equalTo:PFUser.currentUser()!)
        
        // Fetch any posts that are created by users that currentl user is following
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey(ParsePostUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
        
        // Fetch current user posts
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
        
        // Combine 2 queries
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        
        // definte that the combined query should fetch the user assoc with the post
        query.includeKey(ParsePostUser)
        
        // define the order of the results to be stored
        query.orderByDescending(ParsePostCreatedAt)
        
        
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        // kick off the network request
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    // MARK: Likes
    static func likePost(user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseLikeClass)
        likeObject[ParseLikeFromUser] = user
        likeObject[ParseLikeToPost] = post
        likeObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    // MARK: Unlikes
    static func unlikePost(user: PFUser, post: Post) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeFromUser, equalTo: user)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            if let actualResults = results  {
                for likes in actualResults {
                    likes.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
                }
            }
            else if let actualError = error {
                ErrorHandling.defaultErrorHandler(error!)
                print(actualError)
            }
        }
    }
    
    static func likesForPost(post: Post, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeToPost, equalTo: post)
        query.includeKey(ParseLikeFromUser)
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
    // MARK: Following
    /*
        Fetchers all user that the provided user is following.
        :param: user - The user whose followees you want to retrieve
        :param: completionBlock - The completion block that is called when the query completes
    */
    
    static func getFollowingUsersForUser(user: PFUser, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseFollowClass)
        
        query.whereKey(ParseFollowFromUser, equalTo: user)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    /**
     :param: user - The user that is following
     :param: toUser - The user that is being followed
     */
    static func addFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let thisFollowObject = PFObject(className: ParseFollowClass)
        
        thisFollowObject.setObject(user, forKey: ParseFollowFromUser)
        
        thisFollowObject.setObject(toUser, forKey: ParseFollowToUser)
        
        thisFollowObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    /**
     :param: user - The user that is following
     :param: toUser - The user that is being followed
     */

    static func removeFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let thisQuery = PFQuery(className: ParseFollowClass)
        thisQuery.whereKey(ParseFollowFromUser, equalTo: user)
        thisQuery.whereKey(ParseFollowToUser, equalTo: toUser)
        
        thisQuery.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            let results = results ?? []
            
            for follow in results {
                follow.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
            }
        }
    }
    
    // MARK: Users
    /**
     Fetch all users except the ones thats currently signed in.
     Limits the amount of users returned to 20.
     :param: completionBlock - The completion block that is called when the query completes.
     :returns: The generated PFQuery
    */
    
    static func allUsers(completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        let currentQuery = PFUser.query()!
        
        // exclude the current user
        currentQuery.whereKey(ParseHelper.ParseUserUsername,
                              notEqualTo: PFUser.currentUser()!.username!)
        currentQuery.orderByAscending(ParseHelper.ParseUserUsername)
        currentQuery.limit = 20
        
        currentQuery.findObjectsInBackgroundWithBlock(completionBlock)
        return currentQuery
    }
    
    /**
     Fetch users whose usernames match the provided search term.
     :param: searchText - The text that should be used to search for users.
     :param: completionBlock - The completion block that is called when the query completes.
     :returns: The generated PFQuery
     */
    
    static func searchUsers(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        /** We are using a Regex to allow for a case insensitive compare of usernames.
        Regex can be slow on large datasets. For large amount of data it's better to store
        lowercased username in a separate column and perform a regular string compare.
        */
        
        let thisQuery = PFUser.query()!.whereKey(ParseHelper.ParseUserUsername,
                                             matchesRegex: searchText, modifiers: "i")
        thisQuery.whereKey(ParseHelper.ParseUserUsername,
                           notEqualTo: PFUser.currentUser()!.username!)
        
        thisQuery.orderByAscending(ParseHelper.ParseUserUsername)
        thisQuery.limit = 20
        thisQuery.findObjectsInBackgroundWithBlock(completionBlock)
        
        return thisQuery
    }
}

extension PFObject {
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if (object as? PFObject)?.objectId == self.objectId {
            return true
        } else {
            return super.isEqual(object)
        }
    }
}
