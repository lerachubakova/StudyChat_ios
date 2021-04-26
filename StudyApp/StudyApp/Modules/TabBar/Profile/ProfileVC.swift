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
        surnameTextField.text = "Фамилия"
        nameTextField.text = "Имя"
    }
    
    // MARK: - Logic
    private func tappedEdit() {
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
            editButton.setTitle("Edit", for: .normal)
            photoImageView.isUserInteractionEnabled = false
            surnameTextField.isEnabled = false
            nameTextField.isEnabled = false
            changePhotoButton.isHidden = true
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

extension ProfileVC {
    private func changeImage(_ imageView: UIImageView, _ image: UIImage) {
        imageView.image = image
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
        let alert = UIAlertController(title: "Изменить фото", message: nil, preferredStyle: .actionSheet)
        
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
}

extension ProfileVC: UINavigationControllerDelegate {}

extension ProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            changeImage(photoImageView, image)
        }
        dismiss(animated: true)
    }
}
