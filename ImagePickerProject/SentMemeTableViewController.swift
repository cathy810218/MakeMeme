//
//  SentMemeTableViewController.swift
//  MakeMeme
//
//  Created by Cathy Oun on 3/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.registerNib(UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TableViewCell")
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
    print("Numbers of Memes: \(self.memes.count)")

  }
  
  //MARK: UITableViewDelegate and UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
    cell.cellImage.image = memes[indexPath.row].memedImage
    cell.cellLabel.text = memes[indexPath.row].topText + " " + memes[indexPath.row].botText;
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailVC.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(detailVC, animated: true)

  }
  
}
