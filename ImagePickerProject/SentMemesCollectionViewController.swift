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
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    collectionView?.reloadData()
  }
  
  //MARK: CollectionView
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
    let meme = memes[indexPath.item]
    cell.collectionImageView.contentMode = UIViewContentMode.ScaleAspectFit
    cell.collectionImageView = UIImageView(image: meme.memedImage)
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let detailVC = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailVC.meme = memes[indexPath.item]
    navigationController!.pushViewController(detailVC, animated: true)
  }
}
