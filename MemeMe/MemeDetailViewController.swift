//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 16/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // Create a data variable
    var meme: Meme!
    @IBOutlet weak var memeDetailView: UIImageView!
    
    
    // Connect the imageView with the image to display
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeDetailView.image = meme.memedImage
    }
    
    
    
}