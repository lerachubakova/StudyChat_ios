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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRecognizerToPhotoImageView()
        addTargetsToTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registrationView.isHidden = true
        biometricButton.isHidden = true
     
        if userDefaults.bool(forKey: Keys.touchID.rawValue) {
            useBiometrics()
            biometricButton.isHidden = false
        } else {
            let user = User()
            photoImageView.image = user.getPicture()
            if user.getFullName() != " " {
                surnameTextField.text = user.getSurname()
                nameTextField.text = user.getName()
                biometricButton.isHidden = false
                signUpButton.setTitle("Сменить пользователя", for: .normal)
            }
            registrationView.isHidden = false
        }
        
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
                        userDefaults.set(true, forKey: Keys.touchID.rawValue)
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
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        
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
    
    // MARK: - @IBActions
    @IBAction private func unwindToSignInFromHome(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindToSignInVCSegue" else {return}
        guard segue.destination as? SettingsVC != nil else {return}
    }
    
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
        if isFullNameRight(surnameTextField, nameTextField) {
            userDefaults.set(nameTextField.text!, forKey: Keys.surname.rawValue)
            userDefaults.set(surnameTextField.text!, forKey: Keys.name.rawValue)
            userDefaults.set(true, forKey: Keys.touchID.rawValue)
            self.performSegue(withIdentifier: "toMainSegue", sender: nil)
        } else {
            showAlertError(by: "Для завершения регистрации корректно заполните все поля.")
        }
    }
    
    @IBAction private func addPhotoToProfile(_ gestureRecognizer: UITapGestureRecognizer ) {
        showChoiceAlert()
    }
    
}
