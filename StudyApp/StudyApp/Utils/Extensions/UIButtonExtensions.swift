//
//  UIButtonExtensions.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import UIKit

extension UIButton {
    func customButton() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.layer.cornerRadius = self.frame.height / 4
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func setPointSize(procentOfHeight: CGFloat) {
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: self.frame.height * procentOfHeight), forImageIn: .normal)
    }
}
