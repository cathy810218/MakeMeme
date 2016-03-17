//
//  TableViewCell.swift
//  MakeMeme
//
//  Created by Cathy Oun on 3/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var cellImage: UIImageView!
  @IBOutlet weak var cellLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
