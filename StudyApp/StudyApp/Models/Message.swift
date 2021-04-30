//
//  Message.swift
//  StudyApp
//
//  Created by user on 4/29/21.
//

import Foundation

enum Type {
    case sender
    case receiver
}

struct Message {
    let type: Type
    let time: Date
    var text: String
    var images: Data?
    var videos: Data?
    var files: Data?
    
    init(type: Type, text: String) {
        self.type = type
        self.time = Date()
        self.text = text
    }
}
