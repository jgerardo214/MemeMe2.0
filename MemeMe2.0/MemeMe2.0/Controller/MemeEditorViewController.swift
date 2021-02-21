//
//  MemeEditorViewController.swift
//  MemeMe2.0
//
//  Created by Jonathan Gerardo on 1/23/21.
//
import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navigationBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    
    // Sets Text Attributes to font and properties
    let memeAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "Impact", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField(topTextField, text: "TOP")
        setTextField(bottomTextField, text: "BOTTOM")
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check if Camera is available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        
        
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
        
    }
    
    // MARK: Textfield Properties
    
    // sets properties of the textfields
    func setTextField (_ textField: UITextField, text: String) {
        
        textField.defaultTextAttributes = memeAttributes
        textField.textAlignment = .center
        textField.textAlignment = .center
        textField.text = text
        textField.delegate = self
        textField.borderStyle = .none
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // clears the default text once typing begins
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    //MARK: Keyboard Functions
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
            
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
    }
    
   
    
    
    //MARK: Image Picker Functions
    
    @IBAction func imageSelected(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let sharedImage = generateMeme()
        let controller = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed && error == nil {
                self.saveMemedImage()
            }
        }
        controller.isModalInPresentation = true
        present(controller, animated: true, completion: nil)
    }
    
 
    
   
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func saveMemedImage() {
        _ = generateMeme()
               
        let meme = Meme(topText: topTextField.text!,
                        bottomText: bottomTextField.text!,
                        originalImage: imagePickerView.image!,
                        memedImage: imagePickerView.image!)
        
        // saves the meme to the shared appDelegate 
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    
    
    @IBAction func cancelMeme(_ sender: Any) {
        // Cancel button resets to original default text and no image 
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        
    }
    
    
    func generateMeme() -> UIImage {
        
        
        // Hide toolbar
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        //render to viewer
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsGetCurrentContext()
        
        // Show toolbar
        navigationBar.isHidden = false
        toolBar.isHidden = false
        
        
        return memeImage
    }
    
    
    
    
    
    @IBAction func pickImageCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    
}


