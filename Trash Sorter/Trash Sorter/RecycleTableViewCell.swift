//
//  RecycleTableViewCell.swift
//  Trash Sorter
//
//  Created by Edrick Pascual on 6/26/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class RecycleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var garbageNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
