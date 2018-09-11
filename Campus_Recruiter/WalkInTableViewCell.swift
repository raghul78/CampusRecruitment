//
//  WalkInTableViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 03/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class WalkInTableViewCell: UITableViewCell {

    @IBOutlet var locatLabel: UILabel!
    @IBOutlet var ExpLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var qualiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
