//
//  HomeVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak private var navigationBarView: UIView!
    @IBOutlet weak private var navigationBar: UINavigationBar!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var messageView: UIView!
    @IBOutlet weak private var messageTextView: UITextView!
    @IBOutlet weak private var messageTextConstraint: NSLayoutConstraint!
    
    private var isMoving = false
    private var inset: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBar.transparent()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImageView.image = UIImage(named: "imgSomeUser")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
          
            let bottomOfTextField = messageView.convert(messageView.bounds, to: self.view).maxY
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
               inset =  bottomOfTextField - topOfKeyboard
                if inset > 0 && !isMoving {
                    self.messageView.frame.origin.y -= inset
                    isMoving = true
                }
            }
    }
    
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        self.messageView.frame.origin.y += inset
        isMoving = false
    }
    
}
