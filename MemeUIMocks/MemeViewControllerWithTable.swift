//
//  MemeViewControllerWithTable.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/4/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeViewControllerWithTable: UIViewController, UITableViewDataSource, UITableViewDelegate, AddMemeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let tableCellID = "MemeTableCell"
    
    func synchData() {
        let dataCount = MemeHistory.sharedInstance.history.count
        let numItems = tableView.numberOfRowsInSection(0)
        var newIdxs = [NSIndexPath]()
        for i in numItems..<dataCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            newIdxs.append(indexPath)
        }
        tableView.insertRowsAtIndexPaths(newIdxs, withRowAnimation: .Automatic)
    }
    
    override func viewWillAppear(animated: Bool) {
        synchData()
    }
    
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func controller(didAddItem: MemeData) {
        synchData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeHistory.sharedInstance.history.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellID) as! MemeTableViewCell
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        cell.memeImage.image = selectedMeme.memedImage
        cell.memeCaptions.text = "\(selectedMeme.topText) \(selectedMeme.bottomText)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = selectedMeme
        self.navigationController?.pushViewController(vc, animated: true)
    }
}