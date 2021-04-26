//
//  FullNameVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit
import SkyFloatingLabelTextField

class FullNameVC: UIViewController {
       
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    internal func isFullNameRight(_ surnameTextField: SkyFloatingLabelTextField, _ nameTextField: SkyFloatingLabelTextField) -> Bool {
        if let surname = surnameTextField.text,
           let name = nameTextField.text {
            if surname.isEmpty || name.isEmpty { return false }
        }
        if let surnameError = surnameTextField.errorMessage,
           let nameError = nameTextField.errorMessage {
            if !(surnameError.isEmpty) || !(nameError.isEmpty) { return false }
        }
        return true
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
    
    @IBAction internal func checkTextFieldData(_ textField: SkyFloatingLabelTextField) {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        func error() { textField.errorMessage = "Недопустимый символ" }
        func right() { textField.errorMessage = "" }
        
        if let text = textField.text {
            if text.isEmpty { right(); return}
            for symb in text {
                if !(allowLetters.contains(symb) ) {
                    error()
                    return
                } else { right() }
            }
        }
    }
}

extension FullNameVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
