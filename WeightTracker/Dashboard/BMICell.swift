//
//  BMICell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class BMICell: ResizableViewCell, NibLoadableView {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var desc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 8
    }

}
