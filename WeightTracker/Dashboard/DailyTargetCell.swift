//
//  DailyTargetCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class DailyTargetCell: ResizableViewCell, NibLoadableView {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var value: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 8
    }

}
