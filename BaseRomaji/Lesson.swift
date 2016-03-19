//
//  Lesson.swift
//  BaseRomaji
//
//  Created by Mathieu MOLE on 3/15/16.
//  Copyright © 2016 Mathieu MOLE. All rights reserved.
//

import UIKit

class   Lesson {

    var name: String
    var photo: UIImage?
    var complet: Float
    var error: Float
    
    init?(name: String, photo: UIImage?, complet: Float, error: Float) {
    
        self.name = name
        self.photo = photo
        self.complet = complet
        self.error = error
     
        if name.isEmpty || complet < 0 {
            return nil
        }
    }
}
