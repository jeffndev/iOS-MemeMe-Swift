//
//  MemeTableViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    let tableCellID = "MemeTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        print("table view did appear")
    }
    override func viewWillAppear(animated: Bool) {
        print("table view will appear")
        tableView.reloadData()
    }
    
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: connect this to the data...
        let numElements = MemeHistory.sharedInstance.history.count
        print("table view data has \(numElements) elements")
        return numElements //MemeHistory.sharedInstance.history.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellID)!
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        cell.imageView?.image = selectedMeme.memedImage
        return cell
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //grab current meme info, grab a memedetailviewcontroller (vc) from storyboard,
        //      pass meme info to the vc, push the vc on the navigationcontroller's stack
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.memeImage.image = selectedMeme.memedImage
        if let navController = self.navigationController {
            print("found nav, about to push detail..")
            navController.pushViewController(vc, animated: true)
            //self.navigationController?.pushViewController(vc, animated: true)
        }else {
            print("no nav controller in table view")
        }
    }
}