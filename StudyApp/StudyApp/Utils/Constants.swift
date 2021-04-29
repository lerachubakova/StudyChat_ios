//
//  Constants.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

let settingsList: [(String, String)] = [("Profile", "icProfile"), ("Log Out", "icLogOut")]

let tabBarColor = UIColor(red: 51/255, green: 55/255, blue: 62/255, alpha: 1)
let separatorColor = UIColor(red: 139/255, green: 162/255, blue: 134/255, alpha: 0.5)

var messages: [Message] = [Message(type: .sender, text: "Привет"),
                           Message(type: .receiver, text: "И тебе привет"),
                           Message(type: .sender, text: "Как дела?"),
                           Message(type: .receiver, text: "Хорошо. Твои как?"),
                           Message(type: .sender, text: "Тоже ничего")]

let userDefaults = UserDefaults.standard

enum Keys: String {
    case surname = "Surname"
    case name = "Name"
    case touchID = "UseTouchID"
    case pic = "ProfilePicture"
}
