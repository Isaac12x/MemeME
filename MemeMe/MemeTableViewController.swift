//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Isaac Albets Ramonet on 15/10/15.
//  Copyright © 2015 Isaac Albets Ramonet. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController{
    
    var memes: [Meme] { return (UIApplication.sharedApplication().delegate as! AppDelegate).memes}
    
    let cellIdentifier = "MemeTableViewCell"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: .Plain, target: self, action: "newMeme")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowInSection section: Int) -> Int{
        return memes.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MemeTableViewCell
        cell.cellImage?.image = meme.memedImage
        cell.cellTitle?.text = "\(meme.topTextField!)   \(meme.bottomTextField!)"
        
        return cell
    }

}
