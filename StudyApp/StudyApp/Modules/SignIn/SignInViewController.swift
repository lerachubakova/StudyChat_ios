//
//  SignInViewController.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import LocalAuthentication
import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak private var biometricButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var registrationView: UIView!
    @IBOutlet weak private var photoImageView: UIImageView!
    
    @IBOutlet weak private var surnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var nameTextField: SkyFloatingLabelTextField!
    
    private var wasPhotoChanged: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecognizerToPhotoImageView()
        addTargetsToTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureAppearance()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Logic
    private func useBiometrics() {
        let context = LAContext()
            
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please authenticate to proceed.") { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "toMainSegue", sender: nil)
                    }
                } else {
                    guard let error = error else { return }
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func configureAppearance() {
        registrationView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        
        biometricButton.setImage( UIImage(named: "icTouchID"), for: .normal)
        biometricButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 74)
        
        biometricButton.customButton()

        signUpButton.customButton()
    }
    
    private func addTargetsToTextFields() {
        surnameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
        nameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
    }
    
    private func addRecognizerToPhotoImageView() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(addPhotoToProfile(_:)))
        photoImageView.addGestureRecognizer(recognizer)
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
    
    private func showChoiceAlert() {
        let title = wasPhotoChanged ? "Изменить фото" : "Добавить фото"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
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
    
    private func isFullNameRight() -> Bool {
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
    
    func showAlertError(by reason: String) {
        let alert = UIAlertController(title: "", message: reason, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: "Ошибка", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - @IBActions
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
        if isFullNameRight() && wasPhotoChanged {
            self.performSegue(withIdentifier: "toMainSegue", sender: nil)
        } else {
            showAlertError(by: "Для завершения регистрации корректно заполните все поля.")
        }
    }
    
    @IBAction private func addPhotoToProfile(_ gestureRecognizer: UITapGestureRecognizer ) {
        showChoiceAlert()
    }
    
    @IBAction private func checkTextFieldData(_ textField: SkyFloatingLabelTextField) {
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

// MARK: - Extensions
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignInViewController: UINavigationControllerDelegate {}

extension SignInViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
            photoImageView.image = image
            self.wasPhotoChanged = true
        }
        dismiss(animated: true)
    }
}
