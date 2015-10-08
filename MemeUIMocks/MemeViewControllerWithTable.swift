//
//  MemeViewControllerWithTable.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/4/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeViewControllerWithTable: UIViewController, UITableViewDataSource, UITableViewDelegate, DataObserver {
    
    @IBOutlet weak var tableView: UITableView!
    let tableCellID = "MemeTableCell"
    
    
    //LIFECYCLE overrides
    override func viewDidLoad() {
        MemeHistory.sharedInstance.addObserver(self)
    }
    //HELPER methods
    
    //ACTIONS
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //DataObserver delegates..
    func update(indexPath: NSIndexPath) {
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    func remove(indexPath: NSIndexPath) {
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    func insert(indexPath: NSIndexPath) {
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    //delegates UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeHistory.sharedInstance.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellID) as! MemeTableViewCell
        let selectedMeme = MemeHistory.sharedInstance.get(indexPath)
        cell.memeImage.image = selectedMeme.memedImage
        cell.memeCaptions.text = "\(selectedMeme.topText) \(selectedMeme.bottomText)"
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.memeHistoryIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteMe = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { action, indexPth in
                self.deleteMemeAtIndexPath(indexPth)
        }
        return [deleteMe]
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    //SELECTOR for editAction Delete...
    func deleteMemeAtIndexPath(indexPath: NSIndexPath){
        MemeHistory.sharedInstance.deleteMeme(indexPath)
    }
}