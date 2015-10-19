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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView!.reloadData()
    }
    
    
    // REQUIRED METHODS FOR TABLEVIEW IMPLEMENTATION
    
    // Table cell's count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return memes.count
    }
    
    // Populate tableView cells with data form the data storage
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        cell.cellImage?.image = meme.memedImage
        cell.cellTitle?.text = "\(meme.topTextField!)   \(meme.bottomTextField!)"
        
        return cell
    }
    
    // Instructions to segue when pressing down into any cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let editMemeVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        editMemeVC.meme = memes[indexPath.row]
        
        navigationController!.pushViewController(editMemeVC, animated: true)
    }

}