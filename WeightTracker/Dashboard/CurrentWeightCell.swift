//
//  CurrentWeightCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class CurrentWeightCell: ResizableViewCell, NibLoadableView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 16
    }

}
