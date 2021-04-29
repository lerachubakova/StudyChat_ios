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
    
    private func getImage(from sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    internal func showChoiceAlert() {
        let alert = UIAlertController(title: "Изменить фото", message: nil, preferredStyle: .actionSheet)
        
        let fromLibraryAction = UIAlertAction(title: "Выбрать из галереи", style: .default, handler: {_ in
            self.getImage(from: .photoLibrary)
        })
        
        let makePhotoAction = UIAlertAction(title: "Сделать фото", style: .default, handler: {_ in
            self.getImage(from: .camera)
        })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(fromLibraryAction)
        alert.addAction(makePhotoAction)
        alert.addAction(cancelAction)
        alert.pruneNegativeWidthConstraints()
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - @IBActions
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
// MARK: - Extensions
// MARK: - TextFieldDelegate
extension FullNameVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// MARK: - NavigationController
extension FullNameVC: UINavigationControllerDelegate {}

extension FullNameVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            userDefaults.set(image.pngData(), forKey: Keys.pic.rawValue)
        }
        dismiss(animated: true)
    }
}
