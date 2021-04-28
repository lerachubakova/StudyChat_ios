//
//  BaseVC.swift
//  StudyApp
//
//  Created by user on 4/28/21.
//

import UIKit

class BaseVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    internal func showAlertError(by reason: String) {
        let alert = UIAlertController(title: "", message: reason, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: "Ошибка", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
