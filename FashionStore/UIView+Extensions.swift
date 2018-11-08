//
//  Common.swift
//  FashionStore
//
//  Copyright © 2018 Klarna Bank AB. All rights reserved.
//

import UIKit

extension UIViewController {

    func embed(subview: UIView, toBottomAnchor bottomAnchor: NSLayoutYAxisAnchor) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(subview)
        self.view.sendSubviewToBack(subview)

        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            subview.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0),
            subview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),

            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: 8)
        ])
    }

}
