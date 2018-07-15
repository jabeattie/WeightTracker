//
//  AddWeightViewController.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit
import fluid_slider

class AddWeightViewController: UIViewController {
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var slider: Slider!
    
    private let viewModel: AddWeightViewModel
    
    init(viewModel: AddWeightViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: AddWeightViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let weightText = weight.text else { return }
        guard let weightDouble = Double(weightText) else { return }
        viewModel.add(weight: weightDouble)
    }
    
    private func setupSlider() {
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (50 + fraction * 50) as NSNumber) ?? ""
            return NSAttributedString(string: string,
                                      attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.wtBlue])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "50", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "100", attributes: labelTextAttributes))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor.wtBlue
        slider.valueViewColor = .white
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc func sliderValueChanged() {
        let value = 50 + slider.fraction * 50
        let double = Double(value)
        weight.text = double.clean
    }
}
