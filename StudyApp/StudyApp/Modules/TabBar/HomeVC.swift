//
//  HomeVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class HomeVC: BaseVC {

    // MARK: - @IBOutlets
    @IBOutlet weak private var myBackgroundImage: UIImageView!
    @IBOutlet weak private var navigationBarView: UIView!
    @IBOutlet weak private var navigationBar: UINavigationBar!
    @IBOutlet weak private var profileImageView: UIImageView!
    
    @IBOutlet weak private var messageView: UIView!
    @IBOutlet weak private var messageTextView: UITextView!
    @IBOutlet weak private var messageTextConstraint: NSLayoutConstraint!
    @IBOutlet weak private var sendButton: UIButton!
    @IBOutlet weak private var addFileButton: UIButton!
    
    private var oldElementsPositions: [CGFloat] = []

    // MARK: - LifeCycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBar.transparent()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        oldElementsPositions = [navigationBar, navigationBarView, profileImageView, myBackgroundImage].map({ $0?.frame.origin.y ?? 0.0 })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImageView.image = UIImage(named: "imgSomeUser")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
    }
    
    // MARK: - Logic
    private func addKeyboardObservers() {
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func moveElemets(on inset: CGFloat) {
        self.navigationBar.frame.origin.y = oldElementsPositions[0] + inset
        self.navigationBarView.frame.origin.y = oldElementsPositions[1] + inset
        self.profileImageView.frame.origin.y = oldElementsPositions[2] + inset
        self.myBackgroundImage.frame.origin.y = oldElementsPositions[3] + inset
        self.view.frame.origin.y = -inset
    }
        
    // MARK: - @IBAction
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let bottomOfTextField = messageView.convert(messageView.bounds, to: self.view).maxY
        let topOfKeyboard = self.view.frame.height - keyboardFrame.height
        let inset = bottomOfTextField - topOfKeyboard
        
        moveElemets(on: inset)
    }
    
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        moveElemets(on: 0.0)
    }
    
    @IBAction private func sendMessage(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction private func addFile(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
}
