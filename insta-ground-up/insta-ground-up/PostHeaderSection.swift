//
//  PostHeaderSection.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/28/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import Parse

class PostHeaderSection: UITableViewHeaderFooterView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var creationTimeLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    

}
