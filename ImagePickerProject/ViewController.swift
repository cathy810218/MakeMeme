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
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  

  let pickerView = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.shareButton.enabled = false
    self.cameraButton.enabled = false
    self.imageView.backgroundColor = UIColor.lightGrayColor()
    self.pickerView.delegate = self
    
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
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      cameraButton.enabled = true
    }
    
    // tap gesture to dismiess keyboard when user taps anywhere else
    let tap : UITapGestureRecognizer
    tap = UITapGestureRecognizer.init(target: self, action: "dismissKeyboard")
    self.view.addGestureRecognizer(tap)
    
  }
  
  func dismissKeyboard() {
    self.view.endEditing(true)
    unsubscribeFromKeyboardNotifications()

  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()

  }
  
  
  @IBAction func pickImageBtnPressed(sender: AnyObject) {
    self.pickerView.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    self.presentViewController(pickerView, animated: true, completion: nil)
  }
  
  @IBAction func cameraButtonPressed(sender: AnyObject) {
    self.pickerView.sourceType = UIImagePickerControllerSourceType.Camera
    self.pickerView.cameraCaptureMode = .Photo
    self.presentViewController(self.pickerView, animated: true, completion: nil)
  }
  
  @IBAction func shareMemePressed(sender: AnyObject) {
    let memedImage = generateMemedImage()
    let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    activityVC.completionWithItemsHandler = { activity, success, items, error in
      if success {
        self.save(memedImage)
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
    presentViewController(activityVC, animated: true, completion: nil)
  }
  
  @IBAction func cancelButtonPressed(sender: AnyObject) {
    self.imageView.image = nil
    self.imageView.backgroundColor = UIColor.lightGrayColor()
    self.topTextfield.text = "TOP"
    self.bottomTextfield.text = "BOTTOM"
    self.dismissViewControllerAnimated(true, completion: nil)
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
    
    // add it to the memes array in AppDelegate
    let object = UIApplication.sharedApplication().delegate
    let appDelegate = object as! AppDelegate
    appDelegate.memes.append(meme)
  }
  
  func generateMemedImage() -> UIImage {
    
    // Hide the toolbar
    self.topToolbar.hidden = true
    self.bottomToolbar.hidden = true
    
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
    let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
        
    // Set the toolbar
    self.topToolbar.hidden = false
    self.bottomToolbar.hidden = false
    
    return memedImage
  }
  
  // MARK: - UIImagePickerViewDelegate
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      self.imageView.image = image
      self.shareButton.enabled = true
      self.imageView.backgroundColor = UIColor.clearColor()
    }
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    unsubscribeFromKeyboardNotifications()

    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    // clean up the default text
    if (textField == topTextfield && topTextfield.text == "TOP") {
      topTextfield.text = ""
    }
    if (textField == bottomTextfield && bottomTextfield.text == "BOTTOM") {
      bottomTextfield.text = ""
    }
    if textField.isEqual(bottomTextfield) {
      // only subscribe when clicking the bottom textfield
      subscribeToKeyboardNotifications()
    }
  }

}

