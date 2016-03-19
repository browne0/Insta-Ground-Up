//
//  PostCell.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/28/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class PostCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    var objectID: String?
    
    var postInfo: PFObject! {
        didSet {
            descriptionLabel.text = postInfo.objectForKey("caption") as? String
            if postInfo.objectForKey("likesCount") as! Int == 1 {
                likeCount.text = "\((postInfo.objectForKey("likesCount") as! Int)) like"
            } else {
                likeCount.text = "\((postInfo.objectForKey("likesCount") as! Int)) likes"
            }
            objectID = postInfo.objectId
            let likeStatus = postInfo.objectForKey("liked") as! Bool
            
            if likeStatus == true {
                likeButton.setImage(UIImage(named: "like-action-on"), forState: .Normal)
            } else {
                likeButton.setImage(UIImage(named: "like-action"), forState: .Normal)
            }
        }
    }
    
    @IBAction func onLike(sender: AnyObject) {
        
        if likeButton.imageView?.image == UIImage(named: "like-action") {
            UserMedia.likePost(objectID!)
            likeButton.setImage(UIImage(named: "like-action-on"), forState: .Normal)
            if (postInfo.objectForKey("likesCount") as! Int) + 1 == 1 {
                likeCount.text = "\((postInfo.objectForKey("likesCount") as! Int) + 1) like"
            } else {
                likeCount.text = "\((postInfo.objectForKey("likesCount") as! Int) + 1) likes"
            }
        } else if likeButton.imageView?.image == UIImage(named: "like-action-on") {
            UserMedia.unlikePost(objectID!)
            likeButton.setImage(UIImage(named: "like-action"), forState: .Normal)
            likeCount.text = "\((postInfo.objectForKey("likesCount") as! Int)) likes"
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
