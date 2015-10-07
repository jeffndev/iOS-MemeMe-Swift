//
//  MemeDetailViewController.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: MemeData!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage.image = meme.memedImage
    }
}
