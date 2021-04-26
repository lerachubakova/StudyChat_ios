//
//  ProfileVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileVC: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var surnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var changePhotoButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     surnameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
   //     nameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backButton.customButton()
        editButton.customButton()
        changePhotoButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        surnameTextField.text = "Фамилия"
        nameTextField.text = "Имя"
        photoImageView.image = UIImage(named: "icProfile")
    }
    
    // MARK: - Logic
    private func tappedEdit() {
        editButton.setTitle("Save", for: .normal)
        photoImageView.isUserInteractionEnabled = true
        surnameTextField.isEnabled = true
        nameTextField.isEnabled = true
        changePhotoButton.isHidden = false
    }
    
    private func tappedSave() {
        editButton.setTitle("Edit", for: .normal)
        photoImageView.isUserInteractionEnabled = false
        surnameTextField.isEnabled = false
        nameTextField.isEnabled = false
        changePhotoButton.isHidden = true
    }
    
    // MARK: - @IBActions
    @IBAction private func editProfile(_ sender: Any) {
        if let text = editButton.titleLabel?.text {
            switch text {
            case "Edit": tappedEdit()
            case "Save": tappedSave()
            default: break
            }
        }
    }
}
    // MARK: - Extensions
extension ProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
