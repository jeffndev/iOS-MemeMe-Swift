//
//  MemeCollectionViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeCollectionViewController: UICollectionViewController, AddMemeViewControllerDelegate {
    
    let memeCollectionCellID = "MemeCollectionCell"
    
    @IBOutlet weak var flowController: UICollectionViewFlowLayout!
    
    //ACTIONS
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //HELPER methods
    func synchData() {
        let dataCount = MemeHistory.sharedInstance.history.count
        let numItems = self.collectionView!.numberOfItemsInSection(0)
        var newIdxs = [NSIndexPath]()
        for i in numItems..<dataCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            newIdxs.append(indexPath)
        }
        self.collectionView?.insertItemsAtIndexPaths(newIdxs)
    }
    
    //LIFECYCLE Overrides...
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let space = CGFloat(2.0)
        let adjustedFrameWidth = self.view.frame.width
        let numItemsInRow = UIApplication.sharedApplication().statusBarOrientation.isPortrait ? 3.0 : 5.0
        let numCellsWide = CGFloat(numItemsInRow)
        flowController.minimumLineSpacing = space
        flowController.minimumInteritemSpacing = space
        let dimension = (adjustedFrameWidth - 2*space)/numCellsWide
        flowController.itemSize = CGSizeMake(dimension,dimension)
        
        synchData()
    }
    //delegate AddMemeViewControllerDelegate
    func controller(didAddItem: MemeData) {
        synchData()
    }
    
    
    //delegate/overrides UICollectionDataSource
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.item]
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = selectedMeme
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeHistory.sharedInstance.history.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(memeCollectionCellID, forIndexPath: indexPath) as! MemeCollectionCell
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.item]
        cell.memeImage.image = selectedMeme.memedImage
        return cell
    }
    
}