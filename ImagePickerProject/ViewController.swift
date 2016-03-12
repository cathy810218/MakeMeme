//
//  ViewController.swift
//  ImagePickerProject
//
//  Created by Cathy Oun on 3/7/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topTextfield: UITextField!
  @IBOutlet weak var bottomTextfield: UITextField!
  @IBOutlet weak var topToolbar: UIToolbar!
  @IBOutlet weak var bottomToolbar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  
  let selectionAlert = UIAlertController(title: "Choose your photo", message: "from the gallery or camera", preferredStyle: UIAlertControllerStyle.ActionSheet)
  let pickerView = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    shareButton.enabled = false
    imageView.backgroundColor = UIColor.lightGrayColor()
    
    // TextField Attributes
    let memeTextfieldAttributes = [
      NSStrokeColorAttributeName : UIColor.blackColor(),
      NSForegroundColorAttributeName : UIColor.whiteColor(),
      NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSStrokeWidthAttributeName : -1.0 // positive for stroke, negative for both stroke and fill
    ]
    topTextfield.defaultTextAttributes = memeTextfieldAttributes
    bottomTextfield.defaultTextAttributes = memeTextfieldAttributes
    topTextfield.text = "TOP"
    bottomTextfield.text = "BOTTOM"
    topTextfield.textAlignment = .Center
    bottomTextfield.textAlignment = .Center
    topTextfield.delegate = self
    bottomTextfield.delegate = self
    
    // AlertView actions
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
    let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { (alert) -> Void in
      self.showGallery()
    }
    let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
      self.pickerView.sourceType = UIImagePickerControllerSourceType.Camera
      self.pickerView.cameraCaptureMode = .Photo
      self.presentViewController(self.pickerView, animated: true, completion: nil)
    }
    
    // Add alert actions
    selectionAlert.addAction(galleryAction)
    // check if the camera sourse is available
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      selectionAlert.addAction(cameraAction)
    }
    selectionAlert.addAction(cancelAction)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  
  @IBAction func pickImageBtnPressed(sender: AnyObject) {
    
    selectionAlert.modalPresentationStyle = UIModalPresentationStyle.Popover
    if let popover = selectionAlert.popoverPresentationController {
      popover.sourceView = view
    }
    self.presentViewController(selectionAlert, animated: true, completion: nil)
    
  }
  
  func showGallery() {
    pickerView.delegate = self
    pickerView.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    self.presentViewController(pickerView, animated: true, completion: nil)
  }
  
  // MARK: - NSNotification
  func keyboardWillShow(notification: NSNotification) {
    self.view.frame.origin.y -= getKeyboardHeight(notification)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    self.view.frame.origin.y += getKeyboardHeight(notification)
  }
  
  func subscribeToKeyboardNotifications() {
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "keyboardWillShow:",
      name: UIKeyboardWillShowNotification,
      object: nil)
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "keyboardWillHide:",
      name: UIKeyboardWillHideNotification,
      object: nil)
    
  }
  
  func unsubscribeFromKeyboardNotifications() {
    
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: UIKeyboardWillShowNotification,
      object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self,
      name: UIKeyboardWillHideNotification,
      object: nil)
    
  }
  
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.CGRectValue().height
    
  }
  
  // MARK: - Save Memed image
  func save(memedImage: UIImage) {
    
    let meme = Meme(topText: topTextfield.text!,
      botText: bottomTextfield.text!,
      originalImage: imageView.image!,
      memedImage : memedImage)
  }
  
  func generateMemedImage() -> UIImage {
    
    // Hide the toolbar
    topToolbar.hidden = true
    bottomToolbar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
    let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
        
    // Set the toolbar
    topToolbar.hidden = false
    bottomToolbar.hidden = false
    
    return memedImage
  }
  
  @IBAction func shareMemePressed(sender: AnyObject) {
    let memedImage = generateMemedImage()
    let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    activityVC.completionWithItemsHandler = { activity, success, items, error in
      if success {
        self.save(memedImage)
      }
    }
    presentViewController(activityVC, animated: true, completion: nil)
  }
  
  @IBAction func cancelButtonPressed(sender: AnyObject) {
    imageView.image = nil
    imageView.backgroundColor = UIColor.lightGrayColor()
    topTextfield.text = "TOP"
    bottomTextfield.text = "BOTTOM"
    
  }
  
  // MARK: - UIImagePickerViewDelegate
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      imageView.image = image
      shareButton.enabled = true
      imageView.backgroundColor = UIColor.clearColor()
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    // clean up the default text
    textField.text = ""
    if textField.isEqual(bottomTextfield) {
      // only subscribe when clicking the bottom textfield
      subscribeToKeyboardNotifications()
    }
  }
  
}

