//
//  classes.swift
//  memeApp_V1.0
//
//  Created by arora_72 on 13/04/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    
    init(topText: String, bottomText: String, image: UIImage,memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}

