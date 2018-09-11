//
//  StudentListTableViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 30/12/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class StudentListTableViewCell: UITableViewCell {

    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelYear: UILabel!
    @IBOutlet var studProfImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        studProfImage.layer.cornerRadius = 25

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
