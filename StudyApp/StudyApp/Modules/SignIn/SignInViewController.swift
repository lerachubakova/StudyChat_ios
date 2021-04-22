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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // useBiometrics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // print("ViewWillAppear")
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
    
    // MARK: - @IBActions
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
   
    }
    
}

// MARK: - Extensions
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
