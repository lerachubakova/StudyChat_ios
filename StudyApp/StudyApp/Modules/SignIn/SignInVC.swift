//
//  SignInVC.swift
//  StudyApp
//
//  Created by user on 4/22/21.
//

import LocalAuthentication
import UIKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //useBiometrics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // print("ViewWillAppear")
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
    
}
