//
//  SignInViewController.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import LocalAuthentication
import UIKit
import SkyFloatingLabelTextField

class SignInViewController: FullNameVC {

    // MARK: - @IBOutlets
    @IBOutlet weak private var biometricButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var registrationView: UIView!
    @IBOutlet weak private var photoImageView: UIImageView!
    
    @IBOutlet weak private var surnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var nameTextField: SkyFloatingLabelTextField!
    
    private var wasPhotoChanged: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecognizerToPhotoImageView()
        addTargetsToTextFields()
        // registrationView.isHidden = true
        useBiometrics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoImageView.image = UIImage(named: "icUser")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureAppearance()
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
    
    // MARK: - @IBActions
    @IBAction private func unwindToSignInFromHome(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToSignInVCSegue" else {return}
        guard segue.destination as? SettingsVC != nil else {return}
    }
    
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
        if isFullNameRight(surnameTextField, nameTextField) && wasPhotoChanged {
            self.performSegue(withIdentifier: "toMainSegue", sender: nil)
        } else {
            showAlertError(by: "Для завершения регистрации корректно заполните все поля.")
        }
    }
    
    @IBAction private func addPhotoToProfile(_ gestureRecognizer: UITapGestureRecognizer ) {
        showChoiceAlert()
    }
    
}

// MARK: - Extensions
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
