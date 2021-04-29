//
//  FullNameVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit
import SkyFloatingLabelTextField

class FullNameVC: BaseVC {
    
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
    
    @IBAction internal func checkTextFieldData(_ textField: SkyFloatingLabelTextField) {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        let allowSymbols:[Character] = ["ё","Ё"]
        func error() { textField.errorMessage = "Недопустимый символ" }
        func right() { textField.errorMessage = "" }
        
        if let text = textField.text {
            if text.isEmpty { right(); return}
            for symb in text {
                if !(allowLetters.contains(symb) && !(allowSymbols.contains(symb)) ) {
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
