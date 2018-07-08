//
//  OnboardingViewController.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let viewModel: OnBoardingViewModel

    init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: OnboardingViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
