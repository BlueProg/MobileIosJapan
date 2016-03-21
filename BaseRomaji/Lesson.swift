//
//  Lesson.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class   Lesson {

    var lessonTitle: String
    var picture: UIImage?
    var complet: Float
    var sucess: Float
    var dictionary: []
    
    init?(lessonTitle: String, picture: UIImage?, complet: Float, sucess: Float) {
    
        self.lessonTitle = lessonTitle
        self.picture = picture
        self.complet = complet
        self.sucess = sucess
     
        if lessonTitle.isEmpty || complet < 0 {
            return nil
        }
    }
}
