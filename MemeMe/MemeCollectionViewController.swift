//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 15/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] = [Meme]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let cellIdentifier = "MemeCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
         //TODO find a layout that works in both landscape and portrait mode
        // self.view.frame.size.height
        
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        // Create item size depending on Meme View  - depending on screen
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    // var memes:[Meme] {return (UIApplication.sharedApplication().delegate as AppDelegate).memes}

}