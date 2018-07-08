//
//  TabBarController.swift
//  WeightTracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = buildControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func buildControllers() -> [UIViewController] {
        let viewModel = DashboardViewModel()
        let dashboardVC = DashboardViewController(viewModel: viewModel)
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(named: "home"), tag: 0)
        return [dashboardVC]
    }

}
