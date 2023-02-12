//
//  UnderlinedTextfield.swift
//  WeightUI
//
//  Created by James Beattie on 14/06/2020.
//  Copyright © 2020 Ceramic Apps. All rights reserved.
//

import UIKit

public final class UnderlinedTextfield: UITextField {
    
    private lazy var underline: UIView = {
        let view = UIView().forAutoLayout()
        view.heightAnchor.constraint(equalToConstant: 1).activated()
        view.backgroundColor = Asset.Colours.deepPurple100.color
        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(underline)
        NSLayoutConstraint.activate([
            underline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -Dimension.small),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Dimension.small),
            underline.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
