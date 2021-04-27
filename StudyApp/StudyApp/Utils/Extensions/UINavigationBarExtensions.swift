//
//  UINavigationBarExtensions.swift
//  StudyApp
//
//  Created by user on 4/27/21.
//

import UIKit

extension UINavigationBar {
    func transparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
}
