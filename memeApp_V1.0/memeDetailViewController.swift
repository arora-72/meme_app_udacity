//
//  memeDetailViewController.swift
//  memeApp_V1.0
//
//  Created by arora_72 on 15/04/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

class memeDetailViewController: UIViewController {
    
    var memeSelected: Meme!
    
    
    @IBOutlet weak var detailImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    
        detailImageView.image = memeSelected.memedImage
        
        detailImageView.contentMode = .scaleAspectFit
    }
    @IBAction func shareAction(_ sender: Any) {
        
        let m = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [m], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            
           
            self.dismiss(animated: true, completion: nil)
        }
        present(activityController, animated: true, completion: nil)

        
        
    }
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
         return memedImage
    }


    
    
}
