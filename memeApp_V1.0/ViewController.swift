//
//  ViewController.swift
//  memeApp_V1.0
//
//  Created by arora_72 on 13/04/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

var memedImageIndicator:Bool = false

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var memeImage:UIImage!
    
   
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    
    //functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        if imageView.image == nil{
            shareButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
        }
        
        //keyboard notifications subscriptions
        subscibeKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsubscribing keyboard notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextField.delegate = self
        bottomTextField.delegate=self
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes=memeTextAttributes
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //actions
    
   
    @IBAction func bottomEditingDidBegin(_ sender: Any) {
        bottomTextField.text=""
    }
    @IBAction func topEditingdidBEgin(_ sender: Any) {
        topTextField.text = ""
    }
    
    
    
    @IBAction func pickImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
        
    
        
    }
    
    
    @IBAction func shareImage(_ sender: Any) {
        //let image = UIImage(named: "memeImage")
        
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            self.dismiss(animated: true, completion: nil)
        }
        present(activityController, animated: true, completion: nil)
        
        
       
    }
    
    func saveMeme(){
        //create the meme
        let memedImage = generateMemedImage()
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: memedImage)
        
        //appending to memes array in app delegate
        //(UIApplication.shared.delegate as! AppDelegate).meme.append(meme)
        
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // hiding toolbar and navbar
        self.toolBar.isHidden = true
        self.navBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //unhdinding the toolbar and navbar
        self.toolBar.isHidden = false
        self.navBar.isHidden = false
        self.memeImage = memedImage
        
        return memedImage
    }

    

    @IBAction func pickImageCamera(sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
   
    
    
    
    //hiding status bar 
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //image picking control func
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
        }else{
            print("something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    //keyboard view setting functions
    
    func subscibeKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func keyboardWillShow(_ notification:Notification) {
        if(bottomTextField.isFirstResponder){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    
    func keyboardWillHide(_ notifications:Notification){
        if(bottomTextField.isFirstResponder){
        view.frame.origin.y += getKeyboardHeight(notifications)
        }
    
    
   
    
    }


}
