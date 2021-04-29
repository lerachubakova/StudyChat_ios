//
//  ProfileVC.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileVC: FullNameVC {
    
    // MARK: - @IBOutlets
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var surnameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var changePhotoButton: UIButton!
    
    private var isEdit: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        surnameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
        nameTextField.addTarget(self, action: #selector(checkTextFieldData(_:)), for: .allEditingEvents)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backButton.customButton()
        editButton.customButton()
        changePhotoButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = User()
        photoImageView.image = user.getPicture()
        if !isEdit {
            surnameTextField.text = user.getSurname()
            nameTextField.text = user.getName()
        }
    }
    
    // MARK: - Logic
    private func tappedEdit() {
        isEdit = true
        editButton.setTitle("Save", for: .normal)
        
        photoImageView.isUserInteractionEnabled = true
        surnameTextField.isEnabled = true
        nameTextField.isEnabled = true
        changePhotoButton.isHidden = false
        
        surnameTextField.errorMessage = ""
        nameTextField.errorMessage = ""
    }
    
    private func tappedSave() {
        if isFullNameRight(surnameTextField, nameTextField) {
  
            userDefaults.set(nameTextField.text!, forKey: Keys.name.rawValue)
            userDefaults.set(surnameTextField.text!, forKey: Keys.surname.rawValue)
            isEdit = false
            
            self.surnameTextField.lineColor = .green
            self.nameTextField.lineColor = .green
            self.editButton.layer.borderColor = UIColor.green.cgColor
            
            self.surnameTextField.lineHeight = 1.1
            self.nameTextField.lineHeight = 1.1
            UIView.animate(withDuration: 0.5,
                           animations: {
                            self.surnameTextField.lineHeight = 1
                            self.nameTextField.lineHeight = 1
                           },
                           completion: {_ in
                self.nameTextField.lineColor = .white
                self.surnameTextField.lineColor = .white
                self.editButton.layer.borderColor = UIColor.white.cgColor
                self.photoImageView.isUserInteractionEnabled = false
                self.surnameTextField.isEnabled = false
                self.nameTextField.isEnabled = false
                self.changePhotoButton.isHidden = true
                self.editButton.setTitle("Edit", for: .normal)
            })
        } else {
            showAlertError(by: "Для сохранения корректно заполните все поля.")
        }
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
    
    @IBAction private func changePhoto(_ sender: UIButton) {
        showChoiceAlert()
    }
}
