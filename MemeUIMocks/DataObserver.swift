//
//  DataObserver.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/7/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import UIKit

protocol DataObserver {
    func update(indexPath: NSIndexPath)
    func remove(indexPath: NSIndexPath)
    func insert(indexPath: NSIndexPath)
}
