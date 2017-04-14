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

    
    
}
