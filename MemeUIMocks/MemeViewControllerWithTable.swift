//
//  MemeViewControllerWithTable.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/4/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeViewControllerWithTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let tableCellID = "MemeTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        //print("table view did appear")
    }
    override func viewWillAppear(animated: Bool) {
        //print("table view will appear")
        tableView.reloadData()
    }
    
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numElements = MemeHistory.sharedInstance.history.count
        print("table view data has \(numElements) elements")
        return numElements //MemeHistory.sharedInstance.history.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellID) as! MemeTableViewCell
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        cell.memeImage.image = selectedMeme.memedImage
        cell.memeCaptions.text = "\(selectedMeme.topText) \(selectedMeme.bottomText)"
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //grab current meme info, grab a memedetailviewcontroller (vc) from storyboard,
        //      pass meme info to the vc, push the vc on the navigationcontroller's stack
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.row]
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = selectedMeme
        if let navController = self.navigationController {
            print("found nav, about to push detail..")
            navController.pushViewController(vc, animated: true)
            //self.navigationController?.pushViewController(vc, animated: true)
        }else {
            print("no nav controller in table view")
        }
    }
    
}