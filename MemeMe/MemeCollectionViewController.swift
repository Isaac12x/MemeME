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
        
    var memes: [Meme] {return (UIApplication.sharedApplication().delegate as! AppDelegate).memes}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let space: CGFloat = 3.0
        let interSpace: CGFloat = 2.0
        let layoutWidth = (view.frame.size.width - (2 * space)) / 2.0
        let layoutHeight = (view.frame.size.height - (2 * space)) / 3.0
        
        // Flow layout interface spacing
        flowLayout.minimumInteritemSpacing = interSpacet
        flowLayout.minimumLineSpacing = interSpace
        
        // Create item size depending on Meme View  - depending on screen
        flowLayout.itemSize = CGSizeMake(layoutWidth, layoutHeight)
    }

    // Reload data in the collectionView
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    
    // REQUIRED FUNCTIONS FOR COLLECTIONVIEW IMPLEMENTATION
    
    // Populate your custom cell with data from the data storage
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.memeImageView?.image = meme.memedImage
    
        return cell
    }
    
    
    // Count the number of cells
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    // Instructions to segue when pressing down into any cell
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let collectionVC = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        collectionVC.meme = memes[indexPath.item]
        
        navigationController!.pushViewController(collectionVC, animated: true)
        
    }
}