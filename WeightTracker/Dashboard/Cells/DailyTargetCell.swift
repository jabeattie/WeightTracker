//
//  DailyTargetCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class DailyTargetCellViewModel {
    private let calculator: CalorieCalculator
    private let user: User?
    
    init(user: User?, calculator: CalorieCalculator) {
        self.calculator = calculator
        self.user = user
    }
    
    var calories: String? {
        guard let user = user else { return nil }
        return calculator.calculate(user: user).clean
    }
}

class DailyTargetCell: ResizableViewCell, NibLoadableView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var value: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 8
    }

    func update(_ viewModel: DailyTargetCellViewModel) {
        value.text = viewModel.calories
    }

}
