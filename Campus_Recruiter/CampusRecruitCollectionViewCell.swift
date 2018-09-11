//
//  CampusRecruitCollectionViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 03/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class CampusRecruitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var comNameLabel: UILabel!
    @IBOutlet var skillLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var interestButton: UIButton!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 3.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        interestButton.layer.cornerRadius = 4
        interestButton.layer.borderWidth = 2.0
        interestButton.layer.borderColor = UIColor().lightPinkClr().cgColor
        
    }
}
