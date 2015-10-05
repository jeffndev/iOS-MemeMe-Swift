//
//  MemeCollectionViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeCollectionViewController: UICollectionViewController {
    
    let memeCollectionCellID = "MemeCollectionCell"
    
    @IBOutlet weak var flowController: UICollectionViewFlowLayout!
    
    
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //
        let space = CGFloat(2.0)
        
//        let adjustedFrameWidth = UIApplication.sharedApplication().statusBarOrientation.isPortrait ? self.view.frame.width : self.view.frame.height
        let adjustedFrameWidth = self.view.frame.width
        let numItemsInRow = UIApplication.sharedApplication().statusBarOrientation.isPortrait ? 3.0 : 6.0
        let numCellsWide = CGFloat(numItemsInRow)
        //TODO: code to orientation changes...
        flowController.minimumLineSpacing = space
        flowController.minimumInteritemSpacing = space
        let dimension = (adjustedFrameWidth - 2*space)/numCellsWide
        flowController.itemSize = CGSizeMake(dimension,dimension)
        
        self.collectionView?.reloadData()
    }
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        //grab current meme info, grab a memedetailviewcontroller (vc) from storyboard,
        //      pass meme info to the vc, push the vc on the navigationcontroller's stack
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.item]
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = selectedMeme
        navigationController?.pushViewController(vc, animated: true)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: hook that to the data
        return MemeHistory.sharedInstance.history.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(memeCollectionCellID, forIndexPath: indexPath) as! MemeCollectionCell
        let selectedMeme = MemeHistory.sharedInstance.history[indexPath.item]
        
        cell.memeImage.image = selectedMeme.memedImage
        return cell
    }
    
}