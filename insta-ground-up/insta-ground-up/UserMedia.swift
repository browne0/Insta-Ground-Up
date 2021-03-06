//
//  UserMedia.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/25/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import Parse

class UserMedia: NSObject {
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        media["postImage"] = getPFFileFromImage(image) // PFFile column type
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        media["liked"] = false
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func likePost(id: String) {
        let query = PFQuery(className: "UserMedia")
        
        query.getObjectInBackgroundWithId(id) {
            (userMedia: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let userMedia = userMedia {
                userMedia.incrementKey("likesCount")
                userMedia["liked"] = true
                userMedia.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("Successfully liked!")
                    } else {
                        print(error?.description)
                    }
                }
            }
        }
    }
    
    class func unlikePost(id: String) {
        let query = PFQuery(className: "UserMedia")
        
        query.getObjectInBackgroundWithId(id) {
            (userMedia: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let userMedia = userMedia {
                userMedia.incrementKey("likesCount", byAmount: -1)
                userMedia["liked"] = false
                userMedia.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("Successfully unliked!")
                    } else {
                        print(error?.description)
                    }
                }
            }
        }
    }
    
    class func getPosts(completion: (posts: [PFObject]?, error: NSError?) -> ()) {
        let query = PFQuery(className: "UserMedia")
        query.limit = 20
        query.includeKey("author")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("posts retrieved")
                completion(posts: posts, error: nil)
            } else {
                print("Error fetching the posts: \(error.debugDescription)")
                completion(posts: nil, error: error)
            }
        }
    }
    
}
