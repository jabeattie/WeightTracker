//
//  BMICell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class BMICellViewModel {
    private let calculator: BMICalculator
    private let user: User?
    
    init(user: User?, calculator: BMICalculator) {
        self.calculator = calculator
        self.user = user
    }
    
    var bmi: Double? {
        guard let currentWeight = user?.currentWeight, let height = user?.height else { return nil }
        return calculator.calculate(weight: currentWeight, height: height)
    }
    
    var description: String? {
        guard let bmi = bmi else { return nil }
        if bmi < 18.5 {
            return "Underweight"
        } else if bmi < 25.0 {
            return "Healthy weight"
        } else if bmi < 30 {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
}

class BMICell: ResizableViewCell, NibLoadableView {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var desc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 8
    }
    
    func update(_ viewModel: BMICellViewModel) {
        value.text = viewModel.bmi?.clean
        desc.text = viewModel.description
    }

}
