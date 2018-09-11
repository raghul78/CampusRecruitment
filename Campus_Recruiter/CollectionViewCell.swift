//
//  CollectionViewCell.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 14/11/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl: UILabel!
    @IBOutlet var comTypelabel: UILabel!
    @IBOutlet var locLabel: UILabel!


    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 3.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        

    }
}
