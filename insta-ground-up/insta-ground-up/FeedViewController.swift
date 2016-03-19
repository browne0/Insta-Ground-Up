//
//  FeedViewController.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/28/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserMedia.getPosts { (posts, error) -> () in
            if error == nil {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
        
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "PostHeaderSection", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "PostHeaderSection")
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        cell.postInfo = self.posts![indexPath.section]
        let media = cell.postInfo.objectForKey("postImage")
        media!.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                cell.postImageView.image = UIImage(data: data!)
            }
        })
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let posts = posts {
            return posts.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(45.0)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("PostHeaderSection")
        let header = cell as! PostHeaderSection
        
        header.contentView.backgroundColor = UIColor.whiteColor()
        
        
        let media = posts![section]
        let user = media["author"] as! PFUser
        
        header.usernameButton.titleLabel?.text = user.username
        
//        let formatter = NSDateFormatter()
//        let createdAt = "\(media.createdAt!)"
//        let timestamp = formatter.dateFromString(createdAtString)
        let time = Int((media.createdAt!.timeIntervalSinceNow))
        
        if -time < 60 {
            header.creationTimeLabel.text = "\(-time)s"
        } else if -time <= 3600 {
            header.creationTimeLabel.text = "\(-time/60)m"
        } else if -time <= 86400 {
            header.creationTimeLabel.text = "\(-time/3600)h"
        } else if -time <= 2073600 {
            header.creationTimeLabel.text = "\(-time/86400)d"
        } else {
            header.creationTimeLabel.text = "\(-time/60)mon"
        }
        
//        header.usernameButton.titleLabel!.text = userMedia.valueForKey("author") as? String
//        header.creationTimeLabel.text = userMedia.objectForKey("createdAt") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 503
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
