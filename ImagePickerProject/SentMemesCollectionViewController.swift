//
//  SentMemesCollectionViewController.swift
//  MakeMeme
//
//  Created by Cathy Oun on 3/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
}
