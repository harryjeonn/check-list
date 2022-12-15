//
//  UIView+Extension.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/15.
//

import UIKit

extension UIView {
    func setRadiusAndShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
}
