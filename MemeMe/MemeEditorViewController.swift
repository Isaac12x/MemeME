//
//  ViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 15/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    var meme: Meme?
    
    
    @IBOutlet weak var imageViewController: UIImageView!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UINavigationItem!
    
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Top textfield setup
        topTextField.text =  "top"
        settingStyleVariables(topTextField)
        
        // Bottom textfield setup
        bottomTextField.text = "bottom"
        settingStyleVariables(bottomTextField)
        
        actionButton.enabled = false
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyBoardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //IMAGE
    
    // Pick an image method
    func pickImage(argument: UIImagePickerControllerSourceType) {
        let pickImage = UIImagePickerController()
        pickImage.delegate = self
        pickImage.sourceType = argument
        presentViewController(pickImage, animated: true, completion: nil)
    }
    
    // Pick image from the camera
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        pickImage(UIImagePickerControllerSourceType.Camera)
    }
    
    // Pick an image from the album
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        pickImage(UIImagePickerControllerSourceType.SavedPhotosAlbum)
    }
    
    // Display the image in the imageView
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewController.image = image
            if imageViewController != nil {
                actionButton.enabled = true
            } else {
                actionButton.enabled = false
            }
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            func imagePickerControllerDidCancel(picker: UIImagePickerController) {
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    
    //TEXTFIELDS
    
    // A dictionary with the text fields Atrributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0,
    ]
    
    func settingStyleVariables(textField: UITextField!) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.delegate = self
    }
    
    // Clear text for placeholder text
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    // Dismiss the keyboard when the user presses return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    //KEYBOARD
    
    // Subscribe to notifications to receive keyboard height
    func subscribeToKeyBoardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Function to show the keyboard moving the view up the same amount of height the keyboard has
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() == true {
            view.frame.origin.y -= getKeyboardHeight(notification)
        } else {
            view.frame.origin.y = 0
        }
    }
    
    // The actual function that calculates the height of the keyboard.
    func getKeyboardHeight(notification: NSNotification)-> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // Function to unsubscribe from the notifications for showing the keyboard
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object:nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object:nil)
    }
    
    // Function to hide the keyboard the exact height it has
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    
    //DATA MODEL
    
    // create a meme object and add it to thC memes array
    func save() {
        
        // Update the meme
        let meme = Meme( topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, image: imageViewController.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array on the Application Delegate
        //(UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // Create a UIImage that combines the Image View and the Labels
    func generateMemedImage() -> UIImage {
        
        // Hide navigation and toolbar before createing the image
        navBar.hidden = true
        bottomToolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Re show the navigation and toolbar after creating the image
        navBar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    
    // Sharing your meme
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems:[image], applicationActivities:nil)
        
        controller.completionWithItemsHandler = {
            (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in
            if ok{
                self.save()
            }else{
                controller.dismissViewControllerAnimated(true, completion: nil )
            }
            }
        presentViewController(controller, animated: true, completion: nil)
        }
            
    
    
    // Cancel your actions
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        imageViewController.image = nil
        topTextField.text = "top"
        bottomTextField.text = "bottom"
    }

    
    
        
    
}


