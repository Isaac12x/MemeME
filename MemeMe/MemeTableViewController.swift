//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 15/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{
    
    var memes: [Meme] {return (UIApplication.sharedApplication().delegate as! AppDelegate).memes}
    
    @IBOutlet var tableViewOutlet: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func createNewMeme(sender: AnyObject) {
        let newMemeVC = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        navigationController!.presentViewController(newMemeVC, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowInSection section: Int) -> Int{
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        cell.cellImage?.image = meme.memedImage
        cell.cellTitle?.text = "\(meme.topTextField!)   \(meme.bottomTextField!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let editMemeVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        // the error must be here...
        //editMemeVC.memeDetailView.image = memes[indexPath.row].memedImage
        
        editMemeVC.meme = memes[indexPath.item]
        
        navigationController!.pushViewController(editMemeVC, animated: true)
    }

}