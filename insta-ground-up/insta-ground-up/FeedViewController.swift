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
                print(posts)
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
        
        cell.postInfo = posts![indexPath.row]
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
        
//        header.usernameButton.titleLabel!.text = posts["author"]
//        header.creationTimeLabel.text = postInfo.valueForKey("createdAt") as? String
        
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
