//
//  User.swift
//  StudyApp
//
//  Created by user on 4/29/21.
//

import UIKit

struct User {
    private var name: String
    private var surname: String
    private var profilePicture: UIImage
      
    init() {
        self.name = userDefaults.string(forKey: Keys.name.rawValue) ?? ""
        self.surname = userDefaults.string(forKey: Keys.surname.rawValue) ?? ""
        let defImage = UIImage(named: "icProfile") ?? UIImage()
        self.profilePicture = UIImage.init(data: userDefaults.object(forKey: Keys.pic.rawValue) as? Data ?? Data()) ?? defImage
    }
    
    init(name: String, surname: String, pic: UIImage) {
        self.name = name
        self.surname = surname
        self.profilePicture = pic
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getSurname() -> String {
        return self.surname
    }
    
    func getPicture() -> UIImage {
        return self.profilePicture
    }
    
    func getFullName() -> String {
        return "\(self.name) \(self.surname)"
    }
    
}
