//
//  SignInVC.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import LocalAuthentication
import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak private var biometricButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // useBiometrics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // print("ViewWillAppear")
    }
    override func viewDidLayoutSubviews() {
        
        biometricButton.setImage( UIImage(named: "icTouchID"), for: .normal)
       
        biometricButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 80)
        
        signUpButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 4
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor.white.cgColor
    }
    
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
    
    @IBAction private func signInWithBiometrics(_ sender: UIButton) {
        useBiometrics()
    }
    
    @IBAction private func signUp(_ sender: UIButton) {
    }
    
}
