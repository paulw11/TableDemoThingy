//
//  ToDoTableViewCell.swift
//  TableDemoThingy
//
//  Created by Paul Wilkinson on 23/3/17.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoText: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
