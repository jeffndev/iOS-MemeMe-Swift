//
//  MemeDetailViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    //var meme: MemeData!
    var memeHistoryIndex: Int?
    
    @IBOutlet weak var memeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memeImage.image = meme.memedImage
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme")
    }
    
    override func viewWillAppear(animated: Bool) {
        if let idx = memeHistoryIndex {
            let indexPath = NSIndexPath(forItem: idx, inSection: 0)
            memeImage.image = MemeHistory.sharedInstance.get(indexPath).memedImage
        }
    }
    
//    func dataHasChanged() {
//        if let idx = memeHistoryIndex {
//            meme = MemeHistory.sharedInstance.history[idx]
//            memeImage.image = meme.image
//        }
//    }
//    
    func editMeme(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        vc.indexOfMemeToEdit = memeHistoryIndex
        self.presentViewController(vc, animated: true, completion: nil)

    }
}
