//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 16/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var memeDetailView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeDetailView.image = meme.memedImage
    }
    
    
    
}