//
//  SentMemesTableViewController.swift
//  MakeMeme
//
//  Created by Cathy Oun on 3/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.registerNib(UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TableViewCell")
  }

  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
    cell.tag++
    let tag = cell.tag
    if cell.tag == tag {
      cell.imageView?.image = memes[indexPath.row].memedImage
    }
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // TODO: display detail view controller
  }
}
