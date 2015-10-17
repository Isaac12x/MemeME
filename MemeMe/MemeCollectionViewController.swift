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
    
    @IBOutlet var collectionDisplay: UICollectionView!
    
    var memes: [Meme] {return (UIApplication.sharedApplication().delegate as! AppDelegate).memes}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let space: CGFloat = 3.0
        let layoutWidth = (view.frame.size.width - (2 * space)) / 3.0
        let layoutHeight = (view.frame.size.height - (2 * space)) / 3.0
        //TODO find a layout that works in both landscape and portrait mode
        // self.view.frame.size.height
        
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        // Create item size depending on Meme View  - depending on screen
        flowLayout.itemSize = CGSizeMake(layoutWidth, layoutHeight)
    }
    
    @IBAction func createNewMeme(sender: AnyObject) {
        let newMemeVC = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController!.presentViewController(newMemeVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let meme = memes[indexPath.item]
        let memeImageView = UIImageView(image: meme.image)
        cell.backgroundView = memeImageView
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object: AnyObject = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
            
        let collectionVC = object as! MemeDetailViewController
        collectionVC.memeDetailView.image = memes[indexPath.item].memedImage
        
        navigationController!.pushViewController(collectionVC, animated: true)
        
    }
}