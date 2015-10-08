//
//  MemeHistory.swift
//  MemeMe.01
//
//  Created by Jeff Newell on 10/1/15.
//  Copyright © 2015 Jeff Newell. All rights reserved.
//

import Foundation
import UIKit

class MemeHistory {
    static let sharedInstance = MemeHistory()
    
    private var history =  [MemeData]()
    private var observers = [DataObserver]()
    
    func get(atIndex: NSIndexPath) -> MemeData {
        return history[atIndex.item]
    }
    func addObserver(obs: DataObserver) {
        observers.append(obs)
    }
    func appendMeme(newMeme: MemeData){
        history.append(newMeme)
        let indexPath = NSIndexPath(forItem: history.count-1, inSection: 0)
        for o in observers{
            o.insert(indexPath)
        }
    }
    func insertMeme(newMeme: MemeData, atIndexPath: NSIndexPath){
        history.insert(newMeme, atIndex: atIndexPath.item)
        for o in observers{
            o.insert(atIndexPath)
        }
    }
    func deleteMeme(atIndexPath: NSIndexPath) {
        history.removeAtIndex(atIndexPath.item)
        for o in observers{
            o.remove(atIndexPath)
        }
    }
    func updateMeme(updatedMeme: MemeData, atIndexPath: NSIndexPath){
        history[atIndexPath.item].image = updatedMeme.image
        history[atIndexPath.item].memedImage = updatedMeme.memedImage
        history[atIndexPath.item].topText = updatedMeme.topText
        history[atIndexPath.item].bottomText = updatedMeme.bottomText
        for o in observers{
            o.update(atIndexPath)
        }
    }
    var count: Int { get { return history.count }}
}

