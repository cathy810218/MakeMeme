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
  //TODO: Add collection view flow layout
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.collectionView?.reloadData()
    
  }
  
  //MARK: CollectionView
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
    let meme = self.memes[indexPath.item]
    
    cell.backgroundView = UIImageView(image: meme.memedImage)
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailVC.meme = self.memes[indexPath.item]
    self.navigationController!.pushViewController(detailVC, animated: true)

  }
}
