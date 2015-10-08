//
//  MemeDetailViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var memeHistoryIndex: Int?
    
    @IBOutlet weak var memeImage: UIImageView!
    
    //LIFECYCLE overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme")
    }
    
    override func viewWillAppear(animated: Bool) {
        //always refresh from the data source...
        if let idx = memeHistoryIndex {
            let indexPath = NSIndexPath(forItem: idx, inSection: 0)
            memeImage.image = MemeHistory.sharedInstance.get(indexPath).memedImage
        }
    }
    //SELECTOR for right nav button item: Edit
    func editMeme(){
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        vc.indexOfMemeToEdit = memeHistoryIndex
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
