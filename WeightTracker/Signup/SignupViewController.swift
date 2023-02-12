//
//  SignupViewController.swift
//  WeightTracker
//
//  Created by James Beattie on 07/06/2020.
//  Copyright © 2020 James Beattie. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    private let viewModel: SignupViewModel
    
    private lazy var signupView: SignupView = {
        let view = SignupView().forAutoLayout()
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Signup", for: .normal)
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return button
    }()
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(signupView)
        NSLayoutConstraint.activate([
            signupView.topAnchor.constraint(equalTo: view.topAnchor),
            signupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signupView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        signupView.configure(viewModel: viewModel)
    }
    
    @objc func buttonTapped() {
        viewModel.signup()
    }
}
