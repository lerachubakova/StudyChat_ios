//
//  SignInViewController.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import LocalAuthentication
import UIKit

class SignInViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak private var biometricButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var registrationView: UIView!
    @IBOutlet weak private var photoImageView: UIImageView!
    
    private var wasPhotoChanged: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecognizerToPhotoImageView()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    private func addRecognizerToPhotoImageView() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(addPhotoToProfile(_:)))
        photoImageView.addGestureRecognizer(recognizer)
    }
    
    private func photoIsHere() {
        self.wasPhotoChanged = true
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
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
        
    }
    
    @IBAction private func addPhotoToProfile(_ gestureRecognizer: UITapGestureRecognizer ) {
        showChoiceAlert()
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
            photoImageView.image = image
            self.photoIsHere()
        }
        dismiss(animated: true)
    }
}
