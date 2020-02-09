//
//  CustomCell.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/02.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class CustomCell: CardCell {

    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         self.layer.cornerRadius = 20
        
    }

    
   
 
}
