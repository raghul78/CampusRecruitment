//
//  JobFairTableViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 04/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class JobFairTableViewCell: UITableViewCell {


    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ExpLabel: UILabel!
    @IBOutlet var locateLabel: UILabel!
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
