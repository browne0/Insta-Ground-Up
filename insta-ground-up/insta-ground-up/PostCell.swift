//
//  PostCell.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/28/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    var postInfo: PFObject! {
        didSet {
            descriptionLabel.text = postInfo.valueForKey("caption") as? String
            likeCount.text = "\(postInfo.valueForKey("likesCount") as! Int) likes"
            
            if let profilePicture = postInfo.valueForKey("postImage") {
                profilePicture.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    if error == nil {
                        print("Retrieved post image!")
                        self.postImageView.image = UIImage(data: imageData!)
                        
                    } else {
                        print("There was an error retrieving post image")
                    }
                    
                    }, progressBlock: { (progress: Int32) -> Void in
                        
                })
            }
            
            let likeStatus = postInfo.valueForKey("liked") as! Bool
            
            if likeStatus == true {
                likeButton.imageView!.image = UIImage(named: "like-action-on")
            } else {
                likeButton.imageView!.image = UIImage(named: "like-action")
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
