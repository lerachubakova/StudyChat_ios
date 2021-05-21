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
    var text: String?
    var images: [Data]?
    var movies: [URL]?
    var files: Data?
    var link: URL?
    var wasEdited: Bool
    
    init(type: Type, text: String) {
        self.type = type
        self.time = Date()
        self.text = text
        self.wasEdited = false
    }
    
    init(type: Type, images: [Data], movies: [URL]) {
        self.type = type
        self.time = Date()
        self.images = images
        self.movies = movies
        self.wasEdited = false
    }
}
