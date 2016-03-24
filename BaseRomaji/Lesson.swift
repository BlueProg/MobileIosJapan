//
//  Lesson.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

struct DictionaryLesson {
    var fr = String()
    var jap = String()
    var call:Int
    var sucess:Int
}

class   Lesson {

    var lessonTitle: String
    var picture: UIImage?
    var complet: Float
    var sucess: Float
    var dico: [DictionaryLesson]
    
    init?(lessonTitle: String, picture: UIImage?, complet: Float, sucess: Float, words: [DictionaryLesson]) {
    
        self.lessonTitle = lessonTitle
        self.picture = picture
        self.complet = complet
        self.sucess = sucess
        self.dico = words
     
        if lessonTitle.isEmpty || complet < 0 {
            return nil
        }
    }
}
