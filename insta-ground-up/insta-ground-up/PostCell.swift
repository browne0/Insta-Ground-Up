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
            descriptionLabel.text = postInfo.objectForKey("caption") as? String
            likeCount.text = "\(postInfo.objectForKey("likesCount") as! Int) likes"
            
            let likeStatus = postInfo.objectForKey("liked") as! Bool
            
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
