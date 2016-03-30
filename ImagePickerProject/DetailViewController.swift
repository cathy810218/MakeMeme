//
//  DetailViewController.swift
//  MakeMeme
//
//  Created by Cathy Oun on 3/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var meme : Meme!
  
  @IBOutlet weak var detailImageView: UIImageView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.detailImageView.sizeToFit()
    self.detailImageView.image = meme.memedImage
  }
  
}
