//
//  PhotoManagerViewController.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/28/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit

class PhotoManagerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController!
    
    
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        chooseImageButton.titleLabel?.text = ""
        
        postImage.image = resize(editedImage, newSize: CGSize(width: 280, height: 280))
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPost(sender: AnyObject) {
        if postImage.image != nil {
            UserMedia.postUserImage(postImage.image, withCaption: captionLabel.text) { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("success posting image!")
                    self.performSegueWithIdentifier("chosePhotoSegue", sender: nil)
                } else {
                    print("error posting image!")
                }
            }
        }
    }
    
    
    @IBAction func onSelectImage(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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