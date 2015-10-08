//
//  MemeCollectionViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit


class MemeCollectionViewController: UICollectionViewController, DataObserver {
    
    let memeCollectionCellID = "MemeCollectionCell"
    
    @IBOutlet weak var flowController: UICollectionViewFlowLayout!
    
    //ACTIONS
    @IBAction func newMeme(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        //vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //HELPER methods
    
    //LIFECYCLE Overrides...
    override func viewDidLoad() {
        MemeHistory.sharedInstance.addObserver(self)
    }
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
    }
    
    //DataObserver delegates
    func insert(indexPath: NSIndexPath) {
        collectionView?.insertItemsAtIndexPaths([indexPath])
    }
    func remove(indexPath: NSIndexPath) {
        collectionView?.deleteItemsAtIndexPaths([indexPath])
    }
    func update(indexPath: NSIndexPath) {
        collectionView?.reloadItemsAtIndexPaths([indexPath])
    }
    
    //delegate/overrides UICollectionDataSource
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.memeHistoryIndex = indexPath.item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeHistory.sharedInstance.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(memeCollectionCellID, forIndexPath: indexPath) as! MemeCollectionCell
        let selectedMeme = MemeHistory.sharedInstance.get(indexPath)
        cell.memeImage.image = selectedMeme.memedImage
        return cell
    }
}