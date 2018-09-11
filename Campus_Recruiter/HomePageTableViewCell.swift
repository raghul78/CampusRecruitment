//
//  HomePageTableViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 21/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {


    @IBOutlet var labelExperience: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelpostDate: UILabel!
    @IBOutlet var labelLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // studProfImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
