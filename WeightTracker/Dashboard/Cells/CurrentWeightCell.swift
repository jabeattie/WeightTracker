//
//  CurrentWeightCell.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class CurrentWeightCellViewModel {
    private let decorator: WeightDecorator
    private let user: User?
    
    init(user: User?, decorator: WeightDecorator) {
        self.decorator = decorator
        self.user = user
    }
    
    var weight: String? {
        guard let currentWeight = user?.currentWeight else { return nil }
        return decorator.displayValue(for: currentWeight)
    }
}

class CurrentWeightCell: ResizableViewCell, NibLoadableView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 16
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func update(_ viewModel: CurrentWeightCellViewModel) {
        weight.text = viewModel.weight
    }

}
